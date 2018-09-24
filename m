Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB77C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587C7208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587C7208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeIYBaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:30:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIYBaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:30:10 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 78C5213AEDA69;
        Mon, 24 Sep 2018 12:26:29 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:26:29 -0700 (PDT)
Message-Id: <20180924.122629.891745867586399526.davem@davemloft.net>
To:     stefan.wahren@i2se.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.heimpold@i2se.com
Subject: Re: [PATCH] net: qca_spi: Introduce write register verification
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1537788010-6766-1-git-send-email-stefan.wahren@i2se.com>
References: <1537788010-6766-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Sep 2018 12:26:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Mon, 24 Sep 2018 13:20:10 +0200

> The SPI protocol for the QCA7000 doesn't have any fault detection.
> In order to increase the drivers reliability in noisy environments,
> we could implement a write verification inspired by the enc28j60.
> This should avoid situations were the driver wrongly assumes the
> receive interrupt is enabled and miss all incoming packets.
> 
> This function is disabled per default and can be controlled via module
> parameter wr_verify.
> 
> Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied.
