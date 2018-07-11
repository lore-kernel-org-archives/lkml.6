Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9F82084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR3aSXr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9F82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbeGKMVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:21:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33958 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeGKMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:21:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so9084326plo.1;
        Wed, 11 Jul 2018 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iEBvq0TsFT1LQ7yunBbMG0OXuMIdPnqpimYgUOX4jsI=;
        b=aR3aSXr4ENEYbu8yVfw7yLywRI+o9E05ev1NpnnHSQVmBY5vNw2dytXFA2iYvI/IkE
         WebKBL/gCqsZ7OH6eU/Q7VgnUqBP+WN64GXYKCCLu3ms4zunB2CitBWn0tqjY5wc+Y36
         6LoBNNgKQkx66VbvBkvFlvnVZH4dJifPOoIhR1R2xi5FmnEXmXWNuFLZJV2PgI//o7wr
         srMUPh+tAdv4mmydg/Xqi+QBY0cfZwYDnGD7Z2MyGohNbc2+JePcofShECTthQSN9wY6
         t2hjZ4DJROa5JDtTLroMxPUagzg2p5ieZZ8dwtTMbXGuQim3u9QZtCVSYODsjQbDY3KD
         DqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iEBvq0TsFT1LQ7yunBbMG0OXuMIdPnqpimYgUOX4jsI=;
        b=NEDaYM3qcPj1xZWIH/QwhNTg2aJvPGUvotEhz6khcIeoU0d8UaARlb5yONMPTUtJWV
         EyMmZkmUjclM2OpOXOAzJklNpwncQ66vjRY7oYLs59s15pLGlT5TibH24JTscc+2z49V
         gFAgMefh526TJmxK16jXZ3ZkJr/PVT4s1gKOYpKzy5QwWPzyoM7tOyXKA/Ar7kRWFVMZ
         xa1EwcFPoWFGx2CHDHh/1ujow1aHwlXn/jKSVnOu1gPLxce+XSZ3lXGI7pdxK5GupfSq
         JhHKN+3kPTN08tvcB772CMy/9lM/hAynXCz78uTU3RUGzpE+T1HJoa8ATxuJcT0tR2BP
         ja4Q==
X-Gm-Message-State: APt69E0ytmBzD1tbU2sRtLkcV1WaPf+io33Qz920LA1wtOdkKtgqr0J+
        PbN6vi26m+7k32U2dOeH6qJxGPPe
X-Google-Smtp-Source: AAOMgpfeliZeSfZ5Xipsnj/px0Blwns9WB/FJt3q5mjlssxcZrC0vB4YmWtQFMyCJ1V8mn6q5fzhcA==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr28449199plb.74.1531311469613;
        Wed, 11 Jul 2018 05:17:49 -0700 (PDT)
Received: from [10.1.10.12] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id r77-v6sm35674881pfr.117.2018.07.11.05.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:17:48 -0700 (PDT)
Subject: Re: [PATCH] [RESEND, net-next, v2] tcp: use monotonic timestamps for
 PAWS
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Atul Gupta <atul.gupta@chelsio.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Michael Werner <werner@chelsio.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180711101757.3929777-1-arnd@arndb.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <ff297506-d0eb-f242-b623-3b158dbabe0c@gmail.com>
Date:   Wed, 11 Jul 2018 05:17:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180711101757.3929777-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2018 03:16 AM, Arnd Bergmann wrote:
> Using get_seconds() for timestamps is deprecated since it can lead
> to overflows on 32-bit systems. While the interface generally doesn't
> overflow until year 2106, the specific implementation of the TCP PAWS
> algorithm breaks in 2038 when the intermediate signed 32-bit timestamps
> overflow.
> 
> A related problem is that the local timestamps in CLOCK_REALTIME form
> lead to unexpected behavior when settimeofday is called to set the system
> clock backwards or forwards by more than 24 days.
> 
> While the first problem could be solved by using an overflow-safe method
> of comparing the timestamps, a nicer solution is to use a monotonic
> clocksource with ktime_get_seconds() that simply doesn't overflow (at
> least not until 136 years after boot) and that doesn't change during
> settimeofday().
> 
> To make 32-bit and 64-bit architectures behave the same way here, and
> also save a few bytes in the tcp_options_received structure, I'm changing
> the type to a 32-bit integer, which is now safe on all architectures.

Nit: This is only manipulated under socket lock protection, so it is safe even on 
32bit kernels.

> 
> Finally, the ts_recent_stamp field also (confusingly) gets used to store
> a jiffies value in tcp_synq_overflow()/tcp_synq_no_recent_overflow().
> This is currently safe, but changing the type to 32-bit requires
> some small changes there to keep it working.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use time_before32()/time_after32() everywhere as suggested
>     Eric Dumazet in https://lore.kernel.org/lkml/67ebb94d-c73f-6c9f-493b-00c86f595120@gmail.com/

SGTM, thanks Arnd

Signed-off-by: Eric Dumazet <edumazet@google.com>

