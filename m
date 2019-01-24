Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5734C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8858021872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opersys-com.20150623.gappssmtp.com header.i=@opersys-com.20150623.gappssmtp.com header.b="uQtUVQ44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfAXS5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:57:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42466 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXS5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:57:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so5443752edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opersys-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MxMqxnmBqhUVs1j0s1fdMSkuTHa/Lf8suZToYNUzoo8=;
        b=uQtUVQ44VuwE8l5JuccWqjDAqMSFjqTFhVbL/imErvOuIFPdLfHW5GJXLgGbs95aN8
         uyCgMXh1lsPoPj5i5addD2p1mO6OsD6brUBBVOl++oUIbGV9N//58Vbth1UrgpzJ+pav
         l5ohonMElxSgpWdXh63YWJURlmq7+UIaUvPkG/KEgOhDCSnztngtNsep8L6UnIDD6olO
         DDUfeuS/I1itSIri5J1/j961EWXZInTBz7/+md8bT1kH3HC9Ir3ytL7nbaSkLDEn6BLw
         qgKdKLF8/kr1CoSvdHKjdkWwtPv29mkrVakZhEim8AmgwXm4JAn47baLRqSj3otDo5eE
         fd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MxMqxnmBqhUVs1j0s1fdMSkuTHa/Lf8suZToYNUzoo8=;
        b=KELvyRSO0OO742KVTdZsBdyfePiT9iceS9zeFNGfa6piopx3w8vtIW83O9ECBvZsqb
         hRglfk9BGWyLUB8nCvvCXPHcVxttEF1nGk4avE8XZn3p/CHd9ql10/IaYMwpBpSEjpfL
         2MMyXhltnEPHSEIxj8h/ACaVqlkLXQCm5cSrxNDDS4cx5oF7IH2ZhLDsK7Heo4FAr21X
         pFKhfx63M8aYnXtMnhQ1sUqBsLiZYi1fgAEKQk9b6Vo+xjirBbOSgNJgAK+/CaRGngZV
         /8mmFE7ddmZzjE4/GXF1HE6nwyUJqna/KvYOm28hmRPbhYjZOb9J7GvGZghLMT3Spom1
         uIWw==
X-Gm-Message-State: AJcUukce+S4XQgSkS3I5hbNOd0TRqEmcxJDmgCxEb7+IBqf9xiXK/GnT
        eYrkCxA2us6yH2K4dFJnbDljUg==
X-Google-Smtp-Source: ALg8bN7OLCzD+H5HA6g7HsayUP3omdA4ZMX6nRTmT8Xy5czTp+AffvBf/A3l6UeqqQp9/MLH6uNA1g==
X-Received: by 2002:a17:906:3488:: with SMTP id g8-v6mr6896097ejb.11.1548356249385;
        Thu, 24 Jan 2019 10:57:29 -0800 (PST)
Received: from [192.168.1.101] ([62.72.193.115])
        by smtp.googlemail.com with ESMTPSA id b14sm10720136edt.6.2019.01.24.10.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:57:28 -0800 (PST)
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119102800.GB17723@infradead.org> <20190119103606.GA17400@kroah.com>
 <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com>
 <20190120161003.GB23827@google.com>
 <A40C22DF-B43F-44BA-8148-FC0881087315@zytor.com>
 <20190121014553.GD23827@google.com>
 <BC774ED4-C0FC-4AA6-9BAF-36930A661D9B@zytor.com>
 <20190122133901.GA189736@google.com>
 <117d2f96-b0e9-2376-69b7-836fa0c52539@opersys.com>
 <CAKOZuesWgo3CZj49aUChX_-dpijCrVLxgVZChyLLmOWXCLQf-Q@mail.gmail.com>
From:   Karim Yaghmour <karim.yaghmour@opersys.com>
Message-ID: <6f82d99a-d877-aeae-3e63-95dff260c445@opersys.com>
Date:   Thu, 24 Jan 2019 19:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuesWgo3CZj49aUChX_-dpijCrVLxgVZChyLLmOWXCLQf-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/23/19 11:37 PM, Daniel Colascione wrote:
> While I think there's definitely a place for eBPF as part of the
> Android performance toolkit, I think most users will end up using it
> through rich front-end performance collection and analysis tools (of
> the sort I'm working on) rather than directly as a first-line window
> into the operation of the system.

Sure, I don't disagree.

> Below this level is probably
> something like bpftrace, and below that, raw eBPF and ftrace
> manipulation. It's also worth noting that much of the time, system
> analysis is retrospection, not inspection (e.g., investigating the
> causes of rare and hard-to-reproduce bad behavior), and so iteration
> via interactive specification of eBPF programs isn't a practical path
> forward. It's still useful, even in this scenario, to be able (as part
> of higher-level tools) attach "canned" eBPF programs to the kernel to
> extract certain generally-useful bits of information, and in this
> capacity, Joel's header module would be useful.

Hmm. Not sure I agree about that. There's no reason I can't use Android 
Studio to "right-click" on a line of code or even a span of code and 
select a "trace this in detail for me" option, where "in detail" could 
mean different things depending on the code that's highlighted. Doing 
I/O calls? Then automatically measure some I/O benchmarks for that 
portion of code. Doing graphics calls? Do the same for the graphics 
stack, etc.

>> Personally I advocated a more aggressive approach with Joel in private:
>> just put the darn headers straight into the kernel image, it's the
>> *only* artifact we're sure will follow the Android device whatever
>> happens to it (like built-in ftrace).
> 
> I was thinking along similar lines. Ordinarily, we make loadable
> kernel modules. What we kind of want here is a non-loadable kernel
> module --- or a non-loadable section in the kernel image proper. I'm
> not familiar with early-stage kernel loader operation: I know it's
> possible to crease discardable sections in the kernel image, but can
> we create sections that are never slurped into memory in the first
> place? If not, maybe loading and immediately discarding the header
> section is good enough.

Interesting. Maybe just append it to the image but have it not loaded 
and have a kernel parameter than enables a "/proc/kheaders" driver to 
know where the fetch the appended headers from storage at runtime. There 
would be no RAM loading whatsoever of the headers, just some sort of 
"kheaders=/dev/foobar:offset:size" parameter. If you turn the option on, 
you get a fatter kernel image size to store on permanent storage, but no 
impact on what's loaded at boot time.

> Would such a thing really do better than LZMA? LZMA already has very
> clever techniques for eliminating long-range redundancies in
> compressible text, including redundancies at the sub-byte level. I can
> certainly understand the benefit of stripping comments, since removing
> comments really does decrease the total amount of information the
> compressor has to preserve, but I'm not sure how much the encoding
> scheme you propose below would help, since it reminds me of the
> encoding scheme that LZMA would discover automatically.

I'm no compression algorithm expert. If you say LZMA would do the 
same/better than what I suggested then I have no reason to contest that. 
My goal is to see the headers as part of the kernel image that's 
distributed on devices so that they don't have to be chased around. I'm 
just trying to make it as palatable as possible.

>> Whether such craziness makes sense or is adopted or not isn't mine to
>> chart, but I certainly can't see eBPF reaching the same mass deployment
>> ftrace has within the Android ecosystem until there's a way to use it
>> without having to chase kernel headers independently of kernel images.
>> There are "too many clicks" involved and someone somewhere will drop the
>> ball if it's not glued to the kernel in some way shape or form. Any
>> solution that solves this is one I'd love to hear about.
> 
> I agree. There definitely needs to be a "just collect a damn trace"
> button that works on any device, and for this button to work and
> incorporate eBPF, the system needs to be able to describe itself.

I like that: "the system needs to be able to describe itself". True.

Cheers,

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
