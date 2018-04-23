Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeDWIiY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:38:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754594AbeDWIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:37:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, arnd@arndb.de
Subject: [PATCH 1/5] powerpc: always enable RTC_LIB
Date: Mon, 23 Apr 2018 10:36:38 +0200
Message-Id: <20180423083642.2608886-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:zWvL38seKXvP56XrNeY+SIJ3zKyG1Pbqt5VEep1gY3DXFLKqyeK
 EXHINLugZb6isRtvYVOUvAEFpX6yyRLaMVZrVx1tgY+zbTynqhtsJVlDqOHdvNR/wdLC9vC
 p7lVZTBtCgf3Glnbp28T6XYzskc7pelhzP5hJ8ZRvFSNWZCnf5Jv8XEXiF31UO0PRvmTcIc
 J4yIARrcNuU4sXDW+IEDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NUv5yRseWb4=:UJDT8Mw5NiSYLjWnRIgAPM
 6bfCBb7SSzDj1dDqyL8H9Sb+713n650iQrdWl8wkXG0merynvDrQquy1HVQmU/U/UJfHjhBQF
 c+c8L45MJxdE9PgU/X8IN9jpAMw//WHuNvoYrnmxDaqcAa+dNH8/elMcxiKnwjjMI943jsDDT
 DjPD/8RMPMyC112G4itCVt8Z4/B4hT78is9TYENlhUgQYbrbqCefQ+WDounNotdtAICsDALKM
 7gA6GY84pDHku38D0Sus82b7mXntv7VJ0UZWMozYtS+/e2cRuBOsjD2f4bYr93BfgrnLlf5mq
 keLZt24sOOQ/ap4gbbjvLZudwmc/8NV0wVNrNOnmbn/jCXmbmA7KiH6IKK+9IH8GGGGLdmHUI
 aePaK2kHNvtxy/HAatHzdOcNSKn4OSpDG+/Q71/P1npA4yyVmMHM513/yO88yagWRtMelhlsb
 2bxRW1nL8gwI9iLXrCVA+TGUhRuMOePg6U4LwfH9I1UmwTEr0+ss94KTCRrgjqw0ld0HDhZSG
 Ji/dMo4OmSPnDbSYtGNCHGBUfK9y7wvU1vak0b5iPrZtFa6wwus6NQJJplk+wFCTeZAV0PV36
 IODVHSpI8bbyILxtASEOD3ul37D8UXdxlw0DvDBSfd1OrmSeP1IWGyQLF2s6ioreGwXXqdVRv
 AvJkBnGJWkUqNLcvih6H+YwfCDz5mwZB8NnaQU9gXsW9zupXsQxdKSdDpNdlSQwcdTMdDElGV
 5rkSt2htKeGbCa1HgAfOqi7pH3Fue+kSes7TvQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use the rtc_tm_to_time64() and rtc_time64_to_tm()
helper functions in later patches, we have to ensure that
CONFIG_RTC_LIB is always built-in.

Note that this symbol only controls a couple of helper functions,
not the actual RTC subsystem, which remains optional and is
enabled with CONFIG_RTC_CLASS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181a7cbb..de2cda320fdd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -232,6 +232,7 @@ config PPC
 	select OF_RESERVED_MEM
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
+	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS			if !PPC64
-- 
2.9.0
