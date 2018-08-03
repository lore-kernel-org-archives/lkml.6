Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE6C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B21D216FB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyhtxrst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B21D216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeHCGN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:13:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44639 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeHCGN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:13:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so2514382pff.11;
        Thu, 02 Aug 2018 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pbWMsL1SZ4o3blEOXUGiiVVlxcVqdDfKLZdmDvEb6qo=;
        b=QyhtxrstSgHWwZFuGQ6W03HT66cywoEF0y26HtiyuTV7mFmX4Pe+tDu/FO0E/5tGkk
         6lHl6N9PyNWj8Q+xbW2kSFd+kzJ1kxV3qB5Rxul+NNGHoKnbmtjAgxXB71KWt66YUoB2
         pLRZ+ox6Y2/LU9vl6KZ+3DsY4KRNGGvs1D4S1/Tn4UUcVZxMHhjGK+29hhPow7VPkx+9
         UrMdlQEPYhQvLbTvOeHQBIFhR/Wrw1dlpYvUvyMVU63zXCler82mpUiF9TTmXIRnA7Ts
         v6vW4+BcCbczKSPUBkBdnfBwa06an2BvtPQlmUYefJddjX9r8fiPFG0/h3b9tLRNb9Lq
         cKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pbWMsL1SZ4o3blEOXUGiiVVlxcVqdDfKLZdmDvEb6qo=;
        b=WWmpn87mASAor129/1Wfgw1SDifrgp5oq1Y4uNcZv+F9TKTXO67zF1MmABBAD4ymHp
         AdLJZyNzg+Y0Jouf4fc6UwQDMuWjknJV/HHQj8BHfZU/uOpL+qSU/tgOnpxSbGz45SIX
         3Aq6qzu78uMT++8b4zUICOJ30a8ZrNlkYJAVGjK8unAlw6lP1rq3192VM952iOVj62Iu
         uFArLI2WN3oV/BtYZKNOyTtdgJwFlx+EGk2xvYE4FZXqq6EqrPWmf1YD4t1plOWa8hXr
         a0FUhR7q9bGx60VQq24LcXKL1MSKGG/Oe7SWCk8Ny2aDPh8g1IBUBkDec6QhX0ZQBMFD
         GwPA==
X-Gm-Message-State: AOUpUlFswyiA7XRX7NDKYXpT1qcbKOPoBogvMYQHqAJ7BMGqp4lwx/qm
        R3X8IvknZpoA1qYs0hCQxxq5n06qdSE=
X-Google-Smtp-Source: AAOMgpelJDCvVcKlm8K0ecwEtLwykKpBgrG3VocWELv2AyNsZrCsHaWSObAikiWA9pnM0xZcV5d1Gw==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr2572365pfh.208.1533269976768;
        Thu, 02 Aug 2018 21:19:36 -0700 (PDT)
Received: from [192.168.1.101] (222-154-41-72-adsl.sparkbb.co.nz. [222.154.41.72])
        by smtp.gmail.com with ESMTPSA id t15-v6sm7945073pfa.158.2018.08.02.21.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 21:19:36 -0700 (PDT)
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in
 NCR5380_select
To:     Finn Thain <fthain@telegraphics.com.au>
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com>
 <c99a75a2905c1eef50f94ccc0871c36af431e21a.camel@wdc.com>
 <5B627E71.5020600@huawei.com>
 <928ae07a-8c4a-05fc-16af-48fb6e9c341d@gmail.com>
 <alpine.LNX.2.21.1808031148320.16@nippy.intranet>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6e28be9a-b601-17e2-4a04-9635925e5958@gmail.com>
Date:   Fri, 3 Aug 2018 16:19:30 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1808031148320.16@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 03.08.2018 um 14:56 schrieb Finn Thain:
> On Thu, 2 Aug 2018, Michael Schmitz wrote:
>
>>
>> This redundant load of the ICR has been in the driver code for a long
>> time. There's a small chance it is intentional,
>
> Actually, it is intentional.

I had a hunch it might be ...

>
>> so at least minimal testing might be in order.
>>
>
> Minimal testing is almost useless if you are trying to prove the absence
> of race conditions. SCSI arbitration is a race between targets by design;
> so a race between the CPU and the 5380 is going to be hard to observe.

Agreed - I was clearly being too subtle.

>
>> Finn - does the ICR_ARBITRATION_LOST bit have to be cleared by a write
>> to the mode register?
>>
>
> Something like that: the write to the mode register does clear the
> ICR_ARBITRATION_LOST bit, because it clears the MR_ARBITRATE bit.

Yes, but is that the only way the bit can get cleared? Or could the 
first read see the bit set, and the second read (after checking the bus 
data pattern for a higher arbitrating ID) see it cleared? I.e., is that 
bit latched, or does it just reflect current bus status (same as the 
data register)? (I haven't got the datasheet in front of me, so I'm 
guessing here.)

>> In that case, the first load would have been redundant and can be
>> omitted without changing driver behaviour?
>
> This code is a faithful rendition of the arbitration flow chart in the
> datasheet, so even if you are right, I wouldn't want to change the code.

I think that's a pretty clear hint that the 'arbitration lost' condition 
isn't latched. Anyway, we have no hope to demonstrate by testing that 
this patch (or my suggested alternative) does not change driver 
behaviour. No choice but to leave this as-is.

Cheers,

	Michael

