Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE70C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AB823EF9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNQTSSqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AB823EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933390AbeGFPjP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:39:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36668 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932703AbeGFPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:39:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so8745415pfh.3;
        Fri, 06 Jul 2018 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+W5JAPOxPLWd5wrzgU4J396wSwDwZxxIrS3Cta+IMmA=;
        b=eNQTSSqM7PfbXWvGuW/agmyme8Mb2XMqYc49WbfkdeHEF+wwDceLMD8SSX58gE3rdL
         3/jcuIvrVDobzgohKdTlyLRvKa+5ORi3/so/AV4gdASGZZnZy3pViQgXgy5YC3Ua2kfq
         6IuRZgPsABsnoCuOZt9XjYj++Jf3K2Fa3hvaA15fFn9rD3eM0H2LrVuHLLz1MPdpUGsd
         OCAfMHCkwFvfrrb35+xSvyTZtAuunvHtinDiH9JFHMZrj3KyZvBHRDgZpUCJcJ7KC3I+
         9UgNbKC/JbKnBU0ad2cvYXF+2pkmdfJRF+lg/VGUFjnVRtS92Ti11C82sQYOT9eJOUm4
         G4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+W5JAPOxPLWd5wrzgU4J396wSwDwZxxIrS3Cta+IMmA=;
        b=tbNg6TSOhrhf7K0dX13Uo69BVNayrx1Rv7PAA5Vcmq+A3NzU03uEzDNXaybverm8RP
         MbNVmkxXFA/GlDirON3MZFqTpesmv74e16A78m+Za4wXg09blbu69vRV4hw8kpzN0D31
         DttyQHSnYh3CGiHAz/jmCk6BpNmtrSeF7GRREiYH3fdNfKaNED6QmVntJCWtbus11LTE
         k0df117pXvrcinm8fcQdfWYagmyITBdvNy+x43vOYOM8NaWoITh4dApYZf4ZJ2AKCY/w
         SmNEjD3FxJcI7vrDYRWxZHe7FONLdcUUqK46Ukd5MvVg8V1d7Hhn6fF9H0dC5Wr31A+s
         ZkLw==
X-Gm-Message-State: APt69E0WaXNJqhOxTkuiZU5QmfzuEHK/cVuqnWlxaAPCBd4ixwLV8/s0
        1HHHSj/9nrtBWvvOAERUu9PmIK/s
X-Google-Smtp-Source: AAOMgpc0FrU9pjV8eUtJWHD0J5CL9WXR8P5gdZrb7y/dqqggCv5rip+qfL3pIjCUb0qm+EsCs14v/g==
X-Received: by 2002:a63:8c5:: with SMTP id 188-v6mr9686838pgi.97.1530891552822;
        Fri, 06 Jul 2018 08:39:12 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id u42-v6sm15889481pgn.1.2018.07.06.08.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 08:39:11 -0700 (PDT)
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
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <deb5ea83-120f-9181-089d-8ae64e23dc0d@gmail.com>
Date:   Fri, 6 Jul 2018 08:39:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180706145728.57utqqrjzq7iupnh@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2018 07:57 AM, Mark Rutland wrote:
> On Fri, Jul 06, 2018 at 07:47:04AM -0700, Eric Dumazet wrote:
>>
>>
>> On 07/06/2018 07:28 AM, Mark Rutland wrote:
>>> In tnode_free() we iterate over a callback_head list with a while loop.
>>> At the start of the loop body we generate the next head pointer, and at
>>> the end of the loop body we generate the tn pointer for the next
>>> iteration of the loop by using container_of() on the head pointer to
>>> find the tnode, and deriving the kv pointer from this.
>>>
>>> In the final iteration of the loop, this means that we derive a pointer
>>> from NULL, which is undefined behaviour, which UBSAN detects:
>>
>> There is no dereference, your patch title is misleading.
>>
>> UBSAN might be fooled, not the C compiler.
> 
> I'm happy to change the title to "avoid undefined behaviour".
> 

Are you planning to change this as well ?

include/linux/stddef.h:19:#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)

(And probably dozens of other locations)

