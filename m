Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBEA20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrTBJPwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBEA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIEQh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:37:27 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:39796 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIEQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:37:27 -0400
Received: by mail-it0-f54.google.com with SMTP id h1-v6so9090904itj.4;
        Wed, 05 Sep 2018 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7bDjpvrSNuhLRJI2yTRLoh7JGOR7phmxUtq+NJvtg8E=;
        b=PrTBJPwXUv4DoqHzgpTa/leI6x2eRnfjt2y/kThjFjrynmUSE7SQitmpeeR9/jloEE
         F7WpgIM5h3v6vCzBQipTwtu1LQfkS4QkmNu4BpnUN4cTpZIgfkCxQNJVriKGSdT9QuEm
         PN+ud7ma/k2HcqQf2FY35YcxRq73o9cIsfl6SlyxG1vDcECuwGlm6+zxFqf96yXdVctq
         yli0xtbYdNuzot/W444mRze/wYV8eK7WTx+rMHEypeLU68WmeGwLOKt3iXK1Zg6kKcV/
         /yRMaoulnCuhnjFaLl24lc4bDBEuRrQ7zS5ThRGFNLDqNUOZME0Ze7HTi07r6ntmfhsd
         hkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7bDjpvrSNuhLRJI2yTRLoh7JGOR7phmxUtq+NJvtg8E=;
        b=KGz85DiOLESf0i+6t3ZRtIqztIeeq3xa4PwQsgph6xze6VmJA5l8gfduAslX7ksoo/
         0g/L8pSZxeo8RU1d8HeqwLQHrprcedzORUn25VYk7eADYnCu9O3FeSBw5XOEGY+Xu+06
         oLItiyfz5A++zZxuw2VAHA/DOKXHzH80cBcvnmBolxzp13J6mdbxLL7mqotRcMym3fou
         NDf3HqmQ3b3rdbJutvylWmvzQjgqJHn91urVRe+RcI9UrMX+Ddg1eKhsGqHUcviEwPPZ
         ycKoMBhl/DwGygehF8CHpqe4eY+Kfw6TrJJT3QuyiV+VhImj3rDXQ1QjhffNPQ+KrS4q
         3eoQ==
X-Gm-Message-State: APzg51DODTJmCuKnN8wd0QheY/hh+h0da1zbBW60Mf/gDjloVBGr8pON
        7KhmgB0NRSNf54KZbjmUTc8Xy+el
X-Google-Smtp-Source: ANB0Vda3Ld1CQFSxF30X0NxgXQc6esY9rPh45sOOtAz6HIzMaoMqObV+pxDIqsU/agv9SYGzfY8JOw==
X-Received: by 2002:a24:bd8f:: with SMTP id x137-v6mr63595ite.8.1536149248767;
        Wed, 05 Sep 2018 05:07:28 -0700 (PDT)
Received: from [191.9.206.254] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id w8-v6sm1040844itb.0.2018.09.05.05.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 05:07:27 -0700 (PDT)
Subject: Re: POSIX violation by writeback error
To:     =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        R.E.Wolff@bitwizard.nl
Cc:     martin@lichtvoll.de, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180905070847.GC24519@BitWizard.nl> <3805399.0d8HT3LL4o@merkaba>
 <20180905080444.GD24519@BitWizard.nl>
 <CAJDTihya-DxyjzPJfh0LX+qOs2jvwr5TakcmRr8_U7h3pdw6cg@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <1b02ddae-35ae-8ff7-760f-bc9bafee4541@gmail.com>
Date:   Wed, 5 Sep 2018 08:07:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJDTihya-DxyjzPJfh0LX+qOs2jvwr5TakcmRr8_U7h3pdw6cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-05 04:37, 焦晓冬 wrote:
> On Wed, Sep 5, 2018 at 4:04 PM Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:
>>
>> On Wed, Sep 05, 2018 at 09:39:58AM +0200, Martin Steigerwald wrote:
>>> Rogier Wolff - 05.09.18, 09:08:
>>>> So when a mail queuer puts mail the mailq files and the mail processor
>>>> can get them out of there intact, nobody is going to notice.  (I know
>>>> mail queuers should call fsync and report errors when that fails, but
>>>> there are bound to be applications where calling fsync is not
>>>> appropriate (*))
>>>
>>> AFAIK at least Postfix MDA only reports mail as being accepted over SMTP
>>> once fsync() on the mail file completed successfully. And I´d expect
>>> every sensible MDA to do this. I don´t know how Dovecot MDA which I
>>> currently use for sieve support does this tough.
>>
> 
> Is every implementation of mail editor really going to call fsync()? Why
> they are going to call fsync(), when fsync() is meant to persist the file
> on disk which is apparently unnecessary if the delivering to SMTP task
> won't start again after reboot?
Not mail clients, the actual servers.  If they implement the SMTP 
standard correctly, they _have_ to call fsync() before they return that 
an email was accepted for delivery or relaying, because SMTP requires 
that a successful return means that the system can actually attempt 
delivery, which is not guaranteed if they haven't verified that it's 
actually written out to persistent storage.
> 
>> Yes. That's why I added the remark that mailers will call fsync and know
>> about it on the write side. I encountered a situation in the last few
>> days that when a developer runs into this while developing, would have
>> caused him to write:
>>    /* Calling this fsync causes unacceptable performance */
>>    // fsync (fd);
>>
>> I know of an application somewhere that does realtime-gathering of
>> call-records (number X called Y for Z seconds). They come in from a
>> variety of sources, get de-duplicated standardized and written to
>> files. Then different output modules push the data to the different
>> consumers within the company. Billing among them.
>>
>> Now getting old data there would be pretty bad. And calling fsync
>> all the time might have performance issues....
>>
>> That's the situation where "old data is really bad".
>>
>> But when apt-get upgrade replaces your /bin/sh and gets a write error
>> returning error on subsequent reads is really bad.
> 
> At this point, the /bin/sh may be partially old and partially new. Execute
> this corrupted bin is also dangerous though.
But the system may still be usable in that state, while returning an 
error there guarantees it isn't.  This is, in general, not the best 
example though, because no sane package manager directly overwrites 
_anything_, they all do some variation on replace-by-rename and call 
fsync _before_ renaming, so this situation is not realistically going to 
happen on any real system.
