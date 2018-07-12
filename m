Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9F6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1427208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1427208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbeGLWHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:07:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43516 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeGLWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:07:41 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 420D8100811D7;
        Thu, 12 Jul 2018 14:56:11 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:56:10 -0700 (PDT)
Message-Id: <20180712.145610.148554127408069933.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jakub.kicinski@netronome.com, john.hurley@netronome.com,
        simon.horman@netronome.com, pieter.jansenvanvuuren@netronome.com,
        jiri@mellanox.com, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [RESEND] nfp: avoid using getnstimeofday64()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180711123003.453442-2-arnd@arndb.de>
References: <20180711123003.453442-1-arnd@arndb.de>
        <20180711123003.453442-2-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Jul 2018 14:56:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Jul 2018 14:29:53 +0200

> getnstimeofday64 is deprecated in favor of the ktime_get() family of
> functions. The direct replacement would be ktime_get_real_ts64(),
> but I'm picking the basic ktime_get() instead:
> 
> - using a ktime_t simplifies the code compared to timespec64
> - using monotonic time instead of real time avoids issues caused
>   by a concurrent settimeofday() or during a leap second adjustment.
> 
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to net-next.
