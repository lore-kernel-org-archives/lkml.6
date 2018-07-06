Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59BAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A9023DDD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYa33yn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A9023DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeGFQUs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:20:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36469 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:20:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so8829968pfh.3;
        Fri, 06 Jul 2018 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4IGIvxbT+QS/GZhbjrByQbwmGSce32gT3gpzN5/qVKs=;
        b=GYa33yn2BP1awncwygkIV0wHeG7IcBklcL04ZrbCWfCHFoZ4yPnxTsTnUKXJ6zFQLO
         RGKFOgL/J6VoAnQ2JppIEWloYSrzafYmqo4wDn/O5mRwW2FKBoWV4b0AWXG2HuNHbs6K
         V1iGcQ34cRLSluN9zNw5+QJyhlE5YheQOApWe4J0SGMXwbuK9M+qYdYcWjSQp6hvJfH2
         YUIklQblQ7Pa4gLJm4S4n8V/14+quXhO+w/4z20lQbmSST2Y3GBOmfUrlWOH586r7jP5
         dar7as1F62CL/2dikjBWyQOhknaXgcMT7zPgZ0UyylC9kZB+0Bma7PFzUagNpqX4OiFZ
         bEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4IGIvxbT+QS/GZhbjrByQbwmGSce32gT3gpzN5/qVKs=;
        b=YBYiNVoaRNA4l0xzjHDqqmjpw7zyWq44n65G1FgXlF3H5Wzzp/onttGPCLSy0/1qLy
         YBwJmQeJBCIONcPX11VrwtytEk7/EeBUGzyQB0PifttCeKjw/+aSitO1NfxNjtAS0AyT
         fsTaOnRbGYl4BjQ20yEfhjWY/YDKUltLEM5AAtW+uJJT8eKNNuxRbtejLjfqYZZP0s6M
         zzvo2I69wFh4EygMp69nLdDdMa0aPUwRvGVAw5MfaBfN2VD4lnfRmeUx+7io/ULXcWGd
         H04ZrX7Z5uoYSta1sywxcj2PYwwxeWgZTKYP7OkL0aH8kfTHWFfzIcbL50fGhR8wqC9n
         7cVw==
X-Gm-Message-State: APt69E3RMxvFWoVLAI+cST87oNUxVW/SxcXNqXuIOJes0k+IKHUrtwep
        b6Xu+Mmnu8OaBb4s0+Ar3opKdKX3
X-Google-Smtp-Source: AAOMgpenFF6YcBMfCjDDf89H8BMXFyKRqNXgeUEl/IKBJ0RncxDP2S2f0Bj+zWeO9RDVkQE9w9k7nQ==
X-Received: by 2002:a63:4b5a:: with SMTP id k26-v6mr9740804pgl.384.1530894046136;
        Fri, 06 Jul 2018 09:20:46 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id s22-v6sm15303543pgs.34.2018.07.06.09.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:20:45 -0700 (PDT)
Subject: Re: [PATCH] ipv4: fib: avoid NULL dereference
To:     Mark Rutland <mark.rutland@arm.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
References: <20180706142836.1822-1-mark.rutland@arm.com>
 <3ad39534-400a-8d4e-ac50-94eb5655e565@gmail.com>
 <20180706145728.57utqqrjzq7iupnh@lakrids.cambridge.arm.com>
 <deb5ea83-120f-9181-089d-8ae64e23dc0d@gmail.com>
 <20180706155436.k5phclyyheh3zjms@lakrids.cambridge.arm.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0783dbd6-36b0-f726-7dd4-39e51d6835be@gmail.com>
Date:   Fri, 6 Jul 2018 09:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180706155436.k5phclyyheh3zjms@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2018 08:54 AM, Mark Rutland wrote:
> On Fri, Jul 06, 2018 at 08:39:11AM -0700, Eric Dumazet wrote:
>>
>>
>> On 07/06/2018 07:57 AM, Mark Rutland wrote:
>>> On Fri, Jul 06, 2018 at 07:47:04AM -0700, Eric Dumazet wrote:
>>>>
>>>>
>>>> On 07/06/2018 07:28 AM, Mark Rutland wrote:
>>>>> In tnode_free() we iterate over a callback_head list with a while loop.
>>>>> At the start of the loop body we generate the next head pointer, and at
>>>>> the end of the loop body we generate the tn pointer for the next
>>>>> iteration of the loop by using container_of() on the head pointer to
>>>>> find the tnode, and deriving the kv pointer from this.
>>>>>
>>>>> In the final iteration of the loop, this means that we derive a pointer
>>>>> from NULL, which is undefined behaviour, which UBSAN detects:
>>>>
>>>> There is no dereference, your patch title is misleading.
>>>>
>>>> UBSAN might be fooled, not the C compiler.
>>>
>>> I'm happy to change the title to "avoid undefined behaviour".
>>>
>>
>> Are you planning to change this as well ?
>>
>> include/linux/stddef.h:19:#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
> 
> No, because __builtin_offsetof() is used these days (since GCC 4),
> avoiding the undefined behaviour.

Ah... should we remove the line and declare linux must be compiled
with GCC 4 at least ?

> 
>> (And probably dozens of other locations)
> 
> I do concede that if this is everywhere it's not worth the effort, and
> from the looks of things, the gnaliest cases are where we do things
> like:
> 
>   get_user(var, &struct->field)
> 
> ... where the user could validly pass a NULL pointer if it wished.
> 
> So I guess I'll give up.

There is value to your patch, since it makes UBSAN happy.

But please change the title and changelog accordingly.

Thanks.


