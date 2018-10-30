Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74135C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAB920664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pWm/G0WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAB920664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJaC3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:29:00 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52966 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeJaC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:28:59 -0400
Received: by mail-it1-f195.google.com with SMTP id r5-v6so12744772ith.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TwSKLmZBGTfSy7eH4n2X3+XwpWFbTs3Jl6qf6dV0pd0=;
        b=pWm/G0WJ3AHJoJhJwbwu/AGVGldykanbd9d+/kYpe8DncEdgds7TH2cxygUE8rre4n
         555RZGbsV94QVJNIJsgkoDPFnnBP2YNzMcKQapjAkg6bgaXXyGozVq5oCdOXKXH9arKt
         o1zui/darlAiGIftBkMJjCKLSlAfl3kiqa9zBaF9d+JAzBiyGjKdsHu9DkCRuMejxNqm
         jp+DJh9hN8SD0MB6qCvHKkI3w6PR5attySSPyC/r6nd/4IiPWDu0V7ksC9JYVaQGLH8b
         FKhVTJi3OK1qeyTB/1C/Ate3n7g+4CNrc0tt+EZwdt1sB3f9tWZns/4kr3GmdQM+hQyw
         doNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwSKLmZBGTfSy7eH4n2X3+XwpWFbTs3Jl6qf6dV0pd0=;
        b=rwz/Tt3087ZklNjfmzFS00lpBZ/3H6XlZR2YzZyZj+PgwZaPo2zvRAMoBMocrjlk0H
         BPFW1hlnBP3urqw4AqSXEHFOL3MAYZ6nI0D90jBMBQCmTQVzd6hzJuMhyrFgW1n9TrRF
         GKv7gnnBaGAmPx9yyum3pRc8X0clVSBjUyZkx03R4B29xmG9PlNd7qxrsyumV5Egvpip
         VNfv0IVXVoZqewCR8DN5tFt+RjMnAP37AuyO0K+dsMdocYv7Vb6ilb0oSzaFVa0ibNAv
         zdMnlP8PKHOpKVyiBaHBXdcpyf24JIGeBt3CMZ7VPgUJVtgrkJxwBDvfiEfuAXLyqFpE
         4gtw==
X-Gm-Message-State: AGRZ1gIPyGrwNFTWd1p9jwkXpMq6kvovJO8bzHUBQODpfOZQMgKFnPo1
        lHXYpnW3R8lPhh5zQHMUOo2Xylsv7hI=
X-Google-Smtp-Source: AJdET5cY1kLBlXto2E6YMys98gl2N8whsFRLdMFxpTrclOSH3KFXzppPOZVYxEIe9BbWPUMv9Ffnbg==
X-Received: by 2002:a24:85d4:: with SMTP id r203-v6mr2206112itd.116.1540920875008;
        Tue, 30 Oct 2018 10:34:35 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w189-v6sm8232052itb.40.2018.10.30.10.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:34:33 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
 <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
 <20181030160242.GD18906@localhost.localdomain>
 <27c1017a-9560-80cb-038d-f64727a162c3@kernel.dk>
 <alpine.DEB.2.21.1810301824570.5984@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a692fbb3-59ca-0ddb-7abd-67ffc7bfcc1f@kernel.dk>
Date:   Tue, 30 Oct 2018 11:34:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810301824570.5984@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 11:25 AM, Thomas Gleixner wrote:
> Jens,
> 
> On Tue, 30 Oct 2018, Jens Axboe wrote:
>> On 10/30/18 10:02 AM, Keith Busch wrote:
>>> pci_alloc_irq_vectors_affinity() starts at the provided max_vecs. If
>>> that doesn't work, it will iterate down to min_vecs without returning to
>>> the caller. The caller doesn't have a chance to adjust its sets between
>>> iterations when you provide a range.
>>>
>>> The 'masks' overrun problem happens if the caller provides min_vecs
>>> as a smaller value than the sum of the set (plus any reserved).
>>>
>>> If it's up to the caller to ensure that doesn't happen, then min and
>>> max must both be the same value, and that value must also be the same as
>>> the set sum + reserved vectors. The range just becomes redundant since
>>> it is already bounded by the set.
>>>
>>> Using the nvme example, it would need something like this to prevent the
>>> 'masks' overrun:
>>
>> OK, now I hear what you are saying. And you are right, the callers needs
>> to provide minvec == maxvec for sets, and then have a loop around that
>> to adjust as needed.
> 
> But then we should enforce it in the core code, right?

Yes, I was going to ask you if you want a followup patch for that, or
an updated version of the original?

-- 
Jens Axboe

