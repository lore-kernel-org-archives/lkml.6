Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D09E1C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BBC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9gr5x2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BBC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935036AbeFMAvb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934717AbeFMAv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:51:29 -0400
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4D1208AE;
        Wed, 13 Jun 2018 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528851089;
        bh=l6a2Xe+6ojjGTnaL7wc5h/wXwrNSfU92eovdJg0qQO4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=O9gr5x2RFIQPZfMeZwG+5fV6ylu/97Zy4SXQqwteZKkwjfyW+K3OW/jITHywIFpG1
         mPAhyUEShoCO08qf1cZ8pFW1oZtknjHr2jvbzTtoGpZF4hTvx1ng9UFLLCjM5OflUZ
         1/RiuwmVjezPGtFj4puPsb6lkLOd+np3YL6agp8g=
Received: by mail-it0-f53.google.com with SMTP id 188-v6so1700456ita.5;
        Tue, 12 Jun 2018 17:51:29 -0700 (PDT)
X-Gm-Message-State: APt69E0QaKLS7Lnxi/lEyy9yGMmone9HDLiUO4IlQNQlooD0Z7UrD+ym
        1WAxfPiOjSB7nMBS7aCHFOJDvcRrmjtWWSfWjg==
X-Google-Smtp-Source: ADUXVKLV6s9wT6ta7JM/1LAQQLbG0s7yqig2+FrZgkIA6PHESuYZIHS73BH4E470VlyCg9IBSUD4p4roo4E3j5SJUbE=
X-Received: by 2002:a24:f04e:: with SMTP id p14-v6mr2747557iti.106.1528851088564;
 Tue, 12 Jun 2018 17:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 17:51:08
 -0700 (PDT)
In-Reply-To: <1528843243-29782-2-git-send-email-mars.cheng@mediatek.com>
References: <1528843243-29782-1-git-send-email-mars.cheng@mediatek.com> <1528843243-29782-2-git-send-email-mars.cheng@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 12 Jun 2018 18:51:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3LjA3yG7UvD7FyhCxF60xWuu=c4uXLW1wD7MCLWuOPg@mail.gmail.com>
Message-ID: <CAL_JsqJ3LjA3yG7UvD7FyhCxF60xWuu=c4uXLW1wD7MCLWuOPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ndings: mediatek: Add bindings for mediatek MT6765 Platform
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:40 PM, Mars Cheng <mars.cheng@mediatek.com> wrote:
> This adds dt-binding documentation for Mediatek MT6765. Only
> include very basic items, gic, uart timer and cpu.

Check your subject...

>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
>  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
>  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index 7d21ab3..6e42251 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -11,6 +11,7 @@ compatible: Must contain one of
>     "mediatek,mt6589"
>     "mediatek,mt6592"
>     "mediatek,mt6755"
> +   "mediatek,mt6765"
>     "mediatek,mt6795"
>     "mediatek,mt6797"
>     "mediatek,mt7622"
> @@ -41,6 +42,9 @@ Supported boards:
>  - Evaluation phone for MT6755(Helio P10):
>      Required root node properties:
>        - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
> +- Evaluation board for MT6765:
> +    Required root node properties:
> +      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
>  - Evaluation board for MT6795(Helio X10):
>      Required root node properties:
>        - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> index 07bf0b9..c8eda80 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> @@ -11,6 +11,7 @@ Required properties:
>         "mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
>         "mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
>         "mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq": for MT6797
> +       "mediatek,mt6765-sysirq", "mediatek,mt6577-sysirq": for MT6765
>         "mediatek,mt6755-sysirq", "mediatek,mt6577-sysirq": for MT6755
>         "mediatek,mt6592-sysirq", "mediatek,mt6577-sysirq": for MT6592
>         "mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq": for MT6589
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index f73abff..742cb47 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -8,6 +8,7 @@ Required properties:
>    * "mediatek,mt6582-uart" for MT6582 compatible UARTS
>    * "mediatek,mt6589-uart" for MT6589 compatible UARTS
>    * "mediatek,mt6755-uart" for MT6755 compatible UARTS
> +  * "mediatek,mt6765-uart" for MT6765 compatible UARTS
>    * "mediatek,mt6795-uart" for MT6795 compatible UARTS
>    * "mediatek,mt6797-uart" for MT6797 compatible UARTS
>    * "mediatek,mt7622-uart" for MT7622 compatible UARTS
> --
> 1.7.9.5
>
