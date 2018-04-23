Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbeDWILc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:11:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbeDWIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:11:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] powerpc: always enable RTC_LIB
Date: Mon, 23 Apr 2018 10:10:25 +0200
Message-Id: <20180423081114.1813726-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:zHC5cDvJ4I0YEcbUZTRFCgoXtCwXB1uIyBYT/fjUYm5JgsYfV28
 WbVlciXx6YZBE75jhoWJ47JMuSiWI3Rg0WwZTgDHA7XYNaUWKohmd8DWk9NRHwv9fqKk1Xi
 qlJiW6xHLz+JeY0vm6doM0kGCc1ZeHZ0a822JCDu8ZrIwpn1mjSPH/tq+QO18ibPhgPdJFr
 h/C8ANmaVfGQnGPlNKRMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8Xb52kNxDeg=:WkLx3KFEZMwKUTQtAwvD3u
 LVYdIErgaSsMk4ytvGlPGxTmBhJuJGf++LpLviEpeVQsjq9cp6j701OLX9QE1UOrKvk6awNV5
 1Of21RoDreY5YA/eegHM4WGdLRYB/lGmcTDVvUOoW8pcywSOb5JsOX8Tv6hqfiq4/6oUjBOFM
 ezjw5QPrhpoMZqf0Qz/KvpMCuRZA+CxVZW7vrlVZYQFvf9OPqvW55ROnlZBXzpm5RnxqhALRM
 1KHSHaEQKzM2qS5JLf5juv14ppbDPINBh3rrXMaDGzwzr/tVTLZ50uypsZpuTiOj6+Brn9vA1
 p/7N9Sfmbi14CpTHWemEIV7sGR5hJ2pzTPRhZCu21i7oWVo45W/rIL7r9BHZ0J1nTSkI44wuo
 Gfrfu7u9bEq10KX3OIQTvFTMoWV1wfWFqRFFmcOoXjUTqKJ9DUugtrwl3wOeWNOTHkA8R0o9h
 06B08hVxTdCczPT6I4YhIhuIlr3Q+JRR0kYVYj6wrNJQBZe1j6jOzULaLPrn97SSpuoaYqSj6
 wg/UkAAUA46Ot8f7o0FBJbwg7MDwE/zjxGY656V/AERypsfSJaCtWojgpLGYTsaqP/z14vHca
 STChZ88QTZJmVJXJyj32gm17aBz8m/Nw3iSmmkUooWUA04ee8j4fI8IkxtFcSHdWOqpmTw6bj
 y/lHQVqn85dRv83YLKzkX/4weqj9YtJOFQ/Tp5WQYUBRWoEJiRYBlInKBWiQHGhHXLykC2CQ9
 u4Dq8rnxallYXnTGD7N+Iqy9F8oCUsBEv3/PcA==
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
