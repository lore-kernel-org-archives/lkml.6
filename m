Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9320C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E3C2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeLRXgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:36:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeLRXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:36:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9B62812640965;
        Tue, 18 Dec 2018 15:36:17 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:36:14 -0800 (PST)
Message-Id: <20181218.153614.1607918853242585355.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     netdev@vger.kernel.org, phil@nwl.cc, tgraf@suug.ch,
        herbert@gondor.apana.org.au, neilb@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] test_rhashtable: remove semaphore usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181216194836.1310998-1-arnd@arndb.de>
References: <20181216194836.1310998-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 15:36:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 16 Dec 2018 20:48:21 +0100

> This is one of only two files that initialize a semaphore to a negative
> value. We don't really need the two semaphores here at all, but can do
> the same thing in more conventional and more effient way, by using a
> single waitqueue and an atomic thread counter.
> 
> This gets us a little bit closer to eliminating classic semaphores from
> the kernel. It also fixes a corner case where we fail to continue after
> one of the threads fails to start up.
> 
> An alternative would be to use a split kthread_create()+wake_up_process()
> and completely eliminate the separate synchronization.
> 
> Acked-by: Phil Sutter <phil@nwl.cc>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes from v1:
>  - rebase to mainline,
>  - fix pr_err() output
>  - bail out if interrupted

Applied, thanks Arnd.
