Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1472C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24A2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="HXkIzmGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A24A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeKGHoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:44:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32990 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeKGHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:44:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so6736598ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VdxuFMwGQV0m9VpNMFr1KgrEwQF0djPcDMtrmuA0Szc=;
        b=HXkIzmGEetC4n9jBkg77nxoNEvp6EcIIK03YhDs3X0Zr6EgNaEk4tLkrAbt5ORFFtD
         dcQu8n5M+Lvia5mzhyGvbsVqOOFQaNf/bPhoWbzesXm0XC+B5jDpeo94CfktdiWjd72X
         1sp1+Lh6HsloHkercDT5TbiG1gAXcXLsZ2XREIvglbqhPbu9mz6YaOTmktt734qHaW/J
         Q2EDTslVp1s/Kx4pm3HPhuQo99tpl97xK6hCkQpEsyewzmNX7KI61ycfXSFRGUNsgJ/H
         ccHjigw+7P9JBvxZ3cbyQUMEbXBPdDkBYwCnTLoGKDbcu4UbYic+K7ll8fWj2otPGDCg
         +xEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VdxuFMwGQV0m9VpNMFr1KgrEwQF0djPcDMtrmuA0Szc=;
        b=HxiFVlrfihvGy+ltknw8+mXtsWBUHAr4XmEdxBqLVnkwspoSM+1T4dvZC8WQigUmJp
         XIhP4eAghzqM0E3FJ8ixqMUqvUQN0ip7aue8F6dJLq7TMNart7AR4/1FlNoMEeFrJMZa
         UgIYPVS3OtJTSbFrxliaSsFIoWCpgr8Fba1VhzzIAhsYPiBV4ES/VGkeZ/MSZqsdsVim
         CeYDPFYoEXTXHX3sYJijiy4M+uDGKdANFpcRww4gncdjkn100CsoyByhpTJfoj+sr1d4
         f0ggUIaQodUVB9Rf4X1YXwxMJ+HfFaztVMD7BL9ixhsflhym+A0itNLkXkARdVfSKXcc
         wjEg==
X-Gm-Message-State: AGRZ1gINZn8KSfJ2n6woD9Qk8XwWchZKzvNtlhsVWZPgx+EwbY4x+3Dn
        eq+vLzZjdZJ+i/tyiCqsPjKQqkMo5mwDS+bb+s5w1n8UhQs=
X-Google-Smtp-Source: AJdET5fDa1wlE3AfHgkylqlc3zOjo6Bci/xyk1VqRmYzKYtpgdviBBZC6ecErwbKtE1SIMABJB0Z1ff7sPwnKl82S6k=
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr2050048ljg.160.1541542603077;
 Tue, 06 Nov 2018 14:16:43 -0800 (PST)
MIME-Version: 1.0
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 6 Nov 2018 14:16:27 -0800
Message-ID: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
Subject: [TECH TOPIC] SoC maintainer group
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, rmk@armlinux.org.uk,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KS organizers (and others),

This is a late topic proposal, hopefully there is still time on the agenda.

We=E2=80=99ve recently been discussing some maintainer model changes as
described below, and would like a slot to discuss the idea and solicit
feedback/comments from the others there.


This started with Arnd and I finally being in one place at the same
time, and talking about how we want to evolve arm-soc maintainership
moving forward. We've been independently thinking of ways to expand
the group and making it more self-service for everybody, but there's a
bunch of tooling needed to make it run smoothly beyond the smaller
group we have now.

In the end, we ended up looking at it from a slightly different angle:
Right now, when contributors show up with new platform support, the
first hill they need to climb is figuring out how they need to carve
up their platform among all the various maintainers, how to make sure
they're all handshaking on keeping things stable, and get code
submitted. It's awkward, not well documented and one of the biggest
overheads we have on our side as well.

When we started talking to other maintainers, we're also realizing
that we are currently duplicating a lot of work. In particular, we
often all get cc:d on patch series, so we all need to read and filter,
and assume that other maintainers spot the right patches, etc.

We have discussed a few different options, and it seems like pooling
more of the contribution flow to a group of co-maintainers is a useful
approach. Initially, we're considering the arm-soc platforms, clock
drivers and pinctrl drivers, which all tend to be affected by new
platform contributions in this way, and often end up cross-cc:d on
everything. Additionally, the flow for successfully merging a new
platform or SoC needs to be documented and advertised. This is true
whether or not we change the way that maintainers coordinate amongst
themselves, or whether or not we change the current workflow used by
platform contributors today.

So, we're planning to change things up a bit. We're starting a new
group that pools current arm-soc, clk and pinctrl drivers and
maintainers into one funnel. We'll set up a new mail alias for the
maintainer group, and one shared patchwork to collect contributions.
We still expect developers to use existing mailing lists, and we still
expect for example ARM platform maintainers to keep their workflow of
collecting patches for their platform like they do today. Down the
road it might make sense to incorporate other driver subsystems as
well.

Beyond this, we're going to keep a close eye on the drm-misc tree,
which is exploring a move to gitlab (and working with gitlab on adding
the features they need to move over). If they get a broad maintainer
model working well in that environment it could be something we reuse
for ourselves too.

This group will also take on the responsibility of putting together
the documentation and expected patch flow for new platform/SoC
contributors. That documentation will need to evolve a bit over time
as we try out this new collaboration between maintainers.

To avoid an appearance of "ARM is taking over all architectures",
we'll rename this to just the plain "SoC tree/group", and drop ARM
from the name. As mentioned already initially we're anticipating
covering ARM (32/64-bit like before) and RISC-V platform areas in a
similar way. For other older/minor architectures that are
semi-orphaned, we might pick up code as needed when it affects us,
depending on maintainer status at the other end.

We're doing the groundwork now, and will get trees/lists/patchworks
setup for the next release cycle.


People involved so far are:

Olof Johansson (arm-soc)
Arnd Bergmann (arm-soc)
Kevin Hilman (arm-soc)
Mike Turquette (clk)
Stephen Boyd (clk)
Linus Walleij (pinctrl + more)
Mike Brown (gpio/regmap + more)


Thanks!

-Olof (on behalf of the group)
