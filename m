Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93317C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BC120645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrodUrFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BC120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeIJWWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:22:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46320 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeIJWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:22:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so10802448pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUNEpabK8W8PvysPAJIkuV+jocWJhcdETES82Us2rqI=;
        b=MrodUrFw1ijRLR7OAeXX9sD+QwA3zUZJ9004q2OsXK0j/J9ctfkzOEaa3bisLOAdc+
         /nupKHxDnwijtUxY7pcjGT5/Kva8YwkmU6o8boXMPTJbWQD3lIW59UYvhm8N+/So3vlu
         s7n4TlH5IKdTTa0l2gpnOK1ypBXlIrOt8GXwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUNEpabK8W8PvysPAJIkuV+jocWJhcdETES82Us2rqI=;
        b=SOkL9KMQjzFQ1k48hScSMlgYpoOJjEAIlYjET/VfcZXz2m+ovqWNwt0eJnM/XjETrk
         63cfxraSE+ylwEP9oSMtMyFztKIAeKLRL4kzvLnqsHDtEMwbKWbiyB8Zgd/rPXTINPMV
         P0Pm2LTvAFc/+NgacZaXDJxVuyOoKbJZp664h+Nhk7DSqRDx08vR+McQHWjljSE6AsHg
         3DcIrByS1XFwClUPmhCqsmbq1Ad7CzW8ISV9uTpxZ6lFURDdknWkwDRFnFJWphQitqiI
         Y/guhOu27NtmB0pcuUVa8qa06QYyz35K4miO94x3i4jG328RE45CDoSDgiu3q8mLbnkm
         QM1w==
X-Gm-Message-State: APzg51CA5KkGiOj0JSxO1GJ0szliYexXOQZEgCu9GgZgSm1/28tSmmAb
        /8N5m1mermT6f9SAdWGUuiWg
X-Google-Smtp-Source: ANB0VdaGl4j4lnm7uJ3Qzqe/e91LdnjeisUQZFFtRSstUJNP6fRmX+WURh8M6r5JxK32Y45q7YN++Q==
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr25046702pfb.94.1536600454365;
        Mon, 10 Sep 2018 10:27:34 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([157.50.71.251])
        by smtp.gmail.com with ESMTPSA id o10-v6sm31292529pfk.76.2018.09.10.10.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:27:33 -0700 (PDT)
Date:   Mon, 10 Sep 2018 22:56:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: arm: rockchip: Add binding for Rock960
 board
Message-ID: <20180910172655.GA4191@Mani-XPS-13-9360>
References: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
 <20180910151356.25946-3-manivannan.sadhasivam@linaro.org>
 <1606406.b630GQBvc1@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606406.b630GQBvc1@phil>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Sep 10, 2018 at 07:22:26PM +0200, Heiko Stuebner wrote:
> Am Montag, 10. September 2018, 17:13:54 CEST schrieb Manivannan Sadhasivam:
> > Add devicetree binding for Rock960 board from Vamrs Limited.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> > index acfd3c773dd0..aaad9e2ff9a3 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> > @@ -5,6 +5,10 @@ Rockchip platforms device tree bindings
> >      Required root node properties:
> >        - compatible = "vamrs,ficus", "rockchip,rk3399";
> >  
> > +- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
> > +    Required root node properties:
> > +      - compatible = "vamrs,rk3399-rock960", "rockchip,rk3399";
> 
> hmm, are there more boards labeled rock960 from Vamrs?
> Because I'm trying to determine what makes "vamrs,rock960" unsuitable.
> 

Not that I'm aware of but the intention was to follow other RK3399 based
boards. Anyhow, I have no issues with "vamrs,rock960" if you prefer it!

Thanks,
Mani

> 
> Heiko
> 
> 
