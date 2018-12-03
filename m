Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F39DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D356020850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D356020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLCVyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:54:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLCVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:54:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4AD3F12107045;
        Mon,  3 Dec 2018 13:54:00 -0800 (PST)
Date:   Mon, 03 Dec 2018 13:53:59 -0800 (PST)
Message-Id: <20181203.135359.135247381013242647.davem@davemloft.net>
To:     suyj.fnst@cn.fujitsu.com
Cc:     saeedm@mellanox.com, galp@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 8139cp: fix a BUG triggered by changing mtu with
 network traffic
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181203073307.14551-1-suyj.fnst@cn.fujitsu.com>
References: <20181203073307.14551-1-suyj.fnst@cn.fujitsu.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Dec 2018 13:54:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Date: Mon, 3 Dec 2018 15:33:07 +0800

> When changing mtu many times with traffic, a bug is triggered:
 ...
> The patch will check IntrMask before check IntrStatus in cp_interrupt.
> When 8139cp interrupt is disabled, just return.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>

Applied and queued up for -stable.
