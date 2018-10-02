Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA54C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98702089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="pTtdEKH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98702089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJBXQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:16:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54077 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeJBXQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:16:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so2916984wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SHf7GKYXB5qhNZJjsebIev/DMis+sNL18W3mSMKT5p0=;
        b=pTtdEKH7aBIc7YsVoPJt9NiDymLS6wdvRqAEuXXGKn4hY9Nl/o6kl2A/wN7/FNh7Zc
         fhwD2YVORjYRrMqN3FGhpPTq0meCPRrp5tXx8Gii9mGbCj5kv4hwo5vIRr6qE+usmLgo
         GM78Hd4H0VY9lolFt5Tlli8XbjF89n9xuDqST0JVPQE77/NQZwEzN9QOukcCReJ+urQh
         EZ7i1GuB13rwnPJlYOM/wNXOk0830NR3RU/Sxd+VWXABoXQt4b+WPQXuMcap+5RqI85g
         jLGzTEofbXiqlyeTxM9GvssnLq7cjSHTGdR0NwKihTW0/2JFgIGVCVraIEkwO9QrR8KT
         xICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SHf7GKYXB5qhNZJjsebIev/DMis+sNL18W3mSMKT5p0=;
        b=BiGPd06tl0AwSCfEqcaOgFkaow7jQu4mkrcB3byBq0baQTnWwdEq3We4VptoluXtNi
         BcW9VqvkenT/dxPui4LS/IKq2Wmg03WftQSc8AtBFrQnnuzamazA0OgRdVr2CA3VO6bT
         Nf8yg3tHWW1XlbAVbc911GIKopDLpOzpEmP0cdrGbneTxZDVee68fBCzAHav3VSwWay9
         pVnsA7QLD089JhWMFxCeqm/bHuUyHL17hhlBDHywBwpxFwAUe/eHHplFi08YNr30O3m4
         zIRdMtL1YRsYrxOWwzmxHdr/kWr1GxYDfAYSw31SThdkAxi4pRYOsOnCyS3FykY5Z4P8
         GQjA==
X-Gm-Message-State: ABuFfojUZ4rZSQaQz37amMJNMSRJ3PW8jK9jTeS/QWwYm3QoYwk4TR4W
        0FRPgpWBctkMkbQFNPTpsm74xQ==
X-Google-Smtp-Source: ACcGV60SgvAYNTFlPkSVEu9aHIkxY0WLuN5D3dohqCH/iZ/r9AN/1BEfP97yypIIBzCvD2Qjgs8RZA==
X-Received: by 2002:a1c:a696:: with SMTP id p144-v6mr2444528wme.14.1538497936509;
        Tue, 02 Oct 2018 09:32:16 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C77B00B5EB8DB179490446.dip0.t-ipconnect.de. [2003:d9:93c7:7b00:b5eb:8db1:7949:446])
        by smtp.googlemail.com with ESMTPSA id k7-v6sm15661196wmf.41.2018.10.02.09.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:32:15 -0700 (PDT)
Subject: Re: [PATCH v8 3/5] ipc: Allow boot time extension of IPCMNI from 32k
 to 2M
To:     Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
 <1529317698-16575-4-git-send-email-longman@redhat.com>
 <20180817164548.GA32382@linux-r8p5>
 <5ddb67bb-872b-c8c1-7838-2622195ae1fc@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <02ebafee-a295-58cf-044e-e2df0e878e0d@colorfullife.com>
Date:   Tue, 2 Oct 2018 18:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5ddb67bb-872b-c8c1-7838-2622195ae1fc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello together,

On 8/18/18 3:15 AM, Waiman Long wrote:
> On 08/17/2018 12:45 PM, Davidlohr Bueso wrote:
>> Cc'ing Manfred.
>>
>> On Mon, 18 Jun 2018, Waiman Long wrote:
>>
>>> The maximum number of unique System V IPC identifiers was limited to
>>> 32k.  That limit should be big enough for most use cases.
>>>
>>> However, there are some users out there requesting for more. To satisfy
>>> the need of those users, a new boot time kernel option "ipcmni_extend"
>>> is added to extend the IPCMNI value to 2M. This is a 64X increase which
>>> hopefully is big enough for them.
>> Could you please provide more info on the need of these users and how
>> you came up with this new value (which just seems quite arbitrary)?
>>
>> Thanks,
>> Davidlohr
> Red Hat has a customer that is migrating from Solaris to Linux. Some of
> their applications just happen to use more than 32k of shared memory
> segments. I think Solaris allows up to 16M unique ID.
>
> Yes, the amount of increase is a bit arbitrary. I was trying to balance
> how many bits should be left for sequence number. Maybe I should just
> take 8 more bits for ID and leave 8 bits for sequence number to match
> Solaris.

- I think we should use the same numbers as Solaris.
Otherwise we later have to touch it again.

- What is the performance when using shmget() with already 10M segments 
present?

- I like the new logic for updating the sequence counter.

Is there a reason why you only enable it for extended mode?

You create a rarely used codepath, and I don't understand what speaks 
against switching to the 'deleted' approach for all systems.


--

     Manfred

