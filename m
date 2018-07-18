Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC60CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D7F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D7F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGRSEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:04:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbeGRSEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:04:30 -0400
Received: from localhost (unknown [24.18.143.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1C5B21473D1BE;
        Wed, 18 Jul 2018 10:25:36 -0700 (PDT)
Date:   Thu, 19 Jul 2018 02:25:30 +0900 (KST)
Message-Id: <20180719.022530.2143546035904761995.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, tom@herbertland.com,
        david.lebrun@uclouvain.be, m.xhonneux@gmail.com,
        daniel@iogearbox.net, yuvalm@mellanox.com, georg@hofmannsweb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: ila: select CONFIG_DST_CACHE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718084909.1902331-1-arnd@arndb.de>
References: <20180718084909.1902331-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 10:25:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Jul 2018 10:48:56 +0200

> My randconfig builds came across an old missing dependency for ILA:
> 
> ERROR: "dst_cache_set_ip6" [net/ipv6/ila/ila.ko] undefined!
> ERROR: "dst_cache_get" [net/ipv6/ila/ila.ko] undefined!
> ERROR: "dst_cache_init" [net/ipv6/ila/ila.ko] undefined!
> ERROR: "dst_cache_destroy" [net/ipv6/ila/ila.ko] undefined!
> 
> We almost never run into this by accident because randconfig builds
> end up selecting DST_CACHE from some other tunnel protocol, and this
> one appears to be the only one missing the explicit 'select'.
> 
> From all I can tell, this problem first appeared in linux-4.9
> when dst_cache support got added to ILA.
> 
> Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
> Cc: Tom Herbert <tom@herbertland.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
