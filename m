Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD9EFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877BF20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4TB3SIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877BF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbeG3PK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:10:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42699 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3PK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:10:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so10504545ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPgnd0O8lkOwFB7oeiN1sksCDUDzlMePDRTruanQ3H8=;
        b=P4TB3SIauBsSDxSdEuOuewQP7YrhtjyMTTBMmEm2qp+rcCVyR2hEVbyaYol9KMUidb
         DkbmNiOvjBhGg55UT45PzOx1KYGT6OGvrWCAyAAlzTEqZ/POg1arhElNhReXgacyKkKW
         wNrOLU4c4nKBo6qyMcWPs26r2lEx31oz9Dndg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPgnd0O8lkOwFB7oeiN1sksCDUDzlMePDRTruanQ3H8=;
        b=sJcr/tLE1PMX6D9Pq9Q49sxfDs/n9ZfgGUqimTGfGJpJ7tk2UD/4KfhwxH+s+ZPpvd
         ePxjyWe+BHB3e5oYVsK/WqnS5HfxF7LK63RsJhRS5fsYtpsgfI5JAEuRaRqZ2x0Oe/P5
         iveOEVeQr4fHlimckCsj+YixE/PLoLTgeN+uIz/YmAz4rdxd4r4g9j1MzHysvBOuJ/R3
         ylI1bqibXdlIvZX/CNp3Rh2PgG42G+QROUnAM4YIVQC9ZyNeORvfhQ/osLzVmt+glXG9
         0d032K3KPdiQDbesbQ8Hd4GF8hd1zebWvXoZzCiZw+U2yOW3z8MXfeG/VikUDkx8azUQ
         m7ww==
X-Gm-Message-State: AOUpUlGWWML021NY/QdtxIrtbvGybSazgipZMoKXB3NcKuzy+B07caAP
        aGMbqPikUcziDojAFQSXjFUIiW5WaOMdPrlIcKKXvg==
X-Google-Smtp-Source: AAOMgpdpUUDftjViDcbs1vRHf/IEs49f4NmlKs1J9KmDyjy+0U4J89QoTDeD/WUdBd1i9YS2QQRFpSXbgBXe9PMngrU=
X-Received: by 2002:a2e:91d6:: with SMTP id u22-v6mr12496903ljg.64.1532957722817;
 Mon, 30 Jul 2018 06:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com> <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
In-Reply-To: <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 30 Jul 2018 19:04:46 +0530
Message-ID: <CAMi1Hd1o=sXsbYzpxAxXoBOHBenFVOv6i2PGcBR+N+aVdZSk5Q@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     kirill@shutemov.name
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>, aarcange@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 at 18:31, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Jul 30, 2018 at 12:17:46PM +0530, Amit Pundir wrote:
> > On Mon, 30 Jul 2018 at 03:39, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > So unless something odd happens, this should be the last rc for 4.18.
> > >
> > > Nothing particularly odd happened this last week - we got the usual
> > > random set of various minor fixes all over. About two thirds of it is
> > > drivers - networking, staging and usb stands out, but there's a little
> > > bit of stuff all over (clk, block, gpu, nvme..).
> > >
> > > Outside of drivers, the bulk is some core networking stuff, with
> > > random changes elsewhere (minor arch updates, filesystems, core
> > > kernel, test scripts).
> > >
> > > The appended shortlog gives a flavor of the details.
> > >
> > >                   Linus
> > >
> > > ---
> > > Kirill A. Shutemov (3):
> > >       mm: introduce vma_init()
> > >       mm: use vma_init() to initialize VMAs on stack and data segments
> > >       mm: fix vma_is_anonymous() false-positives
> >
> > Hi, I have run into AOSP userspace crash with v4.18-rc7, leading to
> > above mm patches. bfd40eaff5ab ("mm: fix vma_is_anonymous()
> > false-positives") to be specific. The same userspace is working fine
> > with v4.18-rc6.
> >
> > I didn't yet look into what is going wrong from userspace point of
> > view, but I just wanted to give you a heads up on this. I'll be happy
> > to assist in further debugging/diagnosis if required.
>
> Youling reported basically the same bug with zygote crashing, but on
> x86-64.
>
> I think I missed vma_set_anonymous() somewhere, but I fail to see where.
>
> Could you check if removing 'vma->vm_ops = &dummy_vm_ops;" from vma_init
> makes the problem go away?

Yes removing 'vma->vm_ops = &dummy_vm_ops;" from vma_init() works.
Crash is gone with that change.

>
> Any chance the code that crashes can be run under strace?

Running strace on zygote is going to be a pain. I can check logcat
again and see if any other relatively less complex process is crashing
with similar backtrace and try to run that with strace if that is
still required.

Regards,
Amit Pundir

>
> > Here is the crash log from logcat, if it helps:
> > F DEBUG   : *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
> > F DEBUG   : Build fingerprint:
> > 'Android/db410c32_only/db410c32_only:Q/OC-MR1/102:userdebug/test-key
> > F DEBUG   : Revision: '0'
> > F DEBUG   : ABI: 'arm'
> > F DEBUG   : pid: 2261, tid: 2261, name: zygote  >>> zygote <<<
> > F DEBUG   : signal 7 (SIGBUS), code 2 (BUS_ADRERR), fault addr 0xec00008
> > .. <snip> ..
> > F DEBUG   : backtrace:
> > F DEBUG   :     #00 pc 00001c04  /system/lib/libc.so (memset+48)
> > F DEBUG   :     #01 pc 0010c513  /system/lib/libart.so
> > (create_mspace_with_base+82)
> > F DEBUG   :     #02 pc 0015c601  /system/lib/libart.so
> > (art::gc::space::DlMallocSpace::CreateMspace(void*, unsigned int,
> > unsigned int)+40)
> > F DEBUG   :     #03 pc 0015c3ed  /system/lib/libart.so
> > (art::gc::space::DlMallocSpace::CreateFromMemMap(art::MemMap*,
> > std::__1::basic_string<char, std::__
> > 1::char_traits<char>, std::__1::allocator<char>> const&, unsigned int,
> > unsigned int, unsigned int, unsigned int, bool)+36)
> > F DEBUG   :     #04 pc 0013c9ab  /system/lib/libart.so
> > (art::gc::Heap::Heap(unsigned int, unsigned int, unsigned int,
> > unsigned int, double, double, unsigned int, unsigned int,
> > std::__1::basic_string<char, std::__1::char_traits<char>,
> > std::__1::allocator<char>> const&, art::InstructionSet,
> > art::gc::CollectorType, art::gc::CollectorType,
> > art::gc::space::LargeObjectSpaceType, unsigned int, unsigned int,
> > unsigned int, bool, unsigned int, unsigned int, bool, bool, bool,
> > bool, bool, bool, bool, bool, bool, bool, bool, unsigned long
> > long)+1674)
> > DEBUG   :     #05 pc 00318201  /system/lib/libart.so
> > (art::Runtime::Init(art::RuntimeArgumentMap&&)+7036)
> > DEBUG   :     #06 pc 0031af19  /system/lib/libart.so
> > (art::Runtime::Create(std::__1::vector<std::__1::pair<std::__1::basic_string<char,
> > std::__1::char_traits<char>, std::__1::allocator<char>>, void const*>,
> > std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
> > std::__1::char_traits<char>, std::__1::allocator<char>>, void
> > const*>>> const&, bool)+68)
> > F DEBUG   :     #07 pc 0023c353  /system/lib/libart.so (JNI_CreateJavaVM+658)
> > F DEBUG   :     #08 pc 0000205f  /system/lib/libandroid_runtime.so
> > (android::AndroidRuntime::startVm(_JavaVM**, _JNIEnv**, bool)+5038)
> > F DEBUG   :     #09 pc 00002381  /system/lib/libandroid_runtime.so
> > (android::AndroidRuntime::start(char const*,
> > android::Vector<android::String8> const&, bool)+196)
> > F DEBUG   :     #10 pc 0000046b  /system/bin/app_process32 (main+702)
> >
> > Regards,
> > Amit Pundir
> >
>
> --
>  Kirill A. Shutemov
