Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x226UJLNVCGBSnltdAU4w/eGgh2JTN3v3anrUlqEhK0tICzQT+lj4z9wMprZZN6FCXQE244AE
ARC-Seal: i=1; a=rsa-sha256; t=1519127885; cv=none;
        d=google.com; s=arc-20160816;
        b=YbkEgT7XsFxR9icgv1/A3OdBfTUmVUYmWAFTjy9YXcDQ8iv5k7OiuuvgI/FJoUVHoC
         DtAM6zi2j2eACMTHi79BAWzHfAbIqMooIaUBZW83khk2S3z/O7j7ZP2cHMufFye+GGlH
         UjneVjtGhQiSiY3uksHpth1GZ15iZlSAQgEZ+VxtPz5oPr+H1LSwDvDUo3AxIgsY9+oP
         ypHo/2Y4p9NRa/13Zk5i0mqRC/BJYMb9D5FKE45/CXUiMEmRQj6WfaJAnZFslEg1SLmp
         ROsdGR4kOWffqtvhnLnk8+YlDCw1fjlj3ujygLdGYu8hAZiGGWA5bZWAiCiyNUApiPid
         Wjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Z0S1j3hz8v2hsL211MhMKIP9Xvjd89cEAimb7ZObk00=;
        b=akPnCW2k7IssueenyxPHnUs/UY21Mew9OTeSXAP7W9RFhTH6F3SK+HNcEb/+2irvIQ
         K5TbqjKYaOQE8C2phIeAUH/ORQC6TWc1Rx61aWyrsuClO/eJCOCl12isFmCwxutUTlct
         DNRtBsiUg3o6QurHZxN4z5+3SjmL4sUzH5dtNBib+j00RSsv0Yb3eRjxO2syQ5k8PoJi
         RKDcC+nwHddkx/6nZsBpm2T7qSPvKmdr4nLVeBXLU4yuWBxcqCo2oETZhZI6LV7Z6OcU
         A84J9BlyXdc1q1FJxjEu2G79s3F/qUZwlZN5scWILHtp1mXFjDXdM/IT9a0WKwyJQo0J
         jaxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [4.4-stable 06/22] idle: i7300: add PCI dependency
Date: Tue, 20 Feb 2018 12:54:53 +0100
Message-Id: <20180220115527.1806578-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:audqB6t/TKtFuP7xXeMHPpE15je6SNsN6H29ASBsGwcioxtYxRx
 INUR8GjMlOm43y10rc36MBBp7GfQm/mg4igCeVntvN+ThKmVstnxtiWGKB/XbWgXsO6m7sB
 eFojdYSVLtaX67YAJBESmc7f3hSMnDEZhTbsu830GvG2TtkjKLP7g0pXarRAioASPdmYkiD
 OSChE2TjHQmK2tC3eAobg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lZtYoJsoWZA=:BJeO4JbQV4m8JykqZ6CqS7
 KwXBYO2ehmblhpNY8gpFCiZ+Yj8eZIpDdatDkLInfcvGpLc6zBWLJ0H+q81uTwOwuX8xoa5lu
 Zfk7ej+cg0qo52+Gi23le81/FVrNMC0yAdUt9DA2vV4UhZdK4la6fUCJIHt4YaebYPIff66hz
 eo7jo6SNJtUBCdhlqb5TL/DpocZeKo0/qSYsA6D0X/llUlneq9744vTrm87qo96sYqKaf71b7
 5/M1PgBL70EdjnksKNXAIkhw1XUzpdnieaiqwyAyLJuN8vfwAZYKSHGU+RBoGIhjlzx4jb190
 U5qRAeLw+En+4Hdd+lkf23gqiiQaWd7/es/h8l1GF9GpB/Rz0Q7b7RwIz9JsLDPX2m2kXTErk
 WBo95NA3jpxRJ1VxbO4LGkBKNscVIxPBcYwkwxNa4ENMB63tBet71pKZPQOQ0+10v5NnY3qWH
 V2Fqa7IrUoLH+voV4t/U7wmizQ9piecMbjWpwxQMkFqW3R+WEfHiOmt4+YN7oA8oDfVuTgidi
 RUaNJmM3CIiu4QbbDdchdAhqWH3qMZYgSfQcCbb4WLQEYJRvaCoC43Vf/PRR72WO7J0E4Ls7U
 ZYtjB4gPzzthK1ZlxXpJYBMMepc+ZJ/PUyHBbRrj/DlO/KFwXixjJlP10QYhlT/y2DlFIty4V
 hkM3378n3r80lP8LHHwvbfLY2+KVqBRWiHSRuoX3hSnGQlFfONQlqfZHMitwEb1eHt6Old3qq
 o2V/aJM+lLLLVsG5tBPeUGjAf/27ujKRUwNw5Q==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921042301620209?=
X-GMAIL-MSGID: =?utf-8?q?1592921042301620209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

GCC correctly points out an uninitialized variable use when CONFIG_PCI is disabled.

drivers/idle/i7300_idle.c: In function 'i7300_idle_notifier':
include/asm-generic/bug.h:119:5: error: 'got_ctl' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (unlikely(__ret_warn_once && !__warned)) {  \
     ^
drivers/idle/i7300_idle.c:415:5: note: 'got_ctl' was declared here
  u8 got_ctl;
     ^~~~~~~

The driver no longer exists in later kernels, so this patch only appplies to
linux-4.9.y and earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/idle/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
index 4732dfc15447..331adc509f3a 100644
--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -17,6 +17,7 @@ config I7300_IDLE_IOAT_CHANNEL
 
 config I7300_IDLE
 	tristate "Intel chipset idle memory power saving driver"
+	depends on PCI
 	select I7300_IDLE_IOAT_CHANNEL
 	help
 	  Enable memory power savings when idle with certain Intel server
-- 
2.9.0
