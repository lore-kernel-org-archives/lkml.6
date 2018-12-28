Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547E920856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeL1AS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:18:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51878 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeL1AS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:18:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9879314E0964B;
        Thu, 27 Dec 2018 16:18:25 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:18:25 -0800 (PST)
Message-Id: <20181227.161825.582087596488298445.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6/route: Add a missing check on proc_dointvec
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181224163017.17362-1-pakki001@umn.edu>
References: <20181224163017.17362-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:18:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Mon, 24 Dec 2018 10:30:17 -0600

> While flushing the cache via  ipv6_sysctl_rtcache_flush(), the call
> to proc_dointvec() may fail. The fix adds a check that returns the
> error, on failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied, but honestly running garbage collection even if the value
isn't change is completely harmless.
