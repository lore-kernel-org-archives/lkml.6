Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6F4C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94252075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PY6BpNxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94252075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeKTWDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:03:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44400 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeKTWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:03:44 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so1098506iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 03:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qzlm0r3fOaoOkHxMd9XLDt+3KwDmba+ZbzIm6I1xgX4=;
        b=PY6BpNxJLNiGrF0vOzZqs40sxE/kRd2v9VJYlgm5wVMroGhD7XFnzaC3nih1ALI1dc
         Jp6hqX0CkYhb3qxCB7wafn00Tw5Vz4JDedVQv/sTXIjAhyxxVxGjX6f/zqAhIvSK98/H
         r1rJMTPBz2dyUm6/5G/Df3NmdpaxZVApWu11qIBatnaLIu+r8cKzx32y5zan1ipXf5b8
         QL8Xug6flFuPmvAggs7RZ13lol1njUZclKXlDSTdi2/agux5QGoZSFfxr1D3uvemNs/q
         n9lZr5JM/o5+B8K2zP6amewQBMbfOeee8k85MDAeeChLiGzPeddLmaEDhji6c+L2kPvu
         1Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qzlm0r3fOaoOkHxMd9XLDt+3KwDmba+ZbzIm6I1xgX4=;
        b=JjOOII/+lYf8+1hPouUnlEchImPz/Sj9sxsVmWrmQ5Q8Gnl5jDiGuakJXimCSBV05m
         9TW3xmZD2CqHJgeNwDSfqX6yeNAf+SQrrbe07Je8nsQiVlzwla6Ip7lWbpJw/1aH2tRR
         BSNK3tDTz4DQaJ/dy2QrQGaNi8ZhhAbtmXVuOR0uWtUYz0gwH/3tr7WBH7zqoUhioRUz
         M4b9i2L/vBt7dpfja7/TTMSi2rB6YSaR8MGHJIVZb9Z5fqx1ysM3I8MRpLYYuw8q2qMC
         Hl0Nj/vmg/IC5uxlqRb2WuzlO/QndbPY0JbM9TLuERGxpDfy55zOUIqdVhJpCmsFktBE
         HR9g==
X-Gm-Message-State: AA+aEWYfv9VnVoQ1tn1FeM/8S+r6im+tR+1XTGdhw2jo+g0mlYU93Rv3
        X1Xxe36P17BbDUwqbyA1dQY1NoYLVQNX/XMvn4n/sg==
X-Google-Smtp-Source: AFSGD/XztFqXP0ZjssBtIE1X7e/062Mck1vUoS0/Sv2aBnPpy3bRubRwHURJd5NL53iX40ybeCciHVwM6ulAlQSw7PU=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr1064825iod.282.1542713701827;
 Tue, 20 Nov 2018 03:35:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 03:34:40
 -0800 (PST)
In-Reply-To: <20181115005658.GA24847@kroah.com>
References: <20181109203518.GA7130@roeck-us.net> <20181112092051.GA391@ming.t460p>
 <20181112094406.GB391@ming.t460p> <20181112164848.GA1790@roeck-us.net>
 <20181112200236.GA4415@kroah.com> <20181113002226.GA4455@ming.t460p>
 <20181113004124.GC4455@ming.t460p> <20181114110827.GA31430@ming.t460p>
 <20181114151410.GB26378@kroah.com> <20181115003616.GA32603@ming.t460p> <20181115005658.GA24847@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Nov 2018 12:34:40 +0100
Message-ID: <CACT4Y+bSzPM022bGMmj4GQ_YHVsVqd6r+NTC4+fRrRT+yjAjEw@mail.gmail.com>
Subject: Re: kobject lifetime issues in blk-mq
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 1:56 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Nov 15, 2018 at 08:36:17AM +0800, Ming Lei wrote:
>> > So even if you think the kernel is not going to do this, remember, you
>> > have no control over it.  Reference counted objects are done this way
>> > for a reason, you really do not know who has a reference and you really
>> > do not care.
>> >
>> > You are just papering over the real issue here, see my previous email
>> > for how to start working on resolving it.
>>
>> IMO, there isn't real issue, and the issue is actually in 'delay release'.
>
> Nope, sorry, that is not true.
>
>> Please look at the code in block/blk-mq-sysfs.c, both q->mq_kobj and all
>> ctx->kobj share same lifetime with q->kobj, we even don't call get/put
>> on q->mq_kobj & all ctx->kobj, and all are simply released in q->kobj's
>> release handler.
>
> How do you "know" you are keeping those lifetimes in sync?  The joy of a
> kobject is that _ANYTHING_ can grab a reference to your object without
> you knowing about it.  That includes userspace programs.  Yes, sysfs is
> now much better and it trys to release that reference "quickly" when it
> determines you are trying to delete a kobject, but it's not perfict,
> there are still races there.
>
> And that is what the delay release code is showing you.  It is showing
> you that you "think" your reference counting is wrong, but it is not.
> It is showing you that if someone else grabs a reference, you are not
> correctly cleaning up for yourself.
>
> Never think that you really know the lifetime of a kobject, once you
> realize that your code gets simpler and you can then just "trust" that
> the kernel will do the right thing no matter what.
>
> Because really, you are using a kobject because you want that correct
> reference counting logic.  By ignoring that logic, you are ignoring the
> reason to be using that object at all.  If you don't need reference
> counting, then don't use it at all.
>
> And if you need sysfs files, then you need to use the kobject and then
> you need to handle it properly, because again, you do NOT have full
> control over the lifetime of your object.  That's the basis for
> reference counting in the firstplace.
>
> So this code is broken without me evening having to look at it, please
> fix it to handle release properly.  Again, the kernel tried to tell you
> this, but you hacked around the kernel core to remove that warning
> incorrectly.  Please go read the kobject documentation again for even
> more details about this than what I said here.
>
> thanks,
>
> greg k-h

Whoever is the right person to fix this, please prioritize this to the
degree possible.
This issue does not allow to use DEBUG_KOBJECT_RELEASE in any
automated testing (in particular syzbot) on both upstream and stable
trees. We have to disable it for now, so other bugs won't be noticed
and will pile up.

Thanks
