Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeCVUVK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:21:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34851 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeCVUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:21:03 -0400
X-Google-Smtp-Source: AG47ELvNqKEs5LkXiRqY3KTqQ0CyZSr3miLaNnw1i7zZOpQ4FP2mg/srn+ulL+WR0ig/88DQrfFcOg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 13/19] powerpc/52xx: Add missing functions prototypes
Date: Thu, 22 Mar 2018 21:19:59 +0100
Message-Id: <20180322202007.23088-14-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototypes were declared within a `#ifdef CONFIG_PPC_LITE5200`
block which would prevent them from being visible when compiling
`mpc52xx_pm.c`. Move the prototypes outside of the `#ifdef` block to fix
the following warnings treated as errors with W=1:

  arch/powerpc/platforms/52xx/mpc52xx_pm.c:58:5: error: no previous prototype for ‘mpc52xx_pm_prepare’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/52xx/mpc52xx_pm.c:113:5: error: no previous prototype for ‘mpc52xx_pm_enter’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/52xx/mpc52xx_pm.c:181:6: error: no previous prototype for ‘mpc52xx_pm_finish’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/mpc52xx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index e94cede14522..0f6b3cbb119f 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -350,14 +350,14 @@ extern struct mpc52xx_suspend mpc52xx_suspend;
 extern int __init mpc52xx_pm_init(void);
 extern int mpc52xx_set_wakeup_gpio(u8 pin, u8 level);
 
-#ifdef CONFIG_PPC_LITE5200
-extern int __init lite5200_pm_init(void);
-
 /* lite5200 calls mpc5200 suspend functions, so here they are */
 extern int mpc52xx_pm_prepare(void);
 extern int mpc52xx_pm_enter(suspend_state_t);
 extern void mpc52xx_pm_finish(void);
 extern char saved_sram[0x4000]; /* reuse buffer from mpc52xx suspend */
+
+#ifdef CONFIG_PPC_LITE5200
+extern int __init lite5200_pm_init(void);
 #endif
 #endif /* CONFIG_PM */
 
-- 
2.11.0
