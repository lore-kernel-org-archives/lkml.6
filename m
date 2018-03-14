Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2597699-1521060277-2-10913138215385067929
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521060277; b=ko6FutG4zFbUjUU1SG9AF35s3VDM1pYYqQVW0Ue/QfxpYNu
    BjXbMWw/qV3TPxhdgPKOMg7Y61tXxbTaeIFMO+YofoOOS2o/XX1o+4O9j1FkOX0H
    wtoov9JJSz8Qx2h6dvijEn1G4zquIu4KyXWkJ1BWii2ot/Z1n50IE7ScomOsMvKQ
    vFG6PsmMk2Lzxll60UYJF4PTVytAH+y782SJm5cP43omDocXVwLlyJBtkW6woIGi
    zbq86DufqAFkvGFcXdRwbhPT4Zs/m4yUncjmg7/+hB24yeD8s7AnB/JiQopgij41
    HttYFdWkUO5DAwtdmBh6VI4RsPDIC+nR39Iy7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521060277; bh=+
    PL0KCdUbv3OPtTekr2TapH6opGjh2IeLgDU/4Mdk6c=; b=oMfBlHx5I6ShdLG1K
    c5lqQxH0wKhb9V/ltDOJGM97x6hca13Svfhk9mWl1C2nkxFuE9L7Yzf9cWOd56TR
    +ZiQs38zgxtr5fCYe/Oz9PI3NaCpvdEk9ZLS9SKwVffT23u/KvBFpt6jTSGIKoTO
    QBfPLMz+OX0oDLvKtGMy+OcwNwXYP+kDkfybJh/cAKLjxMoZfqyBU2ikmlxGb9Yw
    CCX6Vw2rElFqQieyOona2Ankw/TWlxaYCPDIb7HP/uz8EUZNr4DRyG4dHfcVuIeM
    D9kCHr5JT7yPzj2BTG9mbXZSAYNS2N8hS8kchwSvWKRMEiQT6naLWZxaZ9rKpz8A
    o/lSQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 14 Mar 2018 21:44:07 +0100
Message-Id: <20180314204407.2777-7-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
References: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH 7/7] staging: pi433: fix CamelCase for dagc enum
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 =?UTF-8?q?Luca=20S=C3=B6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch warnings:

  CHECK: Avoid CamelCase: <normalMode>
  CHECK: Avoid CamelCase: <improve4LowModulationIndex>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/Documentation/pi433.txt | 4 ++--
 drivers/staging/pi433/rf69.c                  | 4 ++--
 drivers/staging/pi433/rf69_enum.h             | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
index 3bb38644eb6e..d0b7000faafc 100644
--- a/drivers/staging/pi433/Documentation/pi433.txt
+++ b/drivers/staging/pi433/Documentation/pi433.txt
@@ -215,9 +215,9 @@ rf params:
 		Allowd values: 0...7
 	dagc;
 		operation mode of the digital automatic gain control
-		normalMode
+		normal_mode
 		improve
-		improve4LowModulationIndex
+		improve_for_low_modulation_index
 
  packet format:
 	enable_sync
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 0bc459e32f6b..5b0554823263 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -751,11 +751,11 @@ int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold)
 int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
 {
 	switch (dagc) {
-	case normalMode:
+	case normal_mode:
 		return rf69_write_reg(spi, REG_TESTDAGC, DAGC_NORMAL);
 	case improve:
 		return rf69_write_reg(spi, REG_TESTDAGC, DAGC_IMPROVED_LOWBETA0);
-	case improve4LowModulationIndex:
+	case improve_for_low_modulation_index:
 		return rf69_write_reg(spi, REG_TESTDAGC, DAGC_IMPROVED_LOWBETA1);
 	default:
 		dev_dbg(&spi->dev, "set: illegal input param");
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index eabaea99949d..493bd0025453 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -135,9 +135,9 @@ enum address_filtering {
 };
 
 enum dagc {
-	normalMode,
+	normal_mode,
 	improve,
-	improve4LowModulationIndex
+	improve_for_low_modulation_index
 };
 
 #endif
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
