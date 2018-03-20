Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeCTXCy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:02:54 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35104 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeCTXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:02:20 -0400
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de
Cc: nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 4/5] ARM: drop no-thumb-interwork in EABI mode
Date: Wed, 21 Mar 2018 00:02:05 +0100
Message-Id: <20180320230206.25289-5-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320230206.25289-1-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to GCC documentation -m(no-)thumb-interwork is
meaningless in AAPCS configurations. Also clang does not
support the flag:
  clang-5.0: error: unknown argument: '-mno-thumb-interwork'

Just drop -mno-thumb-interwork in AEABI configuration.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e83f5161fdd8..e9e3fde3c657 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -106,7 +106,7 @@ tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
 tune-y := $(tune-y)
 
 ifeq ($(CONFIG_AEABI),y)
-CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
+CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
 else
 CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
 endif
-- 
2.16.2
