Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FF2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899D2214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Xid/XfkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899D2214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbeKIHj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:39:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeKIHj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:39:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so22898680wre.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0rxaB2PIdvh0q4KbBuieb1EMfBo7ObRax+JeMJGg6g=;
        b=Xid/XfkVp97YJrsA6M/ulFTvpP8FftVWQjxjTBdVsUc3JWbwRjyU2J/x39XeB9TmOL
         k3B5+f5Lxz6SsQZ3urW/KNMBSCuEGJ6IBdlAihxRfC6DXbMYGvSWeR09Z8hlDoT0Es/h
         m0EHXF3YvQ3ORqu9ITatIyTaKcuyI76qQ8o5xgAihVlFW/+EWWhTVBm7A+Ifm7X4W9/5
         kkGZw9w+/U8H33g7i/LLVfOoa2V5EuuveM7pM9UdQB95afOz8AMVtefpbJ7qFsM2JA+n
         nPK/4eci0DLiDDFnNzXj6XOCEcwKO+A4/f3UrBBUdnvlbyQttzRt9POb44r9sJtjUX+i
         RofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0rxaB2PIdvh0q4KbBuieb1EMfBo7ObRax+JeMJGg6g=;
        b=rlqmKDDJuH9eaJrkQDMzm0v75eZtPpI0euO9X/tx+msXXZ61Ji7OCW27NxGLXQkFJV
         0yigEeUiyeaSzD8BbMPunpVn//NXJd/+byI9mzYLkN7kwMKU/BRkWhzE/keoWTGRZAQz
         jFqXNjWuWEbmnE4PSS8VOeBwaaOXxyDgeUEAfhN5B800/E9tDwESTPKn+4enPrg/s1Nj
         6R7ZHZuyjWdV4ku8gFLX7WqRCY4uRW/tVkA0qPmvdx+85JEmPlJASSHncw+wGdvLxufC
         rTaXTO45bA5vkcleGb8xLI0fHckXGAaxrEgD0UoO3dRVGTacdXaH4/r3A3acnp9GVMmd
         SXTw==
X-Gm-Message-State: AGRZ1gKNbwEifnc3F3cwpBj4ebmXmUuS0BFiO7BPqOYNfyMB6Wbw0WQj
        +CeOgb42Y0MDNT8VUA8Lsou3jJmXGlivBmq2GUV5vg==
X-Google-Smtp-Source: AJdET5dt9WmP39T817wMiLJbCDKp+h5jv7T2tl9+2a3UrWqsd+UJcLAJfiwIAMJOXqac1yTQ5WzKLKaBB8WJxpJeGTs=
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr5368280wrc.131.1541714515017;
 Thu, 08 Nov 2018 14:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20181011151523.27101-1-yu-cheng.yu@intel.com> <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com>
 <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
 <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com> <20181108213126.GD13195@uranus.lan>
In-Reply-To: <20181108213126.GD13195@uranus.lan>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 8 Nov 2018 14:01:42 -0800
Message-ID: <CALCETrXNt6nEMu9bbK7GizoeC+rphi8ZK0dDsHiVgOCQj1eQEA@mail.gmail.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 1:31 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Thu, Nov 08, 2018 at 01:22:54PM -0800, Andy Lutomirski wrote:
> > > >
> > > > Why are these __packed?  It seems like it'll generate bad code for no
> > > > obvious purpose.
> > >
> > > That prevents any possibility that the compiler will insert padding, although in
> > > 64-bit kernel this should not happen to either struct.  Also all xstate
> > > components here are packed.
> > >
> >
> > They both seem like bugs, perhaps.  As I understand it, __packed
> > removes padding, but it also forces the compiler to expect the fields
> > to be unaligned even if they are actually aligned.
>
> How is that? Andy, mind to point where you get that this
> attribute forces compiler to make such assumption?

It's from memory.  But gcc seems to agree with me I compiled this:

struct foo {
    int x;
} __attribute__((packed));

int read_foo(struct foo *f)
{
    return f->x;
}

int align_of_foo_x(struct foo *f)
{
    return __alignof__(f->x);
}

Compiling with -O2 gives:

    .globl    read_foo
    .type    read_foo, @function
read_foo:
    movl    (%rdi), %eax
    ret
    .size    read_foo, .-read_foo

    .p2align 4,,15
    .globl    align_of_foo_x
    .type    align_of_foo_x, @function
align_of_foo_x:
    movl    $1, %eax
    ret
    .size    align_of_foo_x, .-align_of_foo_x

So gcc thinks that the x field is one-byte-aligned, but the code is
okay (at least in this instance) on x86.
Building for armv5 gives:

    .type    read_foo, %function
read_foo:
    @ args = 0, pretend = 0, frame = 0
    @ frame_needed = 0, uses_anonymous_args = 0
    @ link register save eliminated.
    ldrb    r3, [r0]    @ zero_extendqisi2
    ldrb    r1, [r0, #1]    @ zero_extendqisi2
    ldrb    r2, [r0, #2]    @ zero_extendqisi2
    orr    r3, r3, r1, lsl #8
    ldrb    r0, [r0, #3]    @ zero_extendqisi2
    orr    r3, r3, r2, lsl #16
    orr    r0, r3, r0, lsl #24
    bx    lr
    .size    read_foo, .-read_foo
    .align    2
    .global    align_of_foo_x
    .syntax unified
    .arm
    .fpu vfpv3-d16
    .type    align_of_foo_x, %function

So I'm pretty sure I'm right.
