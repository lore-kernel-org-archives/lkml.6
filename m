Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE59C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834C020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qBLUh77/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834C020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeILTgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:36:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35126 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeILTgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:36:08 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so360650iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y94YMneVc7JJQ7DEcisYkmamSa3Q0md3dFh2njoiJU0=;
        b=qBLUh77/94dO5iBhhm/Yr18kJXvEqueA1OUdNNyFwQ95vZnyf1/j1f2fbbzHGLvuY1
         X/gRBCZjRRmCnm2bqS+uQohGS5DhYpf8EfYI76cq8T1ELnaLrlA77/Z1b5LF3NJXCgkR
         5Jhm2oEcM7tODWr11JulMw/TObXV74S7AKE//nTIOpZB+bH3TRdgvjkNeR4KZzVzc92J
         wAHJ38YdyBZiH577JGthb8OHcSn4nSG8wENLOghR64l2JVrCI7aXLjccgH0ZIvp4lvCm
         7G0MYY0rSYXuQ2sF8t4IcjX7LfnT/FPmj1PH7MtwrkxMe7Hq0J1NeY7dnoErY5pTL4NI
         P6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y94YMneVc7JJQ7DEcisYkmamSa3Q0md3dFh2njoiJU0=;
        b=pag6rLV3SBOOTltkwBdNDhUXAL3InFhasExNwTYuO1ZYv4/IaIl/Of+vSX99aL4JxK
         xGdQwne5EPRWdREnoj53DfZSLMmY7Q6Xx6fbXawIj/JIvW1C7AIRlytCIjl7pkZhbJFN
         kEkI7R8VKEdqg6FqhcG0xurcOeugMU303OMytG21g+j4jmvtrf1QADnYu2Ay6HcCKYfV
         uKZHMFJr3Cub/tliVcB9j/G0uiaqj7POvRD86Crjoc2SZr1HSTzU9b1/6gsVFUUfFsyU
         O/OOwNhWEo2qDfFz2sgQjifqgOQQRqPIbNYVdH1XW/54p++U93OiDhpM52V0SNt+OEB4
         s8Ow==
X-Gm-Message-State: APzg51AirUqDIA2L1TJwYg/ZDXQH+rQJr02q27gBj5vJXWEZnaDquVAn
        sWFUFoyhjykyt+ZEo6+lql6CLHCNUMU=
X-Google-Smtp-Source: ANB0VdaZJOxLY2XGL6A/7F4SSzGD1Dkmw24Xex0QVOZsjww6ytmDTrADXR8qWhatT8hlwO2nMF3QVg==
X-Received: by 2002:a6b:7906:: with SMTP id i6-v6mr1999423iop.241.1536762681717;
        Wed, 12 Sep 2018 07:31:21 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p130-v6sm525881itd.22.2018.09.12.07.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:31:20 -0700 (PDT)
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
 <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
 <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
 <8d5f3ab2-50e8-226c-8ccb-c722872910db@kernel.dk>
 <s5hbm936qii.wl-tiwai@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e932598-3e24-3918-a600-eb162a475ea3@kernel.dk>
Date:   Wed, 12 Sep 2018 08:31:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <s5hbm936qii.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/18 2:58 AM, Takashi Iwai wrote:
> On Tue, 11 Sep 2018 18:54:19 +0200,
> Jens Axboe wrote:
>>
>> On 9/11/18 10:51 AM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 9/11/18 10:48 AM, Jeff Moyer wrote:
>>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>>
>>>>>> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I noticed that bfq doesn't appear in the I/O scheduler list on
>>>>>>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>>>>>>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>>>>>>>
>>>>>>> Is this already addressed?
>>>>>>
>>>>>> Haven't heard about this one before. What kernel did you last use that
>>>>>> worked?
>>>>>
>>>>> I'm guessing you just need to update the maximum number of policies:
>>>>>
>>>>> /*
>>>>>  * Maximum number of blkcg policies allowed to be registered concurrently.
>>>>>  * Defined here to simplify include dependency.
>>>>>  */
>>>>> #define BLKCG_MAX_POLS          3
>>>>
>>>> That is my guess too, hence the suggestion to try and disable the
>>>> iolatency policy. Just tried here without, and it works, rebooting
>>>> with to verify that we're running out of policy slots.
>>>
>>> Functions calling this function: blkcg_policy_register
>>>
>>>   File                      Function       Line
>>> 0 block/bfq-iosched.c       bfq_init       5675 ret =
>>>                                                 blkcg_policy_register(&blkcg_pol
>>>                                                 icy_bfq);
>>> 1 block/blk-iolatency.c     iolatency_init  946 return
>>>                                                 blkcg_policy_register(&blkcg_pol
>>>                                                 icy_iolatency);
>>> 2 block/blk-throttle.c      throtl_init    2511 return
>>>                                                 blkcg_policy_register(&blkcg_pol
>>>                                                 icy_throtl);
>>> 3 block/cfq-iosched.c       cfq_init       4869 ret =
>>>                                                 blkcg_policy_register(&blkcg_pol
>>>                                                 icy_cfq);
>>>
>>> And then there were 4...
>>
>> Exactly. I'd bump it to 5 to leave room for one more, if we have to grow it
>> again, probably worth it to make it dynamic. So for, not really needed. Takashi,
>> can verify that the below fixes it up for you?
> 
> Yes, it works.
> 
> Tested-by: Takashi Iwai <tiwai@suse.de>

Thanks for verifying (and reporting), I'll get this in for 4.19-rc4.

-- 
Jens Axboe

