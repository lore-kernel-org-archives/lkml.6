Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2309EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AC820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AC820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbeHAUjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:39:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51300 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbeHAUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:39:20 -0400
Received: from localhost (c-71-59-158-49.hsd1.or.comcast.net [71.59.158.49])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9F37B100A24C1;
        Wed,  1 Aug 2018 11:52:11 -0700 (PDT)
Date:   Wed, 01 Aug 2018 11:52:11 -0700 (PDT)
Message-Id: <20180801.115211.922499763840107773.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix user call ID check in
 rxrpc_service_prealloc_one
From:   David Miller <davem@davemloft.net>
In-Reply-To: <153312644299.23453.6879704964860340038.stgit@warthog.procyon.org.uk>
References: <153312644299.23453.6879704964860340038.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Aug 2018 11:52:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Wed, 01 Aug 2018 13:27:23 +0100

> From: YueHaibing <yuehaibing@huawei.com>
> 
> There just check the user call ID isn't already in use, hence should
> compare user_call_ID with xcall->user_call_ID, which is current
> node's user_call_ID.
> 
> Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendmsg/recvmsg")
> Suggested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied and queued up for -stable.
