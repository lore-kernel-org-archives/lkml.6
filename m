Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2530C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B81320844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzZDB9jP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B81320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbeHAMfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:35:01 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:45094 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeHAMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:35:01 -0400
Received: by mail-pf1-f171.google.com with SMTP id i26-v6so7653394pfo.12;
        Wed, 01 Aug 2018 03:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8OICv+Y1dMuYh3GpHFlTBDMuB3V3WMbu4pn4lEiil+o=;
        b=hzZDB9jP4l/xxlaAs5tTV+pN3KllibWTItRWZETwb8TOCU+TiY6g9OfbLBJs1bqw1q
         cuxKau0hqRTu81kRIbwwoQNWl5uCSU1boj/Yh5tVd2QDXILxj1GICDdgvyHoCrSxUF50
         VsPbxKyK/5KDQwR7zTSk4RLualAy8JrpXcEoXKYdPX7JDJzM1T/dT4THl5n6yeZ5Ha3+
         UWhZlVraewBpQoWyU09b4miSwAtBFnSdTwVYNlUI7gREpmPhLSJp1UgUzZrIhMud1jUc
         +CK/MoYBQCoaq3rAg8L2SeXA+yJ9WSa0bCP0avp0ctJGb9DqGLl28e0flDHE1GsoELvy
         h4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8OICv+Y1dMuYh3GpHFlTBDMuB3V3WMbu4pn4lEiil+o=;
        b=eyuWavouumCjM0E2QhfbGrdV8ON6SXlwc2a3jvV7GMWGWTlQuj3If8mYUjpAX5r302
         1GDwBYRsnBnz6pVzua/lN3WZ7Xgkd0hgimynsUdhIYXgsRgl7kl6mRF9gQUl9rNN8BJv
         CiZ5siYNh6lf+EnN3LrNZ3esI2vjCRondYO6+GQ8O/2B9klFxuVRe22c6o66XPl5Z322
         YynvyVKifgqeMO7nCWp6zh5cu9+Mwfw889Vfr+BOqeCggGYT94Rj69ifRANBrZ/1OT8x
         7JD/YfQE7dlc1Z2lUIOCtsKmQKEtfiaACpV4Ts4RFTu08rPRZGm3mMhb5zyQsQJOlhVm
         naxQ==
X-Gm-Message-State: AOUpUlEKJhRExhGWu85+VlOavO3FFSxVarfVDg5bp7M0k/PwsKKVn2El
        8aERm1SGbCpMn/MZUmri/Bw=
X-Google-Smtp-Source: AAOMgpe5yO5+oF5VFOmKehAuKrRBMLsWLSLJGif/NfQ/sPYF5K7eZ9n/bQbQuSmTQhBZ+8sLHo0ddA==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr26397154pfe.209.1533120590203;
        Wed, 01 Aug 2018 03:49:50 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id y5-v6sm51739386pfj.169.2018.08.01.03.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 03:49:49 -0700 (PDT)
Subject: Re: AW: AW: PROBLEM: Kernel Oops in UDP stack
To:     Paolo Abeni <pabeni@redhat.com>,
        Marcel Hellwig <mhellwig@mut-group.com>,
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
 <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <cd53c2fe-5349-c0e2-c6f5-8bcebdef7024@gmail.com>
Date:   Wed, 1 Aug 2018 03:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2018 03:44 AM, Paolo Abeni wrote:
> On Wed, 2018-08-01 at 10:35 +0000, Marcel Hellwig wrote:
>>>> [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c): net/ipv4/udp.c:1234
>>>
>>>              sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
>>>
>>> Unaligned access trap (virtual address c14fe63a), so either sin or ip_hdr(skb) are not on a 32bit alignment
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
> I *think* pskb_trim_rcsum() in __udp4_lib_rcv() can copy the ipv4
> header to an unaligned address, for cloned skbs. If I understood
> correctly the relevant socket is a mcast one, so cloned skbs can land
> there.
> 

kmalloc() should return aligned pointer.

pskb_expand_head() should allocate aligned skb->head

So pskb_expand_head() should keep whatever offset was provided in the source skb 

( Driver called skb_reserve() or similar function)

