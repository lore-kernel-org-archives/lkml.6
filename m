Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80297C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4611921855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OQNxHE/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfBKPqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:46:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35365 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfBKPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:46:08 -0500
Received: by mail-it1-f194.google.com with SMTP id v72so2406374itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MRykhq0nF/ev4nCD1UwgWcq45SxLrHMCGv02wpI5rGY=;
        b=OQNxHE/4ibinM/Lav2/R0+pKz1YH8K2IW6dwB7ldZZWjeVtf4qnIa6RSLjlC/qD7ga
         KkItNg+mub9KrXfQf+yA9TyGBxSvthRrTWhzvMchy4B7gKfnOSlBpyymob/3bm3dF8bj
         XhleCf/qYsPiha+HbHS1JkSFRMV4O8oOxK4q0rYA2z2iC3nvE7Ncm5nFw5w3TCJWPzMZ
         s84oB/sw+S3M4GkYv8U3rYrsO3o2qseLZhEW24zdApPTefcuPMoXH7UPVQuCySA7dnPW
         h0EQU/N+0K9l1VF9Gq5YRFkmawk50R8RTsyeSg2HqKqPSgg4mvVT0naQM45ldfFmLB3l
         8PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MRykhq0nF/ev4nCD1UwgWcq45SxLrHMCGv02wpI5rGY=;
        b=chjA1haJn7pbODfJgQSnI+jsLN4PQmJ+oanVIngoUQU/rAcHlfovpXICOWgl3k8Nxm
         fRxJXUNQcZrGDj9I3be4sjuhAXIirw9Btal6amE6ghk1j46t95YhRSzIzWxL1ZLSXuHu
         FyTSvehtFT+Ipy424R78r6DGhXwfH05ZJoRlf4sMvdnwO1JXZnhf7iGwYtH/yj15RGFF
         ltf5f6EO95Xuuvq018jem8iAu//+vDLvX51RqPPRoPvxW5xrhn3/Uuu4hds3BMEwjUh7
         haYM8qsTs/1f4H54eW0GXYKoXsbWbdJS3jzfATNxb0nKX83U8Iscizcb78Un7sBlm/1V
         R6Rg==
X-Gm-Message-State: AHQUAubYReNp8gQUfFfhzbKZkgsr1L1PU77cOhBi/jpTHxecQkypsbM6
        s+nLgYnVIQgCysbhZnJKhNNbj5HFKvfj2Q==
X-Google-Smtp-Source: AHgI3IY0eJfUXorrmDW82OyL+9nOgvJHEJgabrc31gLfqEO/amrCAWYMW8k3qXePIsYR7ysuMjgZ1g==
X-Received: by 2002:a24:74c2:: with SMTP id o185mr81203itc.100.1549899966415;
        Mon, 11 Feb 2019 07:46:06 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm1816005ioc.45.2019.02.11.07.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:46:05 -0800 (PST)
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
 <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com>
 <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
 <1549815924.4142.8.camel@HansenPartnership.com>
 <0e6e5d67-d305-dd00-2e42-e2299166c8b2@kernel.dk>
 <1549898730.2831.6.camel@HansenPartnership.com>
 <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
 <1549899773.2831.12.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1a00da0e-cb8e-30ea-8d17-120f97242b2f@kernel.dk>
Date:   Mon, 11 Feb 2019 08:46:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549899773.2831.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 8:42 AM, James Bottomley wrote:
> On Mon, 2019-02-11 at 08:28 -0700, Jens Axboe wrote:
>> On 2/11/19 8:25 AM, James Bottomley wrote:
>>> On Sun, 2019-02-10 at 09:35 -0700, Jens Axboe wrote:
>>>> On 2/10/19 9:25 AM, James Bottomley wrote:
>>>>> On Sun, 2019-02-10 at 09:05 -0700, Jens Axboe wrote:
>>>>>> On 2/10/19 8:44 AM, James Bottomley wrote:
>>>>>>> On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
>>>>>>>> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
>>>>>>>> <James.Bottomley@hansenpartnership.com> wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>>> I think the reason for this is that the block mq path
>>>>>>>>> doesn't feed the kernel entropy pool correctly, hence
>>>>>>>>> the need to install an entropy gatherer for systems
>>>>>>>>> that don't have other good random number sources.
>>>>>>>>
>>>>>>>> That does sound plausible, I admit I didn't even consider
>>>>>>>> the possibility that the old block I/O path also was an
>>>>>>>> entropy source.
>>>>>>>
>>>>>>> In theory, the new one should be as well since the
>>>>>>> rotational entropy collector is on the SCSI completion
>>>>>>> path.   I'd seen the same problem but had assumed it was
>>>>>>> something someone had done to our internal entropy pool and
>>>>>>> thus hadn't bisected it.
>>>>>>
>>>>>> The difference is that the old stack included ADD_RANDOM by
>>>>>> default, so this check:
>>>>>>
>>>>>> 	if (blk_queue_add_random(q))
>>>>>> 		add_disk_randomness(req->rq_disk);
>>>>>>
>>>>>> in scsi_end_request() would be true, and we'd add the
>>>>>> randomness. For sd, it seems to set it just fine for non-
>>>>>> rotational drives. Could this be because other devices don't?
>>>>>> Maybe the below makes a difference.
>>>>>
>>>>> No, in both we set it per the rotational parameters of the disk
>>>>> in 
>>>>>
>>>>> sd.c:sd_read_block_characteristics()
>>>>>
>>>>> 	rot = get_unaligned_be16(&buffer[4]);
>>>>>
>>>>> 	if (rot == 1) {
>>>>> 	
>>>>> 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>>>>> 	
>>>>> 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
>>>>> 	} else {
>>>>> 	
>>>>> 	blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
>>>>> 	
>>>>> 	blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
>>>>> 	}
>>>>>
>>>>>
>>>>> That check wasn't changed by the code removal.
>>>>
>>>> As I said above, for sd. This isn't true for non-disks.
>>>
>>> Yes, but the behaviour above doesn't change across a switch to MQ,
>>> so I don't quite understand how it bisects back to that change.  If
>>> we're not gathering entropy for the device now, we wouldn't have
>>> been before the switch, so the entropy characteristics shouldn't
>>> have changed.
>>
>> But it does, as I also wrote in that first email. The legacy queue
>> flags had QUEUE_FLAG_ADD_RANDOM set by default, the MQ ones do not.
>> Hence any non-sd device would previously ALWAYS have ADD_RANDOM
>> set, now none of them do. Also see the patch I sent.
> 
> So your theory is that the disk in question never gets to the
> rotational check?  because the check will clear the flag if it's non-
> rotational and set it if it's not, so the default state of the flag
> shouldn't matter.

No, my point is about non-disks, devices that aren't driven by sd. The
behavior for sd hasn't changed, as it sets/clears it unconditionally.
That's not true for something driven by sr, for instance, and anything
else non-sd. For those we defaulted to adding randomness for !scsi-mq,
and default to not adding randomness for scsi-mq.

The patch I included would have the same behavior for scsi-mq as we had
for non-mq.

-- 
Jens Axboe

