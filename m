Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93AAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB5D2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5Oxw/vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB5D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbeHANKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:10:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34262 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbeHANKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:10:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so8671463plo.1;
        Wed, 01 Aug 2018 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JAMCg0vZ2pwDaJxOeKHAaudnzy8EUpkwrT6Z7S6vVZ0=;
        b=K5Oxw/vvDXuELo5YwvSQfQ2H+UsP6TxCJWlbxcVe4J/QauwB/BOwWS9r7BbsTgFrqU
         1rVR5SorvkWnU82zv9Z+LJIeQU6E6S4ThYompjpJN5QZ2IUq42ZBW1nDMkAJUY0tnIc9
         liBa7G5iQj5REee9T3djaq8MpfvlDJiTzN392rUVieoV+m4PGVwkCONSHPvVrHPz8GHm
         xXmjsRqdvhw4gWcm/eiCOzWtPSjr80pMEm+R4Uved7qJPRRr4uXJqBZguooNmeK8KS8g
         EqwittSaRnkVNgXM5ZK4buVutq+HwEvJSGiWFexorSxh0TP+ikXn8xoSjZBm2r9yGR9E
         7ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JAMCg0vZ2pwDaJxOeKHAaudnzy8EUpkwrT6Z7S6vVZ0=;
        b=M+6ngdyeESEIQJvFpn+ZwNiU2LUYNjjSfDtBBAWfnyRw+LG5djZ9+zUBlQ91DSMHcr
         TbTZ8KALDM7mbeuSvbYPDxj6q+mgf9zd5NqkoSaMVSm6NkHCzchWekGUAwqixDbwO+V8
         5ogxaYdCK/iguRmoJVuXyEEPy7N+JjKwLZZSz4Oe1CC7daIFZ2EVxaDMsWf0hOaMv4t8
         XqsI1bvgkXnpiOyinulrmOITPTcXZAeWrpBYJqJdX3U/c7B5UoWammf2xE772+/EFBNj
         Wae9xeNHYp+FlbnCtSKqoUM68TQcFc6GAEJSVfwuw8nJoErpU0eXsyPYRtczZ76RkGKI
         7s4g==
X-Gm-Message-State: AOUpUlEct1W0hYuz0K/9aTuxSamiE/bCkyjKBtezGLwbvZs7+9lYfLRc
        yQnbmHpasI4/QfNpfRDYqQc=
X-Google-Smtp-Source: AAOMgpdpEhwrtbYW2fW5HXDRljiIeulM6cpCXOBhEEfGzvt63BuNw4JYk2txDi0KYku5yrizQvsUig==
X-Received: by 2002:a17:902:8a87:: with SMTP id p7-v6mr24005422plo.281.1533122721624;
        Wed, 01 Aug 2018 04:25:21 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id q5-v6sm18329377pgv.61.2018.08.01.04.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 04:25:20 -0700 (PDT)
Subject: Re: AW: AW: PROBLEM: Kernel Oops in UDP stack
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Hellwig <mhellwig@mut-group.com>,
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
 <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
 <cd53c2fe-5349-c0e2-c6f5-8bcebdef7024@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b727135a-a428-72bc-fa04-dbd64095b21e@gmail.com>
Date:   Wed, 1 Aug 2018 04:25:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cd53c2fe-5349-c0e2-c6f5-8bcebdef7024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2018 03:49 AM, Eric Dumazet wrote:
> 
> 
> On 08/01/2018 03:44 AM, Paolo Abeni wrote:
>> On Wed, 2018-08-01 at 10:35 +0000, Marcel Hellwig wrote:
>>>>> [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c): net/ipv4/udp.c:1234
>>>>
>>>>              sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
>>>>
>>>> Unaligned access trap (virtual address c14fe63a), so either sin or ip_hdr(skb) are not on a 32bit alignment
>>>>
>>>> Can you produce the disassembly of the trapping instruction ?
>>>
>>> https://gist.github.com/hellow554/6b11c6c0827d5db80a7e66f71f5636ff#file-net_uipv4_udp-lst-L1892-L1895
>>>
>>> 		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
>>> c0228ad8:	e5943080 	ldr	r3, [r4, #128]	; 0x80
>>> c0228adc:	e593300c 	ldr	r3, [r3, #12]
>>> c0228ae0: 	e5823004	str	r3, [r2, #4]
>>
>> I *think* pskb_trim_rcsum() in __udp4_lib_rcv() can copy the ipv4
>> header to an unaligned address, for cloned skbs. If I understood
>> correctly the relevant socket is a mcast one, so cloned skbs can land
>> there.
>>
> 
> kmalloc() should return aligned pointer.
> 
> pskb_expand_head() should allocate aligned skb->head
> 
> So pskb_expand_head() should keep whatever offset was provided in the source skb 
> 
> ( Driver called skb_reserve() or similar function)
> 

I suspect the following patch my need to be backported, please Marcel git it a try.

Another way to spot the problem would be to add a check in pskb_expand_head()

commit 5e2afba4ecd7931ea06e6fa116ab28e6943dbd42
Author: Paul Guo <ggang@tilera.com>
Date:   Mon Nov 14 19:00:54 2011 +0800

    netfilter: possible unaligned packet header in ip_route_me_harder
    
    This patch tries to fix the following issue in netfilter:
    In ip_route_me_harder(), we invoke pskb_expand_head() that
    rellocates new header with additional head room which can break
    the alignment of the original packet header.
    
    In one of my NAT test case, the NIC port for internal hosts is
    configured with vlan and the port for external hosts is with
    general configuration. If we ping an external "unknown" hosts from an
    internal host, an icmp packet will be sent. We find that in
    icmp_send()->...->ip_route_me_harder()->pskb_expand_head(), hh_len=18
    and current headroom (skb_headroom(skb)) of the packet is 16. After
    calling pskb_expand_head() the packet header becomes to be unaligned
    and then our system (arch/tile) panics immediately.
    
    Signed-off-by: Paul Guo <ggang@tilera.com>
    Acked-by: Eric Dumazet <eric.dumazet@gmail.com>
    Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index 9899619ab9b8db0f9d8d02c8005c0e6bb01fda94..4f47e064e262c2f24e7cb13eacfcebff0fad86a3 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -64,7 +64,8 @@ int ip_route_me_harder(struct sk_buff *skb, unsigned addr_type)
        /* Change in oif may mean change in hh_len. */
        hh_len = skb_dst(skb)->dev->hard_header_len;
        if (skb_headroom(skb) < hh_len &&
-           pskb_expand_head(skb, hh_len - skb_headroom(skb), 0, GFP_ATOMIC))
+           pskb_expand_head(skb, HH_DATA_ALIGN(hh_len - skb_headroom(skb)),
+                               0, GFP_ATOMIC))
                return -1;
 
        return 0;

