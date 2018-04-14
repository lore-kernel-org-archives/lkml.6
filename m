Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2821417-1523735566-2-11690770309603355371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523735565; b=wSePAd6XM+a/NTLi9D/23gBax1RLoz9ku9cRSPle/+5elpk8WI
    RwKbheyBgJFM4HiAsXul84CEuy/gcxTDBgLCPE0KAlM7k7uHZuc3qUW1KozDHxS4
    NkqHg1I+a3uvKkIgNVgVOu2+1pCpiDdnbUSj0UlkStT1Wzu8srh0mTVybFsbvR4M
    XM5Kg4ASIqy14BHVuDJt0b13HM0oLfZov4M67qV9u/SdJtsgW2MwLoBppHLVruKJ
    Ye/DPtDMEN+1NTAR/1wJ+9rAnxOZ/hX7qeZhofd1fh+RrOvq4WH1uhpcRam2n0EG
    0VLMAagwCif0896pkLbRdFZfAVOh8vN/m7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523735565;
    bh=V/dcQVjfM434kwdzYHBljeUjTs6RLfHprdiXtaJ/Cjw=; b=LsinMu1BclhJ
    ijmMnIDsgM+yQkADsKW68oBKswtKDAvZiHiDQJxFNPmMTFzI2EHi4F/2aYDaLRfg
    7IIdNwt6q1vHD8g5aQ4jSovMQ6zptHO0ZfgTo+e1PW55l8kj1Dz9pZQo196f615O
    GXW/oHQc6DLMgYV58IwnMXeqXJYg0/DFDFpVOXvY2Ff6//R423AW2ZRn64ZZmDvq
    L+6bXreXH+0AeGrp2voAdX6pzRgSRU23K44xCOcXgVp48/xOlpKvKikurOD4ls9g
    mfiRWs/5DrNsp7BDA69w9G9pqLbdg/T0SlcxWYta4JTBsiSWjqEa4+zKhJAgvLzD
    JqttrpCVPg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=NEgDQ8wr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B3Lpsr/S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=NEgDQ8wr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B3Lpsr/S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfICtrHnd34QgoGxUCJ38Va2KJu0DoPXxVM0gmfohCtoMtATMapkQ1ngG8AmMmLMaWyzJ5H0pG2oTUZcNUW2IEaFDN06/cZ/SHVL1fBlhUVunp8BDfNah
    UdJKwpbj/1tv3EDkfDdQIBksjttxmyHQosMSPfmaGAkhtSa9FPAfTVYJ6//YYj7UtrL+LYs26BUecfCrWoil+hhK5o6VJKZTJ7g6wGu0NRkBNWf1RhxL3s8L
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=9JYAiy1CtAwP3Huq19cA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeDNTwc (ORCPT <rfc822;greg@kroah.com>);
        Sat, 14 Apr 2018 15:52:32 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:45985 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeDNTwb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Apr 2018 15:52:31 -0400
X-Google-Smtp-Source: AIpwx4/28/ax35FW9RuwMAg07XOhnoZe27W0DE/X7MCBVg+EYoKz03A5IX1LVfVXBvlbCqsUW24g3w==
Subject: Re: blktest for [PATCH v2] block: do not use interruptible wait
 anywhere
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
 <1523608284.7787.3.camel@suse.de>
 <d1ce87d6-f77c-96d0-a3df-5ee5ed73a0bf@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <edda0c9e-93c3-2da1-9521-0775d41ca1c1@kernel.dk>
Date: Sat, 14 Apr 2018 13:52:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d1ce87d6-f77c-96d0-a3df-5ee5ed73a0bf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/14/18 1:46 PM, Alan Jenkins wrote:
> On 13/04/18 09:31, Johannes Thumshirn wrote:
>> Hi Alan,
>>
>> On Thu, 2018-04-12 at 19:11 +0100, Alan Jenkins wrote:
>>> # dd if=/dev/sda of=/dev/null iflag=direct & \
>>>    while killall -SIGUSR1 dd; do sleep 0.1; done & \
>>>    echo mem > /sys/power/state ; \
>>>    sleep 5; killall dd  # stop after 5 seconds
>> Can you please also add a regression test to blktests[1] for this?
>>
>> [1] https://github.com/osandov/blktests
>>
>> Thanks,
>> 	Johannes
> 
> Good question. It would be nice to promote this test.
> 
> Template looks like I need the commit (sha1) first.
> 
> I had some ideas about automating it, so I wrote a standalone (see 
> end).  I can automate the wakeup by using pm_test, but this is still a 
> system suspend test.  Unfortunately I don't think there's any 
> alternative. To give the most dire example
> 
>      # This test is non-destructive, but it exercises suspend in all drivers.
>      # If your system has a problem with suspend, it might not wake up again.
> 
> 
> So I'm not sure if it would be acceptable for the default set?
> 
> How useful is this going to be? Is there an expanded/full set of tests 
> that gets run somewhere?
> 
> If you can't guarantee it's going to be run somewhere, I'd worry the 
> cost/benefit  feels a little narrow :-(. There were one or two further 
> "interesting" details, and it might theoretically bitrot if it's not run 
> periodically.

I run it, just last week we found two new bugs with it. I'm requiring
anyone that submits block patches to run the test suite, and also
working towards having it be part of the 0-day runs so it gets run
on posted patches automatically.

So yes, it's useful and it won't bitrot. Please do turn it into a blktests
test.

-- 
Jens Axboe
