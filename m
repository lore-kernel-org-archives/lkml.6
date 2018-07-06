Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35317C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45F4240BE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4x1CZJ5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="CKnMJL35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45F4240BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753661AbeGFA7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:59:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46030 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeGFA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:59:04 -0400
Received: by mail-qt0-f195.google.com with SMTP id y5-v6so8718495qti.12;
        Thu, 05 Jul 2018 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8Q1bAwGL8W801OWtAxnFYjlIUbh0AHoIWFL6HIvnbtg=;
        b=J4x1CZJ5iLQR4hyzkbB7LCdt6Rai3fBE8vIGvUpa+Uu6pP7FYw/YcpBrT3CkiA861Q
         7ItlCxM9DZV9XQ4TnfNrsAGDNFWwnUYS1ryJautd8NTqdBfgGfKEFTiM5v10eI8O5hl5
         v+QRQ3MydBs43fDNWHfeLFLrXkewu8Z2N/gZz0RkATYHQFWiEaEbM+rBbWayyf818/q9
         03MTEjiPPYmFk+8W+bwXWZIEjz1TaBNqx/mUJOf2iM+QqUqdA7XAWIAqVglIc31K/OB6
         awaayoexmLiO4uYoajZQpX/80HD9jFmr5T33cE8vxfrFQLpvj5VLYNXtWNVb85x1alrt
         7B3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8Q1bAwGL8W801OWtAxnFYjlIUbh0AHoIWFL6HIvnbtg=;
        b=CKnMJL35o4rXpqxKDLSlRkmviK6OvKJGS0Tgc0JSGoYAhZa76SnqdNxy0S312WcxaL
         PFAbTZNXM0PN7aA+VC3fzsvu4IVL1infTcSQ0ljfB7Puqw2wZ4znR+sY+g5R3ZCyl3gp
         kW1sYPxJ+qeJRVIn33JTzUMjQToAZWQE5x0x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8Q1bAwGL8W801OWtAxnFYjlIUbh0AHoIWFL6HIvnbtg=;
        b=mP03Cvd/r/cEKidTnyYGMdP4R+0cCgg9jFduTkmkciDp1U2dLjAtV8htcve7mQNggz
         syxFDgdBB3KMSCzODlBneVY1SpnHBQrKlYWOOE3q4nVK3TZ2i9OPjUj0GZ+nvduEa2xj
         F5HAYlz92GBeEDOgBS255uU7FcsFTQkme4T+SZHvsxdWZpLOremv0NOun+QcISB/puR9
         dEHyAu3DS6lWlGmXGpCYJVOwr2DayIMRgpKwOWeecJSicWLlLb1LSmGuXHgEsPVyKyDS
         TVMRjfd+e41y5vTxAeDn4+rvEKZ6H5aAlBHk7X4z6+GHCHZQN0elozY5wqyLCjncjA2q
         gqqA==
X-Gm-Message-State: APt69E1MOSpLf7hrI8NrG+caiiJcMDJtWZ8s1RJC+Rm4X70YWeDvxOck
        sfs615ErJaEOT3aE69nK9PbhCcKD6vVewYfjYtilxw==
X-Google-Smtp-Source: AAOMgpde3tWcyCiF4MKO96g4u5rXys56kDmjaxh9M2NQVZVO+DUTY1xlvwKG+DXn6gPQoznpeji+NQqV77M3VIykgqM=
X-Received: by 2002:a0c:8283:: with SMTP id i3-v6mr7150586qva.21.1530838743712;
 Thu, 05 Jul 2018 17:59:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 17:58:43 -0700 (PDT)
In-Reply-To: <20180607070959.31995-1-joel@jms.id.au>
References: <20180607070959.31995-1-joel@jms.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 6 Jul 2018 10:58:43 +1000
X-Google-Sender-Auth: Io3wA9sG1_f-V1kbOlXxMDqOFtI
Message-ID: <CACPK8XeN6g1PW8ZvBMev=5it6z7sDJPd=pCwkcp+2fLsQ4_rmA@mail.gmail.com>
Subject: Re: [PATCH] clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 June 2018 at 17:09, Joel Stanley <joel@jms.id.au> wrote:
> This is used by the host to talk to the BMC's PCIe slave device. The BMC
> is not involved, but the clock needs to be enabled so the host can use
> the device.
>
> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
> Cc: stable@vger.kernel.org # 4.15
> Acked-by: Andrew Jeffery <andrew@aj.id.au>
> Tested-by: Lei YU <mine260309@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Ping?

> ---
>  drivers/clk/clk-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 4d425594999d..c17032bc853a 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -91,8 +91,8 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>         [ASPEED_CLK_GATE_GCLK] =        {  1,  7, "gclk-gate",          NULL,   0 }, /* 2D engine */
>         [ASPEED_CLK_GATE_MCLK] =        {  2, -1, "mclk-gate",          "mpll", CLK_IS_CRITICAL }, /* SDRAM */
>         [ASPEED_CLK_GATE_VCLK] =        {  3,  6, "vclk-gate",          NULL,   0 }, /* Video Capture */
> -       [ASPEED_CLK_GATE_BCLK] =        {  4,  8, "bclk-gate",          "bclk", 0 }, /* PCIe/PCI */
> -       [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   0 }, /* DAC */
> +       [ASPEED_CLK_GATE_BCLK] =        {  4,  8, "bclk-gate",          "bclk", CLK_IS_CRITICAL }, /* PCIe/PCI */
> +       [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   CLK_IS_CRITICAL }, /* DAC */
>         [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",        "clkin", CLK_IS_CRITICAL },
>         [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",     NULL,   0 }, /* USB2.0 Host port 2 */
>         [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   0 }, /* LPC */
> --
> 2.17.1
>
