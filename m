Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA0BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4718221527
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4718221527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeHPWVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:21:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60646 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeHPWVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:21:49 -0400
Received: from localhost (unknown [205.153.50.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EB35F145E6022;
        Thu, 16 Aug 2018 12:21:31 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:21:31 -0700 (PDT)
Message-Id: <20180816.122131.604270853620318143.davem@davemloft.net>
To:     jian-hong@endlessm.com
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180815062110.16155-1-jian-hong@endlessm.com>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Aug 2018 12:21:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <jian-hong@endlessm.com>
Date: Wed, 15 Aug 2018 14:21:10 +0800

> Found the ethernet network on ASUS X441UAR doesn't come back on resume
> from suspend when using MSI-X.  The chip is RTL8106e - version 39.

Heiner, please take a look at this.

You recently disabled MSI-X on RTL8168g for similar reasons.

Now that we've seen two chips like this, maybe there is some other
problem afoot.

Thanks.
