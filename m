Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D20206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D20206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeK2Fpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:45:38 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38239 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeK2Fpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:45:38 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so9294167uaa.5;
        Wed, 28 Nov 2018 10:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uy8Pk9AsTSQ45pNcTHcAZ5jG30rLshjc1LohcGIefVU=;
        b=InQpm4RE20Mjy/GrLIAmPzYYYJUAzQ/6cejD2yHrAbj18EkOb5eARxTcK072Bi8VaE
         7krA1zS2RITxciOlBdTlS8JBG8xyT7sktm9UebQ7o/brDpvTJVsbhYDUNkLtnPcsVEgG
         jf8HFlInjAJisvLiToUTSfARS3OBAwKbs1Hnm0WlEalyj/uDN6wLUeqhkUgjW51nou0C
         EykOWPpROkwmmWjryi2Oq3w7PgHnolNAjA7DPNxF6Ig4bEVJJLyXW/n6emZLiQZznuXX
         vpXwp17h342A2oTw42zU2snPraxbammWLqAYc9NbHafgFZ+4F2uqhS5Sez/ue8cFDANS
         kl9w==
X-Gm-Message-State: AA+aEWY8iy8WB18grplCtNAyzks4bZy9ux2I11h+hjbsWLTma6famile
        Isy+vGHqevWcpyowYLZwZ7AVoo/YPYUYREvuuvw=
X-Google-Smtp-Source: AFSGD/WxFJGdv66fRo8JZbROl+3VVXIwDm+PT1YL0xhFdtWwbSx6WSB+YH0WtVpzQsNjXkW/3ckfF8k6h9nbSxepOuU=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr15112205uae.75.1543430582149;
 Wed, 28 Nov 2018 10:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20181128183702.231609-1-sboyd@kernel.org>
In-Reply-To: <20181128183702.231609-1-sboyd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Nov 2018 19:42:50 +0100
Message-ID: <CAMuHMdXk8Uoqw05uEqUvXfzQjdgLHLPEDqVvAMETE6BDDHyybw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: Mark rza2_cpg_clk_register static
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 7:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
> This is only used in this file, so mark it static to silence a sparse
> warning.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
