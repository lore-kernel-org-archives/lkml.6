Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D912C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3172720652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3172720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJWJig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:38:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36192 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:38:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so20798240pfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 18:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cGNpZiE5bm5Dwbzd49m6GkEYZ/oFBviilpQqDTYn6KI=;
        b=SR0ELf5YLNzOPx4sN2TxzofnZYlhJ2NAmd5CA3/volQK5QPrjWC3XpUBALz8tOSC3P
         ngy2jVSCji9p39kWvv3Ou87NREoKaeztk8X7G5JgCN+7aVHackqtmgO+YHA0NApmB/Co
         WVSWbD15Cn7DoQbeJaArPaY5VZ2y6vaoka1FMKK7BTZS9ft16Ah3kaTU2QJrpUfz/gpZ
         lSO+Sm6k9lSVUt7VlzwyGQEOjUEea9noCbyIc332Ib3TT2cLHI3nyg14zvwd0NVrJ6En
         56G9LutFJC91B7DrLJVXNiJl6wN8TCBXLS41gYsjKuwzjm6tQBoT+8IIXnZ7aueSbUNT
         vWNw==
X-Gm-Message-State: ABuFfohTbFOLcY0prZHN7cEjgl0aW18YG0uIedhWJy2Txv6CfV88dWTn
        lhEBIx6m4sXCWAs/iWw93S8=
X-Google-Smtp-Source: ACcGV63YBaA2mvdqlPmMWsYyizBOLj8U7XcCdAvpVSy8bZhLIX4fvwwCBRmvGxmkE9lf7gaLAWWa7A==
X-Received: by 2002:a62:670f:: with SMTP id b15-v6mr189156pfc.243.1540257455078;
        Mon, 22 Oct 2018 18:17:35 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id y144-v6sm47853378pfb.81.2018.10.22.18.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 18:17:33 -0700 (PDT)
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
 <1540241646.128590.16.camel@acm.org>
 <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8d1a9c8c-fddb-7fb9-4bba-377bc6d51829@acm.org>
Date:   Mon, 22 Oct 2018 18:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 2:04 PM, Johannes Berg wrote:
> On Mon, 2018-10-22 at 13:54 -0700, Bart Van Assche wrote:
>> The code in the column with label "CPU0" is code called by do_blockdev_direct_IO().
>>  From the body of that function:
>>
>> 			/* will be released by direct_io_worker */
>> 			inode_lock(inode);
> 
> I don't think this is related. If this comment is true (and I have no
> reason to believe it's not), then the inode lock is - by nature of
> allowing lock/unlock to happen in different processes - not something
> lockdep can track to start with.
> 
> [ ... ]
 >> You do realize that this workqueue tracking stuff has been around for
> a few years (and got removed again in refactoring, etc.) and has found > countless bugs?

This is something I had not realized when I posted the patch at the 
start of this e-mail thread. Thanks for having mentioned this.

But I doubt that the inode lock has been annotated incorrectly. From the 
kernel source code:

static inline void inode_lock(struct inode *inode)
{
	down_write(&inode->i_rwsem);
}

[ ... ]

void __sched down_write(struct rw_semaphore *sem)
{
	might_sleep();
	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);

	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
	rwsem_set_owner(sem);
}

It seems to me that the inode lock has been annotated correctly as an 
rwsem. It's not clear to me however why lockdep complains about a 
deadlock for the direct I/O code. I hope someone has the time to go to 
the bottom of this.

Bart.
