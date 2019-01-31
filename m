Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92436C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642EB2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iU3QdGkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfAaWtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:49:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53148 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAaWtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:49:19 -0500
Received: by mail-it1-f193.google.com with SMTP id d11so6426413itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkiv142AtR3mKFcfGs97SC15vyGtXkrw/acP+pBqHzw=;
        b=iU3QdGkv4AxS48U/SOmzRyyCIdzZxnS1g5kI8E4/99+MSd23lPZJaa6yd4sELSXgYO
         AvNNVVEtBu5nRVvVh2INjDsQLz07xJ2x3MVS/oOLaFQocayuDpfXkFHS02G+CO4q9EFl
         akIvTXBoQWXcqEG87LUsRSvBNtAU0Y/6XYOGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkiv142AtR3mKFcfGs97SC15vyGtXkrw/acP+pBqHzw=;
        b=Y6ATOlsODnikz53ZVkPWDASHbDE1I151HxzfQHDoJ1HSqvJVU9TTfi8IxmmcWVxn3e
         rIm98tV6B48MwG1Xm+mQdDgp8Xy3NmsHDKj2h6GOiYATVXz9VP8B+w0ctxNvVSJLIu3w
         NaWoO9c19IHF79VPhGy0DNHUe+wjso2jo7QEx9g18/xdJr7fGsVVCN35zHYWB42L1sWW
         rKyP7zPNPl2JRHAlFZV5NS6e9Zb2S5UYVvmNWX2dsNZHh0xzIM7kbFqYDouTwxJu6Nz1
         v2fYuKHwwtLofBtG0BeaXdmzGplU1tb+UiOw7GYxcMooHffOlPNa3CJVNIDKdthMMMQ1
         FfcA==
X-Gm-Message-State: AHQUAuZpEyjxd6y0AdnJTY9GtDyWZT++wrJiZkW7WF351MMye3nGY1HY
        Hu74xWYJOPcANVS94LxJ1a9kt3jbBKQ=
X-Google-Smtp-Source: AHgI3IaYYfevLoipWavhBGhNzrt1pKVVjggxA/A9I6Ts8kbWNT+jmlj+EvZw3A7Psf7RE4mGXqT/DQ==
X-Received: by 2002:a24:a64f:: with SMTP id r15mr8102118iti.101.1548974958623;
        Thu, 31 Jan 2019 14:49:18 -0800 (PST)
Received: from mail-it1-f173.google.com (mail-it1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id x128sm365382itb.8.2019.01.31.14.49.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 14:49:18 -0800 (PST)
Received: by mail-it1-f173.google.com with SMTP id g85so6414782ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:49:17 -0800 (PST)
X-Received: by 2002:a24:d081:: with SMTP id m123mr19889982itg.119.1548974956119;
 Thu, 31 Jan 2019 14:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-15-thgarnie@chromium.org>
 <01000168a5b35a86-b79bfe67-191e-43bc-a5c7-0e74eac06195-000000@email.amazonses.com>
In-Reply-To: <01000168a5b35a86-b79bfe67-191e-43bc-a5c7-0e74eac06195-000000@email.amazonses.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 31 Jan 2019 14:49:04 -0800
X-Gmail-Original-Message-ID: <CAJcbSZGKR7dKVqNEDEO7Qzf7tnNqmL=p1uVKvsUefS=Hs-=iNA@mail.gmail.com>
Message-ID: <CAJcbSZGKR7dKVqNEDEO7Qzf7tnNqmL=p1uVKvsUefS=Hs-=iNA@mail.gmail.com>
Subject: Re: [PATCH v6 14/27] x86/percpu: Adapt percpu for PIE support
To:     Christopher Lameter <cl@linux.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen@linux.intel.com, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:57 PM Christopher Lameter <cl@linux.com> wrote:
>
> On Thu, 31 Jan 2019, Thomas Garnier wrote:
>
> > Perpcu uses a clever design where the .percu ELF section has a virtual
> > address of zero and the custom linux relocation code avoid relocating
> > specific symbols. It makes the code simple and easily adaptable with or
> > without SMP support.
>
> We usually talk about this as offsets rather than addressess. The intend
> here is to give every processor its own address that is unique for this
> processor. Operations are always relative to a segment register and the
> whole area can be relocated at will by simply changing the segment
> register.
>
> > This design is incompatible with PIE. While creating a PIE binary, the
> > copmiler tries to make everything relative. The compiler will attempt to
>
> This is very compatible with PIE because it is already relative.

The per-cpu symbols are in a section that is zero based to create
offsets. The compiler doesn't see them as offsets but as relative
symbol and try to relocate them. Given the distance between zero and
the mapped kernel is much larger than the instruction offset range, it
fails to do it.

>
> > generate instructions with the distance between zero and any 64-bit
> > virtual address. It will fail as the relocation range cannot fit within
> > the possible instructions accessing a segment register.
>
> Leave the offsets alone and just change the segment register if you need
> to relocate the area of a specific processor?
>
> > The assembly and PER_CPU macros are changed to use relative references
> > when PIE is enabled.
>
> They already use relative reference. What is the point here?
>
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -5,9 +5,11 @@
> >  #ifdef CONFIG_X86_64
> >  #define __percpu_seg         gs
> >  #define __percpu_mov_op              movq
> > +#define __percpu_rel         (%rip)
>
> The percpu section cannot be IP relative since we need to have separate
> address spaces per cpu.
>
