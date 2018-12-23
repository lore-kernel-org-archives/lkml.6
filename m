Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB6DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C0921929
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 02:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbrgR/yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391434AbeLWC3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 21:29:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46251 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389000AbeLWC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 21:29:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so6391351lfc.13;
        Sat, 22 Dec 2018 18:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YfYukEIvjpnj4jhj4j49e3JcsCxQDXDj8x9DO3JATjA=;
        b=vbrgR/yMRyE1WX6zkgAeWduszzxCfICWMWhoIhfGLGdDjZVUJtHdAWv/UVyOOKOY4W
         txFfBLXdUUiTPu+Tf3Img/LdZAS1TNHzCg3XUAU8ao129gR1BsTDUXVxaf6OD+oB6Ohq
         fzf3B7r5EOo3iW1+7YMrBamXdbwdVjBGSIggIIzqCzXDa5PF03ZPgfiJsAY2N8QTYgQr
         UKKRT02rUmC3KNL7Ti3i2k2rPHoz/WLbMAd9q0UkCwINLxf8YfvZlNvLQsNRB+jT6JsI
         fLwkMF7F5nf/l7mfyja9XqN/gwYMa13dDNi3PvVPFjofwz0gYb7JMY1I7SlDcgWMiIPg
         zvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfYukEIvjpnj4jhj4j49e3JcsCxQDXDj8x9DO3JATjA=;
        b=Ewl9+mvdJTqFFJ+Km1Ac/yaYJzkBDb6UbL+rU8Xb0X9sPm1+KxApsVKvjr4KNSxvwA
         1EZXGTapTD/XeyqMbLBzUb2sMV9Z4wDbMc6iUqiVSksg5iY6tVSGEdFj5NDxZPEcIgrR
         iwBg1+mXQ5aua8heWS/nT5pBZyXwxeaTGOXLJegry4o9U8iT9BPI5j7dLpVvg54uS6Ik
         VV5lReQk0GnPMNqcm3g1YwlpNHnffqHMDe0gSNsoftsjaM5w4LnD4yZINrYsnVOn3L+g
         Zqer4ChOgogzFtRckbLHtvFAIqm47uEpQ8JjQyZfzIiKo5Xt/AkeHXSWccbobz+z7nOb
         7hng==
X-Gm-Message-State: AA+aEWYma0IngmiclI98xHti4jt6jXFzaCN8XVpd2P5sU3FcHsOi4p66
        3FLFD3abxo0tEIuScBwbbArY3ozAuCmh7g==
X-Google-Smtp-Source: AFSGD/XKMxhFWZUW0drxZbMwZdEZEIqOcVdIw6joBe/4yhmEBpyKtL/VYgk3lZVAIz44EXh8HWEplQ==
X-Received: by 2002:a19:3b9c:: with SMTP id d28mr4497004lfl.30.1545532142626;
        Sat, 22 Dec 2018 18:29:02 -0800 (PST)
Received: from [192.168.10.160] (91-159-63-61.elisa-laajakaista.fi. [91.159.63.61])
        by smtp.gmail.com with ESMTPSA id o72sm5711942lfg.33.2018.12.22.18.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 18:29:01 -0800 (PST)
Subject: Re: [PATCH 03/12] __wr_after_init: generic header
To:     Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-4-igor.stoppa@huawei.com>
 <8474D7CA-E5FF-40B1-9428-855854CDDB5F@gmail.com>
 <20181221194547.GI10600@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <6562ebd3-e97d-41c4-261a-9f4b863118eb@gmail.com>
Date:   Sun, 23 Dec 2018 04:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221194547.GI10600@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2018 21:45, Matthew Wilcox wrote:
> On Fri, Dec 21, 2018 at 11:38:16AM -0800, Nadav Amit wrote:
>>> On Dec 19, 2018, at 1:33 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
>>>
>>> +static inline void *wr_memset(void *p, int c, __kernel_size_t len)
>>> +{
>>> +	return __wr_op((unsigned long)p, (unsigned long)c, len, WR_MEMSET);
>>> +}
>>
>> What do you think about doing something like:
>>
>> #define __wr          __attribute__((address_space(5)))
>>
>> And then make all the pointers to write-rarely memory to use this attribute?
>> It might require more changes to the code, but can prevent bugs.
> 
> I like this idea.  It was something I was considering suggesting.

I have been thinking about this sort of problem, although from a bit 
different angle:

1) enforcing alignment for pointers
This can be implemented in similar way, by creating a multi-attribute 
that would define section, address space, like said here, and alignment.
However I'm not sure if it's possible to do anything to enforce the 
alignment of a pointer field within a structure. I haven't had time to 
look into this yet.

2) validation of the correctness of the actual value
Inside the kernel code, a function is not supposed to sanitize its 
arguments, as long as they come from some other trusted part of the 
kernel, rather than say from userspace or from some HW interface.
However,ROP/JOP should be considered.

I am aware of various efforts to make it harder to exploit these 
techniques, like signed pointers, CFI plugins, LTO.

But they are not necessarily available on every platform and mostly, 
afaik, they focus on specific type of attacks.


LTO can help with global optimizations, for example inlining functions 
across different objects.

CFI can detect jumps in the middle of a function, rather than proper 
function invocation, from its natural entry point.

Signed pointers can prevent data-based attacks to the execution flow, 
and they might have a role in preventing the attack I have in mind, but 
they are not available on all platforms.

What I'd like to do, is to verify, at runtime, that the pointer belongs 
to the type that the receiving function is meant for.

Ex: a legitimate __wr_after_init data must exist between 
__start_wr_after_init and __end_wr_after_init

That is easier and cleaner to test, imho.

But dynamically allocated memory doesn't have any such constraint.
If it was possible to introduce, for example, a flag to pass to vmalloc, 
to get the vmap_area from within a specific address range, it would 
reduce the attack surface.

In the implementation I have right now, I'm using extra flags for the 
pmalloc pages, which means the metadata is the new target for an attack.

But with adding the constraint that a dynamically allocated protected 
memory page must be within a range, then the attacker must change the 
underlying PTE. And if a region of PTEs are all part of protected 
memory, it is possible to make the PMD write rare.

--
igor
