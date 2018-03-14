Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2597699-1521060276-2-7354492919671909872
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
    t=1521060275; b=Ars/emOnmqWoKIX8x5eqYRnbShCPeCzMYt5P2Op2RnSeN4E
    YfUgyJAjlvscyWGXBQ3sxZRz2Y87tstgWZDS7GTlskTsnQdfCOaRgNseCiSX9agw
    rqcOwwLX6/3VaJKi6WXiWBlgjvjqO8J3Ij8grl+W1vkpWCzKeFbiPv9baFXA9G4/
    gDUu621n7mIsaV8FifoqJFoYiMdF1ZETxZshBbMecVjvY9z7uQp0JDzYpgDk62DC
    gioxVLBofuYNznxl3MdZ5P/P/m+ty1msIpEM1zPZNgzNG1FzOv7NjEhDfPzS+Xbl
    CMQLlw7livwl5PZBGbivE6Xy1mqRR8B7mIXagxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521060275; bh=S
    g0rXuKxZEn0vg+sc+mYz59HkAFcecX6E7ckC+Me83c=; b=SNHx1O0V0fm4/U8NX
    nS7qNMviZGiuVhfoj4wTy8Crq1yGWADJPih8EtqAnkApvrS9y3YeVhXEqTcfrxTg
    FF3OV78wmDNNDzxo+dgDI5WsFHz6hakGCSYmI3PTzo0GQIpanfxvXOamvg0LQo3E
    IdHi5b0lI6Ft59BiSOYMb37BCggdRKIvvRt7EtlrQPgy1cdm/KBByRYGBXM3TsDs
    wCe7NVK0BOT1rg6R3JNHZLfTuWRbRn6AyyPkzfHpOTkzFnHzuoVkx8CktvnHRfnI
    2dqCZ3sncqpY1s1/eblHR+SbZoYwNn/lLVe/SLV6BzZryyIVkaPQ5vStV2ZSaBLi
    N7Hgg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
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
Date: Wed, 14 Mar 2018 21:44:05 +0100
Message-Id: <20180314204407.2777-5-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
References: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH 5/7] staging: pi433: fix CamelCase for DIONumber variable
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

Fixes checkpatch warning:

  CHECK: Avoid CamelCase: <DIONumber>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/rf69.c | 4 ++--
 drivers/staging/pi433/rf69.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index e11c9cca447b..e3394094f6a1 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -501,14 +501,14 @@ int rf69_set_ook_threshold_dec(struct spi_device *spi, enum threshold_decrement
 	}
 }
 
-int rf69_set_dio_mapping(struct spi_device *spi, u8 DIONumber, u8 value)
+int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value)
 {
 	u8 mask;
 	u8 shift;
 	u8 dio_addr;
 	u8 dio_value;
 
-	switch (DIONumber) {
+	switch (dio_number) {
 	case 0:
 		mask = MASK_DIO0; shift = SHIFT_DIO0; dio_addr = REG_DIOMAPPING1;
 		break;
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index ee22a10c85c0..4d6fc07f8255 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -41,7 +41,7 @@ int rf69_set_lna_gain(struct spi_device *spi, enum lnaGain lnaGain);
 int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
 int rf69_set_bandwidth_during_afc(struct spi_device *spi, enum mantisse mantisse, u8 exponent);
 int rf69_set_ook_threshold_dec(struct spi_device *spi, enum threshold_decrement threshold_decrement);
-int rf69_set_dio_mapping(struct spi_device *spi, u8 DIONumber, u8 value);
+int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value);
 bool rf69_get_flag(struct spi_device *spi, enum flag flag);
 int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold);
 int rf69_set_preamble_length(struct spi_device *spi, u16 preamble_length);
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
