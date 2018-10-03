Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE19C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6823920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6823920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeJCMSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:18:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54642 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:18:18 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CD2DF141FD11A;
        Tue,  2 Oct 2018 22:31:29 -0700 (PDT)
Date:   Tue, 02 Oct 2018 22:31:29 -0700 (PDT)
Message-Id: <20181002.223129.1177445698929439953.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     madalin.bucur@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa_eth: Remove useless declaration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181001041029.2334-1-natechancellor@gmail.com>
References: <20181001041029.2334-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Oct 2018 22:31:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Sun, 30 Sep 2018 21:10:29 -0700

> Clang warns:
> 
> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2734:34: warning:
> tentative array definition assumed to have one element
> static const struct of_device_id dpaa_match[];
>                                  ^
> 1 warning generated.
> 
> Turns out that since this driver was introduced in commit 9ad1a3749333
> ("dpaa_eth: add support for DPAA Ethernet"), this declaration has been
> unused. Remove it to silence the warning.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to net-next.
