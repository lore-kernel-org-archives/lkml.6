Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49469C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBF420870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a02DjYVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBF420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeG3IVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:21:53 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35053 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeG3IVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:21:53 -0400
Received: by mail-lj1-f182.google.com with SMTP id p10-v6so9456165ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JKnRJMmtDRTyFijUWJmAtgfa3oPhwYiuDdulRLQwOU=;
        b=a02DjYVcYnL84YNa+NHc0KpFLTHyoWNF5jrx9HSeSGGYlWoY7i1WuYXyR7qt7uynVI
         L1xZEnDTpf1E2BrKtERxPSo7h7r+MRX998zKGBJ4mrbVElpnrD4IQrG5Cr1XpL4HXFbC
         1VUwU3EXUs6/e9jd+7l/BGMirpe6s9vA8sVEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JKnRJMmtDRTyFijUWJmAtgfa3oPhwYiuDdulRLQwOU=;
        b=eMKOcp6ZAc7CKXXSesqcCw3vUPnQCrGnTWK5WKzd+JfD5GfNGZ3oBJkBBRjI8bzB++
         zLBZ+WTRdkZ5afET/HN/lTPstjrrmvvD03QtS3yFrrzCY+F2oiZ+N3hov9+PFGurfiV1
         QYAWUTRHNAus7YjxpDR+r94JoHY81Sz2Sw77eDwJ6p+VYCF3DIJ3jSY8HiXMtB20tUj/
         EdLEFM9jjnCl6XaylIHPzhqIOIMhcY5UiWe9Yx6L4yd1mKaPzk334OZbGfOFYnuwlB/N
         XtUJ+au9zi59GMw7ng0RTRorqzhDSIro8M2pM22xNtV2pms2TPToiU+jvKYM/ZRWS6CC
         bv8Q==
X-Gm-Message-State: AOUpUlGLNxbwFLsA7+pSwPVLSRRJevCGyvrb21Dukn+yfEkCYv1SVKjk
        rrI6EI4oOXv1fnsbc3k/PmT9sWEHXcPWpBQC+GElTg==
X-Google-Smtp-Source: AAOMgpcbu29bUIOMLsZbza2AQfGyudGmvQxDg5Kk7HM+rioL+f80Tb7KDok7GR4J6e7lRDY8EUT4g+OaApqHPRAEo68=
X-Received: by 2002:a2e:29da:: with SMTP id p87-v6mr11222404ljp.12.1532933302477;
 Sun, 29 Jul 2018 23:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
In-Reply-To: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 30 Jul 2018 12:17:46 +0530
Message-ID: <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>, aarcange@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 at 03:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So unless something odd happens, this should be the last rc for 4.18.
>
> Nothing particularly odd happened this last week - we got the usual
> random set of various minor fixes all over. About two thirds of it is
> drivers - networking, staging and usb stands out, but there's a little
> bit of stuff all over (clk, block, gpu, nvme..).
>
> Outside of drivers, the bulk is some core networking stuff, with
> random changes elsewhere (minor arch updates, filesystems, core
> kernel, test scripts).
>
> The appended shortlog gives a flavor of the details.
>
>                   Linus
>
> ---
> Kirill A. Shutemov (3):
>       mm: introduce vma_init()
>       mm: use vma_init() to initialize VMAs on stack and data segments
>       mm: fix vma_is_anonymous() false-positives

Hi, I have run into AOSP userspace crash with v4.18-rc7, leading to
above mm patches. bfd40eaff5ab ("mm: fix vma_is_anonymous()
false-positives") to be specific. The same userspace is working fine
with v4.18-rc6.

I didn't yet look into what is going wrong from userspace point of
view, but I just wanted to give you a heads up on this. I'll be happy
to assist in further debugging/diagnosis if required.

Here is the crash log from logcat, if it helps:
F DEBUG   : *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
F DEBUG   : Build fingerprint:
'Android/db410c32_only/db410c32_only:Q/OC-MR1/102:userdebug/test-key
F DEBUG   : Revision: '0'
F DEBUG   : ABI: 'arm'
F DEBUG   : pid: 2261, tid: 2261, name: zygote  >>> zygote <<<
F DEBUG   : signal 7 (SIGBUS), code 2 (BUS_ADRERR), fault addr 0xec00008
.. <snip> ..
F DEBUG   : backtrace:
F DEBUG   :     #00 pc 00001c04  /system/lib/libc.so (memset+48)
F DEBUG   :     #01 pc 0010c513  /system/lib/libart.so
(create_mspace_with_base+82)
F DEBUG   :     #02 pc 0015c601  /system/lib/libart.so
(art::gc::space::DlMallocSpace::CreateMspace(void*, unsigned int,
unsigned int)+40)
F DEBUG   :     #03 pc 0015c3ed  /system/lib/libart.so
(art::gc::space::DlMallocSpace::CreateFromMemMap(art::MemMap*,
std::__1::basic_string<char, std::__
1::char_traits<char>, std::__1::allocator<char>> const&, unsigned int,
unsigned int, unsigned int, unsigned int, bool)+36)
F DEBUG   :     #04 pc 0013c9ab  /system/lib/libart.so
(art::gc::Heap::Heap(unsigned int, unsigned int, unsigned int,
unsigned int, double, double, unsigned int, unsigned int,
std::__1::basic_string<char, std::__1::char_traits<char>,
std::__1::allocator<char>> const&, art::InstructionSet,
art::gc::CollectorType, art::gc::CollectorType,
art::gc::space::LargeObjectSpaceType, unsigned int, unsigned int,
unsigned int, bool, unsigned int, unsigned int, bool, bool, bool,
bool, bool, bool, bool, bool, bool, bool, bool, unsigned long
long)+1674)
DEBUG   :     #05 pc 00318201  /system/lib/libart.so
(art::Runtime::Init(art::RuntimeArgumentMap&&)+7036)
DEBUG   :     #06 pc 0031af19  /system/lib/libart.so
(art::Runtime::Create(std::__1::vector<std::__1::pair<std::__1::basic_string<char,
std::__1::char_traits<char>, std::__1::allocator<char>>, void const*>,
std::__1::allocator<std::__1::pair<std::__1::basic_string<char,
std::__1::char_traits<char>, std::__1::allocator<char>>, void
const*>>> const&, bool)+68)
F DEBUG   :     #07 pc 0023c353  /system/lib/libart.so (JNI_CreateJavaVM+658)
F DEBUG   :     #08 pc 0000205f  /system/lib/libandroid_runtime.so
(android::AndroidRuntime::startVm(_JavaVM**, _JNIEnv**, bool)+5038)
F DEBUG   :     #09 pc 00002381  /system/lib/libandroid_runtime.so
(android::AndroidRuntime::start(char const*,
android::Vector<android::String8> const&, bool)+196)
F DEBUG   :     #10 pc 0000046b  /system/bin/app_process32 (main+702)

Regards,
Amit Pundir
