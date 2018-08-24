Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C62C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C84D2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uYsR37Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C84D2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHYARY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:17:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32883 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeHYARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:17:24 -0400
Received: by mail-io0-f195.google.com with SMTP id r196-v6so8186976iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BMgAfttewyFfgkwQ2QRWUOGzNBUh8dZNVwn2QkNi5Os=;
        b=uYsR37DbSSrbcw+YAdHwK/6Ww68+Z+kTXVklxFK50ER7vU0MSu34Mdr+kti5+yucvY
         wfOY2xtifwYxMzMABVLTJIdzHreZ9uH7fcLMxAmRtzW/FWMVi+m650zqMnY92R2qp+Wh
         p0UMQ60l1OpKpK8ekxisSAL5I2x5fiXoPS8/z97WPxLmoipEx04+WgGvapvwwcmDBNfk
         5v0djhyU9rBHjpQGbXa4xVkQg0HiFSaIVjXJGBfTI5pAJP6QdnFa43fc0Ix0Rl/tKlbG
         JfV9SzgSEDkQicoaNkp6itMrFKG4ZXBNquS3aWUH+RGno98siWAyiD0tZyLP2mSrqA2O
         IQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMgAfttewyFfgkwQ2QRWUOGzNBUh8dZNVwn2QkNi5Os=;
        b=rRU8v45yR4EeHgEOkpWLCDyGiwdY4sT2sNQiVYvpe8fN7ouvq0p1lvus7L3Zx+KCcp
         0pERh85bQbzwtfFKtGTw3ApqWLykFb96recp8owycC9Ut8ynqAESRe9YUlOiRDG9H+BC
         NU3Di/BIKM2J6tx5YAtMXOu6urRNId8HpUd5rG1r42W4mey51NSuuGLwle4skqlMwkaX
         8xLtLSalRpkCqIp8AcgSpRho8uCXphdKcgfc2/4Jug7QCLkQxJVEJpOXoTu2XX+ISdXE
         m7TNHsKZCShJOlYEG3gwCfShIROuhqHj8xNsQ2dOXidXY5oe9m0u2gp8Lt9pf0yP0KMU
         ACeQ==
X-Gm-Message-State: APzg51DFL6kbJtqpANQCMVSuLq9MNoekh4Ff0BgIVSpVZ7fRKBhFYrQH
        xHdfcsYZN10/z0SOq6pKc07myNOCTwg=
X-Google-Smtp-Source: ANB0VdYf5eDHIs5Ie8dwMpqwexxnIkuysVlqKMu69I/FWZJ1T1JMddbhH9KjigrQeGmSOeGgh5uiGQ==
X-Received: by 2002:a5e:860d:: with SMTP id z13-v6mr2670099ioj.28.1535143269851;
        Fri, 24 Aug 2018 13:41:09 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id p13-v6sm1073762itp.3.2018.08.24.13.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:41:08 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Anchal Agarwal <anchalag@amzn.com>
Cc:     fllinden@amazon.com, Jianchao Wang <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
Date:   Fri, 24 Aug 2018 14:41:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/18 2:33 PM, Anchal Agarwal wrote:
> On Fri, Aug 24, 2018 at 12:50:44PM -0600, Jens Axboe wrote:
>> On 8/24/18 12:12 PM, Anchal Agarwal wrote:
>>> That's totally fair. As compared to before the patch it was way too high
>>> and my test case wasn't even running due to the thunderign herd issues and
>>> queue re-ordering. Anyways as I also mentioned before 10 times 
>>> contention is not too bad since its not really affecting much the number of
>>> files read in my applciation. Also, you are right waking up N tasks seems 
>>> plausible. 
>>
>> OK, I'm going to take that as a positive response. I'm going to propose
>> the last patch as the final addition in this round, since it does fix a
>> gap in the previous. And I do think that we need to wake as many tasks
>> as can make progress, otherwise we're deliberately running the device at
>> a lower load than we should.
>>
>>> My application is somewhat similar to database workload. It does uses fsync 
>>> internally also. So what it does is it creates files of random sizes with 
>>> random contents. It stores the hash of those files in memory. During the 
>>> test it reads those files back from storage and checks their hashes. 
>>
>> How many tasks are running for your test?
>>
>> -- 
>> Jens Axboe
>>
>>
> 
> So there are 128 Concurrent reads/writes happening. Max files written before
> reads start is 16384 and each file is of size 512KB. Does that answer your
> question?

Yes it does, thanks. That's not a crazy amount of tasks or threads.

> BTW, I still have to test the last patch you send but by looking at the patch 
> I assumed it will work anyways!

Thanks for the vote of confidence, I'd appreciate if you would give it a
whirl. Your workload seems nastier than what I test with, so would be
great to have someone else test it too.

-- 
Jens Axboe

