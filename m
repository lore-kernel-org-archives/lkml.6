Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718AE20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718AE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeK2Q4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:56:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46636 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeK2Q4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:56:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 75B8814EC5731;
        Wed, 28 Nov 2018 21:52:44 -0800 (PST)
Date:   Wed, 28 Nov 2018 21:52:41 -0800 (PST)
Message-Id: <20181128.215241.702406654469517539.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     dmitry.bezrukov@aquantia.com, igor.russkikh@aquantia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: aqc111: Properly initialize wol_cfg in
 aqc111_suspend
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181129051808.30015-1-natechancellor@gmail.com>
References: <20181129051808.30015-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 21:52:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 28 Nov 2018 22:18:09 -0700

> Clang warns:
> 
> drivers/net/usb/aqc111.c:1326:37: warning: suggest braces around
> initialization of subobject [-Wmissing-braces]
>                 struct aqc111_wol_cfg wol_cfg = { 0 };
>                                                   ^
>                                                   {}
> 1 warning generated.
> 
> Add another set of braces to initialize the char subobjects as well.
> 
> Fixes: e58ba4544c77 ("net: usb: aqc111: Add support for wake on LAN by MAGIC packet")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

This will in turn make some versions of gcc warn.

Please just memset() this object, thanks.
