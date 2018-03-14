Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2597699-1521060269-2-7990935188866875588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roenda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521060268; b=EhiLR8vvsk1ZUFLnTYjlgbe1rgEjdjErrQNQe6a3z00Zrk8
    bVdPdNtZFVYy3Knl2QR7BSFweU3LeBsQBgzV4l7nOoPTCTayGHdythzmErHDebfd
    dQQA+X1xIYn4EUytBF6b/BlWG7xyd1txgYLx2KdGnZE2pH5SQ/2TLa3QMa4rgLGO
    pj1RUm7Z6Ru+/6zSTH3QHMHFw3iJa7WsqekeE9Sc64g9XNXmkunUhGLL09VhRCZS
    3ZGqVcMEO0y32GNGHfwYjfvyMTctKCHo2ch4/dydP+gRmNscEy61TW0SYMr7dbql
    RJmhpcVWmrKNkcJqfhKG1Z3aJpAjbnuo136J0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:message-id:in-reply-to
    :references:subject:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521060268; bh=u
    +wv+IIsoYeeU53DDWI8tnN5u1B+I1i0iiWdPGsiwN0=; b=WeYhi/5EC2ucOxkuZ
    6xK+/8vRgCaN+OvUggSte5b3mKBWo3S2A57Hqlgy0ZCl514S+80qKheJ22OG9RHY
    PUQO7qlNgdUgIXIBWmB7cGRffVvd1xF7kLNRNUZsAL7Hx48x5uw1znU5OcC4HACv
    0dvBhVgup+kWZgmqPBzj6FRULahplqw8k1BH0YcxTShLRzfDSvFZu+UqZ1zMVkpR
    ci2aVIewNNHzkA34ENFDIpFjcJAS6nGiQZy22RNX72q2ZC7PXouNqZMN/dHudlwq
    LJVBtB6GfXn7oL9xZrelxX0/hFTQsDK8KoGkq9x8qUroRll2ov5dRUUmN1eHK+GU
    DBKQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
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
Date: Wed, 14 Mar 2018 21:44:02 +0100
Message-Id: <20180314204407.2777-2-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
References: <20180314204407.2777-1-Valentin.Vidic@CARNet.hr>
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: [PATCH 2/7] staging: pi433: fix CamelCase for preambleLength variable
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

  CHECK: Avoid CamelCase: <preambleLength>

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
---
 drivers/staging/pi433/rf69.c | 6 +++---
 drivers/staging/pi433/rf69.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index e5c7e48a3b86..b2c54999b022 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -590,7 +590,7 @@ int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold)
 	return rf69_write_reg(spi, REG_RSSITHRESH, threshold);
 }
 
-int rf69_set_preamble_length(struct spi_device *spi, u16 preambleLength)
+int rf69_set_preamble_length(struct spi_device *spi, u16 preamble_length)
 {
 	int retval;
 	u8 msb, lsb;
@@ -598,8 +598,8 @@ int rf69_set_preamble_length(struct spi_device *spi, u16 preambleLength)
 	/* no value check needed - u16 exactly matches register size */
 
 	/* calculate reg settings */
-	msb = (preambleLength & 0xff00) >> 8;
-	lsb = (preambleLength & 0xff);
+	msb = (preamble_length & 0xff00) >> 8;
+	lsb = (preamble_length & 0xff);
 
 	/* transmit to chip */
 	retval = rf69_write_reg(spi, REG_PREAMBLE_MSB, msb);
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index d83808a5dd86..78366f251084 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -44,7 +44,7 @@ int rf69_set_ook_threshold_dec(struct spi_device *spi, enum threshold_decrement
 int rf69_set_dio_mapping(struct spi_device *spi, u8 DIONumber, u8 value);
 bool rf69_get_flag(struct spi_device *spi, enum flag flag);
 int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold);
-int rf69_set_preamble_length(struct spi_device *spi, u16 preambleLength);
+int rf69_set_preamble_length(struct spi_device *spi, u16 preamble_length);
 int rf69_enable_sync(struct spi_device *spi);
 int rf69_disable_sync(struct spi_device *spi);
 int rf69_set_fifo_fill_condition(struct spi_device *spi, enum fifo_fill_condition fifo_fill_condition);
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
