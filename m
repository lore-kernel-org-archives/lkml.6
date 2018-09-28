Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC8C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898CC2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898CC2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeI2EUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:20:40 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:40760 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727443AbeI2EUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:20:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2A7EE182CED2A;
        Fri, 28 Sep 2018 21:54:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crack05_652c402e70243
X-Filterd-Recvd-Size: 1940
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:54:55 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        netdev@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER'
Date:   Fri, 28 Sep 2018 14:54:53 -0700
Message-Id: <20180928215453.29916-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	8726	MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER
	8727	M:	Andrew Lunn <andrew@lunn.ch>
	8728	M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
	8729	L:	netdev@vger.kernel.org
	8730	S:	Maintained
	8731	F:	drivers/net/dsa/mv88e6xxx/
-->	8732	F:	linux/platform_data/mv88e6xxx.h
	8733	F:	Documentation/devicetree/bindings/net/dsa/marvell.txt

Commit that introduced this:

commit 877b7cb0b6f283593a663134ee52703f12c895cc
 Author: Andrew Lunn <andrew@lunn.ch>
 Date:   Sat May 19 22:31:34 2018 +0200
 
     net: dsa: mv88e6xxx: Add minimal platform_data support
     
     Not all the world uses device tree. Some parts of the world still use
     platform devices and platform data. Add basic support for probing a
     Marvell switch via platform data.
     
     Signed-off-by: Andrew Lunn <andrew@lunn.ch>
     Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>
 
  MAINTAINERS                             |  1 +
  drivers/net/dsa/mv88e6xxx/chip.c        | 56 ++++++++++++++++++++++++++++-----
  include/linux/platform_data/mv88e6xxx.h | 17 ++++++++++
  3 files changed, 67 insertions(+), 7 deletions(-)

No commit with linux/platform_data/mv88e6xxx.h found

