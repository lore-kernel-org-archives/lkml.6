Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16913C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48C520665
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 20:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeL3U5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 15:57:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60618 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeL3U5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 15:57:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D132A14AC3A4A;
        Sun, 30 Dec 2018 12:57:22 -0800 (PST)
Date:   Sun, 30 Dec 2018 12:57:22 -0800 (PST)
Message-Id: <20181230.125722.160476917983481656.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] ipv4: fib_rules: Fix possible infinite loop in
 fib_empty_table
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181229064523.15812-1-yuehaibing@huawei.com>
References: <20181229064523.15812-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 30 Dec 2018 12:57:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 29 Dec 2018 14:45:23 +0800

> gcc warn this:
> net/ipv4/fib_rules.c:203 fib_empty_table() warn:
>  always true condition '(id <= 4294967295) => (0-u32max <= u32max)'
> 
> 'id' is u32, which always not greater than RT_TABLE_MAX
> (0xFFFFFFFF), So add a check to break while wrap around.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: clean up exit conditions

Applied.
