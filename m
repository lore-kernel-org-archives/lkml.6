Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AIpwx48foh8IrZOix4oPXyL24lywq/c/SwWo/UWMDGswQufFszMIk18AQ5HhJEapL1jEU60S1agt
ARC-Seal: i=1; a=rsa-sha256; t=1524138999; cv=none;
        d=google.com; s=arc-20160816;
        b=wrhg654OeNdlPFJs03Qj7Xn8TvQVyE8N9l24AbmOkgXuySv3g5T7NrN+4lwXaISvVx
         bJK6vfd4C+3wmsD0+qfOqqMIGmiOPDQUPUtF0I+fiz2G6/K1vEpFibAt2gEMfogurCxj
         38dT59KXjUUoDH9mkHSPAadx3QbMsaFxkhYB5zZOEhIxcCy63xQx7DqwIFy5pooy9KLz
         JcUjM88UEHiSyqszqr/8Pq40nDDo98kVRjgjRFVeuwLUXWDjmNic+Gvx7m4/NDY673GI
         rzV9g7Eao6L617Ri1N6snp9wBm6gcR+CNjqFNAmIdX7wJRmDg9qIkC3TiUp/OI19nHuE
         SgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=02DvErvXFEYxLu0OvuYoGpu5MlwvavHRY4ScFK5P8hE=;
        b=jHI7LmySXEvaP9vmJIlYyueZbscUWuso2MGAtK+XilePiz+Xy4tuhPdjJUZydn6gLz
         rogcSQ0hKio+qO1svJNHusIoy+PQHNI0VnHJR8b6oPlGYMvjO5DnbfS70p0EQJ1hA5fe
         +p8jSuQ1uDIeFbCBclJFG0kQe9UukaBiH7CafUPwOON+7+smtS4q6RKg9qQtKizPvNuh
         Z24JNFzEnaPiHwZw8t/n6xzUFcE9tH6fXTp9FNTVGzpJ3hNBnxU8+NoxOTlGgAreRkdB
         Tt6JI5Bu0V2495RH/HWCz6T6mp3uvFjFosursE7LnsKXpmL/skiliLab14oG5U0Dptko
         QvAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>
CC: <arnd@arndb.de>, <geert+renesas@glider.be>, <horms+renesas@verge.net.au>,
	<gregkh@linuxfoundation.org>, <paul.gortmaker@windriver.com>,
	<robin.murphy@arm.com>, <sebastien.bourdelin@savoirfairelinux.com>,
	<bogdan.purcareata@nxp.com>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, <helgaas@kernel.org>,
	<olof@lixom.net>, <khilman@kernel.org>, <tanxiaojun@huawei.com>, John Garry
	<john.garry@huawei.com>
Subject: [PATCH] HISI LPC: Add Kconfig MFD_CORE dependency
Date: Thu, 19 Apr 2018 19:55:46 +0800
Message-ID: <1524138946-136701-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598175575431248949?=
X-GMAIL-MSGID: =?utf-8?q?1598175575431248949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For ACPI support of the HiSilicon LPC driver we depend
on MFD_CORE config.

Currently the HiSi LPC Kconfig entry does not define this
dependency, so add it.

Fixes: e0aa1563f894 ("HISI LPC: Add ACPI support")
Reported-and-tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d1c0b60..6dc177b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -33,6 +33,7 @@ config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
 	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
 	select INDIRECT_PIO
+	select MFD_CORE if ACPI
 	help
 	  Driver to enable I/O access to devices attached to the Low Pin
 	  Count bus on the HiSilicon Hip06/7 SoC.
-- 
1.9.1
