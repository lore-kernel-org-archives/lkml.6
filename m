Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C92C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6E42080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua1Pyymj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6E42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeJ2WDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeJ2WDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:03:08 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7924C2080A;
        Mon, 29 Oct 2018 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540818870;
        bh=i75QnIMYUhVgFatjnh8VmWpivfkBQDUPuDdSc3HwUe8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ua1PyymjgG/x9yEUauxWSM76L02aN6OSkXjSyAU+0nlFVxxlutLK/xh51a54o+CIZ
         rkLpLO5jys95aUxkOKoGkYEOMqMt1Akm1s4/WuWr49KB5bdHvvSSzem/ihXPh502V4
         ODBT7WODOsEawGNM48vCtuYqz3SHWOFXb8hVG/Ok=
Received: by mail-qk1-f178.google.com with SMTP id p3-v6so4843567qkb.5;
        Mon, 29 Oct 2018 06:14:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIbDXb5p02QuUM+rpw4ZPcrAmGuo1h2WXp0NTKK2UqPdB1UJqJw
        cMKNCh6auJxmU17dCxzty7XhURdFD3jjuCwMTw==
X-Google-Smtp-Source: AJdET5d4ARYqLsMGR0+tB/UhI3PDWqsh0pZ/E+1VEh3VRWK9VC6H5J0tl+ZWVyUvtXeYCWrMgAwY0WqgeoYgN30RcEQ=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr11779639qkg.184.1540818869677;
 Mon, 29 Oct 2018 06:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181025072349.15173-1-jiada_wang@mentor.com> <20181025072349.15173-3-jiada_wang@mentor.com>
 <20181025214925.GA5197@bogus> <d6053012-85b1-3fbf-c35b-c5c5816e9fa8@mentor.com>
In-Reply-To: <d6053012-85b1-3fbf-c35b-c5c5816e9fa8@mentor.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Oct 2018 08:14:18 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+7VF2awqLeott3XTvNU6BgNit+Os+q4LfwDgYGdeA6KA@mail.gmail.com>
Message-ID: <CAL_Jsq+7VF2awqLeott3XTvNU6BgNit+Os+q4LfwDgYGdeA6KA@mail.gmail.com>
Subject: Re: [PATCH linux-next v1 2/4] clk: renesas: Add binding document for
 AVB Counter Clock
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 9:32 PM Jiada Wang <jiada_wang@mentor.com> wrote:
>
> Hi Rob
>
>
> On 2018/10/26 6:49, Rob Herring wrote:
> > On Thu, Oct 25, 2018 at 04:23:47PM +0900, jiada_wang@mentor.com wrote:
> >> From: Jiada Wang <jiada_wang@mentor.com>
> >>
> >> Add device tree bindings for avb counter clock for Renesas
> >> R-Car Socs.
> >>
> >> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> >> ---
> >>   .../bindings/clock/renesas,avb-clk.txt        | 19 +++++++++++++++++=
++
> >>   1 file changed, 19 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/clock/renesas,a=
vb-clk.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/renesas,avb-clk.t=
xt b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
> >> new file mode 100644
> >> index 000000000000..03bf50b5830c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
> >> @@ -0,0 +1,19 @@
> >> +* Renesas AVB Counter Clock
> >> +
> >> +The AVB Counter Clocks are provided by avb_counter8 Clock Generator,
> >> +avb_counter8 has dividers which operates with S0D1=CF=95 clock and ha=
s
> >> +8 output clocks.
> >> +
> >> +Required Properties:
> >> +  - compatible: Must be "renesas,clk-avb"
> > Should be SoC specific?
> yes, avb counter clock is SoC specific, I will move avb clock node to
> Soc .dtsi in next version

The compatible string should be SoC specific too then.

Rob
