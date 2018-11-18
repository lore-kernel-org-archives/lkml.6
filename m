Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1A1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 06:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726EF20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 06:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726EF20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeKRQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 11:22:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42212 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeKRQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 11:22:40 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3C74148C5182;
        Sat, 17 Nov 2018 22:03:22 -0800 (PST)
Date:   Sat, 17 Nov 2018 22:03:22 -0800 (PST)
Message-Id: <20181117.220322.2081647103024305665.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     sbrivio@redhat.com, sd@queasysnail.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] geneve: Initialize addr6 with memset
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181117013626.4808-1-natechancellor@gmail.com>
References: <20181113061146.12182-1-natechancellor@gmail.com>
        <20181117013626.4808-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 17 Nov 2018 22:03:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Fri, 16 Nov 2018 18:36:27 -0700

> Clang warns:
> 
> drivers/net/geneve.c:428:29: error: suggest braces around initialization
> of subobject [-Werror,-Wmissing-braces]
>                 struct in6_addr addr6 = { 0 };
>                                           ^
>                                           {}
> 
> Rather than trying to appease the various compilers that support the
> kernel, use memset, which is unambiguous.
> 
> Fixes: a07966447f39 ("geneve: ICMP error lookup handler")
> Suggested-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
