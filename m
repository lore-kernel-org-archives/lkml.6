Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276520-1523794555-2-13879871966808351917
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523794554; b=Fzrvk5brBRIeTDmfPqLn8enEpaxr91M+qX0tdwMPS0NsqtITgw
    iJ2XrjvnKQt1XRG0cHsfffuPckZkETIb7Ayhk6FaPz2008hYGe8R3yXXkQ6kBfCz
    X0hk4THkBkgvl2fSb/H4HzsoWGblq0Sbx0LRBPxqD1AgrOWt96UgTUBvsLTr7wAL
    KTzxVKd7eymoBDYrMsmTxXWCfqO9+raLgIaJ3d31JRGb8Q6NAnfOG7drdw+hlC38
    W/339fYyStCKa79Avht6VER9qbn9Zh9PdilOFOm7PbfULaUtTZdt6U2NUJ9DTmFE
    DK22XLuJV8wjmeeH6FSmnD4NndtdGubSL8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523794554;
    bh=h+Dad4+YcNnTUZUE22c7cXcI4imMNUDjwkKxZ/fyt3s=; b=h1k8oHxsJBBS
    T5QlSYjzAlHzryJ6xB9g7z1RhUnD1qY8Xv5m8PLL0nWpX4hhqgb34Qa6fV29QSE7
    hymzJwcHpLM01Q6JFxwzPvV5S+edlnpYfPt9Aq920aZwTqVSznlXpXjIg9AolH5R
    k15eB7pGAMMSDLHMy0Da5/FqSN5z1ApnYGVgpZkjfSDganlEhZ5UhBR6OC7jq2t9
    dastaZV7mTgqzYlSRv0L+xBvLzUKF+tOmicksMsTcEmVRzInFh4aUqTMS+sB4nR9
    mve9Wi560YbRWhwiRAwjwrwsHJVTMARWl4hQbk6HKE24m+jDm8llJoOnorHIq8Ps
    Zn6czhYCOA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rWUTuYnz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SVgRTEq6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rWUTuYnz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SVgRTEq6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC6zZEe8lqnD6aSMGQZ4qTljhm2Dcwg+CdWk1u1x666jvMWTLXnCytGz/mfhM/lJYXddz3r7UhncZ3QdA8XsrDA7oB2NQSVetqx0w0eJR6ag4QVoJT+b
    Wl0hvd7e+hhgLg+btfjFfyrcdADVG+IW3CpWz5RjFGP+ACIOII0NFwaB89vDhuk+K5w5SWbXJLs4KNpqqDTUuu3Y1rytJCN3CQ8ZaRZWzVObFu00BURRTX4d
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=206n46q3nOkA:10 a=Kd1tUaAdevIA:10 a=NEAV23lmAAAA:8 a=qBaW39IxCM5bapGFgFsA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeDOMPl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 08:15:41 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46820 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeDOMPj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Apr 2018 08:15:39 -0400
X-Google-Smtp-Source: AIpwx49aA7R7YTKtheb16ACLFgeSikXEHLRYTD7pUG2pFnwda29MXMItKSsmbFCzK/jTYeWR0BBisg==
Subject: Re: blktest for [PATCH v2] block: do not use interruptible wait
 anywhere
To: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
 <1523608284.7787.3.camel@suse.de>
 <d1ce87d6-f77c-96d0-a3df-5ee5ed73a0bf@gmail.com>
 <edda0c9e-93c3-2da1-9521-0775d41ca1c1@kernel.dk>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <891e334c-cf19-032c-b996-59ac166fcde1@gmail.com>
Date: Sun, 15 Apr 2018 13:15:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <edda0c9e-93c3-2da1-9521-0775d41ca1c1@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/04/18 20:52, Jens Axboe wrote:
> On 4/14/18 1:46 PM, Alan Jenkins wrote:
>> On 13/04/18 09:31, Johannes Thumshirn wrote:
>>> Hi Alan,
>>>
>>> On Thu, 2018-04-12 at 19:11 +0100, Alan Jenkins wrote:
>>>> # dd if=/dev/sda of=/dev/null iflag=direct & \
>>>>     while killall -SIGUSR1 dd; do sleep 0.1; done & \
>>>>     echo mem > /sys/power/state ; \
>>>>     sleep 5; killall dd  # stop after 5 seconds
>>> Can you please also add a regression test to blktests[1] for this?
>>>
>>> [1] https://github.com/osandov/blktests
>>>
>>> Thanks,
>>> 	Johannes
>> Good question. It would be nice to promote this test.
>>
>> Template looks like I need the commit (sha1) first.
>>
>> I had some ideas about automating it, so I wrote a standalone (see
>> end).  I can automate the wakeup by using pm_test, but this is still a
>> system suspend test.  Unfortunately I don't think there's any
>> alternative. To give the most dire example
>>
>>       # This test is non-destructive, but it exercises suspend in all drivers.
>>       # If your system has a problem with suspend, it might not wake up again.
>>
>>
>> So I'm not sure if it would be acceptable for the default set?
>>
>> How useful is this going to be? Is there an expanded/full set of tests
>> that gets run somewhere?
>>
>> If you can't guarantee it's going to be run somewhere, I'd worry the
>> cost/benefit  feels a little narrow :-(. There were one or two further
>> "interesting" details, and it might theoretically bitrot if it's not run
>> periodically.
> I run it, just last week we found two new bugs with it. I'm requiring
> anyone that submits block patches to run the test suite, and also
> working towards having it be part of the 0-day runs so it gets run
> on posted patches automatically.
>
> So yes, it's useful and it won't bitrot. Please do turn it into a blktests
> test.

Thanks, it's really great to have a test suite. I was specifically 
checking in on how we can include a system suspend test.

I've been thinking the suspend test could be opt-in test (e.g. 
ALLOW_PM_TEST=1), and then we have some infrastructure (you or 0-day 
runs) that does the opt-in.  Without knowing anything about the 
infrastructure, I didn't want to assume that would work.

I'm aware of one particular suspend issue; inside virt-manager VMs I see 
Linux crashing with a null pointer in qxl_drm_freeze.  A regression soon 
after I learned how to use VMs for suspend tests :-( , and it's been 
long enough that I suspect few people use it.

Partly what you saw me fishing for in the comments, is the idea of some 
kernel code allowing more direct testing of the queue freeze / 
preempt_only flag.  That might be better engineering, but I don't know 
where I could put it.

Alan
