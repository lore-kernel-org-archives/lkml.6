Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027392147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/6xiZvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBGLRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:17:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33385 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfBGLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:17:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so4634350pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q1Cia1wz+5mRCkHMYytkTgvIy7gLgYFs59E2XGQjZCc=;
        b=Y/6xiZvjSdnJhM6j/zki8qil3Ybc/r8bO9vx8LtPIQBMuwcgJWVg17dqthEvGGnbbv
         6v/hBI3qGAEiw02tmnm6d3FTjpa+yQMvzXeE1plc8IsQT4mZVhMf366l+ji79p1Cy3+W
         EtBwsB3sG0wmQzlTX0FDmXsZtRdsIJK847l/GOm4wuYAOJS5riWrS5F1qeJRB2TrCsr/
         Ivzd6bskDEBkexVtUYVO2ah0cMw7EAqBGN1i70aeYz49Rngq7bMPk1wHX/6YkzXK8wQ/
         kDl+LDEHv/4Fw1GlBCSRqVHfbtON5UJcRs9pSfAx7NRaMM4BqvQLTF/XfYGo6W+h9XWR
         nP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1Cia1wz+5mRCkHMYytkTgvIy7gLgYFs59E2XGQjZCc=;
        b=Uth4vgIwfg2k1traTOljPdG34ckM7Po8FISPBhdJmN5jCFTQjiMvi6bJglohc5hBpX
         vMbxOfmtmj0Uq1qkYfPVUUOCCnYEnhhyY/W3pwlvAIXWs0pWiHB5LRYtlFy/mbROS8GL
         ZupC5OXolX4V6K4/FM0SSNvKEsq0NOXr2DDHdOqw2SUErMj5kX/kSkR4I7cAU21k1XNU
         Scgn0tkA0g2MzNzEx0CcvQZ/F8NB7qpzT1EbJ8ILHcCFbE2l9n2s0aLVDkQPl47ijelQ
         JRoNLsDnkk+Jodx9/CAJiVzDPtbSOeIl3xY7V0iVuag9BQFS0lbXXoaiXt+IeR58xfKD
         1u1w==
X-Gm-Message-State: AHQUAuaWQwDXU8fc4qn/dJVSw5Jj6JQCqqsKG01qEr4ENEhrnSED04tB
        jAk/QIcjO3qSAqdnCGrSFmmX
X-Google-Smtp-Source: AHgI3IaTolTllKJ7hnsFOVC1XuKkbhT6P2f8fyuUS5y1sZsQYBC8NV5IIlJx7k/NWQx/Q8ssBCUTkA==
X-Received: by 2002:a63:4858:: with SMTP id x24mr14245500pgk.420.1549538253718;
        Thu, 07 Feb 2019 03:17:33 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730d:914e:a8b4:2532:ae24:7d86])
        by smtp.gmail.com with ESMTPSA id l8sm21650875pfb.68.2019.02.07.03.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 03:17:32 -0800 (PST)
Date:   Thu, 7 Feb 2019 16:47:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add HI3670 reset controller
 binding
Message-ID: <20190207111726.GA30269@Mani-XPS-13-9360>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
 <20190201153841.21903-2-manivannan.sadhasivam@linaro.org>
 <1549536094.4557.8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549536094.4557.8.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Thu, Feb 07, 2019 at 11:41:34AM +0100, Philipp Zabel wrote:
> Hi Manivannan,
> 
> On Fri, 2019-02-01 at 21:08 +0530, Manivannan Sadhasivam wrote:
> > HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
> > driver is reused for HI3670 SoC and the binding is documented here.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt     | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> > index 2bf3344b2a02..5d60ec541331 100644
> > --- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> > +++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> > @@ -5,11 +5,12 @@ Please also refer to reset.txt in this directory for common reset
> >  controller binding usage.
> >  
> >  The reset controller registers are part of the system-ctl block on
> > -hi3660 SoC.
> > +hi3660 and hi3670 SoCs.
> >  
> >  Required properties:
> > -- compatible: should be
> > +- compatible: should be one of the following:
> >  		 "hisilicon,hi3660-reset"
> > +		 "hisilicon,hi3670-reset"
> 
> If the HI3670 reset controller is compatible to the HI3660 reset
> controller, this could be:
> 
> - compatible: should be one of the following:
>               "hisilicon,hi3660-reset" for HI3660
>               "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
> 
> That way there would be no need to change the driver and it would be
> documented that the two reset controllers are compatible.
> 

Yeah, I thought about the fallback approach initially but was unsure
about which method to adopt. Will use fallback compatible in next
revision.

Thanks,
Mani

> regards
> Philipp
