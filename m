Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F142C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4800A208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB69DBtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4800A208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbeFOEDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:03:17 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42783 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeFOEDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:03:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so8487457wrk.9;
        Thu, 14 Jun 2018 21:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EK5/NMSvCynvoOMsYkOc3HXGmChaQWVApBkgjnNsxGU=;
        b=gB69DBtHLYGrJgKU2j7utepgfCCTgIBiuuHOAcd9Hr/qzVXFLZevyg5wG366mQTgG/
         89ZevSyhAzR0Dxtb2nkO3jM/MYFOURygFDuWH4+yYfuknYEaI/R56Z+rIQ295uBqyZg/
         G44C6E+SwonQWwqDCIaaXp5nQ2EW7NpSVBHDOVoEt60f/6hqCFSVXa5Khj1LKkMD35ZY
         h3gopJL56QsBhoHxajjKjvHBzzZJ0QuoJwfNEQQBEEhH0PfcrxVV/6szk462UX9PBg+5
         hmhsdeiW5vsCCf2bUlS+rBaimEtdm+78Ro48clQXE2cBSym9XLK//DdrQSWEssKh/Y+P
         mgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EK5/NMSvCynvoOMsYkOc3HXGmChaQWVApBkgjnNsxGU=;
        b=HBj+cXY9YijrOPkU50GA4cc/0PqqUmRNv9nxGXJ8dMn5nv4OvL3PsNKxE3WafywNdk
         3qdMr/PtIlK0IrGs9oAVtFgpvgcEBJJse6PIjW2bCxxqfrMR5N8MHrISeWFlqZpzXa0r
         DQfg9siSzu2WKy6+ZY3nwIIITqNVpE2h6xZlqQDlgqfVFLgHhsmHTb3bWfcZyjPd9yyC
         1OxGPrhfSC9VXLitI/HRieXRoiEJFEqFQTFcbFbHThtuAj+m1U6cnflwehvECkOMr9Oz
         d1g+zVjWSyO5WTA3KSqT0Y1MaGSJR/Pfp6Uptv5n1CmBir2UqWHwkJlXRm04zEDB7s6a
         JlnQ==
X-Gm-Message-State: APt69E2l70NG5ZgCuZCqM19o9K7hgKwVUXuNKLC3c7lm1aBYfZm4GqeT
        QUr+o3BwN37NJMWhHhC/LhPv9XGIIRE2mByGkQc=
X-Google-Smtp-Source: ADUXVKIjA/u6agXrUgfdCBnxfXQsV5DcJPyTFon8YeNSjx+3Byc1LOUPhgFKd48MWw+4uT9Mwf8hFZNJYuhkST2s8bs=
X-Received: by 2002:adf:c7c3:: with SMTP id y3-v6mr15180wrg.230.1529035393563;
 Thu, 14 Jun 2018 21:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:97c6:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 21:03:12
 -0700 (PDT)
In-Reply-To: <7a77829a-ba5f-8975-edb0-ffdf25dc71d6@oracle.com>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com>
 <3dd3f82a-5b68-f039-3a8a-7c5fe4e24c3e@oracle.com> <e5344293-b0b7-d2e0-f2e7-c0700efdfbe4@oracle.com>
 <CACVXFVMRCM6AvNJjAESbwOeJ_P5AZ+1C-7RfhE9L4u0T=_5h4Q@mail.gmail.com>
 <3970fdc7-52d9-d05b-4118-059d48bf4f2d@oracle.com> <CACVXFVMPAdFbX3x-KUjHCQhb_rT6p9ROYHg63aUtEqdbitEaKQ@mail.gmail.com>
 <7a77829a-ba5f-8975-edb0-ffdf25dc71d6@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 15 Jun 2018 12:03:12 +0800
Message-ID: <CACVXFVO+GsQHCgoc6GuP1osnWprfeGrsikBgxj49+KiJoOsvBA@mail.gmail.com>
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

On Fri, Jun 15, 2018 at 11:26 AM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi Ming
>
> On 06/15/2018 11:20 AM, Ming Lei wrote:
>> On Fri, Jun 15, 2018 at 11:04 AM, jianchao.wang
>> <jianchao.w.wang@oracle.com> wrote:
>>> Hi Ming
>>>
>>> Thanks for your kindly response.
>>>
>>> On 06/15/2018 10:56 AM, Ming Lei wrote:
>>>>>> IMO, ref-counter is just to fix the blk-mq req life recycle issue.
>>>>>> It cannot replace the blk_mark_rq_complete which could avoid the race between
>>>>>> timeout and io completion path.
>>>>> The .timeout return BLK_EH_DONE doesn't always mean the request has been completed.
>>>>> Such as scsi-mid layer, its .timeout callback return BLK_EH_DONE but the timed out
>>>>> request is still in abort or eh process. What if a completion irq come during that ?
>>>> For blk-mq, it is avoided by the atomic state change in
>>>> __blk_mq_complete_request(),
>>>> that is why I mentioned the question in my last reply.
>>>>
>>>
>>> but blk_mq_check_expired doesn't do that.
>>> do I miss anything ?
>>
>> Right, that is the difference between blk-mq and legacy now,
>
> Sorry, I cannot follow your point.
> blk_mq_check_expired doesn't do a atmoc state change from IN-FLIGHT to COMPLETE.
> __blk_mq_complete_request could still proceed to complete a timed out request
> which is in scsi abort or eh process. Is it really OK ?

That is the idea of Christoph's patchset of 'complete requests from ->timeout',
then drivers need to cover race between timeout and normal completeion.

But at least the request won't be completed twice because of the atomic
state change in __blk_mq_complete_request().

So what is your real concern about blk-mq's timeout?

Thanks,
Ming
