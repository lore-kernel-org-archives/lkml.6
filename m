Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC34EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D9F20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rainbow-software.org header.i=@rainbow-software.org header.b="SBwFws8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D9F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rainbow-software.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeK2CTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:19:33 -0500
Received: from smtp-1b-out-4.atlantis.sk ([80.94.52.30]:51117 "EHLO
        smtp-1b-out-4.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeK2CTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:19:32 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 21:19:31 EST
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1b.atlantis.sk (Postfix) with ESMTPSA id 8A55383449E1;
        Wed, 28 Nov 2018 16:08:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rainbow-software.org;
        s=atlsmtp; t=1543417703;
        bh=HoxdWsynUGVCqIsU5mfdpBwyJOPHo64PcxIpAEtCLs4=;
        h=From:To:Subject:Date:Cc;
        b=SBwFws8HAOLxHdO3E/83bg/ehgXcK2dlrbkbH3T9cX7Q+pAvUeo5pbCMq9MYwJ7HO
         Dd2ZRW2IohGwSNtoa651P+1IT+sf6egZnkfD4heUJEXVwo8d7RrU/ovQSz4InhuFCD
         b/bTGvelD6gISOEovJScdHfKOhYmVU1Gdf46O8X8=
From:   Ondrej Zary <linux@rainbow-software.org>
To:     Michael Chan <michael.chan@broadcom.com>
Subject: bnxt_en: NIC Link is Up, 100 Mbps full duplex - but no data
Date:   Wed, 28 Nov 2018 16:08:14 +0100
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201811281608.14617.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a new Dell R740 server with BCM57416:
Ethernet controller [0200]: Broadcom Limited BCM57416 NetXtreme-E 10GBase-T RDMA Ethernet Controller [14e4:16d8] (rev 01)
Subsystem: Broadcom Limited BCM57416 NetXtreme-E Dual-Media 10G RDMA Ethernet Controller [14e4:4160]

When I connect a cable from 100Mbps switch, everything looks good - the link
LED lights up orange, data LED flashes green as when data is sent/received,
this appears in log:
[ 3791.655357] bnxt_en 0000:17:00.0 eno1np0: NIC Link is Up, 100 Mbps full duplex, Flow control: ON - receive & transmit
[ 3791.655361] bnxt_en 0000:17:00.0 eno1np0: EEE is not active
[ 3791.655364] bnxt_en 0000:17:00.0 eno1np0: FEC autoneg off encodings: None

But no data comes in or out. tcpdump shows only outgoing packets and they're
not transmitted in real (not seen by other machines).

It works fine after connecting through a gigabit switch.

Currently running 4.18.0-2-amd64 kernel (Debian testing).

Any ideas?

-- 
Ondrej Zary
