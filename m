Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31410C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B4720862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTcpAf1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B4720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeGaRk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:40:57 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45259 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732331AbeGaRk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:40:57 -0400
Received: by mail-pg1-f173.google.com with SMTP id f1-v6so9295817pgq.12;
        Tue, 31 Jul 2018 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ABMN9YvcXrVvyf3wkSOhp1MZzeTqrqmLeWr4KWtfpFQ=;
        b=bTcpAf1UHCYkH+h2JLqXo7O95v9e/xQxAMCCM8v2uuMT3LTpNJj8hZjVBG0TfXjLrb
         nI+fLXo6SmO19U+xtIKAJIRtDxCWbf59vsWd7KSTsQr0ltBoWbbBTFVCsbEv/G334FC+
         /8ONyQEVg99uEOALnJSfydmbx2x/C5LDtwMLTD7PPBpgn8/JFfW/h+U8RyO+rkXs3uhC
         MZaFJj+/Py9bCuM5KeUW+GsO1cqch+cx0rEikB5TnrlYI+DfhjEzXfj2ITs3YjDV6+H3
         8oxfd1zneMa1YVxszxfhlvsHkSvb8GYWD+3ZAwQZOQvTIQ3iDIbMpns40mVVLUW8UJZU
         j7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABMN9YvcXrVvyf3wkSOhp1MZzeTqrqmLeWr4KWtfpFQ=;
        b=R/V63ZJd0acWIFY1JiVysnVrXish2XfQWNNgtFgecaK7nIQa9ZaVGw7Q+miO6DePoO
         eEVpOhazDH+KugAtvd4I5hGOjDwFF2EP+Lu4LSAv+xLgPg2Z89WqnJpPoFJb+hlBp2sN
         gb2hg6nsFtirBMMPQXLj66HskTwWzbk/HBdLRhjzil5GxNpCy98AC9NDMAiVrr6zc5nI
         gl4/OC/r5p4EBh0IVHLe2syVFGEPChXesIZ2IIRRuj70eOCjdZ4Ct0uTyKwWgrXpEX6n
         Z1PIAlZMiJHHyJtfc8ah7AVWOZJ7zo1evN/ykk+oNQEqmHGb1t//AK1NUs4ARlFdVWCm
         jDgw==
X-Gm-Message-State: AOUpUlGPs9QiZzgi0R2gnEYuKDmtl7UefrxKqiqQC8hvTqSnp+UB+OUQ
        eNl1aXigJ/xZLBc22L3O16FI0BGx
X-Google-Smtp-Source: AAOMgpeWhCU9/MshxQ5WQYAGlgX9Z+u0v+VUNGCz6WUB+TLfKV/sES2vyUF159vxed6/tx5AA+zWYg==
X-Received: by 2002:aa7:87d0:: with SMTP id i16-v6mr22796627pfo.82.1533052799413;
        Tue, 31 Jul 2018 08:59:59 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id p11-v6sm26058854pfj.72.2018.07.31.08.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:59:58 -0700 (PDT)
Subject: Re: PROBLEM: Kernel Oops in UDP stack
To:     Marcel Hellwig <mhellwig@mut-group.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>
Cc:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Matthias Wystrik <mwystrik@mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
Date:   Tue, 31 Jul 2018 08:59:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 08:06 AM, Marcel Hellwig wrote:
> Dear all,

> [ 1125.100000] [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c)
> [ 1125.100000] [<c02306e0>] (inet_recvmsg+0x38/0x4c) from [<c01d2c38>] (sock_recvmsg+0xa8/0xcc)
> [ 1125.100000] [<c01d2c38>] (sock_recvmsg+0xa8/0xcc) from [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc)
> [ 1125.100000] [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc) from [<c01d4fbc>] (__sys_recvmsg+0x50/0x80)
> [ 1125.100000] [<c01d4fbc>] (__sys_recvmsg+0x50/0x80) from [<c000dfe0>] (ret_fast_syscall+0x0/0x2c)

Any idea how you could get file:line information ?

( like : udp_setsockopt+0x62/0xa0 net/ipv4/udp.c:2502 )

