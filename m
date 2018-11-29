Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBEBC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756DD2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1ztXljT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756DD2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeK2RA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:00:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36193 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeK2RAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:00:25 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so618105ioh.3;
        Wed, 28 Nov 2018 21:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/PZuBQYJ5T8N0KQkJXbf6ozyCLnd9UblNtdD32Qm8U=;
        b=W1ztXljTFsViPOzN3HEXY1zuL/RbJk/1WKL7nkWVO7XtKwYZG6rjmAy7TyuBJxPvwf
         2USYEKeBg2bgwmN3r3mtSXkexJDfWpf65tOcLmCV0u4vTJCtmtZW2u5OjwYRk/8mpjAh
         KDFkkOt/wR0gtpCH4VIqwyOyrDK965R42V6LUxMDMUu6ooIiyfKHxEIAkij/haAHr+pF
         /jRVl/dya/Jm6AiucfpQ819ZoEuowpK7DPjvhyCuuiLOMfRZ1Oy+pqPDFqVNW5SPrPO6
         OQ/80xslzEdpBzqH1TRLc1ow4FCMh0xIEtsgVW0HFd0Qz+nJQ//cPHwp6ATo6rOShNNL
         oncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/PZuBQYJ5T8N0KQkJXbf6ozyCLnd9UblNtdD32Qm8U=;
        b=mmw/SIGI7GqTANi8Qb/MAd84CkGTTdk98P4WVizFi9tDND+mRDKM8fDmODWwGmB8tM
         +N8YIQ41ZRyl/zUNBpy3jV2JfqbkKMADB9EpGm6tjmDX7JL9lsOOVmZ83vTxx3GAA9Sx
         liw3V4+PBcImFh2XqUPEhL7w4fjUsMjFzdqfgRQ6WmfT6knX/2qG/v45100QZ1WYNQqg
         lEHHCtt7Fw2fGg0TJinz+Xsx+GUEXFSEA5bZ89L5c/uKvT4JCQ90jDNjcXpBBLZjfGC4
         +t9OdUPVhvN46xL/REo7nFldbDu/3qZM0yCetETjknXDONxv02auJ2WxZM2PHVWPvz6j
         bA1w==
X-Gm-Message-State: AA+aEWZrkLOOp9gldg2/8twMvtolWnDWFfdzvV28ARwqfxem1oq6D2k+
        OzVDLD6Or8ARm7wrYNnyKGL5JZVMQEoqSxynDypRVpBUFQU=
X-Google-Smtp-Source: AFSGD/WVjYzd3Qdrmnz9Ep3yinpTwTryV8d1fQ1aFzYtNJUfgw0diiWpqYtcYqQc6xlBSJzsBJr4lJVX73ELW+whAco=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr132134iom.7.1543470974704;
 Wed, 28 Nov 2018 21:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20181123150600.27445-1-tiny.windzz@gmail.com> <154344291239.88331.14159206270303255502@swboyd.mtv.corp.google.com>
 <154344317086.88331.8296424241716107824@swboyd.mtv.corp.google.com>
In-Reply-To: <154344317086.88331.8296424241716107824@swboyd.mtv.corp.google.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 29 Nov 2018 13:56:29 +0800
Message-ID: <CAEExFWtOR9JVdVnp_S6NHJypX_C=bhZueXq4QmzHL4Pu9+5SMw@mail.gmail.com>
Subject: Re: [PATCH] clk: nomadik: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     sboyd@kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 6:12 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Stephen Boyd (2018-11-28 14:08:32)
> > Quoting Yangtao Li (2018-11-23 07:06:00)
> > > Use macro to simplify the code.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> >
> > Applied to clk-next
> >
>
> Except this doesn't compile. I fixed it, but please actually compile
> your patches before sending next time.
Sorry, I will pay attention next time.

MBR,
Yangtao
>
> diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> index e331634d34df..a95aa96f4a68 100644
> --- a/drivers/clk/clk-nomadik.c
> +++ b/drivers/clk/clk-nomadik.c
> @@ -455,7 +455,7 @@ static const char * const src_clk_names[] = {
>         "RNGCCLK   ",
>  };
>
> -static int nomadik_src_clk_show(struct seq_file *s, void *what)
> +static int nomadik_src_clk_debugfs_show(struct seq_file *s, void *what)
>  {
>         int i;
>         u32 src_pcksr0 = readl(src_base + SRC_PCKSR0);
