Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7570C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D6020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfAURQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:16:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35521 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:16:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so24403381qtc.2;
        Mon, 21 Jan 2019 09:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkmENIPSWFkkOPjdjASO6jPlTgP2cZ2E0xpwv2RymMU=;
        b=e1112uBsIRLIl1HKEq0atQY41aY8c970AidX5WGEYp60GPGJekHSvN8hqi2Z6C2x76
         BfTqVbN6iAgvGlpW3HAD/iJHW5aQKP5dnSUVay0vX5cmwR8ppRiXME0WUWH7lwHUmCrY
         x7SuxJGosuUrRQz+14hRmHZyzPSv5M3Cu0/Q/7ShS6XJ7/Q4iQdjsbhGrR7P9Kv5plP+
         5BMeLq2LprcdfmrxLs1E7VMW8BnPOkl9RL+1AUAQjmDa02EbTY5Kx85Fq69yhUxFY7HQ
         VynySRpO2aDiSedVtP9MFCXuRj4WmXje7yUsaJpdjNZ7Xx3meSNC/54/1pAtRkefDuT6
         5/tw==
X-Gm-Message-State: AJcUukd88DrMNp09M4CXC6RKQL0St2fiUdKLDtFC/SlF8RwEYssm3WpV
        tLcJOMsOsGVF6LADgdYSrCyDItwjSRdNhslDfSPG7w==
X-Google-Smtp-Source: ALg8bN66aBH7RXKQ0bXSkN8sk3VXrCUcqa6u6kZkHpSJbrpKlqHA/geIKx/EPW4fdPypG+N0UQM0nqA0hXlJjtf+fCs=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr26826241qvr.115.1548090999325;
 Mon, 21 Jan 2019 09:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20190121143951.68956db3@canb.auug.org.au>
In-Reply-To: <20190121143951.68956db3@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jan 2019 18:16:22 +0100
Message-ID: <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pidfd tree got conflicts in:
>
>   arch/x86/entry/syscalls/syscall_32.tbl
>   include/uapi/asm-generic/unistd.h
>
> between commit:
>
>   10a9a4dd92e6 ("arch: add split IPC system calls where needed")
>   b1788424aa2e ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
>
> from the y2038 tree and commit:
>
>   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
>
> from the pidfd tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Hi Stephen,

>  +385   i386    io_pgetevents           sys_io_pgetevents_time32        __ia32_compat_sys_io_pgetevents
>   386   i386    rseq                    sys_rseq                        __ia32_sys_rseq
> + 387   i386    pidfd_send_signal       sys_pidfd_send_signal           __ia32_sys_pidfd_send_signal
>  +# room for arch specific syscalls
>  +393   i386    semget                  sys_semget                      __ia32_sys_semget
>  +394   i386    semctl                  sys_semctl                      __ia32_compat_sys_semctl

>   #define __NR_kexec_file_load 294
>   __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> - /* 295 through 402 are unassigned to sync up with generic numbers */
> + #define __NR_pidfd_send_signal 295
> + __SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
> ++/* 296 through 402 are unassigned to sync up with generic numbers */
>  +#if __BITS_PER_LONG == 32
>  +#define __NR_clock_gettime64 403
>  +__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)

If we merge my patches, then any other system calls should get numbers
above 423 on all architectures. Part of what I did in my branch was to
add all missing calls on architectures, and then move up to a common
number for the newly added ones. Your merge works correctly, but
it works against that idea by adding new numbers that conflict with
existing ones on other architectures, e.g. 387 is already assigned
on arm, microblaze, powerpc, and sh, and 294 is assigned almost
everywhere other than the asm-generic version.

      Arnd
