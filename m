Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F258C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6352082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6352082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeKCAnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:43:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbeKCAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:43:10 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MVmBj-1g2pUx1peB-00YzfE; Fri, 02 Nov 2018 16:35:32 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MVmBj-1g2pUx1peB-00YzfE; Fri, 02 Nov 2018 16:35:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Karen Xie <kxie@chelsio.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cxgb4i: fix thermal configuration dependencies
Date:   Fri,  2 Nov 2018 16:35:23 +0100
Message-Id: <20181102153531.1583478-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:qUEQXpVxEVjC3a2WfXlp3ypzaipU73xMJGV+C0oi10E7DdytLbI
 M6yA7M2Lc7esoFio3Fil/K8UMF3DpqEVmUjSEOLuAcmE+yCp8KnKiZ77PcCWTgR3BUSx2tb
 uIsV8UmuPV6d+H5ojZA4tgsugSXagJEqgFomzwOafx6zRNgvGArFfoVkHf63imdEtd7+o12
 d/bsq4k/NxihRatU9XBHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zd4gcr18b2Y=:R6K33GvVWo0ZOsvTY1Nwye
 EUHQtwd3GWPwFRBBSeylWaUrFMQZNUtdCQyjjm3uS3X6C8R/fE3bKJkmw7dak10U0o1JHOV84
 tcSmkV8I4J4ljzHgL0368MEyYFD+l+sKEykTZhZxpbgOX1yTDZgJoVRqJO5zE408Fwi09PgA1
 ygpNDbFdwx8HR2VyV6+/DVmvMuDHIY6xIz8SVJHfRcFmVYgHE+0SaU5tk1hsl7gaCVu07sLJU
 Zep+t1ENOtUxPEn2sBlqVVOZ5HAmIWsiHEHvkkqxwi9PijM30HYvTYP0aIevDOX4G4693zC4T
 i6a6/qUHXP0eWwVDK+tVA8h2n7jU+sUdWa8L5DUQWT3Em7WlvgdE6nRNZEKtxwBL0I0ASydk+
 XGPWfLpQ9qaVqxut5pSblekgYyaBgmK+VpwBpJffprTeIk3qszZ35cYh5gJx3JR5gd2y++gIX
 fweBgqD1tdY19bDhJriahpUEGCDUNs9/gPxm/PelcIUwHU8sqXi5PwOR9Ju8Jb1/aOgQurqS0
 S819n9EjWObyUqjvyOB92m8x5Xd/IGm1jSOxwI7h0v2ofGlrSQ0oL0T/iS/PUB3LbeOOxoqC9
 Z+37sk0CEa2NpIRktG9gm3BmK69v2HKmk4xDBDfDTICwgXMl6si7sZZspPB9+0fiBUxpJV9Mf
 ks751eKcOdw3r5ZI3dCwUwgikY9sA3/0E0i9Xlwpm2PDi1cyvTtJH8FZcSjf+rw748kw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed a bug by adding a dependency in the network driver, but that
fix caused a related bug in the SCSI driver:

WARNING: unmet direct dependencies detected for CHELSIO_T4
  Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_CHELSIO [=y] && PCI [=y] && (IPV6 [=y] || IPV6 [=y]=n) && (THERMAL [=m] || !THERMAL [=m])
  Selected by [y]:
  - SCSI_CXGB4_ISCSI [=y] && SCSI_LOWLEVEL [=y] && SCSI [=y] && PCI [=y] && INET [=y] && (IPV6 [=y] || IPV6 [=y]=n)
drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_init':
cxgb4_thermal.c:(.text+0x158): undefined reference to `thermal_zone_device_register'
drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_remove':
cxgb4_thermal.c:(.text+0x1d8): undefined reference to `thermal_zone_device_unregister'
/git/arm-soc/Makefile:1042: recipe for target 'vmlinux' failed

The same dependency needs to be propagated here to make it work correctly
with CONFIG_THERMAL=m and SCSI_CXGB4_ISCSI=y. That change by itself causes
another problem with a circular dependency, as we use 'select NETDEVICES'.
This is something we really should not do anyway, as a driver symbol
should never select another major subsystem, so let's turn that into a
'depends on'. I don't see any downsides of that, as NETDEVICES is only
disabled in rather obscure cases that are not relevant to the users of
cxgb4i.

Fixes: e70a57fa59bb ("cxgb4: fix thermal configuration dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/cxgbi/cxgb4i/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb4i/Kconfig b/drivers/scsi/cxgbi/cxgb4i/Kconfig
index 594f593c8821..f36b76e8e12c 100644
--- a/drivers/scsi/cxgbi/cxgb4i/Kconfig
+++ b/drivers/scsi/cxgbi/cxgb4i/Kconfig
@@ -1,8 +1,8 @@
 config SCSI_CXGB4_ISCSI
 	tristate "Chelsio T4 iSCSI support"
 	depends on PCI && INET && (IPV6 || IPV6=n)
-	select NETDEVICES
-	select ETHERNET
+	depends on THERMAL || !THERMAL
+	depends on ETHERNET
 	select NET_VENDOR_CHELSIO
 	select CHELSIO_T4
 	select CHELSIO_LIB
-- 
2.18.0

