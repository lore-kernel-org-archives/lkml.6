Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD8DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B58F21479
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B58F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLIF11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 00:27:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36776 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIF10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 00:27:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1D78D141CFB79;
        Sat,  8 Dec 2018 21:27:26 -0800 (PST)
Date:   Sat, 08 Dec 2018 21:27:25 -0800 (PST)
Message-Id: <20181208.212725.171565172090619908.davem@davemloft.net>
To:     tarick@google.com
Cc:     eranbe@mellanox.com, tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: Correctly set PFC param if global pause
 is turned off.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181207083026.173789-1-tarick@google.com>
References: <20181207083026.173789-1-tarick@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 08 Dec 2018 21:27:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tarick Bedeir <tarick@google.com>
Date: Fri,  7 Dec 2018 00:30:26 -0800

> rx_ppp and tx_ppp can be set between 0 and 255, so don't clamp to 1.
> 
> Fixes: 6e8814ceb7e8 ("net/mlx4_en: Fix mixed PFC and Global pause user control requests")
> Signed-off-by: Tarick Bedeir <tarick@google.com>

Applied and queued up for -stable.
