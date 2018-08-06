Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A82C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13D521A32
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13D521A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbeHFTx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:53:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732102AbeHFTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:53:57 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B954F133E98F4;
        Mon,  6 Aug 2018 10:43:48 -0700 (PDT)
Date:   Mon, 06 Aug 2018 10:43:48 -0700 (PDT)
Message-Id: <20180806.104348.60564757746017342.davem@davemloft.net>
To:     yangbo.lu@nxp.com
Cc:     netdev@vger.kernel.org, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp_qoriq: use div_u64/div_u64_rem for 64-bit division
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180806043911.15437-1-yangbo.lu@nxp.com>
References: <20180806043911.15437-1-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Aug 2018 10:43:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Mon,  6 Aug 2018 12:39:11 +0800

> This is a fix-up patch for below build issue with multi_v7_defconfig.
> 
> drivers/ptp/ptp_qoriq.o: In function `qoriq_ptp_probe':
> ptp_qoriq.c:(.text+0xd0c): undefined reference to `__aeabi_uldivmod'
> 
> Fixes: 91305f281262 ("ptp_qoriq: support automatic configuration for ptp timer")
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied.
