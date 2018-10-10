Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E022AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EFE2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GM4yd+1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EFE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJJVbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:31:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38673 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:31:47 -0400
Received: by mail-io1-f68.google.com with SMTP id n5-v6so3959126ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p+i/SeulGZsLtuJoYdnEg6qKNJlUxdAKHT2EfuI4+A8=;
        b=GM4yd+1Sp9buX1op2dU+jEsWChCwsYSarX4SxUqJsxyhIZeLoMgUCuQIlmd84f6f3J
         /b63y92iKPxF23eey37vjYRdm8XgbR6ixWi3Sd7sV1hRebXZrYvytCvL7F0xLpyofOPb
         Zl7p7GyK48lfw5EoZCb4gzpJNzpL9v/8NHftiSMQaUNeRZlpB1+QlHDBr/scsoC6z+2a
         hQ/MtcbKWwLwZEgy9vn/BQMjkCkr/4oMdrqEcfZE9Jsfm9qXRlWyf6MIb7yJSddCxIWT
         pdRSlQN9PeApnGR4yP6rGbAyi9B0S9XBWEpoYPd9IMZJ+pP2NoigF/ys6BkIfdXXgUvd
         rKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p+i/SeulGZsLtuJoYdnEg6qKNJlUxdAKHT2EfuI4+A8=;
        b=hC1YMWBuZ7jZdmFBm9/CCeNAHoZcd+VcF3EDKrbfsw9PnVtcTfKg71IWqmg6MKjGPj
         3Nz8cnzwq9hN4L2W0xfpAnGbLbpoSDSSShC76sBbYPM4+atQ2+K7rCgzqIfzYPBQwd2A
         5s5EVLBc5GBMCGlJQ6y2HZ05nti60Xi8wVdHCkURtR0awkNVPSy6jkAeJP1603kFmSrA
         TKsN5tbfCp/4NHjYoFgxkDoW7seeeeJoKqkNPTFwIO3RpuJ3xDDYXjfmtNt7jELT+0VL
         Bcwf4BGYkZ7vurPikhwte93xaEApF6jQlffH65Or/cc07Il5VNwSMR5qiFTQEFdNVPYQ
         2dCg==
X-Gm-Message-State: ABuFfoh11vBT18/TObNKH4TXXd5N/y7r5IDqqob/T1H82qHyMyCzO/vh
        Gqv+VIBX14hdy6aO6a1UAEnp2dNKg/6c2ybPIpj1iA==
X-Google-Smtp-Source: ACcGV62HccFgm+MI26AbDUUvBOuQCH1Gh+LUQJb9IxBsrhrxbmxRXh5ipQdnilWcHe7g0co5SvexGDnSTzrFy1+Aqvs=
X-Received: by 2002:a6b:ece:: with SMTP id 197-v6mr21646400ioo.192.1539180566119;
 Wed, 10 Oct 2018 07:09:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:09:25
 -0700 (PDT)
In-Reply-To: <20181003173256.GG12998@arrakis.emea.arm.com>
References: <cover.1538485901.git.andreyknvl@google.com> <47a464307d4df3c0cb65f88d1fe83f9a741dd74b.1538485901.git.andreyknvl@google.com>
 <20181003173256.GG12998@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 10 Oct 2018 16:09:25 +0200
Message-ID: <CAAeHK+yPCRNAOSi6OpYC_Tdbo9SoXRVRbx8pjXNq96v8csO-Wg@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] arm64: update Documentation/arm64/tagged-pointers.txt
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 7:32 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Oct 02, 2018 at 03:12:42PM +0200, Andrey Konovalov wrote:
>> diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
>> index a25a99e82bb1..ae877d185fdb 100644
>> --- a/Documentation/arm64/tagged-pointers.txt
>> +++ b/Documentation/arm64/tagged-pointers.txt
>> @@ -17,13 +17,21 @@ this byte for application use.
>>  Passing tagged addresses to the kernel
>>  --------------------------------------
>>
>> -All interpretation of userspace memory addresses by the kernel assumes
>> -an address tag of 0x00.
>> +Some initial work for supporting non-zero address tags passed to the
>> +kernel has been done. As of now, the kernel supports tags in:
>
> With my maintainer hat on, the above statement leads me to think this
> new ABI is work in progress, so not yet suitable for upstream.

OK, I think we can just say "The kernel supports tags in:" here. Will do in v8.

>
> Also, how is user space supposed to know that it can now pass tagged
> pointers into the kernel? An ABI change (or relaxation), needs to be
> advertised by the kernel, usually via a new HWCAP bit (e.g. HWCAP_TBI).
> Once we have a HWCAP bit in place, we need to be pretty clear about
> which syscalls can and cannot cope with tagged pointers. The "as of now"
> implies potential further relaxation which, again, would need to be
> advertised to user in some (additional) way.

How exactly should I do that? Something like this [1]? Or is it only
for hardware specific things and for this patchset I need to do
something else?

[1] https://github.com/torvalds/linux/commit/7206dc93a58fb76421c4411eefa3c003337bcb2d

>
>> -This includes, but is not limited to, addresses found in:
>> +  - user fault addresses
>
> While the kernel currently supports this in some way (by clearing the
> tag exception entry, el0_da), the above implies (at least to me) that
> sigcontext.fault_address would contain the tagged address. That's not
> the case (unless I missed it in your patches).

I'll update the doc to reflect this in v8.

>
>> - - pointer arguments to system calls, including pointers in structures
>> -   passed to system calls,
>> +  - pointer arguments (including pointers in structures), which don't
>> +    describe virtual memory ranges, passed to system calls
>
> I think we need to be more precise here...

In what way?

>
>> +All other interpretations of userspace memory addresses by the kernel
>> +assume an address tag of 0x00. This includes, but is not limited to,
>> +addresses found in:
>> +
>> + - pointer arguments (including pointers in structures), which describe
>> +   virtual memory ranges, passed to memory system calls (mmap, mprotect,
>> +   etc.)
>
> ...and probably a full list here.

Will add a full list in v8.
