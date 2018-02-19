Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3667000-1519028718-2-1066569117477546594
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519028718; b=Cez+4r7Pes4aZz18CyT2SmZki4Xl0zLdo0ckRBB1QOk+U3J
    ikFb8E4hKUFo5k91mZN0Ly5Snk/1tLT6Gpji5RtBFvqpN2j9CQE70DhkjDmM56FP
    mjwkttgLKvvF6py6T139LgmxiXda9b9en0gXtlJjy0Hf4I3OORi7I446mNzRCRb0
    wnxljZsjA1jaEgCKCes1HkIhmjDY+qXXS0cX98G5F+2rNJw9WhtQXbciijFZ8+L4
    OuN9ZzLwIW16ajLMB4+bnYrewBd2nucu/Or+JEhhzk1k+Us6YM56KdTpBlos2TIH
    hAkEnJgrNzoE+qAx41KyFgY+sUcIiS0I0c25JQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519028718; bh=bhMdJ7upgAKk3j1wp+U7lr9wTnMUrdkl06zUhl
    1TC0s=; b=aHEMbE43ZLZPlKmUS3NSD+Hc5c0EviTmqV4KzzZG3Mpx7pc++6z6s2
    aIKlkwILr0QLOunCgyoMkg5qiW+CaxIk4HbKKlkiUY01wveTid/OZRWZ4jquJgcT
    aUb5ixfVEPdYqh1/m/5Z5Uux+tz/TK+LRWsQ3fRwfNHD63P2w4yKJy0aOcXhcnc1
    UnLFuRTkbAn2EvVyQPj943lJtdfBnUwZn2ow/oXbbOXwl0sz12e/9z04Sy4EK/C9
    S5a/J8hb/bPusAOZjTOSleut/WiQm11vNkij2hzMPDjVm5gwkZ3BkcbXcekj9UB/
    SU1H74aVoxN2YPd3EJTydbYY6JliJD+Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fA+4syMy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GAwAw7LO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fA+4syMy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GAwAw7LO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeBSIZQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 03:25:16 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37034 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBSIZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 03:25:14 -0500
X-Google-Smtp-Source: AH8x226l519n702KlJfVrtUx23I4vnFouDI1OuV/STj/avp+83tdwZQdjqxm/UzE32vo3ldIDmbcL9bjxZTbq7x/4cU=
MIME-Version: 1.0
In-Reply-To: <20180216152807.1629038-1-arnd@arndb.de>
References: <20180216152807.1629038-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2018 09:25:12 +0100
X-Google-Sender-Auth: rzEv6_jAEOB93zuw0DRwUoCHwKI
Message-ID: <CAMuHMdXgFcDkGAZuMviYAo6K-KOx5bBSRewed9AUWD+osfG2bw@mail.gmail.com>
Subject: Re: [PATCH] clk: fix false-positive Wmaybe-uninitialized warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        stable <stable@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,

On Fri, Feb 16, 2018 at 4:27 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When we build this driver with on x86-32, gcc produces a false-positive warning:
>
> drivers/clk/renesas/clk-sh73a0.c: In function 'sh73a0_cpg_clocks_init':
> drivers/clk/renesas/clk-sh73a0.c:155:10: error: 'parent_name' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    return clk_register_fixed_factor(NULL, name, parent_name, 0,
>
> We can work around that warning by adding a fake initialization, I tried
> and failed to come up with any better workaround. This is currently one
> of few remaining warnings for a 4.14.y randconfig build, so it would be
> good to also have it backported at least to that version. Older versions
> have more randconfig warnings, so we might not care.
>
> I had not noticed this earlier, because one patch in my randconfig test
> tree removes the '-ffreestanding' option on x86-32, and that avoids
> the warning. The -ffreestanding flag was originally global but moved
> into arch/i386 by Andi Kleen in commit 6edfba1b33c7 ("[PATCH] x86_64:
> Don't define string functions to builtin") as a 'temporary workaround'.
>
> Like many temporary hacks, this turned out to be rather long-lived, from
> all I can tell we still need a simple fix to asm/string_32.h before it
> can be removed, but I'm not sure about how to best do that.
>
> Cc: stable@vger.kernel.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, this is a known false positive.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/clk/renesas/clk-sh73a0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/renesas/clk-sh73a0.c b/drivers/clk/renesas/clk-sh73a0.c
> index eea38f6ea77e..3892346c4fcc 100644
> --- a/drivers/clk/renesas/clk-sh73a0.c
> +++ b/drivers/clk/renesas/clk-sh73a0.c
> @@ -46,7 +46,7 @@ struct div4_clk {
>         unsigned int shift;
>  };
>
> -static struct div4_clk div4_clks[] = {
> +static const struct div4_clk div4_clks[] = {

This change is not part of the fix...

>         { "zg", "pll0", CPG_FRQCRA, 16 },
>         { "m3", "pll1", CPG_FRQCRA, 12 },
>         { "b",  "pll1", CPG_FRQCRA,  8 },
> @@ -79,7 +79,7 @@ sh73a0_cpg_register_clock(struct device_node *np, struct sh73a0_cpg *cpg,
>  {
>         const struct clk_div_table *table = NULL;
>         unsigned int shift, reg, width;
> -       const char *parent_name;
> +       const char *parent_name = NULL;
>         unsigned int mult = 1;
>         unsigned int div = 1;
>
> @@ -135,7 +135,7 @@ sh73a0_cpg_register_clock(struct device_node *np, struct sh73a0_cpg *cpg,
>                 shift = 24;
>                 width = 5;
>         } else {
> -               struct div4_clk *c;
> +               const struct div4_clk *c;

... and neither is this one.

>
>                 for (c = div4_clks; c->name; c++) {
>                         if (!strcmp(name, c->name)) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
