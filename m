Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2597693-1521060272-2-13178535040408827102
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
    t=1521060272; b=fYMgQaxOLO/9nrXlCVCb2NtY77sNrm6L6ogL92HsH3PI+91
    c15XuotZTSO7PpgYAiDKbo4nLXdIOBzMAvDHUSa4ftTaHXN3LZxeQXALbQPz1DWL
    mRs3lP/LJN/jCBI3sUqKowuZYhajkubop4ilH36RT6j6XkmCTCMhc4afYLcX6A94
    Dvwdwsi16JWLVsTIgAJ4XTCmFE4oroPDBHVX9V2iZ2WY9gX7ZcfsJvXk+bBNDGYA
    MWMamDqR+H1c7gfgqFl0fJJ19/JVSEYf4/zzV6onraiDtG/QIOLG6s2vvcqGPUlO
    vH9U5oHG8ry5w+Kc5QTzjLbYA2r0sN9GU/PpbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521060272; bh=c
    NGL1+q8G6xDybb8JunTvfI4/KDOPawfkm9zlXBEBe4=; b=KRzkhK966SMWm7EoD
    d03EvWkc5w09YsZk6l5AW3awHon6OCkE3T7HMtAG5Na4iLM5CZwgNY9y0zZ71Pu/
    hW/zunMDlVmyLQeus4oz+pm5QRImTolbzCduv4cOjaUekXzCpmo2JGE6pUYxz6uJ
    jWUuD9QlnZ86BVb0qrRyOninM6xBSg1pYXu0CaIElEyTxglVzEQs7kFVxo1ASvzn
    M68sKCD504VeVefeF+fLvm5h3fW+Z6Ih4KgEUoDdVTJwzww1w8x03L7m5isGMJni
    V6M2d+gUWHpFO05fqNJZQdkM+BOSjzcNrmbpAevMDvNf788sMfXKm0BU0vvG4cXs
    /C2lg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
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
Date: Wed, 14 Mar 2018 21:44:03 +0100
Message-Id: <20180314204407.2777-3-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
References: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 3/7] staging: pi433: fix CamelCase for syncSize variable
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

  CHECK: Avoid CamelCase: <syncSize>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/rf69.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index b2c54999b022..b57d3f4e9321 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -633,16 +633,16 @@ int rf69_set_fifo_fill_condition(struct spi_device *spi, enum fifo_fill_conditio
 	}
 }
 
-int rf69_set_sync_size(struct spi_device *spi, u8 syncSize)
+int rf69_set_sync_size(struct spi_device *spi, u8 sync_size)
 {
 	// check input value
-	if (syncSize > 0x07) {
+	if (sync_size > 0x07) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
 
 	// write value
-	return rf69_read_mod_write(spi, REG_SYNC_CONFIG, MASK_SYNC_CONFIG_SYNC_SIZE, (syncSize << 3));
+	return rf69_read_mod_write(spi, REG_SYNC_CONFIG, MASK_SYNC_CONFIG_SYNC_SIZE, (sync_size << 3));
 }
 
 int rf69_set_sync_values(struct spi_device *spi, u8 sync_values[8])
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
