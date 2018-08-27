Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31793C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD8E208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD8E208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeH1CMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:12:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeH1CMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:12:37 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CE6A71474BECB;
        Mon, 27 Aug 2018 15:24:02 -0700 (PDT)
Date:   Mon, 27 Aug 2018 15:24:02 -0700 (PDT)
Message-Id: <20180827.152402.1358178279473378697.davem@davemloft.net>
To:     Haiqing.Bai@windriver.com
Cc:     netdev@vger.kernel.org, jon.maloy@ericsson.com,
        ying.xue@windriver.com, zhenbo.gao@windriver.com,
        linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH net] tipc: fix the big/little endian issue in
 tipc_dest
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1535333546-16753-1-git-send-email-Haiqing.Bai@windriver.com>
References: <1535333546-16753-1-git-send-email-Haiqing.Bai@windriver.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Aug 2018 15:24:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiqing Bai <Haiqing.Bai@windriver.com>
Date: Mon, 27 Aug 2018 09:32:26 +0800

> In function tipc_dest_push, the 32bit variables 'node' and 'port'
> are stored separately in uppper and lower part of 64bit 'value'.
> Then this value is assigned to dst->value which is a union like:
> union
> {
>   struct {
>     u32 port;
>     u32 node;
>   };
>   u64 value;
> }
> This works on little-endian machines like x86 but fails on big-endian
> machines.
> 
> The fix remove the 'value' stack parameter and even the 'value'
> member of the union in tipc_dest, assign the 'node' and 'port' member
> directly with the input parameter to avoid the endian issue.
> 
> Fixes: a80ae5306a73 ("tipc: improve destination linked list")
> 
> Signed-off-by: Zhenbo Gao <zhenbo.gao@windriver.com>
> Acked-by: Jon Maloy <jon.maloy@ericsson.com>
> Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>

Applied and queued up for -stable.
