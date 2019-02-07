Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0588C2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfBGQlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:41:37 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:59325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfBGQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:41:20 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTiDV-1gfudw2iFh-00U1Af; Thu, 07 Feb 2019 17:41:13 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Subject: [PATCH 1/4] Makefile: add kernelarch rule that prints the kernel architecture and localversion
Date:   Thu,  7 Feb 2019 17:40:56 +0100
Message-Id: <1549557659-19137-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549557659-19137-1-git-send-email-info@metux.net>
References: <1549557659-19137-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:KBgiOyufyzzLNwZNiHBO7KmwXZdh1eooc8JnKds2YVePoQmyQT1
 cyPEpIRzdKG/KXORaIKDU+9LF0CLQxZ4P57QIuJ7cJnck/Iucav36PEF/aonqoP51eDEBcE
 210zYOcm288prCm2pYGmLSAMAXSju6PnwtWfqjRiOGx3CEenSdpu1a33IkwZ6nB3HO3saZH
 wMa6zeJoO6yjK3ljrwEfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KkDDF+JZuzQ=:hzZb60WOTKwvzk8LbjZ7qG
 cMjRBYGsT3SyBXyzuEiiYBMUj5dlfxo6rI3lxBwFNuL/b4t3Xqx8oxfD0V447cZU9s22r/4Id
 itJ0cJhv5il62lGbkl6G1Wx2D0HnnIE7JblDkJJZiSdgKgwmb36mjjUqpv4h7nJG2VUibWHLx
 kQOUDkFTMH8PrKSyANnYpRuP3C1xcmUj8SaX4xxSYo1UYH2aTD/kJxwnrpRSgFXE3U6C7vcZe
 DZgGx4O0LQzO3okwaq2QzJ0HL2tr+VetfdavK67Adi/Awy2MFtcds9U1UOS4MvU97DcgFE2Zw
 4NirqCxbqAxMkYdP2wKxbtYRgbDl1IJAo8/er8QCWODQ2suY88D06c0ide9nd7wSYOGDiD3Ka
 FtgLDkqiBCobACsOYzatjFoM1aeFV1blOM3tjNysDyZVNaBUA9wzPkpbWKnxdv7ca8cQI+HxS
 7dnLxuSUzahDRJgHqTL8qTSbqZkkdmtr+TLn+Py/GTEW0Su512QmnOSZC7b11VF4uq3OGd1TR
 golEKX8DgTPf8HAV2+JqtuTGmiu/6QPkwo0cs3t7u3j5cA2XV/g+6QIpD2aCE//DFn+DHb6pW
 FesJzuCp0rXLxaecIxp7IQR6UkzjXpdFgvrVb94R1/P4iYmuESB+IGU2DD3NfDb/XfK2PIdi6
 uUwzlHTpTVZcvzAsmyt/hmQ244w5iH2uFXDfeDtXVIMdrA8VN+FQC7DT8u5oijQv3un0Fvqvx
 LT0Pn4FeqMixcM92ZWIv8Apqal7VHT933QA81A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trivial rule to print out the kernel arch and localversion, so external tools,
like distro packagers, can easily get it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 3142e67..2719907 100644
--- a/Makefile
+++ b/Makefile
@@ -1664,6 +1664,12 @@ kernelrelease:
 kernelversion:
 	@echo $(KERNELVERSION)
 
+kernellocalversion:
+	@$(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree) | sed -e 's~^\-~~'
+
+kernelarch:
+	@echo $(ARCH)
+
 image_name:
 	@echo $(KBUILD_IMAGE)
 
-- 
1.9.1

