Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B1C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C3A223AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C3A223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936865AbeF3JoK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 05:44:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933697AbeF3JoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 05:44:09 -0400
Received: from localhost (unknown [220.70.203.118])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E5A43144B7E60;
        Sat, 30 Jun 2018 02:44:07 -0700 (PDT)
Date:   Sat, 30 Jun 2018 18:44:06 +0900 (KST)
Message-Id: <20180630.184406.1626314416899588727.davem@davemloft.net>
To:     laoar.shao@gmail.com
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] tcp: add new SNMP counter for drops when
 try to queue in rcv queue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530159776-29919-1-git-send-email-laoar.shao@gmail.com>
References: <1530159776-29919-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 30 Jun 2018 02:44:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Jun 2018 00:22:56 -0400

> When sk_rmem_alloc is larger than the receive buffer and we can't
> schedule more memory for it, the skb will be dropped.
> 
> In above situation, if this skb is put into the ofo queue,
> LINUX_MIB_TCPOFODROP is incremented to track it.
> 
> While if this skb is put into the receive queue, there's no record.
> So a new SNMP counter is introduced to track this behavior.
> 
> LINUX_MIB_TCPRCVQDROP:  Number of packets meant to be queued in rcv queue
> 			but dropped because socket rcvbuf limit hit.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Applied to net-next.
