Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 286DDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70F820891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkbDvNWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70F820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965523AbeFOC4I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:56:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35240 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965123AbeFOC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:56:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id l10-v6so8424085wrn.2;
        Thu, 14 Jun 2018 19:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aUshg9zDeJA47JQ9vMsRdEYAbwTQMJ8I/12D21XButo=;
        b=DkbDvNWCDlCpaEL+j5Bwflx8jsamTi+mXlOAk78QL7eGrzmOserrLmgCCQ/HcRU2f9
         IcRxMPWuG3q7wbana0uo+np//CHrTW1Kw4NCACPwy1GFWke6+/SB5FJNX1Tu0BsNS97e
         cB2ozTgOQqHetr1yN3qEO1dpRfS53E8F3Mnfe0Snb2f3QWqQs8e8XLFbKPTn8FyJJb0n
         AITxMO+afeEuVHkVIUBZx7q9wQAaGb//MdfrhH7FoC7RIUFe0SDEKzSBdRxt2yKXOV1B
         l8TrV4b4mPxFJ+qYG9zLG31jZvBz8eMVESbEHalgU2zpcwLMTnclOMG3DASNVdL7A6cE
         1xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aUshg9zDeJA47JQ9vMsRdEYAbwTQMJ8I/12D21XButo=;
        b=fvHOSP1uwsnYCZgo3VBanGS1HvVPPZ37RbdHjUPEL3Lx93ZPLT251NO094Ghaj6zs5
         jR7rOUi7+GIUh2MbVe+gceOIc3lYMw8WzPEA3o/J9LzpY+fXJazNGcypC581VHn9c15n
         JlDRwzPdEs+jDidcQfsR+Q1dVYVis+ICMb0H3n9cFG9m01BsSl9CSeM0B9PSu1hUjnl5
         HWO9W3oYsCdfXb3+hxB9+3Bwmw0IyRctUPVEciGD/j3K8JBOrV88vZFIL+958CkKBTYM
         o2LWuuNWnw//6jfGbnv3PIG33sHPFKr0urgx+sA2RymQm8jAP7ezkXuH3hHStSQj9orL
         8P0Q==
X-Gm-Message-State: APt69E2t0xeoM5ncskbVlZJLKBb3L/baOJEuOues9XW35RpTTReSBqyW
        hvGxqYPxi+0/RESbOiEDD75aUsmik+pTbec17ss=
X-Google-Smtp-Source: ADUXVKKeRi2yb8DeSNi0I+fG4KN52y279HOT5BJVBSQh9Rg0sqiManpXsGFGHx4R20Th0AqzNJ1Vp+owkOlrirVeBME=
X-Received: by 2002:adf:ac69:: with SMTP id v96-v6mr4224260wrc.5.1529031364800;
 Thu, 14 Jun 2018 19:56:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:97c6:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 19:56:03
 -0700 (PDT)
In-Reply-To: <e5344293-b0b7-d2e0-f2e7-c0700efdfbe4@oracle.com>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com>
 <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com> <e5344293-b0b7-d2e0-f2e7-c0700efdfbe4@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 15 Jun 2018 10:56:03 +0800
Message-ID: <CACVXFVMRCM6AvNJjAESbwOeJ_P5AZ+1C-7RfhE9L4u0T=_5h4Q@mail.gmail.com>
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

On Fri, Jun 15, 2018 at 10:44 AM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
>
> On 06/15/2018 10:22 AM, jianchao.wang wrote:
>> Hi Ming
>>
>> On 06/15/2018 10:17 AM, Ming Lei wrote:
>>> On Fri, Jun 15, 2018 at 9:57 AM, Jianchao Wang
>>> <jianchao.w.wang@oracle.com> wrote:
>>>> After f6e7d48 (block: remove BLK_EH_HANDLED), LLDD is responsible
>>>> to complete the timed out request, however, for blk-legacy, the
>>>> 'complete' is still marked, blk_complete_request will do nothing,
>>>> we export __blk_complete_request for LLDD to complete the request
>>>> in timeout path.
>>>>
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>> ---
>>>>  block/blk-softirq.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
>>>> index 01e2b35..15c1f5e 100644
>>>> --- a/block/blk-softirq.c
>>>> +++ b/block/blk-softirq.c
>>>> @@ -144,6 +144,7 @@ void __blk_complete_request(struct request *req)
>>>>
>>>>         local_irq_restore(flags);
>>>>  }
>>>> +EXPORT_SYMBOL(__blk_complete_request);
>>>>
>>>>  /**
>>>>   * blk_complete_request - end I/O on a request
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> Looks non-blk-mq timeout code need to convert to ref-counter
>>> based approach too?
>>
>> IMO, ref-counter is just to fix the blk-mq req life recycle issue.
>> It cannot replace the blk_mark_rq_complete which could avoid the race between
>> timeout and io completion path.
>
> The .timeout return BLK_EH_DONE doesn't always mean the request has been completed.
> Such as scsi-mid layer, its .timeout callback return BLK_EH_DONE but the timed out
> request is still in abort or eh process. What if a completion irq come during that ?

For blk-mq, it is avoided by the atomic state change in
__blk_mq_complete_request(),
that is why I mentioned the question in my last reply.

But what if the timed-out request has been freed by EH? Then seems
req's ref_counter
is still needed for non-mq?


Thanks,
Ming Lei
