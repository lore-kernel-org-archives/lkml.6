Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9B72081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9B72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeKCAkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:40:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKCAkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:40:12 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MAwoL-1gPR4S2Y6z-00BP6i; Fri, 02 Nov 2018 16:32:33 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MAwoL-1gPR4S2Y6z-00BP6i; Fri, 02 Nov 2018 16:32:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: skx_edac: add ACPI dependency
Date:   Fri,  2 Nov 2018 16:32:06 +0100
Message-Id: <20181102153232.1450251-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:jaLl+3J9f4Lwte3a8XV7JXCtKcDsfPjBhAViM5pN5G41Kv0IogN
 g5qRz9/MlOVF3RYd0owQXka/VAaEQRqMQaOZYdbI9/HaMRSQGTd2xDJsUhZ9qy5DhePHjok
 R6LUG/m12NKxQUQylwKryP21L8D8RbhPkSZiW8lsqc15j95mna6WTBqluwkE850p04QCDu0
 8BrtvWU5Cb+HNiJhviiow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OvvBWUZRUEA=:eMUesA3X/eXgHa/Ai14pBF
 97j0kvKmrYF9wokFzvpmwZojPY/rgV4yTC1j15ZX5aFfX6vAup31nt9ydewcc+VE8qwI8wvCn
 Bf0g7+MjIyrAKnZ8yX0zJWiXy2iKLwIIwAcnQzejaDrTyKCXiT8jOrm5ef1oF8fOsNXEn9tup
 D6BUH7bRvOLMKBTuohQtbXnoVOqlfFK3iBbWiSs97zEo++Z9VDW7LZv0KHLv1wxRIX+nZg2YP
 dkTn3+LRgEIvBLkR41RATkSA/b48myjb7dlO5PZP07Kx8o/gkhv6rQgAHRru2uAbC+sGm+9Xs
 lOst5V5paT4CCbj6F3Genb0UgTT5AeqcPlqKMirIPzWhsWirVe47U4xVTfPZgBCbOTQelTWfV
 7KLcvIL9kjN0EPQa85d9M4FgjurK+58eCFeucltr6ujaOK/fICWoIpeN6J4EPAgkVf7IgitiE
 z9oM0PD3Pa6q/3/8/eSPHJtjtlUgqTe2q9xPLyyiptrhnoiH/Nq1EoBuo8De5emAbbWe4jHrT
 ymWgUBAyePX95KUP8hZXlFXlYwNK4YiXZaU3L6GZR1MCFQti1Z3kqmSju0G5iVM4XynrgwbI+
 GbkzicEHrkQuRMeNZrHIjY76M/quui2jEo1044X4s33HWckxZ0mx8K77YpOcngePjzrI0lHML
 /FzHPelFOV2IDQEnvhJxAdakQKfI6gM6Eefs45ZlrehdREz73iBGKFeI4BahiPwAaGSA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot currently select ACPI_ADXL without also enabling the top-level
ACPI option:

WARNING: unmet direct dependencies detected for ACPI_ADXL
  Depends on [n]: ACPI [=n]
  Selected by [y]:
  - EDAC_SKX [=y] && EDAC [=y] && PCI [=y] && X86_64 [=y] && X86_MCE_INTEL [=y] && PCI_MMCONFIG [=y] && (ACPI_NFIT [=n] || !ACPI_NFIT [=n])

Add a corresponding dependency here.

Fixes: ad6e16059d8e ("EDAC, skx_edac: Add address translation for non-volatile DIMMs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 41c9ccdd20d6..2397e1d2493a 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -231,7 +231,7 @@ config EDAC_SBRIDGE
 
 config EDAC_SKX
 	tristate "Intel Skylake server Integrated MC"
-	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
+	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG && ACPI
 	depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m, EDAC_SKX can't be y
 	select DMI
 	select ACPI_ADXL if ACPI
-- 
2.18.0

