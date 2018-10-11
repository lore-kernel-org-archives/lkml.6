Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A41C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE9E2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE9E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeJLChM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:37:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60884 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbeJLChM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:37:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 55ED812DE580F;
        Thu, 11 Oct 2018 12:08:40 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:08:39 -0700 (PDT)
Message-Id: <20181011.120839.321027152552999776.davem@davemloft.net>
To:     mail@maciej.szmigiero.name
Cc:     chris2553@googlemail.com, hkallweit1@gmail.com,
        a3at.mail@gmail.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: set RX_MULTI_EN bit in RxConfig for
 8168F-family chips
From:   David Miller <davem@davemloft.net>
In-Reply-To: <73ee1d68-2a27-aee9-d8b5-79ba3eda8187@maciej.szmigiero.name>
References: <73ee1d68-2a27-aee9-d8b5-79ba3eda8187@maciej.szmigiero.name>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Oct 2018 12:08:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Thu, 11 Oct 2018 16:02:10 +0200

> It has been reported that since
> commit 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
> at least RTL_GIGA_MAC_VER_38 NICs work erratically after a resume from
> suspend.
> The problem has been traced to a missing RX_MULTI_EN bit in the RxConfig
> register.
> We already set this bit for RTL_GIGA_MAC_VER_35 NICs of the same 8168F
> chip family so let's do it also for its other siblings: RTL_GIGA_MAC_VER_36
> and RTL_GIGA_MAC_VER_38.
> 
> Curiously, the NIC seems to work fine after a system boot without having
> this bit set as long as the system isn't suspended and resumed.
> 
> Fixes: 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
> Reported-by: Chris Clayton <chris2553@googlemail.com>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Applied and queued up for -stable.
