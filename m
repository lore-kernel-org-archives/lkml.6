Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeB0KHb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:07:31 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33625 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeB0KH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:07:29 -0500
X-Google-Smtp-Source: AG47ELvBykaYpwTh+Uddak6MC6bs5fsTGRh5F3bojKQ3ra3ZE19eIlp2H5xXZQybpKmaIJtPU2qZtA==
From: Sebastian Panceac <sebastian@resin.io>
To: andy.shevchenko@gmail.com
Cc: Sebastian Panceac <sebastian@resin.io>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86: Fix Intel Edison module stuck reboot
Date: Tue, 27 Feb 2018 12:07:00 +0200
Message-Id: <1519726020-24442-1-git-send-email-sebastian@resin.io>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAHp75VfEc0a_Fff1znWVos3rPzCGsvGLGX7NgH_bH96egree7A@mail.gmail.com>
References: <CAHp75VfEc0a_Fff1znWVos3rPzCGsvGLGX7NgH_bH96egree7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I fixed the commit description according to your suggestions and used git send-email.

Regards!

When powering Intel Edison module with 3.3V,
the "reboot" command makes the module stuck.
If the module is powered at a greater voltage,
like 4.4V(as the Edison Mini Breakout board does), reboot works OK.

This patch copies the behaviour from the official Intel Edison BSP,
where "IPCMSG_COLD_RESET" message
was sent to SCU by default at reboot time.

In the official BSP, sending the "IPCMSG_COLD_BOOT" message instead
of "IPCMSG_COLD_RESET" was possible,
by using a kernel command line parameter.

Signed-off-by: Sebastian Panceac <sebastian@resin.io>
---
 arch/x86/platform/intel-mid/intel-mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2c67bae..fb1df94 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
 
 static void intel_mid_reboot(void)
 {
-	intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
+	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
 static unsigned long __init intel_mid_calibrate_tsc(void)
-- 
2.7.4
