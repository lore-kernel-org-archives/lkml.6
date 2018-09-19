Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BBDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD6A208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD6A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeISIl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeISIl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:41:26 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E55C2083A;
        Wed, 19 Sep 2018 03:05:40 +0000 (UTC)
Date:   Tue, 18 Sep 2018 23:05:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     He Zhe <zhe.he@windriver.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180918230537.30448bd7@vmware.local.home>
In-Reply-To: <20180919024754.GA15128@jagdpanzerIV>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
        <20180919015030.GA423@jagdpanzerIV>
        <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
        <20180919023932.GA14090@jagdpanzerIV>
        <20180918224312.6e9aef50@vmware.local.home>
        <20180919024754.GA15128@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 11:47:54 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (09/18/18 22:43), Steven Rostedt wrote:
> > >  First  - switch to u64 size.
> > >  Second - check for NULL str.
> > >   
> > I think I would switch it around. Check for NULL first, and then switch
> > to u64. It was always an int, do we need to backport converting it to
> > u64 to stable? The NULL check is a definite, the overflow of int
> > shouldn't crash anything.  
> 
> Agreed. This order makes much more sense. Do you mind, tho, to have
> "unsigned int size" in the first patch along with NULL str check?
> Just to silent the checkpatch.
> 

I guess that doesn't hurt. I'd personally would keep it separate (just
fix what's broken), but it's such a slight change, I don't have any
strong feelings about it.

Thanks,


-- Steve
