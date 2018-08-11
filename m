Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4AC46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC929219C8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC929219C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHKEoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:44:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeHKEoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:44:20 -0400
Received: from localhost (unknown [172.58.35.185])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E5681434C5F9;
        Fri, 10 Aug 2018 19:11:54 -0700 (PDT)
Date:   Fri, 10 Aug 2018 19:11:53 -0700 (PDT)
Message-Id: <20180810.191153.2290770424551316173.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     Jisheng.Zhang@synaptics.com, thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvneta: fix mvneta_config_rss on armada
 3700
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810222335.GD11955@lunn.ch>
References: <20180810113627.5dec5d40@xhacker.debian>
        <20180810.144031.861564620036768413.davem@davemloft.net>
        <20180810222335.GD11955@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Aug 2018 19:11:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 11 Aug 2018 00:23:35 +0200

> On Fri, Aug 10, 2018 at 02:40:31PM -0700, David Miller wrote:
>> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> Date: Fri, 10 Aug 2018 11:36:27 +0800
>> 
>> > The mvneta Ethernet driver is used on a few different Marvell SoCs.
>> > Some SoCs have per cpu interrupts for Ethernet events, the driver uses
>> > a per CPU napi structure for this case. Some SoCs such as armada 3700
>> > have a single interrupt for Ethernet events, the driver uses a global
>> > napi structure for this case.
>> > 
>> > Current mvneta_config_rss() always operates the per cpu napi structure.
>> > Fix it by operating a global napi for "single interrupt" case, and per
>> > cpu napi structure for remaining cases.
>> > 
>> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> > Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
>> 
>> Applied, thanks.
> 
> Hi David
> 
> Please can you queue up:
> 
> Fixes: 7a86f05faf11 ("net: ethernet: mvneta: Fix napi structure mixup on armada 3700")
> 
> and this patch for stable.

If you want things to go to -stable, don't mark them for net-next as this
patch was.

If it isn't appropriate for 'net' it isn't appropriate for -stable either.
