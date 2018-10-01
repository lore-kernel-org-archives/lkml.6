Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD55206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="X2MVzJlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD55206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeJAMZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:25:50 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:48235 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:25:50 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w915nhl9026741;
        Mon, 1 Oct 2018 14:49:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w915nhl9026741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538372984;
        bh=Qnw6nfv2f5Qfhbl6CcKxxBJpYuyhxpkGAFyiVgJV+BE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X2MVzJlJn2/a1+FprtsEbUVyFee8l4lY0RG8UJgIjEom/1NzC6EUIYq/RS6lHis5c
         jFVdFzePf8tg5WTjx8+xQ2BReCX48uMSMh4ddvoFCJqDjQfxYk3C3n/5zxXkYOMkNp
         CDqz8D4xZUtp2Ii1hmH9UoUMyoMzxh8kXa4MulNqGwTQwblQ/dlHGwTPHYmfQb6Uqq
         dJmpzkfdKV7IzNdeODt9aAzspuAT45rd+0cTC36a+vps8z5nJLm0L6SvsxlQidPoYJ
         RuVXLMikOdN1C/82GeDy0hFBuP3sme/07u2XxBSJdd9UeKoVYFP5jZxFyi+IvJCxl8
         FqaOeD62HAiUQ==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id 125-v6so390145vkx.13;
        Sun, 30 Sep 2018 22:49:43 -0700 (PDT)
X-Gm-Message-State: ABuFfojj2FjYUlMx61R87hCVhLMqkFOdAgct4BdNWD7UFFV8/F7DPYxl
        gxVbD8HjLF6hYeMryUeV84r9plv8JonjEMzizXg=
X-Google-Smtp-Source: ACcGV62iRmxiHkB3QMTJljzoGoephgbyQk5RidQoVpOMzclvUjQgLINmFzCENJujD3tHwm/uyOI4PiPdrnFhgJZdJcU=
X-Received: by 2002:a1f:28e:: with SMTP id 136-v6mr3353329vkc.34.1538372982761;
 Sun, 30 Sep 2018 22:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com> <20180928154150.GA25013@bogus>
In-Reply-To: <20180928154150.GA25013@bogus>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 1 Oct 2018 14:49:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
Message-ID: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


2018=E5=B9=B49=E6=9C=8829=E6=97=A5(=E5=9C=9F) 0:43 Rob Herring <robh@kernel=
.org>:

> +#
> -------------------------------------------------------------------------=
--
> +# Devicetree files
> +
> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> +dtstree :=3D arch/$(SRCARCH)/boot/dts
> +endif
> +
> +ifneq ($(dtstree),)
> +
> +%.dtb : scripts_dtc

%.dtb: prepare3 prepare


because we need to make sure KERNELRELEASE
is correctly defined before dtbs_install happens.


> +       $(Q)$(MAKE) $(build)=3D$(dtstree) $(dtstree)/$@
> +
> +PHONY +=3D dtbs dtbs_install
> +dtbs: scripts_dtc


dtbs: prepare3 scripts_dtc



> +       $(Q)$(MAKE) $(build)=3D$(dtstree)
> +
> +dtbs_install: dtbs


Please do not have dtbs_install to depend on dtbs.

No install targets should ever trigger building anything
in the source tree.


For the background, see the commit log of
19514fc665ffbce624785f76ee7ad0ea6378a527




> +       $(Q)$(MAKE) $(dtbinst)=3D$(dtstree)
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +all: dtbs
> +endif
> +
> +endif
> +
> +PHONY +=3D scripts_dtc
> +scripts_dtc: scripts_basic
> +       $(Q)$(MAKE) $(build)=3Dscripts/dtc
> +
>  #
> -------------------------------------------------------------------------=
--
>  # Modules
>


--=20
Best Regards
Masahiro Yamada
