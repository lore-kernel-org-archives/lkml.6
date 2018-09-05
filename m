Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9CB2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9CB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIETkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:40:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46520 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIETkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:40:39 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E3BF13FFEA03;
        Wed,  5 Sep 2018 08:10:02 -0700 (PDT)
Date:   Wed, 05 Sep 2018 08:10:02 -0700 (PDT)
Message-Id: <20180905.081002.193347914551729211.davem@davemloft.net>
To:     stefan.wahren@i2se.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] net: qca_spi: Fix race condition in spi transfers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1536153798-16494-1-git-send-email-stefan.wahren@i2se.com>
References: <1536153798-16494-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Sep 2018 08:10:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Wed,  5 Sep 2018 15:23:18 +0200

> With performance optimization the spi transfer and messages of basic
> register operations like qcaspi_read_register moved into the private
> driver structure. But they weren't protected against mutual access
> (e.g. between driver kthread and ethtool). So dumping the QCA7000
> registers via ethtool during network traffic could make spi_sync
> hang forever, because the completion in spi_message is overwritten.
> 
> So revert the optimization completely.
> 
> Fixes: 291ab06ecf676 ("net: qualcomm: new Ethernet over SPI driver for QCA700")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied and queued up for -stable, thanks.
