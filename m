Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640BAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3B2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="RYCY/vdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD3B2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeIZTwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:52:47 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40986 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeIZTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:52:47 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so10785557ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JajT+xZ3AwDejdh9D5050iuPH1o8nwyx8Tqe/BRTIb8=;
        b=RYCY/vdvgwLlFkYwQ+P0F54MoeDKupmleCIWkbIzbfgi6SEK/aXua2Lug8kQwDZk9e
         Gf6AOnq2Uw7HAz1x1XBA+XTXU8n5Eidd0r8vs8BZeQ2Hr+MV3NetSyq0Bb/GL3x0wd89
         IB3VBrxGZZKeaSnK5Z4xLJmA1zl4t7SO518GDP7/FjEPTNRBLXn3lgWDwvDjNHJNgerp
         oo+fIj9jpofZz8FZV2o6fZsWmV/RqudRODNzZ7KqT/pnzkvto9RQA0Hv+eZtqKMmR5d1
         S70TN7IjsJon5vdQDwbtbGyZTRgyku8VGChaHL1M2pvCWUMiRMfFqO0R+rIRWIGHOQDZ
         vXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JajT+xZ3AwDejdh9D5050iuPH1o8nwyx8Tqe/BRTIb8=;
        b=AsvIuFCsiVSxwV4KUp7mI5G+VfX2MNjdHyI2pc24vYogzwl/jlqOEGQyY2QeGbsI+u
         q3bOqF0UrA88Gzsh+5TyyH6SWWvJegsR66g/vgjyPaG8j5y5jfbFhGvhtp8fTou4Wexl
         cGQ2Cgj1oJQP6iPLZctL3r+tLIfZHS9MwJamU0Db+JGJhPWuFGM4pK9AmKggSReFko6g
         9Ue70GUofbazpgrgdRHsXP4FvSaG7HobsfMI4hcqpDMAbkNIcNBae0nr2EmG2xGFCuMW
         8DppEtBXp2LDVYSg22jMzirwaU0B1KarIuROo0S/QLYxG1Fj+5zbQmCktSBfCzEEYZzL
         0meg==
X-Gm-Message-State: ABuFfojoIO+eOvlvfGTRYnOeouz4WusiEZoiJt13LH74dFc+ujHAF4I0
        2GPeQMDdQNlp9a2sQgpydPnIlw==
X-Google-Smtp-Source: ACcGV61wwoZ7LfCCFaxqr8K1u373g61HGwanz/KLHgu+vGlzskA0E5ELf7jQ2cvfV0oWdPW1jgHDVQ==
X-Received: by 2002:a0d:cb88:: with SMTP id n130-v6mr3054511ywd.243.1537969186267;
        Wed, 26 Sep 2018 06:39:46 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id r3-v6sm2844263ywr.80.2018.09.26.06.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 06:39:45 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:39:45 -0400
From:   Sean Paul <sean@poorly.run>
To:     Stefan Agner <stefan@agner.ch>
Cc:     sean@poorly.run, alison.wang@nxp.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Move fsl-dcu driver to drm-misc tree
Message-ID: <20180926133945.GR72545@art_vandelay>
References: <20180926125034.4095-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926125034.4095-1-stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 02:50:34PM +0200, Stefan Agner wrote:
> The driver is mostly in maintenance mode. 

Is the status still Supported, then?

> Using drm-misc is a
> good fit and should make maintenance a bit easier.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Sean Paul <sean@poorly.run>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02a39617ec82..6646a3d098a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4822,6 +4822,7 @@ F:	drivers/gpu/drm/fsl-dcu/
>  F:	Documentation/devicetree/bindings/display/fsl,dcu.txt
>  F:	Documentation/devicetree/bindings/display/fsl,tcon.txt
>  F:	Documentation/devicetree/bindings/display/panel/nec,nl4827hc19-05b.txt
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  DRM DRIVERS FOR FREESCALE IMX
>  M:	Philipp Zabel <p.zabel@pengutronix.de>
> -- 
> 2.19.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
