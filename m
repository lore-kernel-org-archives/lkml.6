Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56B6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AEC20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HiCgKM8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AEC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIKVye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:54:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37472 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIKVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:54:33 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so2435213itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pJwSL+Ex5BwU3Q4l+hkP2rNBf6mJHe2JkKE5URc2FRA=;
        b=HiCgKM8aVo+0y5tK+MSdf2Ax2crYIinDO0Gj3HGBedkabI1QaajHfxao3ltZuV1prd
         UgiZ7iZHcen/aelW06pqNymMveqEX61a7kJo6JlUzPO2Hj5VzaFZOmLpT4E5bRaIsx1P
         gq+4eaMj4pWWuQEk1S+98SK9z2fLZqUKqrM+1h4O1Hz2NhDxHMNZio+cEaDvK/B26N0d
         GkgwWU7DP8wtt6InLELu/90sJ4sgG+liGtVVfbSC+5FY+jkaIeDvdpYmF0HtgZtUgDPZ
         yJhqK74J3z0QEVjbGYGQxQ6629XQrtlXQtAyBT9YFtVzAzeIjJoBncv9m6z1zcb/cN4g
         80DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJwSL+Ex5BwU3Q4l+hkP2rNBf6mJHe2JkKE5URc2FRA=;
        b=E4uEuGEyEMFILtDbCuv++Jq2g5DQK/aEhEv5BHhr4XM7UXPh8QiEzmdYywLi4oqcof
         WrsUUxxof9ydBW6yhAPk+LmEB9vnku6p5CA+oPilwYbp0H3/WZsEOrPdiiBXOdTg9xPR
         kqaXmMQSuqvay166qbJkqkgkl7el61aPYC2kyPZqraSaaT/Pm/7yfkWoFrwqAk2AEda2
         a53ixO6wOJ8Cbh1MPu3usJNtD1+d+alVEF8k9wmggpgtDest+7dJW+V2T0IfzCKGl6vo
         4AUFZKcY5Poj90Quo1YGmzpceASSuFp7xJBmk07HuzXOrUov8oEWQOg7YALIPDJO71v7
         CL8g==
X-Gm-Message-State: APzg51ASPqAbgitFL05czYmbmu0DW6N9IlyODWRNynhvzbklM3vblgEz
        s7S0DVtfg5VOldE65JjmSgLQFWdVAyg=
X-Google-Smtp-Source: ANB0VdbB4ryyJRdxjBr0S7t3Cfi309xPD7ALWOgczja8gH2tOikkg5vDTzqzn6r6VCFQiH8Fr6bA7Q==
X-Received: by 2002:a02:1881:: with SMTP id 1-v6mr24171696jar.76.1536684862562;
        Tue, 11 Sep 2018 09:54:22 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id a64-v6sm546403itg.40.2018.09.11.09.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:54:21 -0700 (PDT)
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
 <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
 <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d5f3ab2-50e8-226c-8ccb-c722872910db@kernel.dk>
Date:   Tue, 11 Sep 2018 10:54:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 10:51 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 9/11/18 10:48 AM, Jeff Moyer wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> I noticed that bfq doesn't appear in the I/O scheduler list on
>>>>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>>>>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>>>>>
>>>>> Is this already addressed?
>>>>
>>>> Haven't heard about this one before. What kernel did you last use that
>>>> worked?
>>>
>>> I'm guessing you just need to update the maximum number of policies:
>>>
>>> /*
>>>  * Maximum number of blkcg policies allowed to be registered concurrently.
>>>  * Defined here to simplify include dependency.
>>>  */
>>> #define BLKCG_MAX_POLS          3
>>
>> That is my guess too, hence the suggestion to try and disable the
>> iolatency policy. Just tried here without, and it works, rebooting
>> with to verify that we're running out of policy slots.
> 
> Functions calling this function: blkcg_policy_register
> 
>   File                      Function       Line
> 0 block/bfq-iosched.c       bfq_init       5675 ret =
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_bfq);
> 1 block/blk-iolatency.c     iolatency_init  946 return
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_iolatency);
> 2 block/blk-throttle.c      throtl_init    2511 return
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_throtl);
> 3 block/cfq-iosched.c       cfq_init       4869 ret =
>                                                 blkcg_policy_register(&blkcg_pol
>                                                 icy_cfq);
> 
> And then there were 4...

Exactly. I'd bump it to 5 to leave room for one more, if we have to grow it
again, probably worth it to make it dynamic. So for, not really needed. Takashi,
can verify that the below fixes it up for you?


diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c19f9078da1e..c630e02836a8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1510,8 +1510,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (!blkcg_policy[i])
 			break;
-	if (i >= BLKCG_MAX_POLS)
+	if (i >= BLKCG_MAX_POLS) {
+		pr_warn("blkcg_policy_register: BLKCG_MAX_POLS too small\n");
 		goto err_unlock;
+	}
 
 	/* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs */
 	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0e2b64..6980014357d4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -54,7 +54,7 @@ struct blk_stat_callback;
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
  */
-#define BLKCG_MAX_POLS		3
+#define BLKCG_MAX_POLS		5
 
 typedef void (rq_end_io_fn)(struct request *, blk_status_t);
 

-- 
Jens Axboe

