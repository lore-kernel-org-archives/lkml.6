Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16383C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D3246CC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2FaIBUDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D3246CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbeGDD6Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:58:25 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:36745 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbeGDD6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:58:23 -0400
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com [209.85.213.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w643wHT2003028;
        Wed, 4 Jul 2018 12:58:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w643wHT2003028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530676698;
        bh=Z2SD3fUVxHbuoQb6t24ZsTMglWgO9Deuo68/4te/OD0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2FaIBUDUEQr+xmKGndoNCuHHq3weQL2gaMVT4N7s5Ad+hIZ/xSrTKhpZYkaNEW/KF
         KzRqbx76S3cNTFQaBCYIpORm5GIWMNs6HJIAwJnGzAh+AZ+bxB0G0XhBV3HCI4M2g8
         unvWydDP+x6vzF6CLZXkYxwfSuOrAE27EM7FhpjA2op4alFQeaml462wxzf1QugBKt
         +1rA9LVPMHokI14IE494vW+Bnadecf5Pn+xFMB58aFr8FuDZTgs8nEBdl9R3vsvoOw
         UwHmMOV60fgryC4vLky4MFr4bdVFaVZtqoWz+5OlLpdQs/5O7WSM+W8GUnJTVShXnx
         VxC+YK3a9hQ/w==
X-Nifty-SrcIP: [209.85.213.53]
Received: by mail-vk0-f53.google.com with SMTP id b77-v6so2336957vkb.5;
        Tue, 03 Jul 2018 20:58:17 -0700 (PDT)
X-Gm-Message-State: APt69E0LLa3x50UsY4JGTjfq2qz0DdX7/uPBLs8R+60iLX4CsCBHDfCd
        hX88P+jPLUffbpun2ZkpYXNzbCQLBYGjCEYSrKk=
X-Google-Smtp-Source: AAOMgpd442zJyo2NbOtwIzOCSUC9GaOtWDh7sNhcYY9O36au/LisxB/g6jt/9SNnawo9RLaB6IiGUzBPQC77EUoE1FU=
X-Received: by 2002:a1f:c944:: with SMTP id z65-v6mr160560vkf.11.1530676696818;
 Tue, 03 Jul 2018 20:58:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 20:57:36 -0700 (PDT)
In-Reply-To: <20180703232200.11315-1-labbott@redhat.com>
References: <20180703232200.11315-1-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 4 Jul 2018 12:57:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4ed62CjH-i5YSL5ngW5aMRbMpKZn8UhNQ20KoMwP9cQ@mail.gmail.com>
Message-ID: <CAK7LNAR4ed62CjH-i5YSL5ngW5aMRbMpKZn8UhNQ20KoMwP9cQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/4] Salted build ids via ELF notes
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-07-04 8:21 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> Hi,
>
> This is v5 of the series to allow unique build ids in the kernel. As a
> reminder of the context:




> ""
> In Fedora, the debug information is packaged separately (foo-debuginfo) and
> can be installed separately. There's been a long standing issue where only one
> version of a debuginfo info package can be installed at a time. Mark Wielaard
> made an effort for Fedora 27 to allow parallel installation of debuginfo (see
> https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
> more details)
>
> Part of the requirement to allow this to work is that build ids are
> unique between builds. The existing upstream rpm implementation ensures
> this by re-calculating the build-id using the version and release as a
> seed. This doesn't work 100% for the kernel because of the vDSO which is
> its own binary and doesn't get updated. After poking holes in a few of my
> ideas, there was a discussion with some people from the binutils team about
> adding --build-id-salt to let ld do the calculation debugedit is doing. There
> was a counter proposal made to add in the salt while building. The
> easiest proposal was to add an item in the linker script vs. linking in
> an object since we need the salt to go in every module as well as the
> kernel and vmlinux.
> ""

I think this information is helpful to explain the background
of this work, but the cover letter cannot be committed in git.

Could you add this in 1/4 please?


If I read only the simple log in 1/4,
I would wonder why it is useful...







> v5 uses the approach suggested by Masahiro Yamada which uses the
> existing ELF note macro to more easily add the salt (vs previous
> approaches which tried to adjust via linker section).
>
> If arch maintainers are okay, I'd like acks for this so this can go
> through the kbuild tree.
>
> Thanks,
> Laura
>
> Laura Abbott (4):
>   kbuild: Add build salt to the kernel and modules
>   x86: Add build salt to the vDSO
>   powerpc: Add build salt to the vDSO
>   arm64: Add build salt to the vDSO
>
>  arch/arm64/kernel/vdso/note.S     |  3 +++
>  arch/powerpc/kernel/vdso32/note.S |  3 +++
>  arch/x86/entry/vdso/vdso-note.S   |  3 +++
>  arch/x86/entry/vdso/vdso32/note.S |  3 +++
>  include/linux/build-salt.h        | 20 ++++++++++++++++++++
>  init/Kconfig                      |  9 +++++++++
>  init/version.c                    |  3 +++
>  scripts/mod/modpost.c             |  3 +++
>  8 files changed, 47 insertions(+)
>  create mode 100644 include/linux/build-salt.h
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
