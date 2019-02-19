Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D65C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFF4217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="i2Lr6wPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfBSB0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:26:49 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26113 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBSB0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:26:49 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1J1QYGa003087;
        Tue, 19 Feb 2019 10:26:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1J1QYGa003087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550539595;
        bh=Syvc8CYUnyJsga+YWR2VemKzeLLMgqDIsdamLYpWt6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i2Lr6wPRQ8hi+A49Jo7CgGnfNEUofXKy/F430HjcnO/PKC+waSYXzrL/VLzFgZfc5
         AVBAlH2sZUiKBq/ToftG/4boCMCPrz9wrnxF5/kCYP2FyG1lyrcoBV/WhoGQKnBpTa
         Jcq7qIbgmh0Lb0tZPib1f4HZ7Ay1CndCGyHgh2nFOSBUGhZl42wEoxyk7gMkT9yXL1
         RD7w6OQuCOpRBUJwMaw8DVD+MJmCz0Yjioc1eL0nZCua3CqJKGvfTTVtP+4d+ZI/Wf
         6jiWZUfYhWpDBeTMfZhjoGzpOXeAfNMJfxpahNPaDNpLK0VtRdYRCz7CzwI5lMJOSq
         IZFsf4K0bKY7Q==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id k5so1640262uao.2;
        Mon, 18 Feb 2019 17:26:34 -0800 (PST)
X-Gm-Message-State: AHQUAuYRuQbDITw0zRsq9Y9TRS6wVnCbLX5AvWWmmixRYB9Vy2DpbQ0z
        3/JGTMw5FKjlHKzjoDVwMY2rbpHaakU40eCZ4b8=
X-Google-Smtp-Source: AHgI3IZas5ygeL45f0Nha89sjRomBSU9T2uUd8P0L/EZiHQFjvc53s26SFm8p//v0TaUto4qUriOFaV6W60kzhImkk0=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr2581963uak.55.1550539593750;
 Mon, 18 Feb 2019 17:26:33 -0800 (PST)
MIME-Version: 1.0
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Feb 2019 10:25:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
Message-ID: <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 9:26 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds a DT binding documentation for the M10V and its evaluation
> board.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt



I added uniphier SoC/board binding into

Documentation/devicetree/bindings/arm/socionext/uniphier.txt


You can milbeaut.txt to the socionext directory as well.




> new file mode 100644
> index 0000000..9fd053a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/milbeaut.txt
> @@ -0,0 +1,6 @@
> +Milbeaut platforms device tree bindings
> +---------------------------------------
> +
> +- Milbeaut M10V Evaluation Board
> +    Required root node properties:
> +      - compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
