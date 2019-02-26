Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2459217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLrU6ei2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBZMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:52:23 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42948 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBZMwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:52:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id s16so10189188oih.9;
        Tue, 26 Feb 2019 04:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8k1Z0VFjCjjQHvxoX7Za/EQykhNeDnmQXyAwoS85xeY=;
        b=DLrU6ei2+97mq1RDlMsRwyPD9mUiDg3hLdBdxSLvnGG3Og8x39aU5H2KurUzw8I7C2
         z5XOA5+/ee+WcwhkYu+l9gQBPRT7DhClgv/6e1wspXEsxSsrlpb+hYPLVl/ZdtrYX6Og
         vGgWzm1i/oGej/9X1n+Qh5mp4vd3Qyu3wDUVguoZXwqEzr3Ea1aLE7Ennfqxr4Z2N4gF
         i7OhICqw9UfjrYL+K4noMa+th5521c6z4QjgteFppDwkUbDY1lEg2NCnvZ2nKNHp3LLi
         l3SD5Mc+zFwHO8t+89g2saqv869iaUkCW6w5r3sOalywV9my+cF20ThEs9cgbC+mB7r0
         BJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8k1Z0VFjCjjQHvxoX7Za/EQykhNeDnmQXyAwoS85xeY=;
        b=SKN067LMvUA7XOa/WYMzBqdwH7XbeahFIvMG/HmMEDkCUauuBBlf7WS3YoE4m85Ce/
         xqoTYZl0ozty9yTsTv1a758HjH215NyoDno8l0h4qmj3G+X6690XWJtxEu6bROqVhAPF
         Dk5hKoCEjceSPV7uVLPY3As8zp04Qiwa7ObGm8JdNIoPKWAVxZuBLu3bErsAAP+vQYwn
         h47Vn969HXjCAbBs2RCykX53KmQoyFXWLe6YjmumhIxOFaWS6bSGlPmVbamTXTJH/Llj
         CHJSrc13UI0eidVcick2nGPEAKhdY/+x06STB1WJmLWirblkC33xPO4H5ewvVofI7MMQ
         Dong==
X-Gm-Message-State: AHQUAubctzKJEVvB/DG17JZKmJV8hFEXLcwiRzGm6OP8RnHFrjwS1zq3
        ME16nmPaNgxCmVbAVxXJxUP2jRT8MWsLJB9GlqM=
X-Google-Smtp-Source: AHgI3IZgeZ/KSBoBzsElf3ZOGbtERaW2fR2MUZu7Q6EODXkekVlUSsfEGjKeorYe+3GlMbzbnlvkm8isrtZk5Kh/B0Y=
X-Received: by 2002:aca:5083:: with SMTP id e125mr2316196oib.9.1551185541543;
 Tue, 26 Feb 2019 04:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-1-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Feb 2019 09:52:11 -0300
Message-ID: <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> On i.MX8MQ we can start the party using the wm8524 codec
> which gets it's data through the SAI2 interface.
>
> In order to make it work this patch series enables the SDMA nodes,
> sets the correct pinctrl configuration and uses the simple card
> machine driver to put everything together.
>
> Changes since v2:
>         - s/QM/MQ after Chris comments
>
> Changes since v1:
>         - added cover letter
>         - remove "fsl,imx8mq-sdma" compatible for sdma.

Why? It is good practice to add the new compatible entry.

In case we find out a need for a fix that only affects imx8mq in the
future we can do that by using the specific compatible and no dts
change will be needed.

>
> Daniel Baluta (5):
>   arm64: dts: imx8mq: Add SDMA nodes
>   arm64: dts: imx8mq: Add SAI2 node
>   arm64: dts: imx8mq: Add SAI pinctrl configuration
>   arm64: dts: imx8mq: Enable SAI2 for wm8524 codec
>   arm64: dts: imx8mq: Enable wm8524 codec

I would suggest making the last three patches as a single one.

Also, please make the Subject as: arm64: dts: imx8mq-evk when a patch
is specific to the imx8mq-evk dts.
