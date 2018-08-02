Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073FEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B497C214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qu9SfZ3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B497C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeHBPEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:04:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33132 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732276AbeHBPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:04:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so1317110pfn.0;
        Thu, 02 Aug 2018 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RdCRXFVE5TBzGIEgMyO7srPCJtbIiQTFtmdQetVbZjU=;
        b=qu9SfZ3lHVp3/p8H2rh3WFR6jtUbxZGSvy9psTIK8qaMnoO1khJ9GspX26KZeZA6+c
         kEcSGNsxOYIrv/J6PQZocRfLwOyeGvpuKE3JTN6b9zwmhDOSvgaBhac/H6ITkzRT86WO
         GHOCgbEwqsK0f/P1cU9rOE6+KdE/Kks5aOyhYjv1Mpt2WagXuEQaZNYgr4sg3/WH4a/5
         EznhQqELvhE60suBhsu5//k0GPHoYgR/dQ93k5ZzeJlrB4ReIWfadVAZ6ZN3QsR/Jary
         ruy8SWtwCnD9xNnr6SLLuHiobb1jkZGUuYTlF2bGOBWU3o0jjd5MJWGkloVeFecujbHJ
         uosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RdCRXFVE5TBzGIEgMyO7srPCJtbIiQTFtmdQetVbZjU=;
        b=M7tWSHh7zRokKdnUOMrI4CaiiDQNnxOzpM76S2r06ROdUnSjN+CPWPMid5uCkLhVJG
         z4bXvnGZrS+9wFp02hM0IgtU0CmagEhn4zutmXoG5ZgmDwrHt+w9nxtAnD8daiyi5kjP
         urxNLtbDnbSnGKfBn7ikvB46nbJJobAV29s7iE09p8w5K0B8jNwVkkxazCpRMytEqViT
         uTcVef42HMN70aHFIc6BdeQqINnOtepBTwuA5+cerFn85tyLzgArXQcBzPxYzTPIAAtW
         Dizsg4gL7sL+nYY3Zvp+hgjyJvIgzSTHjSj7NlaHtmb9Ure+/GqelcOdhZu5JimowMzU
         fm7Q==
X-Gm-Message-State: AOUpUlHU17q77DcG0gPqGUaPMMtXiNBCn6AvDR7lbzbsSqaZyLcu0Wt3
        v5cPkLm9SIKAmTS/L0QKojk=
X-Google-Smtp-Source: AAOMgpc9cT1xWi5Pse5oKv+4HwD/3PfxuQ41TPtx08kzkdIUc4iCGgp5U4EPL4hvM8V6g8ncZg+xfQ==
X-Received: by 2002:a62:1314:: with SMTP id b20-v6mr2983110pfj.230.1533215584058;
        Thu, 02 Aug 2018 06:13:04 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id v6-v6sm3704900pfa.28.2018.08.02.06.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 06:13:03 -0700 (PDT)
Subject: Re: AW: PROBLEM: Kernel Oops in UDP stack
To:     David Laight <David.Laight@ACULAB.COM>,
        'Marcel Hellwig' <mhellwig@mut-group.com>,
        'Eric Dumazet' <eric.dumazet@gmail.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
Cc:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Matthias Wystrik <mwystrik@mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
Date:   Thu, 2 Aug 2018 06:13:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2018 02:17 AM, David Laight wrote:
> From: Marcel Hellwig
>> Sent: 01 August 2018 11:36
>>>> [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c):
>> net/ipv4/udp.c:1234
>>>
>>>              sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
>>>
>>> Unaligned access trap (virtual address c14fe63a), so either sin or ip_hdr(skb) are not on a 32bit
>> alignment
>>>
>>> Can you produce the disassembly of the trapping instruction ?
>>
>> https://gist.github.com/hellow554/6b11c6c0827d5db80a7e66f71f5636ff#file-net_uipv4_udp-lst-L1892-L1895
>>
>> 		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
>> c0228ad8:	e5943080 	ldr	r3, [r4, #128]	; 0x80
>> c0228adc:	e593300c 	ldr	r3, [r3, #12]
>> c0228ae0: 	e5823004	str	r3, [r2, #4]
> 
> There are actually 2 faults, difficult to quickly sort out the merged tracebacks.
> You are also running a rather old kernel: Linux version 3.4.113.
> 
> It may well be that whichever ethernet driver generated the misaligned frame
> has since been fixed.

A misalign frame driver problem would have faulted earlier in IP stack,
much before we perform the copy to user space in udp_recvmsg()


