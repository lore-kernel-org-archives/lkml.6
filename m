Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D1FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017D4206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017D4206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI2EUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:20:07 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:40723 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbeI2EUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:20:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 68FD5182CED28;
        Fri, 28 Sep 2018 21:54:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: join92_6094d4fda1c3e
X-Filterd-Recvd-Size: 2992
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:54:23 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, netdev@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'LANTIQ / INTEL Ethernet drivers'
Date:   Fri, 28 Sep 2018 14:54:22 -0700
Message-Id: <20180928215422.29755-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	8155	LANTIQ / INTEL Ethernet drivers
	8156	M:	Hauke Mehrtens <hauke@hauke-m.de>
	8157	L:	netdev@vger.kernel.org
	8158	S:	Maintained
	8159	F:	net/dsa/tag_gswip.c
	8160	F:	drivers/net/ethernet/lantiq_xrx200.c
	8161	F:	drivers/net/dsa/lantiq_pce.h
-->	8162	F:	drivers/net/dsa/intel_gswip.c

Commit that introduced this:

commit 14fceff4771e51b23b4485b575cf9e5b3414b89b
 Author: Hauke Mehrtens <hauke@hauke-m.de>
 Date:   Sun Sep 9 22:20:39 2018 +0200
 
     net: dsa: Add Lantiq / Intel DSA driver for vrx200
     
     This adds the DSA driver for the GSWIP Switch found in the VRX200 SoC.
     This switch is integrated in the DSL SoC, this SoC uses a GSWIP version
     2.1, there are other SoCs using different versions of this IP block, but
     this driver was only tested with the version found in the VRX200.
     Currently only the basic features are implemented which will forward all
     packages to the CPU and let the CPU do the forwarding. The hardware also
     support Layer 2 offloading which is not yet implemented in this driver.
     
     The GPHY FW loaded is now done by this driver and not any more by the
     separate driver in drivers/soc/lantiq/gphy.c, I will remove this driver
     is a separate patch. to make use of the GPHY this switch driver is
     needed anyway. Other SoCs have more embedded GPHYs so this driver should
     support a variable number of GPHYs. After the firmware was loaded the
     GPHY can be probed on the MDIO bus and it behaves like an external GPHY,
     without the firmware it can not be probed on the MDIO bus.
     
     The clock names in the sysctrl.c file have to be changed because the
     clocks are now used by a different driver. This should be cleaned up and
     a real common clock driver should provide the clocks instead.
     
     Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
     Signed-off-by: David S. Miller <davem@davemloft.net>
 
  MAINTAINERS                     |    2 +
  arch/mips/lantiq/xway/sysctrl.c |    8 +-
  drivers/net/dsa/Kconfig         |    8 +
  drivers/net/dsa/Makefile        |    1 +
  drivers/net/dsa/lantiq_gswip.c  | 1169 +++++++++++++++++++++++++++++++++++++++
  drivers/net/dsa/lantiq_pce.h    |  153 +++++
  6 files changed, 1337 insertions(+), 4 deletions(-)

No commit with drivers/net/dsa/intel_gswip.c found

