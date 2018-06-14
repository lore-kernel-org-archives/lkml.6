Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6E153C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190BB208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIDEY6/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190BB208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeFNHTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:19:01 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45462 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeFNHS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:18:59 -0400
Received: by mail-vk0-f67.google.com with SMTP id l64-v6so3052934vkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AYTgYH1aXBXyH8pYpGovCd4Mht1/FEJDSxDrFYwdC68=;
        b=TIDEY6/h4sQu1/CtZQgFs0Lk5uLcSp//EO4MkleHJiJpmPlh8EaWrW7GdI5TccVsFc
         k6T7JS8CvBYh8eCPtYy3CZ3PG2ZoNMovsDIYDCjD8dhIzcD12jW1FV0lJ5tVNb9zROBG
         wFXYO6N9HUTgHJ7qhd1k6babauRuSMadE1VwK8Gm8lOyvqFjDfl2hoxTEICNRHeKNc+g
         2LsnHx42nAwD+T69J6MMwC1B34GL9ZojwoatZHxSom7fZrM0/Ur9i3YiyKIOXp91kCRX
         cYHA4JK326iEUMllbD1jHZVhSJeINK+0ai3e/4FULFIl/GpNG4SFV9f7vI49M/wW0cUU
         Nk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AYTgYH1aXBXyH8pYpGovCd4Mht1/FEJDSxDrFYwdC68=;
        b=YGTdzcmdDoniQtMo6owb1C50rwxwvdjN8B3zsS4vg87ZA+BksZNKnBLLPwrYVZov4P
         0nj/d+eJG/s2omjbWXuKTufXMY0AWRLUK6q3t0Ofg+A7rhV77JvCkZODYnJAoDq6Xcc7
         hoRER9RD/A2LobUVYmcC6LIeFqP5XbE7mATW7fhadC9kZ00/CsFISQYrlSsc1ijuCZyX
         oYcet0WueoiZ+Dvxbpnao/ah72T1UdiCIjheXY4Wg1NNK4WvxU/isbK1Rhrcxlco8gxL
         irfQy2J15vyUK4p2/S6/gx68M3wZHhpUTxTBHXKHmowbo0BhH6i0HnerYBvwAsiPNtHN
         lMLw==
X-Gm-Message-State: APt69E3U0AjLZ2Q4egFxBYHFrSXzRd8TuL2YuHOGsQXh+Fmv12RUYCCC
        8+PFxkJF0abM6X/Xt1e/8OQ1iuvz8XBKlchNgrU=
X-Google-Smtp-Source: ADUXVKKd3P1Nl12kYJrn2zQaMRFn9V3Chjt849WAuuiBNdufe0SrxowTrpkbryWZDlBBKTQXel0azQIHFNgW6gDAMic=
X-Received: by 2002:a1f:154b:: with SMTP id 72-v6mr802373vkv.70.1528960739103;
 Thu, 14 Jun 2018 00:18:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:483:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:18:58 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com>
 <20180612212007.GA22717@redhat.com> <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
From:   jing xia <jing.xia.mail@gmail.com>
Date:   Thu, 14 Jun 2018 15:18:58 +0800
Message-ID: <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comment.

On Wed, Jun 13, 2018 at 10:02 PM, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Tue, 12 Jun 2018, Mike Snitzer wrote:
>
>> On Tue, Jun 12 2018 at  4:03am -0400,
>> Jing Xia <jing.xia.mail@gmail.com> wrote:
>>
>> > Performance test in android reports that the phone sometimes gets
>> > hanged and shows black screen for about several minutes.The sysdump shows:
>> > 1. kswapd and other tasks who enter the direct-reclaim path are waiting
>> > on the dm_bufio_lock;
>>
>> Do you have an understanding of where they are waiting?  Is it in
>> dm_bufio_shrink_scan()?
>>
>> > 2. the task who gets the dm_bufio_lock is stalled for IO completions,
>> > the relevant stack trace as :
>> >
>> > PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
>> >  #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
>> >  #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
>> >  #2 [ffffffc0282af450] schedule at ffffff8008850f4c
>> >  #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
>> >  #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
>> >  #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40
>> >  #6 [ffffffc0282af5b0] shrink_inactive_list at ffffff8008177c80
>> >  #7 [ffffffc0282af680] shrink_lruvec at ffffff8008178510
>> >  #8 [ffffffc0282af790] mem_cgroup_shrink_node_zone at ffffff80081793bc
>> >  #9 [ffffffc0282af840] mem_cgroup_soft_limit_reclaim at ffffff80081b6040
>
> Please send the full stacktrace of this task.
>
> Then, we can see, why is it waiting here.
>
Please refer to:

PID: 22920  TASK: ffffffc0120f1a00  CPU: 1   COMMAND: "kworker/u8:2"
 #0 [ffffffc0282af3d0] __switch_to at ffffff8008085e48
 #1 [ffffffc0282af3f0] __schedule at ffffff8008850cc8
 #2 [ffffffc0282af450] schedule at ffffff8008850f4c
 #3 [ffffffc0282af470] schedule_timeout at ffffff8008853a0c
 #4 [ffffffc0282af520] schedule_timeout_uninterruptible at ffffff8008853aa8
 #5 [ffffffc0282af530] wait_iff_congested at ffffff8008181b40
 #6 [ffffffc0282af5b0] shrink_inactive_list at ffffff8008177c80
 #7 [ffffffc0282af680] shrink_lruvec at ffffff8008178510
 #8 [ffffffc0282af790] mem_cgroup_shrink_node_zone at ffffff80081793bc
 #9 [ffffffc0282af840] mem_cgroup_soft_limit_reclaim at ffffff80081b6040
#10 [ffffffc0282af8f0] do_try_to_free_pages at ffffff8008178b6c
#11 [ffffffc0282af990] try_to_free_pages at ffffff8008178f3c
#12 [ffffffc0282afa30] __perform_reclaim at ffffff8008169130
#13 [ffffffc0282afab0] __alloc_pages_nodemask at ffffff800816c9b8
#14 [ffffffc0282afbd0] __get_free_pages at ffffff800816cd6c
#15 [ffffffc0282afbe0] alloc_buffer at ffffff8008591a94
#16 [ffffffc0282afc20] __bufio_new at ffffff8008592e94
#17 [ffffffc0282afc70] dm_bufio_prefetch at ffffff8008593198
#18 [ffffffc0282afd20] verity_prefetch_io at ffffff8008598384
#19 [ffffffc0282afd70] process_one_work at ffffff80080b5b3c
#20 [ffffffc0282afdc0] worker_thread at ffffff80080b64fc
#21 [ffffffc0282afe20] kthread at ffffff80080bae34

> Mikulas
