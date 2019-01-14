Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC5F20645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdKMZrEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANSLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:11:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45941 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfANSLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:11:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so10684837pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6GtwG3HAnkm37nX1xim6b7DZEer8Rmsl7NV2xIs5MOA=;
        b=kdKMZrEUrv93bBJrjGm/PP4q1YZxZVND1YoUArnL7rSFbBVUV9pCf2/n7LFiE6OvdP
         tCP+ATBkvB8G2ZE7iz6WGsoGKOcbOtDRPn6HOeRJaYC3ihwk0q48YdOlyb+dujgQfwbf
         01mpMLTkO66GBfEUdZ2w9RUwGdZ40JCk6h6qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6GtwG3HAnkm37nX1xim6b7DZEer8Rmsl7NV2xIs5MOA=;
        b=LtSSk00o10zi/xI8ffCZmUybCOWEPElU/qOFHHP0wEZQHRXoWEX3yfvXVZdqHIgZqo
         EZT1cGkWbCZ9SASTIIwLCcFQgfRrAN/tJimW4k/EnOD4n0fTyUax9wyzgTeKsaAc3pN3
         NZoaNbSmYbPkgWq7tacI3yVNg+TRwO4OCQ6eoTkjBsSo1MZvdyMETAFryyVc3uWgV8Il
         6jX1Yb/xkcDNoG1e8uc2lfvZzFAeJQqYzBiT1XAZG8KXgZEYHfpuzvFmMVRs0+0bMwuA
         /eZhj9EA/EC8wn32bm/uk+wO+XU3SeMaHA89d+Z1a/q6ANCeFDyrHcu8+6zM6q3PFkMw
         +HZw==
X-Gm-Message-State: AJcUukelq6wQ4t6EHTMqubSQaKnhvFuMwJEMp4mFZ74i18eMSKJzvzFb
        U6ZR9AIjCSXPBzPDcOV1F4z2
X-Google-Smtp-Source: ALg8bN74ZX2uUEWOkAMgpG0Kpwim7SBVthxcD3LPwAPRJXtBtGVuwNfpRYbJsO7AAuCZB2K4Tr1bsA==
X-Received: by 2002:a63:104d:: with SMTP id 13mr24091353pgq.303.1547489466279;
        Mon, 14 Jan 2019 10:11:06 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6388:942c:7d9b:d1a4:6536:aa21])
        by smtp.gmail.com with ESMTPSA id w88sm2973528pfk.11.2019.01.14.10.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:11:05 -0800 (PST)
Date:   Mon, 14 Jan 2019 23:40:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.tropschug@ebs-systart.com, m.bittner@ebs-systart.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190114181057.GA6636@Mani-XPS-13-9360>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add devicetree binding for Oxalis board in JSON format. While adding
> > that, let's fix the description for LS1012A also.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index d34fe0749199..0f30142fe316 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -173,12 +173,13 @@ properties:
> >                - fsl,vf610
> >                - fsl,vf610m4
> >
> > -      - description: LS1021A based Boards
> > +      - description: LS1012A based Boards
> 
> Well, yes that was wrong...
> 
> >          items:
> >            - enum:
> >                - fsl,ls1012a-rdb
> >                - fsl,ls1012a-frdm
> >                - fsl,ls1012a-qds
> > +              - ebs-systart,oxalis
> 
> Sort alphabetically.
> 

Okay.

> >            - const: fsl,ls1021a
> 
> And this is wrong too.
> 

Ah, I missed this ;-)

> I you just change it, then we will be missing an entry for LS1021A.
> What's the status of that SoC because there is no board dts file? We
> should not have .dtsi files in the kernel which don't get built.
> 

I don't know much about LS1021A. Shawn should have an idea!

Thanks,
Mani

> Rob
