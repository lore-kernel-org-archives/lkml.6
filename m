Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA53ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D0521479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f90ll0rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D0521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJSVp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:45:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44502 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbeJSVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:45:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id x24-v6so6696832qtx.11;
        Fri, 19 Oct 2018 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vpiaLaLMi/AXmZ69e+QiLJnlaqPAl7+SFQzHn5Neoo=;
        b=f90ll0rYu9PbRm71GsMcqrT09h7ro0Ifh1DXEEYceOB0Y+IwKjW1V3T2CGwS8wFAbJ
         l9GjQkSeRSYbbH1+2ikc4BYOdg3q1+0mA0X41PizAnOr8qpQOgSqSwQ1v/241KyTjcb9
         3MGPM2b2U241thh/NAgZsFsETmOpwLRDs3rbMHdcyEFJ343Vwh5EzY2SpySrJfmzLR8C
         FOX1CzrE0pPLplIwXRdoJFQ4GLKb+L+rrd6rjC3p5qtKMeW/bNuj/mdMI0IqW79ESl5k
         u2ahVR/3FhqzvcT/75Zh3zTQJ0fsPCTJOD86/0m6WTK4duUa1FNONjVbsTvB9iURSeci
         4YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vpiaLaLMi/AXmZ69e+QiLJnlaqPAl7+SFQzHn5Neoo=;
        b=OzJD/JroNb4BqCzVt9coRRgHxl8RZfBa4eXZGNpmivIn+qilWcMJXCh0a2iHMUhwgL
         lliqCJuojQxrnTBkL9VmIZVAhcL8Aqo2VkAtAnGMowMn1oxDYzV4DYglWEJgvcMeOww5
         zEFCXKpj2lJ1Dwic53ngQi7IP2MwSoe94KmPU+7YCnzFwKxubOhoUUgCPQaKT+Y+ngwK
         73xh+9QFdr0/RlRSjAp2JSXKQMxW7VGspwijtFvOPKHfrx6gKlUN+HBw0wygAJ2DhP0a
         l6JvoRdxFcz8KrxvTCe00M3U6buBk+5B36jxwD4sMbQUxsnqCjlpVhv7xWZBLOxTYzWK
         IH9g==
X-Gm-Message-State: ABuFfoikyoo9Ngng2Nz6n/JCtLWSbdurrvd8v3xXT3C6MA6KYo+6WI/r
        V0yfqqVYvqiagewV3025M7HnZwPHsaPMl+nU6pU=
X-Google-Smtp-Source: ACcGV61l7gnAMmNqROnK5/PmIR6umZfvoFg4V7rgoyWdGEeaV7jra/5kbEOr6PHk4wxIlfzcxVQaHDbWSUFiPFs6lY8=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr32674150qtc.194.1539956386643;
 Fri, 19 Oct 2018 06:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-10-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-10-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:39:35 +0300
Message-ID: <CAHp75VcwjoNT76F0qn=2CjETRCdNjX2P-GRLWT4pqJ-9Ch6+ZQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] Platform: OLPC: add a regulator for the DCON
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> All OLPC ECs are able to turn the power to the DCON on an off. Use the
> regulator framework to expose the functionality.

> +static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
> +{
> +       unsigned char ec_byte = state;
> +       int ret;
> +
> +       if (ec->dcon_enabled == state)
> +               return 0;
> +

> +       ret = olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
> +       if (ret == 0)
> +               ec->dcon_enabled = state;
> +
> +       return ret;

I would prefer to see usual pattern, i.e.

if (ret)
 return ret;

...
return 0;

This comment applies to entire series. (Yes, you might address an old
code in a separate patch to be on consistent side)

> +}

> +       return olpc_ec_set_dcon_power(ec, 1);

defined as boolean, supplied an int. Not good.

> +       return olpc_ec_set_dcon_power(ec, 0);

Ditto.

> +static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
> +       return ec->dcon_enabled;

Ditto.

-- 
With Best Regards,
Andy Shevchenko
