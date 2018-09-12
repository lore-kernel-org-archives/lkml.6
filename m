Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C19C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BE120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BE120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeILUUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:20:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57885 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeILUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:20:47 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2m7Q-1fqMwK0c1M-0138WQ; Wed, 12 Sep 2018 17:15:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/17] compat_ioctl: remove PCI ioctl translation
Date:   Wed, 12 Sep 2018 17:13:07 +0200
Message-Id: <20180912151422.571531-6-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151422.571531-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151422.571531-1-arnd@arndb.de>
X-Provags-ID: V03:K1:16boItyQJqAAjoblHWeigXKi0Y1vak+TqvOsJf/iQQkL8a1DBec
 ItX1kkSVdustKRX71Ese5MgtRRuyPFkErY3wuO7KY+yT2YGDv60E1Oe8W/JhrKRew7yMrdh
 EXbrQkl0WEvccr5Mf8+9pp7VzWtLuz3m3sXBeBLBI+xoxfrkNwxWRKcttVt+d3ruIUABXTO
 s7o4DXLcpj1AzisCgjcAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n/KXENKiRpo=:Vzv2h6i8yIKlj0Gg/ie+qH
 eMzasZPLz46HWQg84jAdUVZviqWBjmesax+FxMznlnIHy6YXRadXCrS8MUOtIRFUOIozzGG/R
 4RxLckVYV5cZW5lpyUUNrE+DSFNqDrzaHhyeoXcv5zXAffyUbYjRQrOtUzRTm+5cNVThxpW1c
 HsAvvwlzjZ5xjg0MisqSkKBypckrUzTTXA1PIlUj223hnbAKUfmIi/ovcKYHMLkIJqYVmQ+u1
 xdNyMmfhxwJIAx+/UGWDj9Dao7v/S7hfxm5TTVmBMmpXGviYcmMNHoFehqLJPlLKMdWHnB21R
 g82SBbAryB+AWUrnMTp8onlkd+drhuTveqcs2zlx/HROUUKlTUg09824Abo7Ef+GlsMkRiy8X
 PSTiFG1U1Zv+lMhJFmaf/5nT5SvswkuapT2ybI3US9a41/Hsd/o5+Q4MKkMjT+U/pqvOYIY0l
 dh2vvIBVZK8wODozsuC3ZZ//ImCwWg25h+3UpN0Nrn2vj4WCntRAVwmVJXSoulPk9UnNg7XNE
 az6zfxaUpa+1s4LzA10m97V/KdsRcjtL4VDIHiTh61fkICfzS1N6eQMrOn+BtrH/Zkr4f6VoC
 ekKNMOBMTvwgGW7q/EPn3LVMUg1HzfZ3AG5TLHeDvqXUKHfXE6n8RHZScx3vyiqdh/KgvPYWr
 j1YN3JH2Xu1+7HKXrMNrpTlmpvWkY6/2AFFGUZxLCyEfzpPtOyATANRdvLdyzxY5koDI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/pci/ implementation already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 0e3a879339c2..8510cd652bb0 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -43,7 +43,6 @@
 #include <linux/raw.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
-#include <linux/pci.h>
 #include <linux/serial.h>
 #include <linux/if_tun.h>
 #include <linux/ctype.h>
@@ -810,10 +809,6 @@ COMPATIBLE_IOCTL(HIDPGETCONNINFO)
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
-COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
 /* dvb */
 COMPATIBLE_IOCTL(AUDIO_STOP)
 COMPATIBLE_IOCTL(AUDIO_PLAY)
-- 
2.18.0

