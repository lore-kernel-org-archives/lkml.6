Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16B721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opersys-com.20150623.gappssmtp.com header.i=@opersys-com.20150623.gappssmtp.com header.b="WOXxP/Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAWV3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:29:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46390 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfAWV33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:29:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so2866350edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opersys-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NtPwTB8HjhhIEWo/aYz8QPWMMTlqzbdNK2buzkp8Dxo=;
        b=WOXxP/Z0GGoaivWqmpurkMtewZVQOTYSIMaOViKQM2tUBNiQj0Re6f1WV9AC0Git49
         +rKFHYy/XbIudgQ0SclB5WBgAjOJkB6UKs1hUjZVrnb3GCaA691dyZP347vlOMMD5mUN
         vB6fnRHkpR4sUJPGVzINJo16EDtS4JWB8iySY7TIesGHfSufYsZAB/+Dossh6wwxiDaU
         oDTUFxUgWMXN9By6mfOvE67g04ff/JfK+q7FpdnbOBeU7VWm17YCW8+i0foh+FOYepaj
         GjQEKwylaQDC+t2Qj0CXngQg/RN3LC0it1NNdT2JeA5FMZi9jDRq1O8ZGFeYMlhmKGEF
         ReWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NtPwTB8HjhhIEWo/aYz8QPWMMTlqzbdNK2buzkp8Dxo=;
        b=bRcWCdzqvgYH9lLsOiLLEnVC264Cdoc8/o4yadmeNCLiOT2/sX2mxjKvF67AA7DdV+
         JhyUKToGwZisJZylK1aEBDCxARPSIZUVJ5FrsB6tWVGqTOboW0PyBEnYEFgn80Zq6ecf
         ISKQfPLylgl6I5L15vlhTVmWJ2nlI1YrFbad6uAHwJ6kOIZyikT9D9EnjmsHiNh4Y3OL
         y/AsxEk0XR8BkHee7AbDA6HocDmTA4yACNlFHpmsXMFZXUGnko0m2rRIsHIq/Nzd3Rir
         i8h8RlB1QeFj7bREzn+p8sm2HR6/po/1XsufcGqcJzje7RJW9/dg3+GfY4d8qOkF4Oha
         3U8Q==
X-Gm-Message-State: AJcUukc4zv5urfGlkrIXMZcpHDuHhqbkt0b1asm33XWnF7e5MUk9nYlA
        VT0o6UErCwtLZzGQHZW3O/sP0w==
X-Google-Smtp-Source: ALg8bN6br09mJj2UPzniCd+JKwqHsdJ7LYv+/fDjGICwZNa2bCEJ9rDwfIOBWmLHpsS+FuqB0NyzGg==
X-Received: by 2002:a50:c408:: with SMTP id v8mr4136946edf.144.1548278966510;
        Wed, 23 Jan 2019 13:29:26 -0800 (PST)
Received: from [192.168.1.101] ([62.140.137.151])
        by smtp.googlemail.com with ESMTPSA id 97sm10658923edq.45.2019.01.23.13.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:29:25 -0800 (PST)
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Joel Fernandes <joel@joelfernandes.org>, hpa@zytor.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        dancol@google.com, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
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
From:   Karim Yaghmour <karim.yaghmour@opersys.com>
Message-ID: <117d2f96-b0e9-2376-69b7-836fa0c52539@opersys.com>
Date:   Wed, 23 Jan 2019 22:29:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122133901.GA189736@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/19 2:39 PM, Joel Fernandes wrote:
[snip]
> On Sun, Jan 20, 2019 at 06:49:56PM -0800, hpa@zytor.com wrote:
[snip]
>> My point is that if we're going to actually solve a problem, we need to make it so that the distro won't just disable it anyway, and it ought to be something scalable; otherwise nothing is gained.
> 
> Agreed. Although there are many ways distros can misconfigure a kernel and
> shoot themselves in the foot.
> 
>> I am *not* disagreeing with the problem statement!
> 
> Ok, that's great to know. Thanks for all the discussions!
> 
>> Now, /proc isn't something that will autoload modules. A filesystem *will*, although you need to be able to mount it; furthermore, it makes it trivially to extend it (and the firmware interface provides an . easy way to feed the data to such a filesystem without having to muck with anything magic.)
> 
> My thought is for the tools needing the module to try to load them, if they
> need the headers. And then unload the module once they are done with it.
> 
>> Heck, we could even make it a squashfs image that can just be mounted.
> 
> That would add another dependency on a kernel configuration though.
> 
>> So, first of all, where does Android keep its modules, and what is actually included? Is /sbin/modprobe used to load the modules, as is normal? We might even be able to address this with some fairly trivial enhancements to modprobe; specifically to search in the module paths for something that isn't a module per se.
>> The best scenario would be if we could simply have the tools find the location equivalent of /lib/modules/$version/source...
> 
> Sandeep answered this in the other thread, modprobe is there in Android.
> About storing sources on the filesystem, I already went down this route (this
> was my first effort) and there is quite some resistance to ship sources on
> the filesystem of an Android device due to Licensing reasons. A kernel module
> though is something that's a binary artifact and is not something
> "distributed" by Google.
> 
> The other issue is with enforcing different OEM vendors that they should
> store kernel-header sources on their Android products. That's much harder to
> enforce, however we can easily enforce kernel config options be enabled,
> since we already enforce a kernel configuration options that are needed for
> Android to work correctly:
> https://source.android.com/devices/architecture/kernel/config. So this config
> option can just be another one.
> 
> By the way, we can easily write a script to just extract the .ko directly -
> if the whole "load it as a module" thing bothers you. The kheaders.ko can
> just be thought of as a tarball. There's already a script to extract
> /proc/config.gz in the same/similar way: scripts/extract-ikconfig

If I may add a few more thoughts here ... in no specific order:

I've been helping customers put Android in all sorts of weird devices 
over the past decade, handsets included, and have had a front-row seat 
to how this ecosystem works/has-evolved (Google, SoC vendors, 
manufacturers, etc.) One thing that stands out is that while the outside 
perception might be that Google has a stronghold on what "partners" do, 
the reality is that almost any rule that can be broken will be broken by 
someone in the ecosystem. And yet, still, Google somehow has to manage 
and provide app developers and, ultimately, consumers with a coherent 
experience, while still herding everyone to more-or-less go in the same 
direction ...

 From that point of view, if something comes from or is rooted in 
mainline, instead of being mandated, it's usually easier to find it 
across the board. A perfect example of this is ftrace. The fact that 
it's in mainline has enabled google to: a) instrument their entire stack 
to log events to it (see 
http://www.opersys.com/downloads/cc-slides/android-debug/slides-main-181012.html#/82 
and 
http://www.opersys.com/downloads/cc-slides/android-debug/slides-main-181012.html#/83), 
and b) provide app-developer-facing tools (see 
https://developer.android.com/studio/command-line/systrace). Since this 
tracing functionality is now integrated into Android Studio (look for 
"System Trace" here: 
https://developer.android.com/studio/profile/cpu-profiler), it's very 
much "standard android" and additional proof, if any was needed, that 
tracing is useful to everyone.

A few years back I was asked by a customer to put together some class 
material for internal Android debugging and performance analysis 
(commercial disclaimer applies, but slides/exercises are under 
"courseware": 
http://www.opersys.com/training/android-debug-and-performance). ftrace 
was very much in those early versions and it was great to show people 
that they could use it "out of the box". Recently I wanted to update 
this class material to cover eBPF and its applicability in Android. Holy 
cow. That turned out to be less obvious than necessary and somewhat 
peculiar to pull off. In this specific case, Joel tried a few things 
(see 
http://www.opersys.com/downloads/cc-slides/android-debug/slides-main-181012.html#/111) 
before eventually settling on loading a Debian chroot jail into a live 
Android (https://github.com/joelagnel/adeb) ... all of which require a 
proper set of kernel headers to properly function. Don't get me wrong, 
Joel's Androdeb makes this easy, but it's still outside the standard 
Android MO.

In short, let's just say that, contrary to ftrace, I don't see the path 
for eBPF to being part of the standard toolset used by app developers 
any time soon. The recently-released bpftrace might help in that regard, 
but the kernel headers aren't too far in that regard either.

Personally I advocated a more aggressive approach with Joel in private: 
just put the darn headers straight into the kernel image, it's the 
*only* artifact we're sure will follow the Android device whatever 
happens to it (like built-in ftrace). To that end, I even had some crazy 
ideas on how to compress the headers even further than with std 
compression algorithms -- here's a snippet from an email I sent Joel 
some time back detailing such a hack:
> Since C headers have fairly constrained semantics and since the types of semantics generally used to name structs, etc. in the Linux kernel are well established, we can likely devise a very customized compression algorithm for the purpose.
> 
> We know, for example, that there are quite a few ascii characters that can't be found in a normal header. So we can play some games. Say, replace all the "#" dictionary with 2 bytes, the first being a magic (illegal) ascii character and the 2nd with a constant. As such, we could replace all #foo entries with 2 bytes:
> #define goes from 7 bytes to 2
> #include from 8 to 2
> #ifdef from 6 to 2
> etc.
> 
> The same goes for several keywords of the C language and words very often found in Linux kernel headers:
> struct from 6 to 2
> linux from 5 to 2
> CONFIG from 6 to 2
> "unsigned long" from 13 to 2
> etc.
> 
> And if we run out of space with one magic character (256), we can start using a next one.
> 
> We'd have a script that runs at build time that does this replacement, and we could even package the counter-script as part of the kernel image the to convert the "cooked" headers back to their original format; ex: Steven has a README in the ftrace directory.
> 
> Such a replacement strategy combined with stripping comments and gzipping the result may provide some very interesting compression results. 

Whether such craziness makes sense or is adopted or not isn't mine to 
chart, but I certainly can't see eBPF reaching the same mass deployment 
ftrace has within the Android ecosystem until there's a way to use it 
without having to chase kernel headers independently of kernel images. 
There are "too many clicks" involved and someone somewhere will drop the 
ball if it's not glued to the kernel in some way shape or form. Any 
solution that solves this is one I'd love to hear about.

My $0.02

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
