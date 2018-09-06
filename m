Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B587C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E70B206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDh9TQm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E70B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIGDlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:41:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52842 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeIGDlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:41:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so12813207wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TjYY1V6XgUtJlPaW4l1bRAiafDh6u6CiY5eox43rQXA=;
        b=sDh9TQm2S8IOLrpOnEv7NcE3exftB3N5MBhHxMe6RyL70PBlt4fZPQMrdGTy0dPhD7
         xnFGtwXtdVaeJJf86P7MjbCVo42gJt9UP8L7yHtEHEp3+IkEObnYqclRiFQ8L1M/VcG/
         ZvDv02IoV9b/kRC6NmM6Ub88r5ZCc1+2ltjQF7NAuWMEFXZhIxd1oADh5AejhBe5AmsK
         Bf3oB0je0Flq7JHqg/KLKIxIURvaxC1ERfAFZpFSBIYBsCH8dW++KKol/3Snpv+zvSi1
         NqUhX30AwU7H3KHw4axAyaGVbo1aIUJhryCW8IGTgPCxADUob/F9doAgp0rB+2zXTdnB
         hyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TjYY1V6XgUtJlPaW4l1bRAiafDh6u6CiY5eox43rQXA=;
        b=Mq+yHbUJSIwuiZEqsrMPD0SBT/xUlxmKhnT/1wTvxI5+lISw4++Dt7WVWp6v+dImMA
         31aSEs3rlBStJmtwGsl+F/5JiAkfNuTwgkmjoWPmiRZ+SlxKgWbyZvtzSIviK5Dua6FN
         ceBLPkqD4exUo8kRBTDXVBK2LAo8h4rc9futNSITC2DyBPG6dXa50l2X/Y6aHUGpZwt6
         SDvv6VAuJ09iaae2K/BjYvt2PzIqYlXYh8ETQl5LOyQqct+VY26IZcfb4PZGrY5yWGc1
         BE2JeEGaSJeXD1R+Dw5ur0mN2BCGPCWbNnLwSNtF4hyqVfJWxpi0SVwbKGVXlQcvkjKt
         +5sQ==
X-Gm-Message-State: APzg51A04zxS7E93TKkYKL3uZJCwpkngiuUC2NvnChL41h3dRN9HMSXT
        zt6hzK9Rme2gfQYr5KgtmO8vTE16GtbZju0Wod76FQ==
X-Google-Smtp-Source: ANB0VdYzdIcW/MuTae0Z8J3Et1deySPsSe1vdfkiAL6wEMRc9ixijPuCFiRGMVLacaBr9hCV52zLgkRAMVoeLLTCcT8=
X-Received: by 2002:a1c:200c:: with SMTP id g12-v6mr3693576wmg.102.1536275012863;
 Thu, 06 Sep 2018 16:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180906203719.209399-1-xueweiz@google.com> <1536272873.26747.11.camel@acm.org>
 <20180906224210.GK5098@thunk.org>
In-Reply-To: <20180906224210.GK5098@thunk.org>
From:   Xuewei Zhang <xueweiz@google.com>
Date:   Thu, 6 Sep 2018 16:03:21 -0700
Message-ID: <CAPtwhKoFE-eZcRkvhpJgyutGK91ZouwSjTRb-cwHLQjBkriksw@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: Contribute to randomness when running
 rotational device
To:     "Theodore Ts'o" <tytso@mit.edu>, bvanassche@acm.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        ming.lei@redhat.com, hare@suse.de, hch@lst.de, pbonzini@redhat.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kali <adityakali@google.com>, groeck@chromium.org,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 3:42 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Sep 06, 2018 at 03:27:53PM -0700, Bart Van Assche wrote:
> >
> > Although this patch looks fine to me, seeing this patch makes me wonder
> > whether the default should be changed (QUEUE_FLAG_MQ_DEFAULT) instead of
> > modifying the sd driver. Can anyone remind me why QUEUE_FLAG_MQ_DEFAULT does
> > not include QUEUE_FLAG_ADD_RANDOM?

Besides Ted's point of "SSD users have no entropy", I think there are two more
reasons:
1. setting QUEUE_FLAG_ADD_RANDOM has a more visible performance hit
on SSD disks than rotational disks.
2. SSD disks provide less entropy than rotational disks.
I actually experimented on Container-Optimized OS, running on Google Compute
Engine with QUEUE_FLAG_ADD_RANDOM set.
Turns out the VM will have ~800 bit of entropy provided on boot on
rotational disk;
and will only have ~70 bit of entropy if running on SSD (and remember there are
~50 bit contributed from other sources).
(in the above experiment, both disks were virtualized disks)

>
> There was a discussion about a number of *years* ago; blk-mq has been
> baking for a very long time.  In the early days of block_mq, the
> overwhelming percentage of the users of blk-mq where those who were
> using PCIe attached flash.  So when, I raised this question, the
> argument was that SSD users have no entropy.  Which I agree with; but
> now that blk-mq is the default, and hard drives are using blk-mq, it's
> time for a patch like Xuewei's.
>
> Cheers,
>
>                                         - Ted
