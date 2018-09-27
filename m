Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B61CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B9E21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B9E21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeI1Amp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:42:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41288 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1Amp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:42:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id e18-v6so3499096oti.8;
        Thu, 27 Sep 2018 11:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HCRvshO3ACBAbn/7N1ApN8FYnEyZ/+IboJa/TSnpTzg=;
        b=Pxuy/kMO9apxmGhQihDwG1dm8k7TvvORfAFBVMj2XV+ujwHM32+1GpiOD4cFFS+k4C
         vTs6Hb29yWYDSFovBDy9iVddq0lEpEqijqM+VBVIcE8WNYi380g5Ph4gC9xF/yHjAqmi
         pSECsz2Xkf6gZvZcAYFH2dyEJp7LpEBybcUm2iXBBLH8kc4vcTDTbpSSNgm5sSROEClp
         PnL+0Ol8ud+XI/0WLC5nJ76eDf9LE4HuvxaOycKpI6brDGESSqG0FhjdJ4pzfTDZD40/
         7109WTahJWzPeOJ9XZrV5XukOKNem0W43ZOipQG/OSMpe5QlCrA/eTr2fjlq5w2Ap+45
         wCdA==
X-Gm-Message-State: ABuFfoiU8wtkaUvqZ2z1HLhWgr1MKC6mYjXTVv4IAXqJSHfsH40GtCsD
        FwjFSYxjGlJp3ie6qxWZ5A==
X-Google-Smtp-Source: ACcGV61OIOnhm726mQTeHpFt44tJ3EEn9PpflefLkgn0H/9DAJJt+7QibLGx78+prf43h8FWFrL9Sw==
X-Received: by 2002:a9d:2cc:: with SMTP id 70-v6mr8146135otl.239.1538072593572;
        Thu, 27 Sep 2018 11:23:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k23-v6sm871419otl.69.2018.09.27.11.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:23:12 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:23:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/7] [media] ad5820: DT new optional field enable-gpios
Message-ID: <20180927182311.GA27227@bogus>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
 <20180920204751.29117-3-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920204751.29117-3-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:47:47PM +0200, Ricardo Ribalda Delgado wrote:
> Document new enable-gpio field. It can be used to disable the part

enable-gpios

> without turning down its regulator.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> index 5940ca11c021..9ccd96d3d5f0 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> @@ -8,6 +8,12 @@ Required Properties:
>  
>    - VANA-supply: supply of voltage for VANA pin
>  
> +Optional properties:
> +
> +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity of
> +the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
> +GPIO deasserts the XSHUTDOWN signal and vice versa).

shutdown-gpios is also standard and seems like it would make more sense 
here. Yes, it is a bit redundant to have both, but things just evolved 
that way and we don't want to totally abandon the hardware names (just 
all the variants).

Rob
