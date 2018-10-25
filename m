Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7035CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9522054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9522054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeJZE5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:57:14 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46952 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeJZE5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:57:13 -0400
Received: by mail-vs1-f68.google.com with SMTP id l6so6365192vsj.13;
        Thu, 25 Oct 2018 13:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLdRxfNmP43TAn/OI9nfYuwiU+ICyhHouu8hZyiSeXk=;
        b=ftCFXyzNi6oRCFvw8WmwKvove9FWAZ088cthH7khdNxDTseB8zO328c7Ojk3+aD+h8
         GRnb8hDhEdHbU5GK2WAJZz0DXFffwFYqnHEULS8ZmaDI/FxXjUKFqIfh0PH40pyJ5c6H
         F+rTWsER1aphA7AiPGxTidFl5oMS82xARxgzwrmYQa++LGNv+MYT0kQn4EO8NtTLR3a5
         YCobkIP+pV0GkIRLNCegWmVyBShZWaRqFXDmttoINDk7AWDCSGgdztKpOQy9hXaZtxPV
         GX8rnHoynGQx+uUYPRFUjzrpWSsOh49oxWxnIqMGth7dlkU/Rcsb7icblo7HtVt+WOne
         dJgQ==
X-Gm-Message-State: AGRZ1gIWy90YiaFqBx7gar/VNlkpcS3nOqjk8AMIYtYovClzI0D8t/hq
        klEtioWlrLQlRnNktz6/7meCF9oVfQ73CB3YXw8=
X-Google-Smtp-Source: AJdET5e29UeDnnas9JzwcrqcShzQuQLfbgnsqtlnMEgsgx/LdyhRcVMvOykK9rsHyTDDLLFlVZq9uvE/r9ZVHjchK8U=
X-Received: by 2002:a67:f3c6:: with SMTP id j6mr309370vsn.96.1540498981252;
 Thu, 25 Oct 2018 13:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181025072349.15173-1-jiada_wang@mentor.com> <20181025072349.15173-4-jiada_wang@mentor.com>
In-Reply-To: <20181025072349.15173-4-jiada_wang@mentor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Oct 2018 22:22:47 +0200
Message-ID: <CAMuHMdUciu+SJR+CsrwzkdUtX3L82xAzqgtrybYmcq--sR7Wig@mail.gmail.com>
Subject: Re: [PATCH linux-next v1 3/4] arm64: ulcb: Add avb counter clock
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

On Thu, Oct 25, 2018 at 9:24 AM <jiada_wang@mentor.com> wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
>
> Add avb counter clock node to R-Car ULCB boards
>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
> @@ -32,6 +32,12 @@
>                 clock-frequency = <12288000>;
>         };
>
> +       clk_avb: avb-clock@ec5a011c {
> +               compatible = "renesas,clk-avb";
> +               reg = <0 0xec5a011c 0 0x24>;
> +               #clock-cells = <1>;
> +       };
> +
>         hdmi0-out {
>                 compatible = "hdmi-connector";
>                 type = "a";

Why would this belong in the board .dtsi, not in the SoC .dtsi?
(same for salvator-common.dtsi)

How is this intended to be used by the AVB?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
