Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0B3C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD75520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+ZrJm6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD75520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeLIWJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44048 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeLIWJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so6572018lfe.11;
        Sun, 09 Dec 2018 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n+Ya67k3G7QqpGQxiWdPuzLYWBm/bB4xDgItNbG3BA4=;
        b=s+ZrJm6AVqooMLlRVcKD7boKVIim9Bxa9V9wfBgyMMwAW/FZt7Vnw5tLuq+CDP+MTf
         wKIQDBEx8iH3Y9fyhRUeT7h3QcySPEVst7PeLoQP32zCiCRG4Wyzo0u1QHyh00DISC2b
         M8iinQedR4kVPqq9pznWFiez9fwWBm1indpACtdPGY9dynBhULTUVoF68z9vceBHzIOf
         ABvbvXRCdLK9vXM5znp34NmuNTSWSjHMi7tIbuT/L4CyIZhmBLwhkqfZ45bOKiGcwpxv
         MBmp1r8HPnOmMTWCVzFRLpUKoEiHla8s1rgMK3kvrf4Lnob2dX3hkAFvaxbzI0upTAOb
         qCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n+Ya67k3G7QqpGQxiWdPuzLYWBm/bB4xDgItNbG3BA4=;
        b=oGyYWtxG0D4XYk6AKkjgOFwvNVc9/njLYv/vOA8tlXtE+rSuLWGRDBw9c7ICuw8soy
         k6PgnN5L9KBXRh6R3goIPwlLeRzotLFiT0OTE7V+JjRupB8r2oZHjY5K7Koc6LJh/NI/
         us8UO3cnQAvNOWAa+pVITob6DFcgs+nUHeFPXO6gYXGU5/iMH7PZo/hg3Dl8xb0Mahsr
         ic/AjSaf8j9HO1jZrY2Qej/a1tm7q9c1KhZxEDlIxtiQdoxtxCqNgoi3x/Gqp+SXlG2R
         t8tErkWthDfmQmNCze4EO4IdL9/xzqaji6lZ79a4pI7f0wjzSVoKnF2p3H0UeVVkjWMq
         BrAA==
X-Gm-Message-State: AA+aEWYTPCz9PpSOvTT/vGs2bI2CeQks7Xka8B5LSHIEizkgbgh7XSfS
        +bgzfOk7SkLANM/OYR0s8B/UEaYD
X-Google-Smtp-Source: AFSGD/VJSHW72t7Jf7Fe0T8/JuzJXUCSKXCIAaKjUyBlh0Xgl0BRHqSPF9E4eh9gGxA7ZWxRN7xi8g==
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr5260797lfa.49.1544393385301;
        Sun, 09 Dec 2018 14:09:45 -0800 (PST)
Received: from [192.168.10.160] (91-159-62-226.elisa-laajakaista.fi. [91.159.62.226])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1826756lje.73.2018.12.09.14.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 14:09:44 -0800 (PST)
Subject: Re: [PATCH 2/6] __wr_after_init: write rare for static allocation
To:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
 <20181204121805.4621-3-igor.stoppa@huawei.com>
 <CALCETrVvoui0vksdt0Y9rdGL5ipEn_FtSXVVUFdH03ZC93cy_A@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <8c4c45a5-a4c9-7094-002e-9b6006eb2f9e@gmail.com>
Date:   Mon, 10 Dec 2018 00:09:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVvoui0vksdt0Y9rdGL5ipEn_FtSXVVUFdH03ZC93cy_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 01:13, Andy Lutomirski wrote:

>> +       kasan_disable_current();
>> +       if (op == WR_MEMCPY)
>> +               memcpy((void *)wr_poking_addr, (void *)src, len);
>> +       else if (op == WR_MEMSET)
>> +               memset((u8 *)wr_poking_addr, (u8)src, len);
>> +       else if (op == WR_RCU_ASSIGN_PTR)
>> +               /* generic version of rcu_assign_pointer */
>> +               smp_store_release((void **)wr_poking_addr,
>> +                                 RCU_INITIALIZER((void **)src));
>> +       kasan_enable_current();
> 
> Hmm.  I suspect this will explode quite badly on sane architectures
> like s390.  (In my book, despite how weird s390 is, it has a vastly
> nicer model of "user" memory than any other architecture I know
> of...).

I see. I can try to setup also a qemu target for s390, for my tests.
There seems to be a Debian image, to have a fully bootable system.

> I think you should use copy_to_user(), etc, instead.

I'm having troubles with the "etc" part: as far as I can see, there are 
both generic and specific support for both copying and clearing 
user-space memory from kernel, however I couldn't find something that 
looks like a memset_user().

I can of course roll my own, for example iterating copy_to_user() with 
the support of a pre-allocated static buffer (1 page should be enough).

But, before I go down this path, I wanted to confirm that there's really 
nothing better that I could use.

If that's really the case, the static buffer instance should be 
replicated for each core, I think, since each core could be performing 
its own memset_user() at the same time.

Alternatively, I could do a loop of WRITE_ONCE(), however I'm not sure 
how that would work with (lack-of) alignment and might require also a 
preamble/epilogue to deal with unaligned data?

>  I'm not
> entirely sure what the best smp_store_release() replacement is.
> Making this change may also mean you can get rid of the
> kasan_disable_current().
> 
>> +
>> +       barrier(); /* XXX redundant? */
> 
> I think it's redundant.  If unuse_temporary_mm() allows earlier stores
> to hit the wrong address space, then something is very very wrong, and
> something is also very very wrong if the optimizer starts moving
> stores across a function call that is most definitely a barrier.

ok, thanks

>> +
>> +       unuse_temporary_mm(prev);
>> +       /* XXX make the verification optional? */
>> +       if (op == WR_MEMCPY)
>> +               BUG_ON(memcmp((void *)dst, (void *)src, len));
>> +       else if (op == WR_MEMSET)
>> +               BUG_ON(memtst((void *)dst, (u8)src, len));
>> +       else if (op == WR_RCU_ASSIGN_PTR)
>> +               BUG_ON(*(unsigned long *)dst != src);
> 
> Hmm.  If you allowed cmpxchg or even plain xchg, then these bug_ons
> would be thoroughly buggy, but maybe they're okay.  But they should,
> at most, be WARN_ON_ONCE(), 

I have to confess that I do not understand why Nadav's patchset was 
required to use BUG_ON(), while here it's not correct, not even for 
memcopy or memset .

Is it because it is single-threaded?
Or is it because text_poke() is patching code, instead of data?
I can turn to WARN_ON_ONCE(), but I'd like to understand the reason.

> given that you can trigger them by writing
> the same addresses from two threads at once, and this isn't even
> entirely obviously bogus given the presence of smp_store_release().

True, however would it be reasonable to require the use of an explicit 
writer lock, from the user?

This operation is not exactly fast and should happen seldom; I'm not 
sure if it's worth supporting cmpxchg. The speedup would be minimal.

I'd rather not implement the locking implicitly, even if it would be 
possible to detect simultaneous writes, because it might lead to overall 
inconsistent data.

--
igor
