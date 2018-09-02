Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E524CC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9CA20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9CA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeIBJmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 05:42:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56058 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeIBJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 05:42:10 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 45262143D0E2D;
        Sat,  1 Sep 2018 22:27:39 -0700 (PDT)
Date:   Sat, 01 Sep 2018 22:27:38 -0700 (PDT)
Message-Id: <20180901.222738.2092199274760750174.davem@davemloft.net>
To:     stefan.wahren@i2se.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qca_spi: Fix race condition in spi transfers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1535719981-20812-1-git-send-email-stefan.wahren@i2se.com>
References: <1535719981-20812-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 01 Sep 2018 22:27:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Fri, 31 Aug 2018 14:53:01 +0200

> The performance optimization with the prepared spi messages
> also introduced a race condition between the kernel thread
> and the register dump. This could make spi_sync hang forever.
> 
> So revert the optimization completely.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Please resubmit this patch with a better commit message, explaining in
more detail what the race is exactly.

Thank you.
