Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2019CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E2A208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp66YOci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E2A208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965449AbeFODUp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:20:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38957 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFODUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:20:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so8427269wrn.6;
        Thu, 14 Jun 2018 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8tLvUZheOGICUkJkecPK4j59o5xN6LbtCfGdBYQfuWM=;
        b=Kp66YOciG4H08KCPA7hNSCLQtWpm78kxpZk+7DbQ2W+ArxGoPxB1GLXqmtJq5IQmaN
         D8ZfsHrMWmX5dVtZ4lIcVo2aZBkBFam0oTAspp5LHuJ5bvH/KDPkYr8JwkLI2meMqOVb
         ntpiwb/zQciVW+cxHhNuZFeJprx/8VO5HxCLu8VsPsxtu8LD1Df28Shh7/fcUOVU3cIL
         WERbPvLLzqUWMngmlpoTwdss/Vjw3vu79GSowgYsaDNO7qsnwGwh9N2OdmBQZUClWmAN
         Vj1E/tb74Evmc3ne9nlU5O9e4X2TFp3cjKGiHt6phz04IzXwh6l7ASphqA08N9rRbf0b
         gtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8tLvUZheOGICUkJkecPK4j59o5xN6LbtCfGdBYQfuWM=;
        b=bfaqXPCkl/O382WJyzGdJQZdxvZtOpREqCZfOpgMWDaUF3iPC39Cb+JW6Jg7y6vbGi
         Dtm58k+o78QURZDMZ5WEXlwbkhmqT1VHUAk3IVV8zci3qf+RY4Xc/qkkh4QgPRobafXL
         q6mU8ZiXG4Nmy4yocEprDMUGRzNJhY63C7ZYm8m7dGJiudyIuRZ0vUoLiAA6IANxKV8o
         mxHIty26mbyMozU8Mq/bg1Lf2W5Zi9tCGPrODgNkZe9lVv8S+3bJhonu2rIRQ6rDManB
         KHENQFvilV5jIl6fiSGigUvNlCOXReXb48Ampbg9XiRrn7sGgXhhDCfai+KvU/2pCs3m
         oRsA==
X-Gm-Message-State: APt69E2CroF+iLLXy3gBAJa++RyK2UnINUMXnRjYKeOUUQgOXZqHIuCl
        ElASCnvYm8b3YO3h8myV9r2RfPA1shE8A22UEHI=
X-Google-Smtp-Source: ADUXVKJZsFl2CPnGrZkItKKhwHQp/T6tHic4OavK3FsQW4OCwQ+YNoCPx/9SfrX7/Ep8dxAkf8AqNr+kBgwJNLe1pqQ=
X-Received: by 2002:adf:e542:: with SMTP id z2-v6mr4543580wrm.111.1529032842478;
 Thu, 14 Jun 2018 20:20:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:97c6:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 20:20:40
 -0700 (PDT)
In-Reply-To: <3970fdc7-52d9-d05b-4118-059d48bf4f2d@oracle.com>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com>
 <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com> <e5344293-b0b7-d2e0-f2e7-c0700efdfbe4@oracle.com>
 <CACVXFVMRCM6AvNJjAESbwOeJ_P5AZ+1C-7RfhE9L4u0T=_5h4Q@mail.gmail.com> <3970fdc7-52d9-d05b-4118-059d48bf4f2d@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 15 Jun 2018 11:20:40 +0800
Message-ID: <CACVXFVMPAdFbX3x-KUjHCQhb_rT6p9ROYHg63aUtEqdbitEaKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: export __blk_complete_request
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:04 AM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi Ming
>
> Thanks for your kindly response.
>
> On 06/15/2018 10:56 AM, Ming Lei wrote:
>>>> IMO, ref-counter is just to fix the blk-mq req life recycle issue.
>>>> It cannot replace the blk_mark_rq_complete which could avoid the race between
>>>> timeout and io completion path.
>>> The .timeout return BLK_EH_DONE doesn't always mean the request has been completed.
>>> Such as scsi-mid layer, its .timeout callback return BLK_EH_DONE but the timed out
>>> request is still in abort or eh process. What if a completion irq come during that ?
>> For blk-mq, it is avoided by the atomic state change in
>> __blk_mq_complete_request(),
>> that is why I mentioned the question in my last reply.
>>
>
> but blk_mq_check_expired doesn't do that.
> do I miss anything ?

Right, that is the difference between blk-mq and legacy now, then if scsi-mq
drivers can work well, they should work well with the following change in the
non-mq mode:

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 4b8a48d48ba1..9fce09d55652 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -88,7 +88,6 @@ static void blk_rq_timed_out(struct request *req)
        switch (ret) {
        case BLK_EH_RESET_TIMER:
                blk_add_timer(req);
-               blk_clear_rq_complete(req);
                break;
        case BLK_EH_DONE:
                /*
@@ -115,8 +114,7 @@ static void blk_rq_check_expired(struct request
*rq, unsigned long *next_timeout
                /*
                 * Check if we raced with end io completion
                 */
-               if (!blk_mark_rq_complete(rq))
-                       blk_rq_timed_out(rq);
+               blk_rq_timed_out(rq);
        } else if (!*next_set || time_after(*next_timeout, deadline)) {
                *next_timeout = deadline;
                *next_set = 1;


Thanks,
Ming Lei
