Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F45FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C6F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C6F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeIMUcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:32:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49932 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeIMUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:32:43 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2422013FCB146;
        Thu, 13 Sep 2018 08:22:44 -0700 (PDT)
Date:   Thu, 13 Sep 2018 08:22:43 -0700 (PDT)
Message-Id: <20180913.082243.1622516360155710681.davem@davemloft.net>
To:     jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] xen/netfront: don't bug in case of too many frags
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180911070448.3958-1-jgross@suse.com>
References: <20180911070448.3958-1-jgross@suse.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 08:22:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>
Date: Tue, 11 Sep 2018 09:04:48 +0200

> Commit 57f230ab04d291 ("xen/netfront: raise max number of slots in
> xennet_get_responses()") raised the max number of allowed slots by one.
> This seems to be problematic in some configurations with netback using
> a larger MAX_SKB_FRAGS value (e.g. old Linux kernel with MAX_SKB_FRAGS
> defined as 18 instead of nowadays 17).
> 
> Instead of BUG_ON() in this case just fall back to retransmission.
> 
> Fixes: 57f230ab04d291 ("xen/netfront: raise max number of slots in xennet_get_responses()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Juergen Gross <jgross@suse.com>

Applied.
