Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D85C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E34920658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tEI36/Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E34920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeH2R7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:59:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54580 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeH2R7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:59:06 -0400
Received: by mail-it0-f66.google.com with SMTP id f14-v6so7786293ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmhCqCmO0y+AGnT8D+mIJT9av+8DZXzf7TOmLxHOK5I=;
        b=tEI36/BuhGqUULqgl5RXkbWZR5vL/bHXhQm7DYHwLl26A8n2cvzGe/JZqzxW1rYHI2
         PnJS0262Mc8cvgRBKRiWWRCL3FFuBEWl81/n6ElYWWxdqGvzfJLwchjYSqrKYjFbWjQ0
         PXNdhW8MNERYaOMYGhgGlEFcTCeMN3Ak7bzJSvByljZoY6H09CgA2g9DoL9Sb31hm2no
         WnGdJZYGW/k41NMns+PvF5psLtyxFbsLUFHzLQ72HF6xNL3kzLB+PjWGiU+viXPJsqDA
         GZaeCiDBW5/Sl/b47dEyMVhLLKHMZMmMcs6PZylgUYUleUFjXbDQB66zyLTvvqfW79Jz
         PrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmhCqCmO0y+AGnT8D+mIJT9av+8DZXzf7TOmLxHOK5I=;
        b=DHyrP4kbhmAa1cgaa8sHtGKi4z49AjjTRstipL+YcHDKr+9AS24j5C1XoN/G07xuK4
         tWTmXQ3hTy+L2zfp/WoaZ5hGxtR4SpyDycmjpM5oObTEz+Qg6stT368IZ2X6vg1TcWdH
         2+CdjUNmNFZw7XmfQhnzuGZ35wd8e++FECUOiE3VIqe6IaJQLXJB3jnkmJxEshzvZ3FQ
         QmFl95aTNuEax0nLWsBO5xXoIuNrwnrovxHBj377FQFX/QCBgH/W2KDvRgV6LQcm9ufD
         KjpLHjhME/yEpfZMV9g5m/FOAYPL9HoCfDj/6iKmXF5cQJXrotdR6gUzoqI86oSeOneA
         ud9Q==
X-Gm-Message-State: APzg51D9wF25jNso5X7+9xpVkm9iYZtX0O1GuRIfUY1fA2ZUObf+0hE3
        yttiMbSZYi56h5eyKHqeCTee6Q==
X-Google-Smtp-Source: ANB0VdbKoIp0vWwZU1RfHjXm/OzL1oa4IQ7MzcbBKOtYXNaq3kn9sFd45eufo1ps0C1vqRtvu0aN7g==
X-Received: by 2002:a24:5d0:: with SMTP id 199-v6mr5113375itl.88.1535551320496;
        Wed, 29 Aug 2018 07:02:00 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y18-v6sm2339655ita.29.2018.08.29.07.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:01:59 -0700 (PDT)
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Ian W MORRISON <ianwmorrison@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
 <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk>
 <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
 <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
 <702eb090-2bf4-69d1-bfb6-afdca4ba5c5f@kernel.dk>
 <363DA0ED52042842948283D2FC38E4649C266411@IRSMSX106.ger.corp.intel.com>
 <CAPDyKFqLdWL-VG2uZsiQNrJA=VvytGJp0xYYd52jMtmeP1nLcw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <77d400a8-2b16-8cac-7e2c-f155a734d047@kernel.dk>
Date:   Wed, 29 Aug 2018 08:01:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqLdWL-VG2uZsiQNrJA=VvytGJp0xYYd52jMtmeP1nLcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/18 12:15 AM, Ulf Hansson wrote:
> On 28 August 2018 at 21:11, Hunter, Adrian <adrian.hunter@intel.com> wrote:
>>> -----Original Message-----
>>> From: Jens Axboe [mailto:axboe@kernel.dk]
>>> Sent: Tuesday, August 28, 2018 8:12 PM
>>> To: Ian W MORRISON <ianwmorrison@gmail.com>
>>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> kashyap.desai@broadcom.com; loberman@redhat.com; osandov@fb.com;
>>> hch@lst.de; bart.vanassche@wdc.com; hare@suse.de;
>>> ming.lei@redhat.com; Hunter, Adrian <adrian.hunter@intel.com>
>>> Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
>>> case of 'none'"
>>>
>>> On 8/28/18 11:01 AM, Ian W MORRISON wrote:
>>>> On Wed, 29 Aug 2018 at 02:13, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 8/28/18 10:10 AM, Ian W MORRISON wrote:
>>>>>> On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>
>>>>>>> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
>>>>>>>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk>
>>> wrote:
>>>>>>>>>
>>>>>>>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>>>>>>>>>> Kernel oops when booting on Bay and Cherry Trail devices such as
>>>>>>>>>> Intel Compute Stick. Bisected as:
>>>>>>>>>>
>>>>>>>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't
>>>>>>>>>> busy in case of 'none'")
>>>>>>>>>>
>>>>>>>>>> This patch reverts the above commit.
>>>>>>>>>
>>>>>>>>> Did I miss the posting of that oops? Just curious where this is
>>>>>>>>> going wrong. Not adverse to reverting, but I'd like to try to
>>>>>>>>> understand the issue first.
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Jens Axboe
>>>>>>>>>
>>>>>>>>
>>>>>>>> I've not been able to capture it however manually transcribing
>>>>>>>> what is on the screen:
>>>>>>>>
>>>>>>>> mmc0: Got data interrupt 0x00000002 even though no data operation
>>>>>>>>
>>>>>>>> followed by:
>>>>>>>>
>>>>>>>> mmc0: sdhci: ============= SDHCI REGISTER DUMP
>>> ==============
>>>>>>>>
>>>>>>>> Do you want any specific register value or should I transcribe
>>>>>>>> each (as I am working from an image taken at boot)?
>>>>>>>
>>>>>>> Just take a picture of the screen, that should be good enough.
>>>>>>>
>>>>>>> --
>>>>>>> Jens Axboe
>>>>>>>
>>>>>>
>>>>>> Attached as requested.
>>>>>
>>>>> Can you see if this patch helps?
>>>>>
>>>>> https://marc.info/?l=linux-mmc&m=153485326025301&w=2
>>>>>
>>>>> --
>>>>> Jens Axboe
>>>>>
>>>>
>>>> I confirm that the above patch works with commit 6ce3dd6eec11 and
>>>> removes the need for reverting it on eMMC based devices.
>>>>
>>>> Tested on Bay Trail, Cherry Trail (both now working) and Kaby Lake
>>>> (not affected) devices.
>>>
>>> Great, thanks for testing. Adrian, when is this going upstream?
>>
>> It is in Ulf's fixes branch, so most likely v4.19-rc2 .  Then to stable in due course.
>>
>>         https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=fixes&id=26caddf274cf1e89fd4ce44ab2b8dbc7a7f97681
> 
> Yep, correct!
> 
> As I told someone before, I am deliberately holding on to fixes a
> little longer that before, to extend the test coverage a bit.
> 
> If someone wants to test the latest rc with fixes, one could instead
> try the pending-fixes branch in Stephen Rothwell's linux-next tree.

With all due respect, you should expedite this one so we're not
wasting peoples time bisecting it again and again. I didn't even
know about a pending-fixes branch in the linux-next tree, so I
doubt most users will.

-- 
Jens Axboe

