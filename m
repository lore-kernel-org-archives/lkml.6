Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F296C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CE3206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550857063;
	bh=R05J4YFBiOMBaIaftT39Ifhl0DhkG6xkElL25wNgz+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n2eezj74ZhCfXOPvcNV08WPk+pGohsaZe6F1Fba/Oo2LK0R0Sd0jXpqj+VlWoVtNk
	 LR0h//mL/Nz4eGP0FXp+b35bOP4VcLMpiPr5Juk1yyzKhONcYTmtWhd5/FX9m+rKiK
	 R83YnyBYg44Z7coTbcRRZ5V/7ZkckIDikNJZzOmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfBVRhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:37:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41008 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBVRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:37:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id e7so2331145oia.8;
        Fri, 22 Feb 2019 09:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGQIM3GpgLZbnfp+DGR8UCIwyuFKStrA4F203lEZjdg=;
        b=i36K8+CscmEO6tq9wmlpTiscyknGvBulailDDsCN2+zJT6e1dYOA/wYXpW6y/G3keU
         fc10wsr1Kp4CBLkBnXGl5UnK1AwkyhRgqxQBophICrJLfAAfhTjYkR+NXBVijYiEfear
         ZXavMUX3iUsjEr5G5U8OUCovD9hl8AWfaT55toSOpt2dEAzotwMmZsWT5m/a3cIh1OJC
         rNqljAP5beNYKvik2uXexVIl9PvmVp9MIz+DemvIFVYhR9RfBHXbYxofl038ZRYJvm/B
         TYaHRNqBuIhBfS80hzEwGPdcE9iCP730Pb2ZrHsKYoNumvwX7SRvQWzruwZf3kOIXxhc
         hE5w==
X-Gm-Message-State: AHQUAuZjcnh/XGU6G18K8WUm2vlLx/4m7rDzXv/0DAsDTTmRrPqa7++0
        j7YJJRwBRwoJDJz5+p7HCA==
X-Google-Smtp-Source: AHgI3IZUfBK9YOhRiNGj5F8GS3/KiwiNW9Rro1YvobOAtrHDZZVXK/BrseZVXFxmCt4lGYSTEbLUFA==
X-Received: by 2002:aca:3a87:: with SMTP id h129mr3358649oia.86.1550857060131;
        Fri, 22 Feb 2019 09:37:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r9sm750565otp.81.2019.02.22.09.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 09:37:39 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:37:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH V4 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead  of group number
Message-ID: <20190222173738.GA2168@bogus>
References: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
 <1550662447-8565-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550662447-8565-2-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 11:40:40 +0000, Aisheng Dong wrote:
> Not all 64 interrupts may be used in one group. e.g. most irqsteer in
> imx8qxp and imx8qm subsystems supports only 32 interrupts.
> 
> As the IP integration parameters are Channel number and interrupts number,
> let's use fsl,irqs-num to represents how many interrupts supported
> by this irqsteer channel.
> 
> Note this will break the compatibility of old binding. As the original
> fsl,irq-groups was born out of a misunderstanding of the HW config
> options and we are not aware of any users of the current binding.
> And the old binding was just published in recent months, so it's
> worth to change now to avoid confusing in the future.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v3->v4:
>  * add more commit messages to describe the compatibility break
> v2->v3:
>  * no changes
> v1->v2:
>  * change property name fsl,irqs-per-chan to fsl,num-irqs.
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
