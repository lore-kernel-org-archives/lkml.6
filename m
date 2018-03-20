Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-260780-1521515470-2-12732931977232055881
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521515469; b=jA1l0eL4znZDHYnR17U/acK0Kb9Cj57MRXaJbpSZJllbBWN
    Uc1Z5+ShduR3A2Sc8xOz7fjpbB9Enlcj8BgKpLOi7qGheKiEjQjDdyklDWIdQy4z
    zgSlwD8+Lx/U15hNpzhI254jDv+hHMWtVTtZ1veKMNp4nbhs6K6Dc/M6GWRDYoge
    EB4gpMDQOUK2toTAf7p6PEA8ZTNUzwBg73rRyUFIqIxpzxlKi98a2oHXfwYnOiVr
    bB0jRSHR7NvT4a9wEJ5OaJ3XZ+ONjLhkMjrqAXciOtdMg7ozwK6BO8a0TnRQV40e
    PMR+rgOvUp7rXJbKWKrTJ1u9Li1pTUOm05RSOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521515469; bh=SFGORCTqJVdQL1WCRUfDU2xmdHaBEz2+sBB2E3
    HotZ4=; b=I/hvENQthH5cOL9iSlWZrTD1zZTjNFFQTqEPaBEon+7pOFPpbnqegd
    pEhADnP4OjeKqfmqp/u1IcUJdeJTAqCJeR47rWuDDl3Qs5vKrCP495k8QEB8801p
    ZQqq1UNoTXctdO4Z/Ko3YdeJFL/ku1ZnSPqsR5p2w5Ga3KeJgfhRjKYqNGjleCqg
    qyYJ3QicbwG1CjATr04+vRKIT8ndNDFFuFJH45Qx7BVhTWiMrjTOHAl9jYCvUlbB
    mEcFrdksq//k/8p9MJsvf8zwgqwWdLKPGxvpy1UrzsrIInD6ZfMpWHA3HV7ycvHH
    yURaxwsfvw5lVveY9s5P3cnxDQrifz2A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Lse0jY5o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepjghfhfffkffuvfgtshhpjeesthdtredttddtjeenucfhrhhomhepvehhvghnqdgjuhcuvfhsrghiuceofigvnhhssegtshhivgdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpjeegrdduvdehrdekvddrgeehnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheekieejnecuvehluhhsthgvrhfuihiivgeptd
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Lse0jY5o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepjghfhfffkffuvfgtshhpjeesthdtredttddtjeenucfhrhhomhepvehhvghnqdgjuhcuvfhsrghiuceofigvnhhssegtshhivgdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpjeegrdduvdehrdekvddrgeehnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheekieejnecuvehluhhsthgvrhfuihiivgeptd
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeCTDLG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 23:11:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54753 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeCTDLF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 23:11:05 -0400
X-Google-Smtp-Source: AG47ELvuhPgAsMsv99ETsumn+tUceiGZpOTlgvL0h3/h45q3eEj8MoElgf7OiZG0QlCvkfTy2G0tGw==
MIME-Version: 1.0
In-Reply-To: <20180303222716.26640-109-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com> <20180303222716.26640-109-alexander.levin@microsoft.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 20 Mar 2018 11:10:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v67rPBSPy8e8CXtWzwKW8eeqjj=JyTnYPNH5mJ01yB7haw@mail.gmail.com>
Message-ID: <CAGb2v67rPBSPy8e8CXtWzwKW8eeqjj=JyTnYPNH5mJ01yB7haw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset
 and minimum value for DDR1 PLL N factor
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Sun, Mar 4, 2018 at 6:28 AM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> [ Upstream commit 68f37d862403e8f95337b2eca90af15d0b8cd5d7 ]
>
> The DDR1 PLL on the A33 is an oddball amongst the A33 CCU clocks.
> It is a clock multiplier, with the effective multiplier in the
> range of 12 ~ 255 and no offset between the multiplier value and
> the value programmed into the register.
>
> Implement the zero offset and minimum value of 12 for this clock.
>
> Fixes: d05c748bd730 ("clk: sunxi-ng: Add A33 CCU support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> index e1dc4e5b34e1..bdbaf26f551f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> @@ -159,13 +159,17 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
>                                         BIT(28),        /* lock */
>                                         CLK_SET_RATE_UNGATE);
>
> -/* TODO: Fix N */
> -static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
> -                                 "osc24M", 0x04c,
> -                                 8, 6,                 /* N */
> -                                 BIT(31),              /* gate */
> -                                 BIT(28),              /* lock */
> -                                 CLK_SET_RATE_UNGATE);
> +static struct ccu_mult pll_ddr1_clk = {
> +       .enable = BIT(31),
> +       .lock   = BIT(28),

As you undoubtedly noticed, this does not build. It needs commit
cf719012b232 ("clk: sunxi-ng: mult: Support PLL lock detection")
to be applied first. They were part of the same series.

Incidentally, how can we note these kinds of dependencies to make
life easier for stable kernel maintainers?

Thanks
ChenYu

> +       .mult   = _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 6, 0, 12, 0),
> +       .common = {
> +               .reg            = 0x04c,
> +               .hw.init        = CLK_HW_INIT("pll-ddr1", "osc24M",
> +                                             &ccu_mult_ops,
> +                                             CLK_SET_RATE_UNGATE),
> +       },
> +};
>
>  static const char * const cpux_parents[] = { "osc32k", "osc24M",
>                                              "pll-cpux" , "pll-cpux" };
> --
> 2.14.1
