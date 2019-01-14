Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E80C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B21E2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547488982;
	bh=Ev/n5b53GOCLb05qQdtq7PSdDCtXNFlR01DuJETX6ss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bJot5t45bjBWd/N0w+1A8J9CmFNx+fkcdSNh3wZrZha2OfiIYOV3RsOdOUWVp7p6V
	 0ElbINk/FFJSCZGXW4RzZ7UP9PafdSKVK5Ax4JfqK7nApeZdsB2FjGY8v0oxre/gOn
	 ABQZaoYOmuBmdJEwdLIA11vZGIdMsIr/BOjqk1m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfANSDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANSDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:03:00 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B91620873;
        Mon, 14 Jan 2019 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547488979;
        bh=Ev/n5b53GOCLb05qQdtq7PSdDCtXNFlR01DuJETX6ss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X/xXy5Tc/x0ttoGw74IeUMOkvHz3VBk4GocsfUWt5ipr3j24vSo3ZD1rJdoSytX+F
         +78P0K8j/A+6QKFV+ZemneCxRchOgQwBDtJE5j1LN0Sztt76H0Bl3RTQWvTdx34iP8
         p/rBb2vNFw8tbwImx6hoM4QkKqsmav1bokx3ePgE=
Received: by mail-qt1-f173.google.com with SMTP id n32so27517659qte.11;
        Mon, 14 Jan 2019 10:02:59 -0800 (PST)
X-Gm-Message-State: AJcUukc2TyFWrimK00K0HJ/pJv4VfaquENU9ow8ICiyI4U1KXPhFvKZr
        zekecfpsfn1CnBzjcFKTjo5F+L43waf2FHUuvw==
X-Google-Smtp-Source: ALg8bN7Vh5+gL2cUGcNomkkzpk/sAGgH5VukCTVPe7m8sXRyyLmwisB1+AFthfa9RhSZcQvi6fCsps/OJh0jaaOBTDA=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr23935497qta.38.1547488978744;
 Mon, 14 Jan 2019 10:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org> <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 14 Jan 2019 12:02:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
Message-ID: <CAL_JsqJpRPrCpRTpqh1v6JZwpEtZnaeuLTHR+0EiMSoxbk9zeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for Oxalis
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
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

On Mon, Jan 14, 2019 at 4:21 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add devicetree binding for Oxalis board in JSON format. While adding
> that, let's fix the description for LS1012A also.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index d34fe0749199..0f30142fe316 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -173,12 +173,13 @@ properties:
>                - fsl,vf610
>                - fsl,vf610m4
>
> -      - description: LS1021A based Boards
> +      - description: LS1012A based Boards

Well, yes that was wrong...

>          items:
>            - enum:
>                - fsl,ls1012a-rdb
>                - fsl,ls1012a-frdm
>                - fsl,ls1012a-qds
> +              - ebs-systart,oxalis

Sort alphabetically.

>            - const: fsl,ls1021a

And this is wrong too.

I you just change it, then we will be missing an entry for LS1021A.
What's the status of that SoC because there is no board dts file? We
should not have .dtsi files in the kernel which don't get built.

Rob
