Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D945C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A993820835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 21:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A993820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeICBbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 21:31:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeICBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 21:31:11 -0400
Received: from localhost (96-93-106-177-static.hfc.comcastbusiness.net [96.93.106.177])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 76F6714239965;
        Sun,  2 Sep 2018 14:14:04 -0700 (PDT)
Date:   Sun, 02 Sep 2018 14:14:03 -0700 (PDT)
Message-Id: <20180902.141403.1656418595490448023.davem@davemloft.net>
To:     Jisheng.Zhang@synaptics.com
Cc:     thomas.petazzoni@bootlin.com, andrew@lunn.ch,
        gregory.clement@bootlin.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: mvneta: some small improvements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Sep 2018 14:14:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Fri, 31 Aug 2018 16:08:10 +0800

> patch1 removes the NETIF_F_GRO check ourself, because the net subsystem
> will handle it for us.
> 
> patch2 enables NETIF_F_RXCSUM by default, since the driver and HW
> supports the feature.
> 
> patch3 is a small optimization, to reduce smp_processor_id() calling
> in mvneta_tx_done_gbe.
> 
> since v1:
>  - based on net-next tree
>  - remove the fix patches, since they should be based on net branch.
>  - Add Gregory's Reviewed-by tag

Series applied, thanks.
