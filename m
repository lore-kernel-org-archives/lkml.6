Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C3C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736C820880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZ/RorbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfAUHNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:13:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36179 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfAUHNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so9699082pfc.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOM/uD0QCo+R8A70jLNHCXKLD6NDSRQnu6GicijX3uM=;
        b=KZ/RorbYqB6p82S5YpiClVd/+5Uz+NUJcryFloOg44jqPBITRgYtnEbxjakwy7V9EF
         oLLehle6x6lODRX0i1emydEOoV7Wi73TctV4ahHgLt7yMok3e7Ti/CRrDPg4HaO/yi0t
         SNguuz/pTmEgy+2nEFA+hn9LFFLU3Wvkxg58Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOM/uD0QCo+R8A70jLNHCXKLD6NDSRQnu6GicijX3uM=;
        b=tA0vMJ+Df2xVxMQkXzXfHYSuerdbGGFPC+EKFQKoRhUVn+XpguN6NjNC+WWcBGzzAx
         EMGNMalmZxj0h/Blmt9hGy8Y3lZ0+slWxFtgb+IqYkrXaqpykz6Vb0UGAfc2TDZ0he4k
         TEowg38Qpq06igaVL6iNr7n+WV5hmTXCpOkg+RLgHm129lxjIFaaQRyy8+nhidrtuOvE
         y/lntkpkiUCgyO9OEvKSriPK1kpGdenIb631AF7/hGjlTnKtVgW4JiL6XJWTlHEObg8U
         HyEQfy4XI0xREaGjcs6YVp9h+Z8P82PpiQzmNDW7/1sX4fr1gQ7Ag1aFMgXxaxcW7R1C
         3jZQ==
X-Gm-Message-State: AJcUukdtiNoMajaYZ3/OGnM7HC9bke2AXgBXvqnOt+RsPib8NHFSopd3
        XOa2Hli5lFWfEI3vCx11hfv9
X-Google-Smtp-Source: ALg8bN5tEuiDvy/7UjSiOHIjPc1PRhcF/jybPjBK96SHNgTi6RXlqFvivbKwuNKTKBfHsET2NRZ5LQ==
X-Received: by 2002:a63:f65:: with SMTP id 37mr26796456pgp.238.1548050999815;
        Sun, 20 Jan 2019 22:09:59 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:620d:6d18:8cdf:8a2:4d22:45a8])
        by smtp.gmail.com with ESMTPSA id 186sm24903247pga.36.2019.01.20.22.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 22:09:58 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:39:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Yang-Leo Li <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.tropschug@ebs-systart.com, m.bittner@ebs-systart.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
Message-ID: <20190121060950.GA8713@Mani-XPS-13-9360>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
 <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
 <20190116101441.GH15808@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116101441.GH15808@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:14:43PM +0800, Shawn Guo wrote:
> On Tue, Jan 15, 2019 at 10:07:12PM -0600, Rob Herring wrote:
> > On Tue, Jan 15, 2019 at 8:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> > > > On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > Add devicetree binding for Oxalis board in JSON format. While adding
> > > > > that, let's fix the description for LS1012A also.
> > > > >
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > index d34fe0749199..0f30142fe316 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > @@ -173,12 +173,13 @@ properties:
> > > > >                - fsl,vf610
> > > > >                - fsl,vf610m4
> > > > >
> > > > > -      - description: LS1021A based Boards
> > > > > +      - description: LS1012A based Boards
> > > >
> > > > Well, yes that was wrong...
> > > >
> > > > >          items:
> > > > >            - enum:
> > > > >                - fsl,ls1012a-rdb
> > > > >                - fsl,ls1012a-frdm
> > > > >                - fsl,ls1012a-qds
> > > > > +              - ebs-systart,oxalis
> > > >
> > > > Sort alphabetically.
> > > >
> > > > >            - const: fsl,ls1021a
> > > >
> > > > And this is wrong too.
> > > >
> > > > I you just change it, then we will be missing an entry for LS1021A.
> > > > What's the status of that SoC because there is no board dts file? We
> > > > should not have .dtsi files in the kernel which don't get built.
> > >
> > > Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect it's
> > > just a typo of LS1012A.
> > >
> > > @Leo, do we have a LS1021A SoC?
> > 
> > arch/arm/boot/dts/ls1021a.dtsi
> 
> Oops, I only searched arm64 folder.
> 
> So it seems the compatible of the boards below are missing there.
> 
>   ls1021a-moxa-uc-8410a.dts
>   ls1021a-qds.dts
>   ls1021a-twr.dts

So how should we proceed here? The above mentioned boards are lacking
compatible in dts files and I guess that's the reason they didn't get
mentioned in "fsl" binding file.

Should I just go ahead and add the compatibles for these boards and list
them in binding file?

Thanks,
Mani

> 
> Shawn
