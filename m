Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226D421580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226D421580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbeHNTyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:54:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbeHNTyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:54:53 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7AD6013CF2FCA;
        Tue, 14 Aug 2018 10:06:53 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:06:52 -0700 (PDT)
Message-Id: <20180814.100652.1049665545919235495.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     santosh.shilimkar@oracle.com, anders.roxell@linaro.org,
        gthelen@google.com, ka-cheong.poon@oracle.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rds: fix building with IPV6=m
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180814090752.1681486-1-arnd@arndb.de>
References: <20180814090752.1681486-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Aug 2018 10:06:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Aug 2018 11:07:42 +0200

> When CONFIG_RDS_TCP is built-in and CONFIG_IPV6 is a loadable
> module, we get a link error agains the modular ipv6_chk_addr()
> function:
> 
> net/rds/tcp.o: In function `rds_tcp_laddr_check':
> tcp.c:(.text+0x3b2): undefined reference to `ipv6_chk_addr'
> 
> This adds back a dependency that forces RDS_TCP to also be
> a loadable module when IPV6 is one.
> 
> Fixes: e65d4d96334e ("rds: Remove IPv6 dependency")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
