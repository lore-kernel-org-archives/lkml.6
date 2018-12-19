Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57517C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F7620869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545251831;
	bh=1+z1U2ETRHl7/lSNYy+XCG0i3eKIe5ZGPy8c7PQOKRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CdkvyHEanJp2Gbw0oWSbOIElrTEglF5hIEWVe1fpjTNRMVevE3jqnGy1ycNv62WPm
	 PspqSPJksSZ4N5pHPmBT4eirR9maTWVt52FmzPkKUjWcN0Nxv/q16n4K9SKJRcu9zZ
	 OV4qby2Kd4xITH11SNXncdEBQa/gI3mWuv/6CUFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeLSUhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:37:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40365 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:37:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so20348683oth.7;
        Wed, 19 Dec 2018 12:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=usk1fd7QE5TIvv63FGxMIV2Wbz/Y+NgCQyLcmPts7w8=;
        b=RMUVUg7LEOYBEPckhqnTbouuy6QTE2fqgsDujei2sGUNdhFvHO15V44/FmTiX8PaK1
         /SIEMamPm/ts3C++vdi5cAXAP3uaAWnCxtBWHZWmDygdIS+joZPSAePSbv8xxs1l2ubz
         dQek19lDn56pucZYRYXR6JoG8o1/sL2tMnTB8O20nb3uFIiMx79dIeI8iMOm+9ltPFKO
         fMn4fDVjCAKm3EsNWogWbymFR8ZnqsI39DiVYHv2VAAFB8A/HgqQQ3rJTiauIjPnkcVG
         xk3Yxgj0FDr856ADVSXMChp56ulpLqekagZYxLaHvRP5Y7dcygNraFq19kvSk5bVT67J
         7w7A==
X-Gm-Message-State: AA+aEWac+mBt6TUzgnIFd7TJ4+XuzvYCwex7O6mEk7EaLKI1reiF72O2
        HL6G7a6LnDVFZCPgXmEj8A==
X-Google-Smtp-Source: AFSGD/U6EhvqDFn08nwBAgj9bXgFp2843GC9k6dHm+xyLWrlr3wA5UydSTeYplY2aKOPEdJ2KGUsiA==
X-Received: by 2002:a9d:6009:: with SMTP id h9mr17035174otj.349.1545251828843;
        Wed, 19 Dec 2018 12:37:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b23sm9124008otq.5.2018.12.19.12.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 12:37:08 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:37:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/4] dt-bindings: phy: ti: Add support for AM654x USB2 PHY
Message-ID: <20181219203707.GA28675@bogus>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
 <1544022206-2300-4-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544022206-2300-4-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 17:03:25 +0200, Roger Quadros wrote:
> Add support for USB2 PHY on AM654x SoC.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
