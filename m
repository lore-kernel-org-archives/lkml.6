Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9939BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7471820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfAQTrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:47:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59480 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfAQTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:47:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D494C14B9556D;
        Thu, 17 Jan 2019 11:47:53 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:47:53 -0800 (PST)
Message-Id: <20190117.114753.495905826813982221.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: he: fix sign-extension overflow on large shift
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190115180338.32357-1-colin.king@canonical.com>
References: <20190115180338.32357-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Jan 2019 11:47:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 15 Jan 2019 18:03:38 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Shifting the 1 by exp by an int can lead to sign-extension overlow when
> exp is 31 since 1 is an signed int and sign-extending this result to an
> unsigned long long will set the upper 32 bits.  Fix this by shifting an
> unsigned long.
> 
> Detected by cppcheck:
> (warning) Shifting signed 32-bit value by 31 bits is undefined behaviour
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
