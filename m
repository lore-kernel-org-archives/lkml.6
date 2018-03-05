Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-819802-1520233375-2-10529895418113256111
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enroda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520233373; b=RkH6VRDMI2ykfESp2HCiVXmexDFfshTU/kzXhLbgtgq/IFt
    3P0MVyXQRlsbjqDAF4p2DFcTz1ubfPYimsQubwonvywtBvJk92ArU+knHW/1MBUu
    ZJH/Y7call32eS65nh8or6ZLyg7bmkG53ALNmH9c2ndRj5SlgKOZXsaqvG64SxlZ
    bsdkf8i9atODkE1hrhVUJzBcHA/vD438jtxbiClOoawuc+4D6iEaRJgQE4+PvhMe
    mho6kmnFvFBo2zMB5n4xa2aNhkGAF1+ujZm4UDJhVThbb2BEz1O7AOKWq4w6YESx
    6ZDFmDc35cPpyR6LEzm//nniyBo1ge89eCHOtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520233373; bh=2
    XbfjnN331D/AMhGhP0PBqiQ32vbCv55LRg7yoBiV1E=; b=oq/dVJJ/5vTh3gWF4
    +jHtLLxZwQx7N0SlUQEJHQcT01LbJfZmc9XdCXhNd752E+vRirFR4sukyxsnK/9e
    B8iDbzA9uV4qGx5XH9acfd74cYAkcCAhhFq/iPiY09kYLvibL70wVxSk+wkzk783
    Msclb6H3KTR6FoHsxE7P/YrO8M9AcJiwXgLH26reFFaAHD7KMpkzsJpiHOfNau1w
    4BHVd2ju437kX+u9wEJ8mJOobB65IwPumX8ATE6FusCR3Fi0kvAjBQPy632itxig
    9TLqvM+B0URy2HGmvwo0uaVy8KM35iBq9VsNS/x2C5L4wjxgdmhc7wSRH+INSAqX
    y3lxw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon,  5 Mar 2018 08:02:16 +0100
Message-Id: <20180305070219.7131-3-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
References: <20180305070219.7131-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 3/6] staging: pi433: fix CamelCase for afterSyncInterrupt
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

  CHECK: Avoid CamelCase: <afterSyncInterrupt>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/pi433_if.c  | 2 +-
 drivers/staging/pi433/rf69.c      | 2 +-
 drivers/staging/pi433/rf69_enum.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 57db806ff5af..730200597218 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -209,7 +209,7 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 			return ret;
 
 		ret = rf69_set_fifo_fill_condition(dev->spi,
-						   afterSyncInterrupt);
+						   after_sync_interrupt);
 		if (ret < 0)
 			return ret;
 	} else {
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index fc4919711477..a73a3d2c0685 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -625,7 +625,7 @@ int rf69_set_fifo_fill_condition(struct spi_device *spi, enum fifo_fill_conditio
 	switch (fifo_fill_condition) {
 	case always:
 		return rf69_set_bit(spi, REG_SYNC_CONFIG, MASK_SYNC_CONFIG_FIFO_FILL_CONDITION);
-	case afterSyncInterrupt:
+	case after_sync_interrupt:
 		return rf69_clear_bit(spi, REG_SYNC_CONFIG, MASK_SYNC_CONFIG_FIFO_FILL_CONDITION);
 	default:
 		dev_dbg(&spi->dev, "set: illegal input param");
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 81287ce6be35..d82d2be88cbd 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -114,7 +114,7 @@ enum flag {
 };
 
 enum fifo_fill_condition {
-	afterSyncInterrupt,
+	after_sync_interrupt,
 	always
 };
 
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
