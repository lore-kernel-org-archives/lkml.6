Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C040DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C25021B32
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C25021B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeHKAML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:12:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeHKAML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:12:11 -0400
Received: from localhost (c-73-240-71-155.hsd1.or.comcast.net [73.240.71.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4FE0E142AC15B;
        Fri, 10 Aug 2018 14:40:32 -0700 (PDT)
Date:   Fri, 10 Aug 2018 14:40:31 -0700 (PDT)
Message-Id: <20180810.144031.861564620036768413.davem@davemloft.net>
To:     Jisheng.Zhang@synaptics.com
Cc:     thomas.petazzoni@free-electrons.com, andrew@lunn.ch,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada
 3700
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810113627.5dec5d40@xhacker.debian>
References: <20180810113627.5dec5d40@xhacker.debian>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Aug 2018 14:40:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Fri, 10 Aug 2018 11:36:27 +0800

> The mvneta Ethernet driver is used on a few different Marvell SoCs.
> Some SoCs have per cpu interrupts for Ethernet events, the driver uses
> a per CPU napi structure for this case. Some SoCs such as armada 3700
> have a single interrupt for Ethernet events, the driver uses a global
> napi structure for this case.
> 
> Current mvneta_config_rss() always operates the per cpu napi structure.
> Fix it by operating a global napi for "single interrupt" case, and per
> cpu napi structure for remaining cases.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")

Applied, thanks.
