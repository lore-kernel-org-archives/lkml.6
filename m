Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75389C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3692121929
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLeONhHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfBPEVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:21:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42954 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfBPEVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:21:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so20056303oto.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 20:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Oa2zNtL0aUyVArZ4mLGbN0Oa+haiEnKGGS1aclDiCI=;
        b=uLeONhHBsdCGpmV6n1KFrcPNlfSkseDSDltPGo59+U2sHVth76jTDpLVRLj6pYUqs/
         vK3QAmZaPWKU+t84cHrIECX48h7UrXWNuIxMuTa5303sog0ufYJ5jCE8zUXludOIEv6p
         wVgsOoUSlaTiowsIUyGXG/I2XgvhG8GmDSO1SVHRZ2HAVHZhvskbYXOm+QG/0xlDP5hN
         Y6qMJwxJ6ZsicwzZdgDPHMEKGWoRjPtD0G5INwmyIcREQ9dfSVbPsr3ux956zrvR0X7U
         pR98bQrrI8HjQV20Yaa1ofTgrqVhzSKA/LXCLXCYICT4WlZqDZ/q3kz0vqXzql2tLVEd
         zxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Oa2zNtL0aUyVArZ4mLGbN0Oa+haiEnKGGS1aclDiCI=;
        b=nDGVrnQye8GotnqdHID9+vnUQM2iso+MQToUWD21MYMpdQAtUwb36lbR0GH5hbbsQp
         mU05XZRT+L1tLj+0sIiBoVWIAAjyVNA2GW6pTuTjuLIXwGKWGl/+7mNTYgylQMaG7Byl
         4mpfQ/KHQ+iPj0eUMz879wUF1XqemrRmbVoYecMgEUQyU+K3AvjS0nMfs8BxN11tHDzv
         fAqmzBPmHgrZy0IQJye8u9Kc+Amy4vY+fnqIRM1+34YSENjeIETxSGpqwMBY1SnlTxkg
         Al3gSdn3jS4EDArqzBS2oCKdpqZaPTPmbCA0CjcHehJZuBHAXLAKIMNbkLwEAbitncAo
         8xSQ==
X-Gm-Message-State: AHQUAubAwqEKdiDoxDzGQgHK0sdpSzPwxESOyRM+ej8zqumdso1RjfGt
        cZWHmWgF5WRqIDYEIBkGKH1cjfniGzX/L4pvdrrXp3z0FBg=
X-Google-Smtp-Source: AHgI3IZ6SU9kKzapvEH9LVHrG2oFaae6JQ3eP5mFCh9zYND7CBnYKsVQ1ixjjD7OP3b1WBN0cCRaCfJiNfATQtIrd/I=
X-Received: by 2002:a9d:7091:: with SMTP id l17mr7032382otj.198.1550290875907;
 Fri, 15 Feb 2019 20:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20190215235901.23541-1-baloo@gandi.net>
In-Reply-To: <20190215235901.23541-1-baloo@gandi.net>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 16 Feb 2019 05:20:49 +0100
Message-ID: <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
To:     baloo@gandi.net, Andy Lutomirski <luto@amacapital.net>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andy Lutomirski

On Sat, Feb 16, 2019 at 12:59 AM <baloo@gandi.net> wrote:
>
> From: Arthur Gautier <baloo@gandi.net>
>
> When extracting an initramfs, a filename may be near an allocation boundary.
> Should that happen, strncopy_from_user will invoke unsafe_get_user which
> may cross the allocation boundary. Should that happen, unsafe_get_user will
> trigger a page fault, and strncopy_from_user would then bailout to
> byte_at_a_time behavior.
>
> unsafe_get_user is unsafe by nature, and rely on pagefault to detect boundaries.
> After 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")
> it may no longer rely on pagefault as the new page fault handler would
> trigger a BUG().
>
> This commit allows unsafe_get_user to explicitly trigger pagefaults and
> handle them directly with the error target label.

Oof. So basically the init code is full of things that just call
syscalls instead of using VFS functions (which don't actually exist
for everything), and the VFS syscalls use getname_flags(), which uses
strncpy_from_user(), which can access out-of-bounds pages on
architectures that set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, and
that in summary means that all the init code is potentially prone to
tripping over this?

I don't particularly like this approach to fixing it, but I also don't
have any better ideas, so I guess unless someone else has a bright
idea, this patch might have to go in.

> Kernel bug:
> [    0.965251] Unpacking initramfs...
> [    1.797025] BUG: pagefault on kernel address 0xffffae80c0c7e000 in non-whitelisted uaccess
> [    1.798992] BUG: unable to handle kernel paging request at ffffae80c0c7e000
> [    1.798992] #PF error: [normal kernel read fault]
> [    1.798992] PGD 68526067 P4D 68526067 PUD 68527067 PMD 67f0d067 PTE 0
> [    1.798992] Oops: 0000 [#1] SMP PTI
> [    1.798992] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc6+ #14
> [    1.798992] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    1.798992] RIP: 0010:strncpy_from_user+0x67/0xe0
> [    1.798992] Code: fe fe 48 39 ca 49 ba 80 80 80 80 80 80 80 80 48 0f 46 ca 31 c0 45 31 db 49 89 c8 4c 89 c1 48 29 c1 48 83 f9 07 76 49 44 89 d9 <4c> 8b 0c 06 85 c9 75 3e 49 8d 0c 19 4c 89 0c 07 49 f7 d1 4c 21 c9
> [    1.798992] RSP: 0000:ffffae80c031fc40 EFLAGS: 00050216
> [    1.798992] RAX: 0000000000000040 RBX: fefefefefefefeff RCX: 0000000000000000
> [    1.798992] RDX: 0000000000000fe0 RSI: ffffae80c0c7dfba RDI: ffff8b3d27cce020
> [    1.798992] RBP: 00000000ffffff9c R08: 0000000000000fe0 R09: caccd29190978b86
> [    1.798992] R10: 8080808080808080 R11: 0000000000000000 R12: ffffae80c0c7dfba
> [    1.798992] R13: ffffae80c031fd00 R14: 0000000000000000 R15: 0000000000000000
> [    1.798992] FS:  0000000000000000(0000) GS:ffff8b3d28a00000(0000) knlGS:0000000000000000
> [    1.798992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.798992] CR2: ffffae80c0c7e000 CR3: 000000003a60e001 CR4: 0000000000360eb0
> [    1.798992] Call Trace:
> [    1.798992]  getname_flags+0x69/0x187
> [    1.798992]  user_path_at_empty+0x1e/0x41
> [    1.798992]  vfs_statx+0x70/0xcc
> [    1.798992]  clean_path+0x41/0xa2
> [    1.798992]  ? parse_header+0x40/0x10a
> [    1.798992]  do_name+0x78/0x2b5
> [    1.798992]  write_buffer+0x27/0x37
> [    1.798992]  flush_buffer+0x34/0x8b
> [    1.798992]  ? md_run_setup+0x8a/0x8a
> [    1.798992]  unlz4+0x20b/0x27c
> [    1.798992]  ? write_buffer+0x37/0x37
> [    1.798992]  ? decompress_method+0x80/0x80
> [    1.798992]  unpack_to_rootfs+0x17a/0x2b7
> [    1.798992]  ? md_run_setup+0x8a/0x8a
> [    1.798992]  ? clean_rootfs+0x159/0x159
> [    1.798992]  populate_rootfs+0x5d/0x105
> [    1.798992]  do_one_initcall+0x86/0x169
> [    1.798992]  ? do_early_param+0x8e/0x8e
> [    1.798992]  kernel_init_freeable+0x16a/0x1f4
> [    1.798992]  ? rest_init+0xaa/0xaa
> [    1.798992]  kernel_init+0xa/0xfa
> [    1.798992]  ret_from_fork+0x35/0x40
>
> You may reproduce the issue with the following initrd:
>   truncate -s 8388313 a
>   SECONDFILENAME=bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
>   truncate -s 10 $SECONDFILENAME
>   echo "a\n$SECONDFILENAME" | cpio -o --format=newc | lz4 -l > initrd.img.lz4
>
> This places the second filename in the cpio near the allocation boundary made
> by lz4 decompression and should trigger the bug.
>
> Fixes: 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")
>
> Cc: Jann Horn <jannh@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Pascal Bouchareine <pascal@gandi.net>
> Signed-off-by: Arthur Gautier <baloo@gandi.net>
> ---
>  arch/x86/include/asm/uaccess.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 780f2b42c8efe..2c272dc43e05a 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -724,7 +724,9 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
>  do {                                                                           \
>         int __gu_err;                                                           \
>         __inttype(*(ptr)) __gu_val;                                             \
> +       current->kernel_uaccess_faults_ok++;                                    \
>         __get_user_size(__gu_val, (ptr), sizeof(*(ptr)), __gu_err, -EFAULT);    \
> +       current->kernel_uaccess_faults_ok--;                                    \
>         (x) = (__force __typeof__(*(ptr)))__gu_val;                             \
>         if (unlikely(__gu_err)) goto err_label;                                 \
>  } while (0)
> --
> 2.20.1
>
