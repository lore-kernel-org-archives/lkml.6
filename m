Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5F061C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1470E208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzf7xUyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1470E208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965520AbeFOCtd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:49:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40436 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFOCtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:49:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so1185323wmc.5;
        Thu, 14 Jun 2018 19:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J8pH5mFpf3/288/WZmuq1e6xn5EzsFYib600ox6pOoQ=;
        b=Hzf7xUyTPwUikEzQmk4XyDKnucLnkmOQx3sIqJCZ8ZrRguIsgkZMyVGbtKvzyasqgn
         c/mqE0JgTz7iFy7sCbfFfm32CsF3Nnp766AT2QdjbnNyWsCwrKkVUIKysA5LX7aPmYlN
         uf7/7pNzylV5RVoegOwLzAiVWMTpU3JvM4u/BN67qkZYsYKuoQeiJHCDn9HWoIEUQGI8
         Fx8tUrnmt17BirLKtdr8CTN0KPqfeggRaSfORmvykaGY2Z8ZcPIK3MSwRwf7Ja4lsHc1
         /TKeUL6RQGDafQcptLyAmnNBS3nAEIbHwh3yyqHZ6vfyj++zfbqlBL+xmEiSA/FgcT3A
         LKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J8pH5mFpf3/288/WZmuq1e6xn5EzsFYib600ox6pOoQ=;
        b=rVt0JNtlmBBwtSYq7Lt9nHQDD92X3XodVgMZwIlkWG8X1OeSD4BOPDgUfVNhRPrB3g
         HsG3fv/Cu5u4QdFSn6cO65TiTBPEdhDCAbsOhjlGLVPvnPZOuJ5HQ1Y5LBypMaONZhwN
         HWszwauvmHghQ7RwywI3w5QmMTF/5WgMYDcHykGAms/NDgEpForjBPQsIHkWpNBBvjVn
         69MbBzundn692Uin+INShHMEW0+8WT47jwB6ONDuVSsRsRFKEfQOG4pJOHREPRQSqUt1
         b49aiFU9g+l/GqdgKhXzUO38KhWboLHRFf0t8YcQocVhRKlCZqbh7FV6T/ndBDs8mov8
         udmQ==
X-Gm-Message-State: APt69E1HtjLvaR7qxKDm+zPVD/rDSyITg6gu9HwDhy+5gHv/pfwqWn/s
        GUq1IRzoY7ggOFAarYKlU0WzIUAwmFppuu5AbrI=
X-Google-Smtp-Source: ADUXVKI7ksFM/9ZcePh/WEry6jLCJNuhB0zyJw94/Nw/9BVlVKgRgLB0BRHdDgIQAerKOo4lbWwIqKnkQHbx/zc1d0I=
X-Received: by 2002:a1c:e594:: with SMTP id c142-v6mr112479wmh.161.1529030969885;
 Thu, 14 Jun 2018 19:49:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:97c6:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 19:49:29
 -0700 (PDT)
In-Reply-To: <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com> <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 15 Jun 2018 10:49:29 +0800
Message-ID: <CACVXFVPcuqzXiKUnaFxhw4CuqGpFdkmvfw=7yJAydXTYLKXDCw@mail.gmail.com>
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

On Fri, Jun 15, 2018 at 10:22 AM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi Ming
>
> On 06/15/2018 10:17 AM, Ming Lei wrote:
>> On Fri, Jun 15, 2018 at 9:57 AM, Jianchao Wang
>> <jianchao.w.wang@oracle.com> wrote:
>>> After f6e7d48 (block: remove BLK_EH_HANDLED), LLDD is responsible
>>> to complete the timed out request, however, for blk-legacy, the
>>> 'complete' is still marked, blk_complete_request will do nothing,
>>> we export __blk_complete_request for LLDD to complete the request
>>> in timeout path.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> ---
>>>  block/blk-softirq.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
>>> index 01e2b35..15c1f5e 100644
>>> --- a/block/blk-softirq.c
>>> +++ b/block/blk-softirq.c
>>> @@ -144,6 +144,7 @@ void __blk_complete_request(struct request *req)
>>>
>>>         local_irq_restore(flags);
>>>  }
>>> +EXPORT_SYMBOL(__blk_complete_request);
>>>
>>>  /**
>>>   * blk_complete_request - end I/O on a request
>>> --
>>> 2.7.4
>>>
>>
>> Looks non-blk-mq timeout code need to convert to ref-counter
>> based approach too?
>
> IMO, ref-counter is just to fix the blk-mq req life recycle issue.

Just thought of that, it is one blk-mq specific issue.

> It cannot replace the blk_mark_rq_complete which could avoid the race between
> timeout and io completion path.
> Or maybe my understanding is wrong ...

I didn't mean that this patch is unnecessary.

But the question is that given driver has to deal with race between timeout
and normal completion, why don't you follow blk-mq's way to move
the atomic state change into __blk_complete_request()?


Thanks,
Ming Lei
