Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E9DC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63429214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63429214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeJJC5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:57:08 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.133]:12620 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbeJJC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:57:08 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 968E3400FF003
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 14:38:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9xpegVrISBcCX9xpqgoieV; Tue, 09 Oct 2018 14:38:36 -0500
X-Authority-Reason: nr=8
Received: from 57.154.24.109.rev.sfr.net ([109.24.154.57]:39200 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9xpd-001vLo-9T; Tue, 09 Oct 2018 14:38:13 -0500
Date:   Tue, 9 Oct 2018 21:38:11 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next 0/2] fix signedness bug and memory leak in mscc
 driver
Message-ID: <cover.1539113472.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 109.24.154.57
X-Source-L: No
X-Exim-ID: 1g9xpd-001vLo-9T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 57.154.24.109.rev.sfr.net (embeddedor) [109.24.154.57]:39200
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to fix a signedness bug in function
vsc85xx_downshift_get() and a memory leak in function
vsc8574_config_pre_init().

Thanks

Gustavo A. R. Silva (2):
  net: phy: mscc: fix signedness bug in vsc85xx_downshift_get
  net: phy: mscc: fix memory leak in vsc8574_config_pre_init

 drivers/net/phy/mscc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

