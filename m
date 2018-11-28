Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A3EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30CF20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30CF20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeK1VMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:12:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:59518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbeK1VL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:11:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E0F3AEFA;
        Wed, 28 Nov 2018 10:10:51 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: macb: probe of 10090000.ethernet failed with error -110
X-Yow:  Here is my refrigerator full of FLANK STEAK...and over there is my
 UPHOLSTERED CANOE...I don't know WHY I OWN them!!
Date:   Wed, 28 Nov 2018 11:10:50 +0100
Message-ID: <mvmefb5fr6d.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY probing of the macb driver appears to be rather unreliable.
Most of the time it doesn't work the first time, I have to reload the
module several times to let it succeed.

[   40.530000] macb: GEM doesn't support hardware ptp.
[   40.530000] libphy: MACB_mii_bus: probed
[   41.450000] macb 10090000.ethernet (unnamed net_device) (uninitialized): Could not attach to PHY
[   41.510000] macb: probe of 10090000.ethernet failed with error -110
[ 1354.400000] macb: GEM doesn't support hardware ptp.
[ 1354.410000] libphy: MACB_mii_bus: probed
[ 1355.260000] macb 10090000.ethernet (unnamed net_device) (uninitialized): Could not attach to PHY
[ 1355.300000] macb: probe of 10090000.ethernet failed with error -110
[ 1358.100000] macb: GEM doesn't support hardware ptp.
[ 1358.110000] libphy: MACB_mii_bus: probed
[ 1358.310000] Microsemi VSC8541 SyncE 10090000.ethernet-ffffffff:00: attached PHY driver [Microsemi VSC8541 SyncE] (mii_bus:phy_addr=10090000.ethernet-ffffffff:00, irq=POLL)
[ 1358.320000] macb 10090000.ethernet eth0: Cadence GEM rev 0x10070109 at 0x10090000 irq 12 (70:b3:d5:92:f1:07)

This is 4.20-rc4 on a HiFive-U.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
