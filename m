Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2263ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8362086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8362086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPHgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:36:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeGPHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:36:17 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3E1A101518D0;
        Mon, 16 Jul 2018 00:10:20 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:10:18 -0700 (PDT)
Message-Id: <20180716.001018.1749913018733645131.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 0/5] net: mvpp2: add debugfs interface
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180714112928.14246-1-maxime.chevallier@bootlin.com>
References: <20180714112928.14246-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Jul 2018 00:10:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Sat, 14 Jul 2018 13:29:23 +0200

> The PPv2 Header Parser and Classifier are not straightforward to debug,
> having easy access to some of the many lookup tables configuration is
> helpful during development and debug.
> 
> This series adds a basic debugfs interface, allowing to read data from
> the Header Parser and some of the Classifier tables.
> 
> For now, the interface is read-only, and contains only some basic info.
> 
> This was actually used during RSS development, and might be useful to
> troubleshoot some issues we might find.
> 
> The first patch of the series converts the mvpp2 files to SPDX, which
> eases adding the new debugfs dedicated file.
> 
> The second patch adds the interface, and exposes basic Header Parser data.
> 
> The 3rd patch adds a hit counter for the Header Parser TCAM.
> 
> The 4th patch exposes classifier info.
> 
> The 5th patch adds some hit counters for some of the classifier engines.
> 
> Changes since V1:
> - Rebased on the lastest net-next
> - Made cls_flow_get non static so that it can be used in mvpp2_debugfs

Series applied.
