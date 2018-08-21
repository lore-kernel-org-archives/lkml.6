Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F932151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F932151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHUX7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:59:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUX7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:59:44 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MGiBd-1ffEyf0cZV-00DZMT; Tue, 21 Aug 2018 22:37:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: fix menuconfig presentation of ACPI submenu
Date:   Tue, 21 Aug 2018 22:37:33 +0200
Message-Id: <20180821203750.2394352-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:eGZyrbTrHR7YXv/Uq138j0BUGeIZBM0TIhQ1EIOuYR+54oY+tXJ
 gwqyUgcP15Bz9Cmvv3rGF8c5npVeaWHeRKRXK1NDgWMfKoPL1lv9INAZMZUJ8MAcx85UcJK
 nAvtFOWYA9plTZdzY/Aqxg3SKHtrogYyPppIyoQ0nYPzO74Zomd8ej0HAKYwwZLaOA2IJi4
 3x8HeJ9TANwa7vhxWSZpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MU/25j/+BrM=:YYCBagmsGld/hFGC0RPLkp
 44mCvoZQd3m3v1ApKigGSFHOPiKd1LQVuR70cPUqFJN1Gy2Ka00cCU2L1uDegi27nrtFK7kTe
 YVZxR2wZAKv8b/bUQzMjF+LzgNV9xLsIDuCiQcf34x34xmeqtAUddJL/8Qn9bu4DKK5jcnZE6
 Zegi27PSqNO2OfbMDjLZdF4rVK8Wp+RyaMbgmX4DC1WtA/IJKxHa8r06B1MlPYo21LnqIMMaN
 Z5BO63XGjopL8+HPTVwRYNo7Pp52NosbQONsbQsZuzRaumQIsZnurAVz9j+FzWPjRF0T8e0a5
 OyaLiQpsKvELqgHDiVYFeFKMWWwBf+VWGq4rdtoGLx6Ug3pGQEOzgZ5a4sO/J1V0y4OOdtLoz
 YGUZi5E+d5bXQP8imBN+SCViwjOxvshx8FN+/p6extmJFUykx92JMIeP8rUwOxDHIKwBRzrO3
 IBXpiiLLPyWldKKaRe5W3mJ6dDNuyA+24/W0GpUCOPrM67FP0HQzE37oLNm7nXlMf1RcYx/iU
 /npK5+A9A3Wln4JzDSD5DZqRJz/qyj9v6Kj6R5gfrzsXYtAsf1ApmZvTuXLBY4ASccBI6JUJr
 IQNho6ur4YK9F9flTaWwvWtpMC+rT/YQ3/QX0ZWC4MU8fuK3gA4Zh1Pwt9CtVaC7/cly47Mpg
 ylOCQFmcoJDFdre6obp6na6V9Qw/pjf1nLSdxshJNyk2S4E+2vKyOIxdspl7+nnhYpBY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My fix for a recursive Kconfig dependency caused another issue where the
ACPI specific options end up in the top-level menu in 'menuconfig'. This
was an unintended side-effect of having a silent option between
'menuconfig ACPI' and 'if ACPI'.

Moving the ARCH_SUPPORTS_ACPI symbol ahead of the ACPI menu solves that
problem and restores the previous presentation.

Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Fixes: 2c870e61132c ("arm64: fix ACPI dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1edca05ee0ae..e92eab1e960c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -3,6 +3,9 @@
 # ACPI Configuration
 #
 
+config ARCH_SUPPORTS_ACPI
+	bool
+
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on ARCH_SUPPORTS_ACPI
@@ -40,9 +43,6 @@ menuconfig ACPI
 	  <http://www.acpi.info>
 	  <http://www.uefi.org/acpi/specs>
 
-config ARCH_SUPPORTS_ACPI
-	bool
-
 if ACPI
 
 config ACPI_LEGACY_TABLES_LOOKUP
-- 
2.18.0

