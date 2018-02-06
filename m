Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeBFMiC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:38:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:62696 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752802AbeBFMhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:37:48 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: wii: Probe the whole devicetree
Date: Tue,  6 Feb 2018 13:37:04 +0100
Message-Id: <20180206123707.13715-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:T0XLB246LKK6QD4PZok0juLiiYuO21gSzaiHYu8diB1wPizqnl4
 dyw2XhH0MvUVZb9xclukhB3X2/bWG2ahyMTPtQFdksTK8oSZJ316b697AZlp6VoHPThny4Z
 YGbOR4VAIRFARVy1pUyMkmg3FO+ZUesrgPko/ZYhS3s8ZimIyppuOeF+OSq4Z60BLz0j2at
 0Dz4y63UU6O5Aha7azdOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wUDxFjLZwmI=:8Wr0TqlleogdmHF4TyLQxk
 V7p6eKHU+ZK4K05Em8WwgeYxhwZhslKmRroYUbBoHByLW3Bonsle0+y5lRJFjRAVN6dG7kiPR
 QbarKeMXXxOAJIbeRh8GoyRLQr3zmQzZ33WrMMbSaYieq3jUpu6kW218MAPnDsRccRSE/lRJR
 dMBiktbx+IA/OEhrwkz+daHRbUetwmOJdGiOulG9fqea8jsKhwdeNjU7eJ1UHm1BifkHZniiS
 BVEtg+s0ftFjlt10MS6M8pNh5XgTPhWg/MGZieNEku8wmam5+HADpucPHLkOXMDPcI148TOVn
 hnwcvAuurDupk43mSkpm6vGf6dJJU9/0ivbslyvxJln2FxVow//JcD4MmIkYSN1D63sX9F0/j
 QE3JreWOpK0774jprvPc0O68sUHGRjAsj/XFyhXG3dbYZmtK8/UyLMMx5+QaiMeCrfezDe0dh
 R8stpGPCVVpHnLhh8rLMQBLfItBF82bo1FsgJuRNuzvFL8VMV8eOUORtdRGbOgtyDmld02R2D
 KN7jCMvRAimj5puy2c0NB2Kd5Y+UdcQyx/HTcABlyf2vJ72GEvJ0rsWT5B3yraocMisUp/BHW
 6DMRlB5OQAzI/ZknEUCqpq9ESX/p8P/JK6+5cMdZVUDl2jIyoVoKN6lzXZhNgFB7r/yMlxtyt
 GWJyJjYGSgQGHKK/OncyXKv9mR/vvh4vwZ1xf8uWoW3XjdFg+ZDZTzeyFe4O8Te3X+GlkgCcR
 EBnux1KW2pRW2r3BRJYia3ub6cz8tIo+6JKHJQUiu6peyw67a/MzrY4wSEmCbUyMu4eXQkbAs
 FRF3UhR7f6nWPLMhE9yrpInKlBafxA+NxfO+F90zeUfvdqeTR+qoRn0dcRbrC3hf0AKIOS2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, wii_device_probe would only initialize devices under the
/hollywood node. After this patch, platform devices placed outside of
/hollywood will also be initialized.

The intended usecase for this are devices located outside of the
Hollywood chip, such as GPIO LEDs and GPIO buttons.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index f598d5fe1d72..4de26c3c4f6d 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -248,7 +248,7 @@ static int __init wii_device_probe(void)
 	if (!machine_is(wii))
 		return 0;
 
-	of_platform_bus_probe(NULL, wii_of_bus, NULL);
+	of_platform_populate(NULL, wii_of_bus, NULL, NULL);
 	return 0;
 }
 device_initcall(wii_device_probe);
-- 
2.15.1
