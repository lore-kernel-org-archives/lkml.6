Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE36C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9221920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1dStBDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbeLURmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:42:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35519 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbeLURmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:42:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so4484467lfc.2;
        Fri, 21 Dec 2018 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ES2QpDL34biuGS/gjZpcfvuqAD2aanuBW43zxllJqY=;
        b=G1dStBDJy2RhAxrA9ufVmXKGorWQm+4oc71etSCtok1MAs+lLabVz44BKwoBntjGhU
         WQFKHJJSz13QjmqQ8KeyRqDSMLCqowWz83DXxE+wzgIlv6BH0qwm/OOs4/J+2YKv0K+x
         Xb/MS99QXIc8ite8h3XH4QWiW4Pixg8tjhMjoXFfTGwU9xMSlmlevn33UPR+T7q8BZhc
         00eOW6PGRJ9iOSeuEL4hZMxEIbHAZ/soqqpFKlrFwEgCqh181VCkHVX2ZVuaP5XmTpHi
         E/O+orGW7LYOyfyQjM47TGMbvGYva61PSKrr3mvWIQCK4Uetk02X6DsW/n0aSaSQaXsF
         etDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ES2QpDL34biuGS/gjZpcfvuqAD2aanuBW43zxllJqY=;
        b=ZDMpoCypAaF2Mc+O8F7HGdTSdckomXLLw8nbm3uV3kSgW/I1BdkzCDsR/XK4Ryh3mD
         ppzZhzddgYgC9vHe2t9kqHCr7guNzQKtIlqUsLZtTMV/m2CNdsdTRsLTjsuGLOcx8/Hf
         8ULcjCiXq0GmMvP3Bs/prkf/U9QFJkYMr0IYMPeSApxAdsGtDqSMoYkMbGAeNRVH0Fl1
         0xpDZjMOUy9PxtrmO9mK2KdHK6hPjIZ50TZ8FLsP1Z5PLLXEMbjCmUc0202jSk8zXSUi
         QGCAY2Dzp+Y7CyPWsM/KHCtLcU4wxkrqUwmUZvrYvAgJRydslJYYVV1AjQPxXXIsD0oj
         y9Iw==
X-Gm-Message-State: AA+aEWb7fXWCEfjwEqyW2ax/QL7rYwim1Jz+79ow4nk1I2FvUrWz+gDz
        c2K+tTViuZsB93fWxUXY4Gr7wRZA4js=
X-Google-Smtp-Source: AFSGD/UcxK/KwlyJd97jx1VIfHCdNKeQmL2zk9xTAQYn8xCyP20Z47cR7WhxAogv0cAXtpOE02aiVg==
X-Received: by 2002:a19:518d:: with SMTP id g13mr1890219lfl.143.1545414149624;
        Fri, 21 Dec 2018 09:42:29 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m21sm4931849lfl.97.2018.12.21.09.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 09:42:28 -0800 (PST)
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-5-igor.stoppa@huawei.com>
 <20181220184917.GY10600@bombadil.infradead.org>
 <d5e8523a-3afd-d992-1af3-b329985c5ed5@gmail.com>
 <CALCETrU8GZbF2oWYeKUVKBURuh1zeMqcHM5RMTchiDsdrSSVPA@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <187b5db9-63e4-05c2-ddb4-004969edb4d2@gmail.com>
Date:   Fri, 21 Dec 2018 19:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrU8GZbF2oWYeKUVKBURuh1zeMqcHM5RMTchiDsdrSSVPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2018 19:23, Andy Lutomirski wrote:
> On Thu, Dec 20, 2018 at 11:19 AM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>>
>>
>>
>> On 20/12/2018 20:49, Matthew Wilcox wrote:
>>
>>> I think you're causing yourself more headaches by implementing this "op"
>>> function.
>>
>> I probably misinterpreted the initial criticism on my first patchset,
>> about duplication. Somehow, I'm still thinking to the endgame of having
>> higher-level functions, like list management.
>>
>>> Here's some generic code:
>>
>> thank you, I have one question, below
>>
>>> void *wr_memcpy(void *dst, void *src, unsigned int len)
>>> {
>>>        wr_state_t wr_state;
>>>        void *wr_poking_addr = __wr_addr(dst);
>>>
>>>        local_irq_disable();
>>>        wr_enable(&wr_state);
>>>        __wr_memcpy(wr_poking_addr, src, len);
>>
>> Is __wraddr() invoked inside wm_memcpy() instead of being invoked
>> privately within __wr_memcpy() because the code is generic, or is there
>> some other reason?
>>
>>>        wr_disable(&wr_state);
>>>        local_irq_enable();
>>>
>>>        return dst;
>>> }
>>>
>>> Now, x86 can define appropriate macros and functions to use the temporary_mm
>>> functionality, and other architectures can do what makes sense to them.

> I suspect that most architectures will want to do this exactly like
> x86, though, but sure, it could be restructured like this.

In spirit, I think yes, but already I couldn't find a clean ways to do 
multi-arch wr_enable(&wr_state), so I made that too become arch_dependent.

Maybe after implementing write rare for a few archs, it becomes more 
clear (to me, any advice is welcome) which parts can be considered common.

> On x86, I *think* that __wr_memcpy() will want to special-case len ==
> 1, 2, 4, and (on 64-bit) 8 byte writes to keep them atomic. i'm
> guessing this is the same on most or all architectures.

I switched to xxx_user() approach, as you suggested.
For x86_64 I'm using copy_user() and i added a memset_user(), based on 
copy_user().

It's already assembly code optimized for dealing with multiples of 
8-byte words or subsets. You can see this in the first patch of the 
patchset, even this one.

I'll send out the v3 patchset in a short while.

--
igor
