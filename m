Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27651C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79B72081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79B72081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeKCAzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:55:31 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeKCAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:55:30 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MadC8-1fhuGy2p3K-00c5tQ; Fri, 02 Nov 2018 16:47:42 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MadC8-1fhuGy2p3K-00c5tQ; Fri, 02 Nov 2018 16:47:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: myrs: only build on little-endian platforms
Date:   Fri,  2 Nov 2018 16:47:23 +0100
Message-Id: <20181102154740.2011289-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:tTw5B+h8d5z8bsOIPBCyLc1qb7hir+Hl5vrgsRcq3BpkzZ7+/7/
 ZnaexOMFNTYdsYFbQ82rJFYutOaiTJUh7kST6kb4zfSARS1qpApwXNGqtDUnPqVqdjMpJ9L
 ajiXeC5hLJ8yFQ/kLniSeaou2HRZqo4posoGchgGBr2A3nMuFtKWtV6G7b3tJ5gDDkP8N8q
 sgbwasf3KIb9S5NfpohqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Imq3BK1NRDM=:Lkn4PUzLwyKBan3HXmGSAF
 Z0IcGWQl6xqNbEMG11l+r2cennw98ZVWGSHdLQS0qNF41rDHmrXp7nkRdDaPio8+QASbaWsts
 ntiL/2b9fBRPqf2StQqCJQoTDJvaiv/uaAFQFxU2m2nGNA1j0m33stulwBISVKOzOMSjEqetw
 jVnNh9PCAhBtxbhAtv1NZPChlPe/aCD4TapsUbw39NZL4UUImTFfciHqWVPyWtvGVJlw3ABlF
 HhbY1eZvOQYcyLPJaxcN9P0PQAfH6EbpV6Ytm1QK9oTvJes4SlzHPx/2eMzX3ug1aaKq8Ieiz
 Iws4T4osjQb9hOgfeBz4FGBYIqcG1V1/Z7113tiNcX0OStFjq3HJEQpuUaxlpBiY5jwWgRTdf
 MMmJLtIC8D3y4lGp/Jyvr5Udde1JhPbE7QYXceexXtasvxgtQAunKPDmjQPfaxcZ4TCyMclu0
 b47t8JFW5b5K76G4nwkGUJdoiJWRou682jBBRi5Pdy3YcaxPLLl7uRVHH6vx40bfmKJD17TQr
 pA0wNTBy2vFs/m0i4W1Vk5HUNN2UC/jcOZSM8YOd3KaWAB+ESX3hNC8+yKBM61eU+yJNjZraN
 TFTPsF2e+Dy0oK2scl+nbcgQireCEpfpaUmCTzIHTbnzmbwjqFRPgwrbkIngTFl6LUubZLQSi
 YREprGrjpw8XNe4RdVE8pf7ouf+/h6nqNh4FKT48O2Rjud2Dx7pfFIDpKBCAUJkYirh4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading throught the new driver, I noticed that this cannot work on
big-endian CPUs, and the old DAC960 had exactly the same behavior.

To document this for the future, add a Kconfig dependency that prevents it
from being included in big-endian kernels.  Since the hardware is really
old and we never had a working driver on it for big-endian platforms,
it's unlikely to make a difference to users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index f07444d30b21..640cd1b31a18 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -578,6 +578,7 @@ config SCSI_MYRB
 config SCSI_MYRS
 	tristate "Mylex DAC960/DAC1100 PCI RAID Controller (SCSI Interface)"
 	depends on PCI
+	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
 	select RAID_ATTRS
 	help
 	  This driver adds support for the Mylex DAC960, AcceleRAID, and
-- 
2.18.0

