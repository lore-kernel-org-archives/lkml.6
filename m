Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31D2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5388A2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="LY3zJ5up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfAGC6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:58:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41338 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfAGC6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:58:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so21091415pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 18:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2QXH0xRRsD/ZdimkM0cbFROeHfeuE/lAJ8Hc364nC3E=;
        b=LY3zJ5upHzF39zpIFlJMlcLfq4GrO+jjXYrUPBCQFXRb8gtNAQ1R30pc0XN9H9riZ4
         9CzCFipWEk5NkWJ/wXQ1VlZFU8FXdKTSNWBIekEZAqKHGZDvOc5OKVc8rJdNyzYnYmrA
         +7dc4Sqt4IqEEr+MC2q5sqmpxaQj9U7QCe5OfhWLR5N25n9lRrKcfnMrPAiARHSjvKAy
         ZXXllwT7njCB41RxJRKOVpB3nqNLzKL9GoUthbIpa8Sfz+AQt71RdoqQa9CDs22/xLXR
         4iI6ZJomNNZAMMB1h1h49eQPmr1QiS9WXO18wSg4mhU1pnefQJi/6oiw+tovj3NNdI8U
         3sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2QXH0xRRsD/ZdimkM0cbFROeHfeuE/lAJ8Hc364nC3E=;
        b=TVO+QvwwOH0I+QPktbsf5ORS5BpQfr9/deCv+xj9kgLDCuNpIbuDzj1h+STH4jlZbm
         zeZ7LBaBc/wTxFTP9aa4wExJstgaCme3fOX+wmTSNJMvj0ImGKqEI+ni6/CR1OV1z8Xd
         +0qGKc+I5wHOJXc/tTVxQmw05kG1n0I+Ka5Yb38HFbspsSUQXRyxAK9GQOKjj1WKbpYm
         oV8HQ+5GDXLOev8EV/JuQbIrp1eX+N1AUkW3ty8cBsX3ETeXUJCHqnK5ToF2nBG6LtAX
         s47rUBy+yRxfqVJ1OoBf2ewmIz5NItY7x0Bpuo+HAzC1VDHVvlMXmYoT1BOaEdnwyglm
         S4JQ==
X-Gm-Message-State: AJcUukeEZHughEgLhs7BHyzJbum0c/0MP54pd7FwFHtVPQKRrbERgXSs
        Nga4eIzo+FSbj3CoZSZJkDjRwv9wffI=
X-Google-Smtp-Source: ALg8bN4R+WjzN8HpY0umlhC26SaUKoyobCLAkZKUX+vb20xD1rs074MwX+9fsY9O/8RYY9cpVp/Beg==
X-Received: by 2002:a63:184a:: with SMTP id 10mr56045737pgy.81.1546829885836;
        Sun, 06 Jan 2019 18:58:05 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id f13sm91004222pfa.132.2019.01.06.18.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 18:58:05 -0800 (PST)
Subject: Re: compilation failure with CONFIG_VFIO_PCI_NVLINK2
To:     Laura Abbott <labbott@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <28d0ba1d-b116-178a-d6d0-8a8b569c7c02@redhat.com>
 <e74e0922-af2e-dac4-2260-8589afa2426b@ozlabs.ru>
 <2e4484ae-06b7-0de3-db8e-3a6989fac1f7@redhat.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <91da4363-fed8-a09e-b657-6c10f2b6c33a@ozlabs.ru>
Date:   Mon, 7 Jan 2019 13:58:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2e4484ae-06b7-0de3-db8e-3a6989fac1f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/2019 02:08, Laura Abbott wrote:
> On 1/3/19 5:49 AM, Alexey Kardashevskiy wrote:
>>
>>
>> On 03/01/2019 03:37, Laura Abbott wrote:
>>> Hi,
>>>
>>> I got a compilation failure when building with CONFIG_VFIO_PCI_NVLINK2
>>> enabled:
>>>
>>> + make -s 'HOSTCFLAGS=-O2 -g -pipe -Wall -Werror=format-security
>>> -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions
>>> -fstack-protector-strong -grecord-gcc-switches
>>> -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
>>> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mcpu=power8
>>> -mtune=power8 -fasynchronous-unwind-tables -fstack-clash-protection'
>>> 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now
>>> -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -Wl,--build-id=uuid'
>>> ARCH=powerpc -j4 modules
>>> BUILDSTDERR: In file included from drivers/vfio/pci/trace.h:102,
>>> BUILDSTDERR:                  from
>>> drivers/vfio/pci/vfio_pci_nvlink2.c:29:
>>> BUILDSTDERR: ./include/trace/define_trace.h:89:42: fatal error:
>>> ./trace.h: No such file or directory
>>> BUILDSTDERR:  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>> BUILDSTDERR:                                           ^
>>> BUILDSTDERR: compilation terminated.
>>> BUILDSTDERR: make[3]: *** [scripts/Makefile.build:277:
>>> drivers/vfio/pci/vfio_pci_nvlink2.o] Error 1
>>> BUILDSTDERR: make[2]: *** [scripts/Makefile.build:492: drivers/vfio/pci]
>>> Error 2
>>> BUILDSTDERR: make[1]: *** [scripts/Makefile.build:492: drivers/vfio]
>>> Error 2
>>> BUILDSTDERR: make: *** [Makefile:1053: drivers] Error 2
>>> BUILDSTDERR: make: *** Waiting for unfinished jobs....
>>>
>>> I don't know enough about ftrace building to make a guess here.
>>> Config is attacked.
>>
>> What gcc is this and what is the exact sha1 of the tree? gcc8 prints
>> other error with your config in drivers/scsi/esas2r/esas2r_ioctl.c but
>> not this one so I am curious.
>>
> 
> gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
> 
> sha 8e143b90e4d45cca3dc53760d3cfab988bc74571


Your config and this sha1 still make "make oldconfig" ask few questions
and then it compiles just fine, are you sure about the config?

These are questions on "make oldconfig":

Kernel Live Patching (LIVEPATCH) [N/y/?] (NEW)
Stack Protector buffer overflow detection (STACKPROTECTOR) [Y/n/?] (NEW)
  Strong Stack Protector (STACKPROTECTOR_STRONG) [Y/n/?] (NEW)
    Do NOT protect notrace function from kprobe events
(KPROBE_EVENTS_ON_NOTRACE) [N/y/?] (NEW)



>>>
>>> Also, would it be possible to switch this option from def_bool to
>>> bool? I can't turn it off directly when it's def_bool.
>>
>> Why? Honestly I'd rather fix the compile error.
>>
>>
> 
> It's not just about this error, there may be other situations where
> it would be good to have this turned off.

Oh well I think I misunderstood what "def_bool" actually does (it does
not make much sense without "if" conditions). I'll post a patch.



-- 
Alexey
