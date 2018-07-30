Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DAEFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768F920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="cI6GyEPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768F920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeG3Ogf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:36:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36141 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeG3Ogf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:36:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so5521263plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6ASgZKK5V3LxehiWdESBFt/s5+p21ySwRNbWuEoXRY=;
        b=cI6GyEPYeiVQ250JHDDYJ6903pX7kmz7AKXrOU3nLS9dqd9fIfIX0Ww0uWiDaVUcZ7
         VCxwVx6BiY5YYNvvOL+Wi1xnBUynBqRSMW07uPXl0Dsr+PTsPqaErlSJVws4zBqL92Jo
         0uPl8f65sRYmJwLXtdCpZg2WsWc6cK6j3jnM4th6Ke3gvEnQef9o+MyV+NZoWuSqRm/K
         h6V3QVeNjx76bJ0K74bhoYh6pzS3yUsQPFYMfM+irTBwlFcERMbqRUJvwXKQ10FWxIpE
         iutYh2UAAJq0AJrf9NiFOmU2l6tJZSEWMuT/TK/yj+yxoTZ8lieXC13H9T8fcKkM8QGh
         tpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6ASgZKK5V3LxehiWdESBFt/s5+p21ySwRNbWuEoXRY=;
        b=Jp5GKavEo7AlvPmtlhEyOY7aDvmeAhiGVwLIQMGKkmm1d404ZDGczl1lDtgDgncmB9
         X5bvIWuoEbBWt/arTyeWlQttvUCyq25Bmr0YHliSQSsIA8qNv++TVxxzv48Cu8teewOr
         XDc6Tq3OFoDyWCOnfaK3DugqZ3fWsdFDx/qdUnr6ThPuGcMgWbt1RqHL6Mr17GC/0PqM
         jvi/ajf3L1sHebKjsTpNivhfoGQjLjIUueA5Xso5WeEvO33x4OvXHAyQxWzllmwyk/QE
         xseZkxwPBrX8ReFbUB/ljdZqVC788hxpijk4kGE+oxFlFf4Mbge9hEjFz+fvd8UCI9C5
         SQIA==
X-Gm-Message-State: AOUpUlHy3kN6HsgHs872nIXK64fLQbgw2s3DttTejKin7pwZzTQyDlle
        +49+h1w0ftRFIQ1gx/xSqekYEA==
X-Google-Smtp-Source: AAOMgpdLGTK/Dy/f8B+XSvO9/eQiazs9INstyZfdXhdHEBm8y6LPBoXS0roYqADxLUjf10UX4ASXzw==
X-Received: by 2002:a17:902:4601:: with SMTP id o1-v6mr14430506pld.202.1532955701382;
        Mon, 30 Jul 2018 06:01:41 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id w81-v6sm23525101pfk.92.2018.07.30.06.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:01:40 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 188183002A5; Mon, 30 Jul 2018 16:01:34 +0300 (+03)
Date:   Mon, 30 Jul 2018 16:01:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>, aarcange@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>
Subject: Re: Linux 4.18-rc7
Message-ID: <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:17:46PM +0530, Amit Pundir wrote:
> On Mon, 30 Jul 2018 at 03:39, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So unless something odd happens, this should be the last rc for 4.18.
> >
> > Nothing particularly odd happened this last week - we got the usual
> > random set of various minor fixes all over. About two thirds of it is
> > drivers - networking, staging and usb stands out, but there's a little
> > bit of stuff all over (clk, block, gpu, nvme..).
> >
> > Outside of drivers, the bulk is some core networking stuff, with
> > random changes elsewhere (minor arch updates, filesystems, core
> > kernel, test scripts).
> >
> > The appended shortlog gives a flavor of the details.
> >
> >                   Linus
> >
> > ---
> > Kirill A. Shutemov (3):
> >       mm: introduce vma_init()
> >       mm: use vma_init() to initialize VMAs on stack and data segments
> >       mm: fix vma_is_anonymous() false-positives
> 
> Hi, I have run into AOSP userspace crash with v4.18-rc7, leading to
> above mm patches. bfd40eaff5ab ("mm: fix vma_is_anonymous()
> false-positives") to be specific. The same userspace is working fine
> with v4.18-rc6.
> 
> I didn't yet look into what is going wrong from userspace point of
> view, but I just wanted to give you a heads up on this. I'll be happy
> to assist in further debugging/diagnosis if required.

Youling reported basically the same bug with zygote crashing, but on
x86-64.

I think I missed vma_set_anonymous() somewhere, but I fail to see where.

Could you check if removing 'vma->vm_ops = &dummy_vm_ops;" from vma_init
makes the problem go away?

Any chance the code that crashes can be run under strace?

> Here is the crash log from logcat, if it helps:
> F DEBUG   : *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
> F DEBUG   : Build fingerprint:
> 'Android/db410c32_only/db410c32_only:Q/OC-MR1/102:userdebug/test-key
> F DEBUG   : Revision: '0'
> F DEBUG   : ABI: 'arm'
> F DEBUG   : pid: 2261, tid: 2261, name: zygote  >>> zygote <<<
> F DEBUG   : signal 7 (SIGBUS), code 2 (BUS_ADRERR), fault addr 0xec00008
> .. <snip> ..
> F DEBUG   : backtrace:
> F DEBUG   :     #00 pc 00001c04  /system/lib/libc.so (memset+48)
> F DEBUG   :     #01 pc 0010c513  /system/lib/libart.so
> (create_mspace_with_base+82)
> F DEBUG   :     #02 pc 0015c601  /system/lib/libart.so
> (art::gc::space::DlMallocSpace::CreateMspace(void*, unsigned int,
> unsigned int)+40)
> F DEBUG   :     #03 pc 0015c3ed  /system/lib/libart.so
> (art::gc::space::DlMallocSpace::CreateFromMemMap(art::MemMap*,
> std::__1::basic_string<char, std::__
> 1::char_traits<char>, std::__1::allocator<char>> const&, unsigned int,
> unsigned int, unsigned int, unsigned int, bool)+36)
> F DEBUG   :     #04 pc 0013c9ab  /system/lib/libart.so
> (art::gc::Heap::Heap(unsigned int, unsigned int, unsigned int,
> unsigned int, double, double, unsigned int, unsigned int,
> std::__1::basic_string<char, std::__1::char_traits<char>,
> std::__1::allocator<char>> const&, art::InstructionSet,
> art::gc::CollectorType, art::gc::CollectorType,
> art::gc::space::LargeObjectSpaceType, unsigned int, unsigned int,
> unsigned int, bool, unsigned int, unsigned int, bool, bool, bool,
> bool, bool, bool, bool, bool, bool, bool, bool, unsigned long
> long)+1674)
> DEBUG   :     #05 pc 00318201  /system/lib/libart.so
> (art::Runtime::Init(art::RuntimeArgumentMap&&)+7036)
> DEBUG   :     #06 pc 0031af19  /system/lib/libart.so
> (art::Runtime::Create(std::__1::vector<std::__1::pair<std::__1::basic_string<char,
> std::__1::char_traits<char>, std::__1::allocator<char>>, void const*>,
> std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
> std::__1::char_traits<char>, std::__1::allocator<char>>, void
> const*>>> const&, bool)+68)
> F DEBUG   :     #07 pc 0023c353  /system/lib/libart.so (JNI_CreateJavaVM+658)
> F DEBUG   :     #08 pc 0000205f  /system/lib/libandroid_runtime.so
> (android::AndroidRuntime::startVm(_JavaVM**, _JNIEnv**, bool)+5038)
> F DEBUG   :     #09 pc 00002381  /system/lib/libandroid_runtime.so
> (android::AndroidRuntime::start(char const*,
> android::Vector<android::String8> const&, bool)+196)
> F DEBUG   :     #10 pc 0000046b  /system/bin/app_process32 (main+702)
> 
> Regards,
> Amit Pundir
> 

-- 
 Kirill A. Shutemov
