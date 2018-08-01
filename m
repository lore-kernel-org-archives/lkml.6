Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90070C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418FE20685
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYqlshRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418FE20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbeHAMFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:05:31 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:45833 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbeHAMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:05:30 -0400
Received: by mail-pf1-f179.google.com with SMTP id i26-v6so7617047pfo.12;
        Wed, 01 Aug 2018 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6KjirQVM6cBNUYCJLvqWr+4AdudTfyXZbBWrDpsNR8s=;
        b=MYqlshRwrGcrwockuqRcu/iUJIJeTO/uXdy5mYD58cw05srnEGAlnUfB0PuwOaZXY5
         ISux7LBA3FD8ZU26I1wYk109GydmHdvM1n1qq5ul0hOOdB4Ka7G9j+Sk7W63TqffcFLC
         c5Eyqq9GqC8UePCXdodjWBB8mKBW/+u5FtPxmCO9+uVCF9vwLs0Zd6PBtIHalrh2pD7i
         1DWf8EQDciia0C8R5AGJPwlDPQCvdZOEzTSiYPZzARc+Q8KSozQBbG5igBEcY1mkuzck
         F2QjYff6hbP7Pin2Ai5IH9dQB3O9frwSOTIuk3YuVtF+rWDtsWaffnavkEgIiJ4CaWOg
         9+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6KjirQVM6cBNUYCJLvqWr+4AdudTfyXZbBWrDpsNR8s=;
        b=DAvGQUWL4Zj6wEKSjySxmOJ08sfFb99g7X3Cofdbb/2TSu5ursuKvUhLN+yttaABPP
         XM+P2jXO95VXSkddpG63zC4bg49Arg3/nbRgnO0s4mGOVCPSgCd3gyth/oGaeqbJCIHu
         lC5Fnc/fSG6MYj590VzDjWqmbvVbUJfwbCKBdCNdued8zA1t2WgjbsO9TDv546L6MPUT
         FbOl2YsSkNpRU0HbzjjRur8s5kowv8I6RlaNkBArfnZXow9ZjyxkVUjvt8Zz4GfIdD70
         bKrXVkNMUzcrEwqYpHsKskh9SX3PvxHSV8jdNPYqw/OdILQUG/Ix6Pg3rVw6t0OXuLMQ
         skzQ==
X-Gm-Message-State: AOUpUlG7XikLLWJfcNUvtwAD+0uo93ZxpstLxSNF8kxNJ2y3qOy0Nfoi
        fezfUOrj1F7d0qxDUsel0IQ=
X-Google-Smtp-Source: AAOMgpcG3OvaGtxVOyn3w0KZhcB4gWw6dz0VN4aKc4AySZY2OB8AihorPAkFw4CzbCTL3wiHge8ZgA==
X-Received: by 2002:a63:7007:: with SMTP id l7-v6mr24158899pgc.206.1533118826949;
        Wed, 01 Aug 2018 03:20:26 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id r81-v6sm29155301pfa.18.2018.08.01.03.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 03:20:25 -0700 (PDT)
Subject: Re: AW: PROBLEM: Kernel Oops in UDP stack
To:     Marcel Hellwig <mhellwig@mut-group.com>,
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
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
Date:   Wed, 1 Aug 2018 03:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 10:55 PM, Marcel Hellwig wrote:
> 
> [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c): net/ipv4/udp.c:1234


              sin->sin_addr.s_addr = ip_hdr(skb)->saddr;

Unaligned access trap (virtual address c14fe63a), so either sin or ip_hdr(skb) are not on a 32bit alignment

Can you produce the disassembly of the trapping instruction ?

(Is is a read at address c14fe63a, or a write ...)

Thanks.

