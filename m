Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ABCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FA420834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="rYJsoTpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FA420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeJFAHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:07:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37237 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJFAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:07:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so3546501wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=omVygbcTYdT0JG/mGBY8WXc3C5dFkxVGFhiTfz0WKgk=;
        b=rYJsoTpjPm+/2EBVbSEcOp9WHCpZoMcJ9X4KgF6vzj7ecr6zGAWZRqmgl8BzRBhJpL
         tlBSlLqTdzBUopx51Jxw5EXzQDWztqIQDVHMCZgMCAAkvgXoUBqbTjLsjX0CqBYQkWv4
         SF5HqTERhaJJ2rIbFXnwSt28s+/SB+D9aa+LBC4ps8FooznxfYUORhOliRnWl9+xGykL
         75B1SwXtAo2FyZ4aXtK2Au2tl/9s3yfhmSy1ExoXo0iTCauPsTk9g+Hcn76THDqK0qSR
         Lj0nYDf4gYxb/99LoPfzAqfsiZiXw9nmD+8WkruErFv3Cr4EJc+dr3/si4Qye2q5OMyv
         8vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=omVygbcTYdT0JG/mGBY8WXc3C5dFkxVGFhiTfz0WKgk=;
        b=Md9DbNm1VJm6uvBZ3oeCWgTTAGvf43zJ5azMmEOhGz9xjV6yI5T0TG5vzR4FszYd41
         buA60B1VDFZh/sv8Q5mCxMqBoYm4CsUU5oj6S12+fDQ00RxFbueDFsBbRY2p17HhwEXd
         ux8TVZgxD3vv2ftl6ceBeC5IeSt86gKBf+0+k5+DUMILo0TbF+U8nHfW100VX6FnmQjj
         8+yi0EQ1CxYbzeRqBodIzH/KDir8ACV70xWhl3r/hvBhxv6CEBARQs10SY5VQKUL72g9
         0J/d4pZPHMy5g8o9VU9JVgnwyIbYjF5lX2786HXIgBJksx2gI15oNUS5aXrv2HNdmKof
         LKrA==
X-Gm-Message-State: ABuFfohwcBMLj1SQ57b4Bh3dj9JdgHeGIoyzQ95vfG7een5zS+KWlyfy
        DL6ur7cFSdoagD4H3TS8vvtW5VX3lv6hI1kGOKYgKQ==
X-Google-Smtp-Source: ACcGV62X5ZnFm0HuSz8wH/UW6fi45YL2teet8czwGUJoELbMulwCJy3EcCIJBegqdO0Lq7IEGz/z8TeIfZhZ4vOS3dM=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr8552145wrc.131.1538759278792;
 Fri, 05 Oct 2018 10:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180921150553.21016-1-yu-cheng.yu@intel.com> <20180921150553.21016-4-yu-cheng.yu@intel.com>
 <20181003195702.GF32759@asgard.redhat.com> <fc2f98ab46240c0498bdf4d7458b4373c1f02bf8.camel@intel.com>
 <5BF3AE8F-CC2A-4160-9FF6-FEA171A76371@amacapital.net> <aa5a061c159471f410d677af6a609793906cece1.camel@intel.com>
In-Reply-To: <aa5a061c159471f410d677af6a609793906cece1.camel@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 5 Oct 2018 10:07:46 -0700
Message-ID: <CALCETrXVdYsJsVy=QWruDYdRc6wb44b=0J3OK3zjR_fT1fQH7w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/9] x86/cet/ibt: Add IBT legacy code bitmap
 allocation function
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:03 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Fri, 2018-10-05 at 09:28 -0700, Andy Lutomirski wrote:
> > > On Oct 5, 2018, at 9:13 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote=
:
> > >
> > > > On Wed, 2018-10-03 at 21:57 +0200, Eugene Syromiatnikov wrote:
> > > > > On Fri, Sep 21, 2018 at 08:05:47AM -0700, Yu-cheng Yu wrote:
> > > > > Indirect branch tracking provides an optional legacy code bitmap
> > > > > that indicates locations of non-IBT compatible code.  When set,
> > > > > each bit in the bitmap represents a page in the linear address is
> > > > > legacy code.
> > > > >
> > > > > We allocate the bitmap only when the application requests it.
> > > > > Most applications do not need the bitmap.
> > > > >
> > > > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > > > ---
> > > > > arch/x86/kernel/cet.c | 45 ++++++++++++++++++++++++++++++++++++++=
+++++
> > > > > 1 file changed, 45 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> > > > > index 6adfe795d692..a65d9745af08 100644
> > > > > --- a/arch/x86/kernel/cet.c
> > > > > +++ b/arch/x86/kernel/cet.c
> > > > > @@ -314,3 +314,48 @@ void cet_disable_ibt(void)
> > > > >    wrmsrl(MSR_IA32_U_CET, r);
> > > > >    current->thread.cet.ibt_enabled =3D 0;
> > > > > }
> > > > > +
> > > > > +int cet_setup_ibt_bitmap(void)
> > > > > +{
> > > > > +    u64 r;
> > > > > +    unsigned long bitmap;
> > > > > +    unsigned long size;
> > > > > +
> > > > > +    if (!cpu_feature_enabled(X86_FEATURE_IBT))
> > > > > +        return -EOPNOTSUPP;
> > > > > +
> > > > > +    if (!current->thread.cet.ibt_bitmap_addr) {
> > > > > +        /*
> > > > > +         * Calculate size and put in thread header.
> > > > > +         * may_expand_vm() needs this information.
> > > > > +         */
> > > > > +        size =3D TASK_SIZE / PAGE_SIZE / BITS_PER_BYTE;
> > > >
> > > > TASK_SIZE_MAX is likely needed here, as an application can easily s=
witch
> > > > between long an 32-bit protected mode.  And then the case of a CPU =
that
> > > > doesn't support 5LPT.
> > >
> > > If we had calculated bitmap size from TASK_SIZE_MAX, all 32-bit apps =
would
> > > have
> > > failed the allocation for bitmap size > TASK_SIZE.  Please see values=
 below,
> > > which is printed from the current code.
> > >
> > > Yu-cheng
> > >
> > >
> > > x64:
> > > TASK_SIZE_MAX    =3D 0000 7fff ffff f000
> > > TASK_SIZE    =3D 0000 7fff ffff f000
> > > bitmap size    =3D 0000 0000 ffff ffff
> > >
> > > x32:
> > > TASK_SIZE_MAX    =3D 0000 7fff ffff f000
> > > TASK_SIZE    =3D 0000 0000 ffff e000
> > > bitmap size    =3D 0000 0000 0001 ffff
> > >
> >
> > I haven=E2=80=99t followed all the details here, but I have a general p=
olicy of
> > objecting to any new use of TASK_SIZE. If you really really need to dep=
end on
> > 32-bitness in new code, please figure out what exactly you mean by =E2=
=80=9C32-bit=E2=80=9D
> > and use an explicit check.
>
> The explicit check would be:
>
> test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET : TASK_SIZE_MAX
>
> which is the same as TASK_SIZE.

But this is only ever done in response to a syscall, right?  So
wouldn't in_compat_syscall() be the right check?

Also, this whole thing makes me extremely nervous.  The MSR only
contains the start address, not the size, right?  So what prevents
some goof from causing the CPU to read way past the end of the bitmap
if the bitmap is short because the kernel thought it was supposed to
be 32-bit?

I'm inclined to suggest something awful-ish: always allocate the
bitmap as though it's for a 64-bit process, and just let it be at a
high address.  And add a syscall or arch_prctl() to manipulate it for
the benefit of 32-bit programs that can't address it directly.

>
> Or, do we want a new macro?
>
> #define IBT_BITMAP_SIZE (test_thread_flag(TIF_ADDR32) ? \
>         (IA32_PAGE_OFFSET / PAGE_SIZE / BITS_PER_BYTE) : \
>         (TASK_SIZE_MAX / PAGE_SIZE / BITS_PER_BYTE))

No.  I don't like hiding magic like this in a macro that looks like a const=
ant.
