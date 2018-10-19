Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D47ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A452086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A452086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJTBxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:53:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeJTBxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:53:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5B8141438CA8D;
        Fri, 19 Oct 2018 10:45:56 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:45:55 -0700 (PDT)
Message-Id: <20181019.104555.830780623382872282.davem@davemloft.net>
To:     davej@codemonkey.org.uk
Cc:     mroos@linux.ee, xiyou.wangcong@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: netconsole warning in 4.19.0-rc7
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181019134704.ky2vqeij6m77qrpg@codemonkey.org.uk>
References: <20181018145922.ytqxvdihp3iqounl@codemonkey.org.uk>
        <ddc5fea8-6c66-d096-57bb-c86a3771fec4@linux.ee>
        <20181019134704.ky2vqeij6m77qrpg@codemonkey.org.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Oct 2018 10:45:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@codemonkey.org.uk>
Date: Fri, 19 Oct 2018 09:47:04 -0400

> On Fri, Oct 19, 2018 at 12:51:38PM +0300, Meelis Roos wrote:
>  > >   > > I took another look at that error path. Turns out this is all we need I
>  > >   > > think..
>  > >   >
>  > >   > With this patch applied on top of 4.19-rc8, I stll get the warning:
>  > >   >
>  > >   > [   13.722919] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:168 __local_bh_enable_ip+0x2e/0x44
>  > > 
>  > > It's going to be a couple days before I get chance to get back to this.
>  > > Did the previous patch in this thread (without the _bh) fare any better?
>  > 
>  > Tried it with rcu_read_unlock() instead, still the same.
> 
> Ok, this is going to take more time than I have.  DaveM, do you want
> to revert 6fe9487892b32cb1c8b8b0d552ed7222a527fe30, or do you want a
> patch doing the same ?
> 
> That'll bring back the rcu warning, but fewer people were complaining
> about that than this new issue..

I'll revert.

Thanks Dave.
