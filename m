Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34409C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC982205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f72++kst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC982205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeH3QHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:07:40 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37121 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeH3QHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:07:40 -0400
Received: by mail-io0-f196.google.com with SMTP id v14-v6so7314994iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=okiHGm/oZ3Hx0cFtjG2hFE6CJR/jllnO85PdE4zwZ6o=;
        b=f72++kstMlzC51TBpys/bz/oB1qEAmFmkgzgBZAinZioXNzM3zdRsdTL74lGH2O5qq
         Xo4uZI0nBlvs1acTZcIIJ/QUpYxXgwr2R+Um8hJm+fQ5dMcv3HmjN84lkECd2ih89oUK
         AROKR51hZjf2DjFq5T2q6n1Ou3V32y9VIZpCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=okiHGm/oZ3Hx0cFtjG2hFE6CJR/jllnO85PdE4zwZ6o=;
        b=CFfDFSIZYCcBsrpaSJ0wGXaik+7NbblN7e+dudD0K+OKMLS1HCisitG2emjmZv/Ngs
         HJHttGRo34ZLGlbJ5LUaLBQc9Fyo1qU6Sq/qWJ7IrO4ub88s6fHMQLZruYLVlds47YPQ
         dKfbz6TqCRpLB85ZPMRSa0mwe9cGqCq1XMxx5Y91kdkEidj4m7txdkM4bRqaxAVYcDje
         aRvTHg07zy45WnnDODwowFQ9oeGULc7s1+fJYJmHD8EF5b264TGigOxzH717ryPUgaNp
         874qW6qi+0SPKmrZahYcaUoUwWvGggA/DssRdg7qhG5BgvzU7S9b18diGRPoKtltMu64
         B9cg==
X-Gm-Message-State: APzg51DQJM/OXM0WRTws1QYqbjd4ifPkg56RnZ9984DEJSQ3nrSq/2z5
        x5R92MYuE8hZeBL+gCAA83sf7EYvd1TWx52a/Yh0qg==
X-Google-Smtp-Source: ANB0VdbPK577kIR6PMfuZeDYYGt7d37P4i8zRwyErGSOPAXi63mbz71lZH3BuDOfciB+6qyPRJphSMEIomdOD+SlAyQ=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr8577756iou.218.1535630750695;
 Thu, 30 Aug 2018 05:05:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 05:05:49
 -0700 (PDT)
In-Reply-To: <77d400a8-2b16-8cac-7e2c-f155a734d047@kernel.dk>
References: <20180828154727.3589-1-ianwmorrison@gmail.com> <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk> <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk> <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
 <702eb090-2bf4-69d1-bfb6-afdca4ba5c5f@kernel.dk> <363DA0ED52042842948283D2FC38E4649C266411@IRSMSX106.ger.corp.intel.com>
 <CAPDyKFqLdWL-VG2uZsiQNrJA=VvytGJp0xYYd52jMtmeP1nLcw@mail.gmail.com> <77d400a8-2b16-8cac-7e2c-f155a734d047@kernel.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Aug 2018 14:05:49 +0200
Message-ID: <CAPDyKFp=JJR3rs2NSnVL=TDB80C5oYpMxnMhDGSwBhqqm=JBSw@mail.gmail.com>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 August 2018 at 16:01, Jens Axboe <axboe@kernel.dk> wrote:
> On 8/29/18 12:15 AM, Ulf Hansson wrote:
>> On 28 August 2018 at 21:11, Hunter, Adrian <adrian.hunter@intel.com> wrote:
>>>> -----Original Message-----
>>>> From: Jens Axboe [mailto:axboe@kernel.dk]
>>>> Sent: Tuesday, August 28, 2018 8:12 PM
>>>> To: Ian W MORRISON <ianwmorrison@gmail.com>
>>>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> kashyap.desai@broadcom.com; loberman@redhat.com; osandov@fb.com;
>>>> hch@lst.de; bart.vanassche@wdc.com; hare@suse.de;
>>>> ming.lei@redhat.com; Hunter, Adrian <adrian.hunter@intel.com>
>>>> Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
>>>> case of 'none'"
>>>>
>>>> On 8/28/18 11:01 AM, Ian W MORRISON wrote:
>>>>> On Wed, 29 Aug 2018 at 02:13, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>> On 8/28/18 10:10 AM, Ian W MORRISON wrote:
>>>>>>> On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>
>>>>>>>> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
>>>>>>>>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk>
>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>>>>>>>>>>> Kernel oops when booting on Bay and Cherry Trail devices such as
>>>>>>>>>>> Intel Compute Stick. Bisected as:
>>>>>>>>>>>
>>>>>>>>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't
>>>>>>>>>>> busy in case of 'none'")
>>>>>>>>>>>
>>>>>>>>>>> This patch reverts the above commit.
>>>>>>>>>>
>>>>>>>>>> Did I miss the posting of that oops? Just curious where this is
>>>>>>>>>> going wrong. Not adverse to reverting, but I'd like to try to
>>>>>>>>>> understand the issue first.
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Jens Axboe
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I've not been able to capture it however manually transcribing
>>>>>>>>> what is on the screen:
>>>>>>>>>
>>>>>>>>> mmc0: Got data interrupt 0x00000002 even though no data operation
>>>>>>>>>
>>>>>>>>> followed by:
>>>>>>>>>
>>>>>>>>> mmc0: sdhci: ============= SDHCI REGISTER DUMP
>>>> ==============
>>>>>>>>>
>>>>>>>>> Do you want any specific register value or should I transcribe
>>>>>>>>> each (as I am working from an image taken at boot)?
>>>>>>>>
>>>>>>>> Just take a picture of the screen, that should be good enough.
>>>>>>>>
>>>>>>>> --
>>>>>>>> Jens Axboe
>>>>>>>>
>>>>>>>
>>>>>>> Attached as requested.
>>>>>>
>>>>>> Can you see if this patch helps?
>>>>>>
>>>>>> https://marc.info/?l=linux-mmc&m=153485326025301&w=2
>>>>>>
>>>>>> --
>>>>>> Jens Axboe
>>>>>>
>>>>>
>>>>> I confirm that the above patch works with commit 6ce3dd6eec11 and
>>>>> removes the need for reverting it on eMMC based devices.
>>>>>
>>>>> Tested on Bay Trail, Cherry Trail (both now working) and Kaby Lake
>>>>> (not affected) devices.
>>>>
>>>> Great, thanks for testing. Adrian, when is this going upstream?
>>>
>>> It is in Ulf's fixes branch, so most likely v4.19-rc2 .  Then to stable in due course.
>>>
>>>         https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=fixes&id=26caddf274cf1e89fd4ce44ab2b8dbc7a7f97681
>>
>> Yep, correct!
>>
>> As I told someone before, I am deliberately holding on to fixes a
>> little longer that before, to extend the test coverage a bit.
>>
>> If someone wants to test the latest rc with fixes, one could instead
>> try the pending-fixes branch in Stephen Rothwell's linux-next tree.
>
> With all due respect, you should expedite this one so we're not
> wasting peoples time bisecting it again and again. I didn't even
> know about a pending-fixes branch in the linux-next tree, so I
> doubt most users will.

I guess it takes some time before people gets aware of the
pending-fixes branch. At least I managed to highlight its presence in
this thread. :-)

PR about to be created, I keep the folkz in this thread on cc once I post it.

Kind regards
Uffe
