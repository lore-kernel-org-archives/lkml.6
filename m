Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD08C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048D524005
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoVjyjoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048D524005
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeGEP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753642AbeGEP6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:58:32 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE5324116
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jul 2018 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530806311;
        bh=gv5x6CBm8MAwUQlrFjXPm1GU7QMy1/Sj/6UAhvsscMQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=KoVjyjoBIOwAvN1fhi1zr9rsICV01u01HPSqiv0VuxeL3i2aREvh4mEBpmvesEGDk
         ZVD9T7D9wTDvcXhEw9kEecEOxcQ712aE5qp4jjZ2FFrba4DM4HGR+BqzOazt2Dw34A
         NI+L17vv0A0i4J9W50wm8SZQFxTp1xr63EGy//4U=
Received: by mail-wm0-f53.google.com with SMTP id p11-v6so11715235wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:58:31 -0700 (PDT)
X-Gm-Message-State: APt69E3EkwRVm2WdP8tty4wgSW8AGDkhxbzLDgqkOruU3yIufKTAUZ8k
        SKAREP5uE4gNtswEhzLVslielkGY0peDD/4yZXIPow==
X-Google-Smtp-Source: AAOMgpcNXR/uGGbZT1JphenOwA3C+idCykBnGEVY8EggC0WQ/anJK9dx3tZDcsMLhenisvYF5smgMRnmCc/lL6QKJTU=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr4714133wma.21.1530806309802;
 Thu, 05 Jul 2018 08:58:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:58:09 -0700 (PDT)
In-Reply-To: <20180703233430.14416-3-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com> <20180703233430.14416-3-labbott@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 5 Jul 2018 08:58:09 -0700
X-Gmail-Original-Message-ID: <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com>
Message-ID: <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com>
Subject: Re: [PATCHv5 2/4] x86: Add build salt to the vDSO
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 4:34 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
>

Looks good to me.  I have no idea whose tree these would go through.

> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: Switched to using the single line BUILD_SALT macro
> ---
>  arch/x86/entry/vdso/vdso-note.S   | 3 +++
>  arch/x86/entry/vdso/vdso32/note.S | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
> index 79a071e4357e..79423170118f 100644
> --- a/arch/x86/entry/vdso/vdso-note.S
> +++ b/arch/x86/entry/vdso/vdso-note.S
> @@ -3,6 +3,7 @@
>   * Here we can supply some information useful to userland.
>   */
>
> +#include <linux/build-salt.h>
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> @@ -10,3 +11,5 @@
>  ELFNOTE_START(Linux, 0, "a")
>         .long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT
> diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/note.S
> index 9fd51f206314..e78047d119f6 100644
> --- a/arch/x86/entry/vdso/vdso32/note.S
> +++ b/arch/x86/entry/vdso/vdso32/note.S
> @@ -4,6 +4,7 @@
>   * Here we can supply some information useful to userland.
>   */
>
> +#include <linux/build-salt.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
>
> @@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
>         .long LINUX_VERSION_CODE
>  ELFNOTE_END
>
> +BUILD_SALT
> +
>  #ifdef CONFIG_XEN
>  /*
>   * Add a special note telling glibc's dynamic linker a fake hardware
> --
> 2.17.1
>
