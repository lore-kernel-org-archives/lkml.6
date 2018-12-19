Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5101C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB7C217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeLSGAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:00:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49566 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeLSGAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:00:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DFA7610179D34;
        Tue, 18 Dec 2018 22:00:13 -0800 (PST)
Date:   Tue, 18 Dec 2018 22:00:13 -0800 (PST)
Message-Id: <20181218.220013.1743575331051422957.davem@davemloft.net>
To:     jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org,
        boris.ostrovsky@oracle.com, stable@vger.kernel.org
Subject: Re: [PATCH] xen/netfront: tolerate frags with no data
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181218150619.6964-1-jgross@suse.com>
References: <20181218150619.6964-1-jgross@suse.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 22:00:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>
Date: Tue, 18 Dec 2018 16:06:19 +0100

> At least old Xen net backends seem to send frags with no real data
> sometimes. In case such a fragment happens to occur with the frag limit
> already reached the frontend will BUG currently even if this situation
> is easily recoverable.
> 
> Modify the BUG_ON() condition accordingly.
> 
> Tested-by: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Applied and queued up for -stable.

But many of these BUG's in the driver should be converted to
WARNs and recovery code added.
