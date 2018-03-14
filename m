Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCNPok (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:44:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34685 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeCNPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:44:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org
Subject: [PATCH 20/47] media: platform: remove blackfin capture driver
Date: Wed, 14 Mar 2018 16:35:33 +0100
Message-Id: <20180314153603.3127932-21-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:1OLt0KgLmA5OwZu96CFwvLXqzUfWu9xvmvKLV0m/i89eApdhTtw
 4qtOHmEBZ7AeI20nBeQ/rtcYwnye9dhApE3EQsduZVt+qZK/Vv9k2VvKmFMoHK+k+RdMr22
 vm0DPQYmPXpB7dlWHgN8GcfNaFOxNbrVS8/aLM3ZvHywtTuG6Mez61uI+rZhZvryYvQtOLH
 wvPIklfNTUjUIU5ap7cVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+oL9f0mgSfg=:+2Abs6TwLvIRxE1rQ72EbI
 3mo0yyBwuTE7UCB4FUhrMJ0AYp0rtFm6NZ2QjRc1HufkIIwtGGFf5Tre8FV54SlU1pb1hAJ5p
 wQlMQAxadgIHgfymOVh8OxxOd6jhJtyuiwmoQqRcVv9tmPXdWPJSWkbBW+PsSw9ph48KP7JUU
 F6j7dgTfBhDDby2eNTxhhYYOeHU8P+x+6sqHBRvBiVTcHMCTEvIgoH32Tgn5UvwWD0hF2/NkW
 Wg/7W1s+Oke/bXbtzpQW5od2JKbJgaDLWfjo7+VWXiyqmdVWvu2ObdBcbb391UryADW8wnsVe
 GyigMHUL1U3B7jLILGOzEPy9m15qStKKKuL4lIGKuJETQtPftOFwF6rSRl0XuJFmvuNyYzWdo
 98jSoPIHqWWVSTtZYGxuL4tOTPie1vfTS/sNoJVFj9wi/u8tagepKTUP5wn0vxyWHR8avZaZy
 9FqnryHg29xNAdZkyqbbkZums/JGATkjLCB1rZkDJ/RZi8PjYSCb7KejQX+jISEcaAZGkQ52d
 EQYRFMND3xZlWURGiarkDjAdca1bMb9IeAuBHWXo6zk2XNnE2WtNifc/u1r7CE698eooSrSP2
 BzqtyZYSjdLXp55ERygDGxDWrSw3zai7ES6G2I5fMEIB3miZ5drQqEkej9lKmXhfa6mqqHyPH
 i5sTQFaNtvCxD/yk8HCNSBKRb+22yRSF91rQDtLqh/tIX6H8dWf92Qhx9XslnmxjlawVSZaUx
 tWV44bzGaxP5+pcWecSLel2xry5pLqT7R0bz9Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so the video
capture driver is also obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/Kconfig                 |   2 -
 drivers/media/platform/Makefile                |   2 -
 drivers/media/platform/blackfin/Kconfig        |  16 -
 drivers/media/platform/blackfin/Makefile       |   2 -
 drivers/media/platform/blackfin/bfin_capture.c | 983 -------------------------
 drivers/media/platform/blackfin/ppi.c          | 361 ---------
 include/media/blackfin/bfin_capture.h          |  39 -
 include/media/blackfin/ppi.h                   |  94 ---
 8 files changed, 1499 deletions(-)
 delete mode 100644 drivers/media/platform/blackfin/Kconfig
 delete mode 100644 drivers/media/platform/blackfin/Makefile
 delete mode 100644 drivers/media/platform/blackfin/bfin_capture.c
 delete mode 100644 drivers/media/platform/blackfin/ppi.c
 delete mode 100644 include/media/blackfin/bfin_capture.h
 delete mode 100644 include/media/blackfin/ppi.h

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 5d8fd71fc454..2136702c95fc 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -31,8 +31,6 @@ source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/omap/Kconfig"
 
-source "drivers/media/platform/blackfin/Kconfig"
-
 config VIDEO_SH_VOU
 	tristate "SuperH VOU video output driver"
 	depends on MEDIA_CAMERA_SUPPORT
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 85e112122f32..2b07f2e2fca6 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -53,8 +53,6 @@ obj-$(CONFIG_VIDEO_TEGRA_HDMI_CEC)	+= tegra-cec/
 
 obj-y					+= stm32/
 
-obj-y                                   += blackfin/
-
 obj-y					+= davinci/
 
 obj-$(CONFIG_VIDEO_SH_VOU)		+= sh_vou.o
diff --git a/drivers/media/platform/blackfin/Kconfig b/drivers/media/platform/blackfin/Kconfig
deleted file mode 100644
index 68fa90151b8f..000000000000
diff --git a/drivers/media/platform/blackfin/Makefile b/drivers/media/platform/blackfin/Makefile
deleted file mode 100644
index 30421bc23080..000000000000
diff --git a/drivers/media/platform/blackfin/bfin_capture.c b/drivers/media/platform/blackfin/bfin_capture.c
deleted file mode 100644
index b7660b1000fd..000000000000
diff --git a/drivers/media/platform/blackfin/ppi.c b/drivers/media/platform/blackfin/ppi.c
deleted file mode 100644
index d3dc765c1609..000000000000
diff --git a/include/media/blackfin/bfin_capture.h b/include/media/blackfin/bfin_capture.h
deleted file mode 100644
index a999a3970c69..000000000000
diff --git a/include/media/blackfin/ppi.h b/include/media/blackfin/ppi.h
deleted file mode 100644
index 987e49e8f9c9..000000000000
-- 
2.9.0
