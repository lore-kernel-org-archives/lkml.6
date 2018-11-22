Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7219C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2A520684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5IcbZcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2A520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405320AbeKVVL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:11:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35810 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeKVVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:11:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so8735576wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l57SLsSzQbtZugTE6jJy9K6Pf6qm6kn/+UlrybrpMvc=;
        b=g5IcbZcIxAjJ7yohPo9NftdJ8iKrGi3KYhrE3Pc0akSG5WPfxLGVHXxCHJDhexd9uq
         +sDt5I50KeRGPvWhTNakvF9FlLkTv+J8gkVzuq0lY+UGeYdFgAncPSEKp/m31rHRHT9D
         b1cydph5TaBqOTOzSC9tTrX7KYOxcX3XI33monPUOKgR+OGZvhVyXsfgWAvEVOV4Mt2c
         GVx/I5LQzYOvlyhvTiHRELZvTXeR3Ml1FvzDQYZkitrPTTLyIEBPS7s5kcRQeLXHnGqm
         n7aMQ1s15AFbEvows0YrInFjfaHDq+Xq1VoNNBmtLuG63Z/daNMNInMDlzCCiF3Fp8tF
         UXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l57SLsSzQbtZugTE6jJy9K6Pf6qm6kn/+UlrybrpMvc=;
        b=rSkv6Xnsq7fIyRhJwET6ljtFcEz41E6JFXY4bcDWPzRk7tEsSUIyJ9GTDmDw287OY1
         iyYC4hOQ1cIK0vE44vKIue1jQNk4FF2awPWBQ3+r1IQSdIisGgUpNrolpFo5LTFyS6By
         3ad5tLBNO6PDD+u3xeWIw/4fxJcqn+NlfIXUiqdWNCO9J++l4j8o19AQrmdzNsXNa6+b
         IBYLsf28VndzMEJ78cRfLrhyYgpSFecpneP/3IvdWqvZuEn/WXcQ2YUhYYe1lExpjqqE
         03TKZ+Wtzt9f0L66X3JW3t8dV70bBmR2/HCaEE7YiBTotSYkBK5vs1ppPoQ3IbnheZvs
         8KGw==
X-Gm-Message-State: AA+aEWbEAvoit98mQvJAkdm1tlL63O2IcjBRKn8vT1ofNF5ikO5B/Qtg
        l98O3Tzrx8hyn4pk/uTmXPo=
X-Google-Smtp-Source: AFSGD/UC6GfwqdhL58M3HEo3QR/oba/ud2MNoTWt65Ak8S9M0T/2J6FG3aiOiuF2ePtq/0qdOOveGw==
X-Received: by 2002:adf:a50c:: with SMTP id i12mr8733250wrb.220.1542882754531;
        Thu, 22 Nov 2018 02:32:34 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b22sm2849927wmj.9.2018.11.22.02.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 02:32:33 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:32:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pabeni@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
Message-ID: <20181122103231.GA102790@gmail.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
 <CAHk-=wiDLq5CVnTJhFNEEduqYP_VSsQPSNvi=w6a8Y9figuh7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDLq5CVnTJhFNEEduqYP_VSsQPSNvi=w6a8Y9figuh7g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Nov 21, 2018 at 10:16 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It might be interesting to just change raw_copy_to/from_user() to
> > handle a lot more cases (in particular, handle cases where 'size' is
> > 8-byte aligned). The special cases we *do* have may not be the right
> > ones (the 10-byte case in particular looks odd).
> >
> > For example, instead of having a "if constant size is 8 bytes, do one
> > get/put_user()" case, we might have a "if constant size is < 64 just
> > unroll it into get/put_user()" calls.
> 
> Actually, x86 doesn't even set INLINE_COPY_TO_USER, so I don't think
> the constant size cases ever trigger at all the way they are set up
> now.

Side note, there's one artifact the patch exposes: some of the 
__builtin_constant_p() checks are imprecise and don't trigger at the 
early stage where GCC checks them, but the lenght is actually known to 
the compiler at later optimization stages.

This means that with Jen's patch some of the length checks go away. I 
checked x86-64 defconfig and a distro config, and the numbers were ~7% 
and 10%, so not a big effect.

The kernel text size reduction with Jen's patch is small but real:

 text		data		bss		dec		hex	filename
 19572694	11516934	19873888	50963516	309a43c	vmlinux.before
 19572468	11516934	19873888	50963290	309a35a	vmlinux.after

But I checked the disassembly, and it's not a real win, the new code is 
actually more complex than the old one, as expected, but GCC (7.3.0) does 
some particularly stupid things which bloats the generated code.

> I do have a random patch that makes "unsafe_put_user()" actually use
> "asm goto" for the error case, and that, together with the attached
> patch seems to generate fairly nice code, but even then it would
> depend on gcc actually unrolling things (which we do *not* want in
> general).
> 
> But for a 32-byte user copy (cp_old_stat), and that
> INLINE_COPY_TO_USER, it generates this:
> 
>         stac
>         movl    $32, %edx       #, size
>         movq    %rsp, %rax      #, src
> .L201:
>         movq    (%rax), %rcx    # MEM[base: src_155, offset: 0B],
> MEM[base: src_155, offset: 0B]
> 1:      movq %rcx,0(%rbp)       # MEM[base: src_155, offset: 0B],
> MEM[(struct __large_struct *)dst_156]
> ASM_EXTABLE_HANDLE from=1b to=.L200 handler="ex_handler_uaccess"        #
> 
>         addq    $8, %rax        #, src
>         addq    $8, %rbp        #, statbuf
>         subq    $8, %rdx        #, size
>         jne     .L201   #,
>         clac
> 
> which is actually fairly close to "optimal".

Yeah, that looks pretty sweet!

> Random patch (with my "asm goto" hack included) attached, in case
> people want to play with it.

Doesn't even look all that hacky to me. Any hack in it that I didn't 
notice? :-)

The only question is the inlining overhead - will try to measure that.

> Impressively, it actually removes more lines of code than it adds. But
> I didn't actually check whether the end result *works*, so hey..

Most of the linecount reduction appears to come from the simplification 
of the unroll loop and moving it into C, from a 6-way hard-coded copy 
routine:

> -	switch (size) {
> -	case 1:
> -	case 2:
> -	case 4:
> -	case 8:
> -	case 10:
> -	case 16:

to a more flexible 4-way loop unrolling:

> +	while (size >= sizeof(unsigned long)) {
> +	while (size >= sizeof(unsigned int)) {
> +	while (size >= sizeof(unsigned short)) {
> +	while (size >= sizeof(unsigned char)) {

Which is a nice improvement in itself.

> +	user_access_begin();
> +	if (dirent)
> +		unsafe_put_user(offset, &dirent->d_off, efault_end);
>  	dirent = buf->current_dir;
> +	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
> +	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
> +	unsafe_put_user(0, dirent->d_name + namlen, efault_end);
> +	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
> +	user_access_end();
> +
>  	if (copy_to_user(dirent->d_name, name, namlen))
>  		goto efault;
>  	buf->previous = dirent;
>  	dirent = (void __user *)dirent + reclen;
>  	buf->current_dir = dirent;
>  	buf->count -= reclen;
>  	return 0;
> +efault_end:
> +	user_access_end();
>  efault:
>  	buf->error = -EFAULT;
>  	return -EFAULT;

In terms of high level APIs, could we perhaps use the opportunity to 
introduce unsafe_write_user() instead, which would allow us to write it 
as:

	unsafe_write_user(&dirent->d_ino, d_ino, efault_end);
	unsafe_write_user(&dirent->d_reclen, reclen, efault_end);
	unsafe_write_user(dirent->d_name + namlen, 0, efault_end);
	unsafe_write_user((char __user *)dirent + reclen - 1, d_type, efault_end);

	if (copy_to_user(dirent->d_name, name, namlen))
		goto efault;

This gives it the regular 'VAR = VAL;' notation of C assigments, instead 
of the weird historical reverse notation that put_user()/get_user() uses.

Note how this newfangled ordering now matches the 'copy_to_user()' 
natural C-assignment parameter order that comes straight afterwards and 
makes it obvious that the d->name+namelen was writing the delimiter at 
the end.

I think we even had bugs from put_user() ordering mixups?

Or is it too late to try to fix this particular mistake?

Thanks,

	Ingo
