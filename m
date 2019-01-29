Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D8FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E0721874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfA2Ta4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:30:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34796 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfA2Taz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:30:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6C5531411AC1B;
        Tue, 29 Jan 2019 11:30:54 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:30:51 -0800 (PST)
Message-Id: <20190129.113051.1765896152662794323.davem@davemloft.net>
To:     jelsasser@appneta.com
Cc:     josh@elsasser.ca, ecree@solarflare.com, ktkhai@virtuozzo.com,
        jiri@mellanox.com, petrm@mellanox.com, edumazet@google.com,
        amritha.nambiar@intel.com, alexander.h.duyck@intel.com,
        lirongqing@baidu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: set default network namespace in
 init_dummy_netdev()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190126223835.14613-1-jelsasser@appneta.com>
References: <20190126223835.14613-1-jelsasser@appneta.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Jan 2019 11:30:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Elsasser <jelsasser@appneta.com>
Date: Sat, 26 Jan 2019 14:38:33 -0800

> Assign a default net namespace to netdevs created by init_dummy_netdev().
> Fixes a NULL pointer dereference caused by busy-polling a socket bound to
> an iwlwifi wireless device, which bumps the per-net BUSYPOLLRXPACKETS stat
> if napi_poll() received packets:
> 
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000190
>   IP: napi_busy_loop+0xd6/0x200
>   Call Trace:
>     sock_poll+0x5e/0x80
>     do_sys_poll+0x324/0x5a0
>     SyS_poll+0x6c/0xf0
>     do_syscall_64+0x6b/0x1f0
>     entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> Fixes: 7db6b048da3b ("net: Commonize busy polling code to focus on napi_id instead of socket")
> Signed-off-by: Josh Elsasser <jelsasser@appneta.com>

Applied and queued up for -stable.
