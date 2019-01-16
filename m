Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E7F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547611648;
	bh=2HlDFwn84+HFe+4yBNCkldUE7+7VKyYJQ2UorUXUktI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VAGsoenpEyyLGyzpejxtMYRmCjAKMMnxKXGfb9nN3tKMCanC26NkFxlit6T79CqXZ
	 GSXmlCsIj5adP8oR6ZwNgMT0CyDehKIJ87Me+okdNdF7uV+jqOP8ctHWVHAM9rDW4w
	 XmyNANjIPWw7rG0SQCxlGT2WV80ZgIdwvCSs3mj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfAPEH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfAPEH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:07:26 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6CF2087E;
        Wed, 16 Jan 2019 04:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547611645;
        bh=2HlDFwn84+HFe+4yBNCkldUE7+7VKyYJQ2UorUXUktI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fRYsuG00CR5eQPKPV2q221wxX8fEcjL6EWTdEwR4BDPIr0WrMaUn3EMx9OvySWslT
         k+n7rBN3sAU8+RED/R9OD9QcEhmlj8gjkBYAHg18n1Y1/I/wdRwZeUn2hsDAK30itb
         fzkdjNtH73Y6ckaGpLD2G9y8wyKSGLjVj0X5CItY=
Received: by mail-qk1-f177.google.com with SMTP id o125so2980765qkf.3;
        Tue, 15 Jan 2019 20:07:25 -0800 (PST)
X-Gm-Message-State: AJcUukfNYiEvXjnCEKlfYnBX77tMZEHRJPzboxyPtKxfC4JErhQDPos1
        Q3HNCXklhzc/RYzhdyGVeBfaub9thaKBo1hQ2g==
X-Google-Smtp-Source: ALg8bN7OhhgKLjFlQNntw++eOnNgjBDqCJchN8L5+YbQl3pK+57waLH4sp5M0umV0VvGjHGvM7U2XJAp/ZRBPq3P2I0=
X-Received: by 2002:a37:a483:: with SMTP id n125mr5080568qke.184.1547611644713;
 Tue, 15 Jan 2019 20:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
 <20190114102053.16013-3-manivannan.sadhasivam@linaro.org> <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
 <20190116022100.GC15808@dragon>
In-Reply-To: <20190116022100.GC15808@dragon>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jan 2019 22:07:12 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
Message-ID: <CAL_Jsq+myeZ1n4X=KhHZjtPDHnGH=L65xxYbzMrt8Rq6Bur4Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for Oxalis
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.tropschug@ebs-systart.com, m.bittner@ebs-systart.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 8:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Jan 14, 2019 at 12:02:47PM -0600, Rob Herring wrote:
> > On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Add devicetree binding for Oxalis board in JSON format. While adding
> > > that, let's fix the description for LS1012A also.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index d34fe0749199..0f30142fe316 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -173,12 +173,13 @@ properties:
> > >                - fsl,vf610
> > >                - fsl,vf610m4
> > >
> > > -      - description: LS1021A based Boards
> > > +      - description: LS1012A based Boards
> >
> > Well, yes that was wrong...
> >
> > >          items:
> > >            - enum:
> > >                - fsl,ls1012a-rdb
> > >                - fsl,ls1012a-frdm
> > >                - fsl,ls1012a-qds
> > > +              - ebs-systart,oxalis
> >
> > Sort alphabetically.
> >
> > >            - const: fsl,ls1021a
> >
> > And this is wrong too.
> >
> > I you just change it, then we will be missing an entry for LS1021A.
> > What's the status of that SoC because there is no board dts file? We
> > should not have .dtsi files in the kernel which don't get built.
>
> Hmm, I do not see any LS1021A SoC .dtsi in the tree.  I suspect it's
> just a typo of LS1012A.
>
> @Leo, do we have a LS1021A SoC?

arch/arm/boot/dts/ls1021a.dtsi

Rob
