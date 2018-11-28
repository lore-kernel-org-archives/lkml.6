Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560ACC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD36206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD36206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeK2Fog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:44:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36086 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeK2Fog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:44:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD99614E0B2C6;
        Wed, 28 Nov 2018 10:42:00 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:41:58 -0800 (PST)
Message-Id: <20181128.104158.314372136288891394.davem@davemloft.net>
To:     bianpan2016@163.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.bounine@idt.com
Subject: Re: [PATCH] rapidio/rionet: do not free skb before reading its
 length
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1543387999-115433-1-git-send-email-bianpan2016@163.com>
References: <1543387999-115433-1-git-send-email-bianpan2016@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 10:42:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>
Date: Wed, 28 Nov 2018 14:53:19 +0800

> skb is freed via dev_kfree_skb_any, however, skb->len is read then. This
> may result in a use-after-free bug.
> 
> Fixes: e6161d64263 ("rapidio/rionet: rework driver initialization and removal")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Applied and queued up for -stable.
