Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C109FC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4DB2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4DB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeK3K7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:59:20 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37666 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK3K7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:59:20 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E259E14F07FA3;
        Thu, 29 Nov 2018 15:52:02 -0800 (PST)
Date:   Thu, 29 Nov 2018 15:52:00 -0800 (PST)
Message-Id: <20181129.155200.484195944365513578.davem@davemloft.net>
To:     keescook@chromium.org
Cc:     corsac@corsac.net, linux-kernel@vger.kernel.org,
        ishkamiel@gmail.com, dwindsor@gmail.com, elena.reshetova@intel.com,
        ktkhai@virtuozzo.com, viro@zeniv.linux.org.uk,
        xiyou.wangcong@gmail.com, mjurczyk@google.com, dvlasenk@redhat.com,
        dh.herrmann@gmail.com, netdev@vger.kernel.org, agk@godking.net,
        johannes.berg@intel.com, garsilva@embeddedor.com,
        arvind.yadav.cs@gmail.com, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au
Subject: Re: Freeze when using ipheth+IPsec+IPv6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAGXu5jKw-En2p3ffgfJja63E3WnF+Q7-b0S6QHOf3FOTjgu7ew@mail.gmail.com>
References: <20180605085450.GA3506@scapa.corsac.net>
        <20180606082130.GA3730@scapa.corsac.net>
        <CAGXu5jKw-En2p3ffgfJja63E3WnF+Q7-b0S6QHOf3FOTjgu7ew@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Nov 2018 15:52:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Thu, 29 Nov 2018 15:31:25 -0800

> Did you ever solve this?

I think it was fixed by:

commit 45611c61dd503454b2edae00aabe1e429ec49ebe
Author: Bernd Eckstein <3erndeckstein@gmail.com>
Date:   Fri Nov 23 13:51:26 2018 +0100

    usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2
