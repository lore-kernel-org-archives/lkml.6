Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E55C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009EA2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfALB5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:57:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALB5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:57:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 324FF14CCB476;
        Fri, 11 Jan 2019 17:57:12 -0800 (PST)
Date:   Fri, 11 Jan 2019 17:57:11 -0800 (PST)
Message-Id: <20190111.175711.1689272658462652060.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     isdn@linux-pingi.de, viro@zeniv.linux.org.uk, linux@roeck-us.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: i4l: isdn_tty: Fix some concurrency double-free
 bugs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190108130448.22102-1-baijiaju1990@gmail.com>
References: <20190108130448.22102-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 11 Jan 2019 17:57:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Tue,  8 Jan 2019 21:04:48 +0800

> The functions isdn_tty_tiocmset() and isdn_tty_set_termios() may be
> concurrently executed.
 ...
> These possible bugs are found by a static tool written by myself and 
> my manual code review.
> 
> To fix these possible bugs, the mutex lock "modem_info_mutex" used in
> isdn_tty_tiocmset() is added in isdn_tty_set_termios().
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.
