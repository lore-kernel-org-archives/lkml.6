Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C92C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B57420818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B57420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeKINTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:19:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42316 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeKINTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:19:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2BFCF14B3D599;
        Thu,  8 Nov 2018 19:41:13 -0800 (PST)
Date:   Thu, 08 Nov 2018 19:41:12 -0800 (PST)
Message-Id: <20181108.194112.1819328948681907759.davem@davemloft.net>
To:     stefan.wahren@i2se.com
Cc:     michael.heimpold@i2se.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: qca_spi: Add available buffer space
 verification
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541684301-15824-1-git-send-email-stefan.wahren@i2se.com>
References: <1541684301-15824-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 19:41:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Thu,  8 Nov 2018 14:38:21 +0100

> Interferences on the SPI line could distort the response of
> available buffer space. So at least we should check that the
> response doesn't exceed the maximum available buffer space.
> In error case increase a new error counter and retry it later.
> This behavior avoids buffer errors in the QCA7000, which
> results in an unnecessary chip reset including packet loss.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied.
