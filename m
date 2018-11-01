Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F21C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036282064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="NaiY80cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036282064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeKBCYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:24:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35435 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeKBCYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:24:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so14752480lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSai6ptFovwf12HhXChp9SksxZNPqvxDg9dyqxc5eqM=;
        b=NaiY80cQlgfVrO1fqSVryJYTWU2Uk5xgdwq4aHvqHnfXa1YaA2YU0i+wuaF8ErVEU4
         dyz7MsigK3s+D9BisRK1j/VHNABNEK1Oa1hOJxx/YVYBxHcxek11LeKeHgA9+Z8t/MD0
         T+zOXyHP75iEBUMw5wY0I59Vi5x/C6+jWp7QphBKb0xc/2iqjf0/0T343vcQPdntn0cZ
         +nVIpUDZrFha1m/xwjx2MiuuhKSmJBgkEkueBtKOmZKGmmKY8ngn7auVYadnccKSro6/
         DMZZw/tKMw1Ztqohty7y9E0XMwl0MOtvehGgU8RAslhRc6yJtuBTlw8z0cnku01DDNBy
         oy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSai6ptFovwf12HhXChp9SksxZNPqvxDg9dyqxc5eqM=;
        b=JLWM2h231Tevt30S/BVLYrsPYqYEW87ZBfrDDtZts5yjxj2L4990qYo3xnd9iW1A/q
         r8Umsjqom1xnz/JWCCZlw0RpGqTJ/Ur4QNcLhxNO3nLDpI4i0rhlMNTowtUa/5g0qzYj
         hwQc9tk/+gPpdc0C5iSXw6ievbmnh7REkmSLWGEcSEaHIX2v+kA15lhf8RkouooosLCr
         xhsnFTRFb6gdwkkrgl87dnBy2NQPaOm2qnLaIkb2nkzBOntQrwXz7KCpkArZ2k2IU5aN
         ylZiDx5sLRuONlqW8ZPAaOZqZOaGqzBwWGLocQwo1BkdemIvgCFqTev1NSGxY9v/h8ol
         WXDg==
X-Gm-Message-State: AGRZ1gJpKg1eZIAe4noEcFkO2bptRAfV3u7npf/XdsJ1DIIsTkqzN9jK
        ppHMC+TRuA2a5GDNaAFmPHt7sHES4hHrZqD0t9jplg==
X-Google-Smtp-Source: AJdET5f2ARpNgZ006YwGjijg/38ijicAbnvk3dZ9yyhsUy17OVtcQEP5T0RYeogKjdfTVhKWHZVppE8snjGwDKlhvBA=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr5279633lfe.87.1541092818819;
 Thu, 01 Nov 2018 10:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <da34ca57-ea7b-7fb9-bc45-4b315513e43f@deltatee.com> <mhng-b2753147-e1db-4a2a-8dfb-710e71a38bed@palmer-si-x1c4>
In-Reply-To: <mhng-b2753147-e1db-4a2a-8dfb-710e71a38bed@palmer-si-x1c4>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 1 Nov 2018 10:20:06 -0700
Message-ID: <CAOesGMjOfE8KADq2hDORvVtYw8sa7GbL6MtbiDRRgPbWMiXQCA@mail.gmail.com>
Subject: Re: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     logang@deltatee.com, philip.li@intel.com,
        Fengguang Wu <fengguang.wu@intel.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        kbuild test robot <lkp@intel.com>, kbuild@lists.01.org,
        Zong Li <zongbox@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 9:17 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 01 Nov 2018 08:43:15 PDT (-0700), logang@deltatee.com wrote:
> >
> >
> > On 2018-10-31 8:19 p.m., Li, Philip wrote:
> >>>> I think it would also be very nice to get the existing kbuild test robot
> >>>> to start compile testing a few riscv configs. It already does most of
> >> thanks Logan, the support to riscv and nds32 has been in our TODO list for
> >> a while, but whole team is blocked by other effort. We will focus on this soon
> >> to complete it within 2-3 weeks.
> >
> > Thanks! Glad to hear it.
>
> We should probably at least have builds for rv32imac, rv32imafdc, rv64imac, and
> rv64imafdc.  It's probably also good to test SMP/non-SMP as well as
> medlow/medany, as I doubt those get regularly tested.  If you'd like I can
> write up the configs, just point me to something that describes what I should
> do.

It might make sense to either do a pseudo-arch for riscv32, or maybe a
config snippet to generate these arch-specific configs.

For the ISA options, it's a bit trickier. Ideally we want to build
just one kernel that can boot everywhere, and enable the rest
dynamically ('fd' in particular). Whether the kernel itself is built
with 'c' could be a config option to enable (like THUMB kernel on
32-bit ARM), but in general we probably want to watch out for
explosions of combinations here.

Embedded/low-end users will want a way to disable whatever they don't
need, so there's a balance to be found.

FWIW, the configs I build today are:

if [ -f arch/riscv/Makefile ] ; then
        (grep -v "CONFIG_SMP=y" arch/riscv/configs/defconfig ; echo
"CONFIG_SMP=n") > arch/riscv/configs/nosmp_defconfig
        (grep -v "CONFIG_ARCH_RV32I is not"
arch/riscv/configs/defconfig ; echo "CONFIG_ARCH_RV32I=y") >
arch/riscv/configs/rv32_defconfig
fi

+ tinyconfig, allmodconfig, allnoconfig and in some cases
allyesconfig. allmod and allyes take forever so I'm trying to figure
out what targets to build those for. Maybe linux-next only or
something. So doing allmod+ISA combinations would be quite a time
addition for build turnarounds for me.


-Olof
