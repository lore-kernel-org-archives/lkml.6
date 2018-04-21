Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2946400-1524271343-2-9785714847929809137
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524271342; b=dwiumFPR7/6/wsz3OSQjI8Ar5pT8bK/iG1OeSAvR+HKKB4jwV8
    wGZGYVT2JkPKSCbB1O49piZ16oA+CRzESiwtCIWfu5aszRroNP6o5kEHj+c13QVh
    Pw7vzA5D1wi7xWxfKMlvMvHEeEmP3YNJNobcqte/DCoEnR6c46W9jw+ZGVe6I/E1
    NEhnYPD3MzT0OggDix80vu319FyQ2HUtG8Nhp3NWClWQZz3NsPlWrixsg1Z3LsNx
    jXiXRaUAgX4+8sYfhQwcYRgRFlFTv0T6qP4CvaUndtmE/GnTO41ZsAmkFOKlm5Gj
    mL6RBjax9QU1XAB6PoqzYNWoa9b9gllmGCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524271342; bh=E5TiG
    qCvCwrMTkE4ou/26C715BTeqDoD9vxWmeXHCk0=; b=r8KG36I5CiovZJiU7Zflu
    DKke8SiK2Md5/w4uDlmIhdlErxnM+IfQT26Ilof9BrbZBcNYGXdyWIs2IN9I8gkR
    flGVk4CiTPmdu+WXqtZ4yvWvG0fyyUMnDg4CjPB67qoIVAN3Scs/BIA9O483tC6z
    QzmPZrtsI7mgdbTy8426hg3eMWiWF/nJEx0ZHXDABE4ef6cfrmMZKsAkdxU0plGG
    DqH4dIVCagdKJw3wEAA8lt81wGBalpeSFRJ20CCLgBIBzd7h+ijaww7aKx/VSJDe
    UuqDKvX//NKI+AKAnCjXsLwCpk6fABQ4COgY5HuZgqp+wavYsntuhdsTyvZwtvxN
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=UieUIFXD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=UieUIFXD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDdvwMDAVttlmG5aK7dlAfub1vricIuvuvlaS53WMM6nxbqkRLTsoAPFzHj8lCCAYpohzBm9clUqts5Gx4p3t4yPZwtP03xP9wYLnn52lxUjDP7nRH/
    3TYOFbsK4Gb7FX3oRFL68QESVgQLUJqAn+a58Eq/F75ngOdV/1wernUrc2K80bv4SgqG3GnF48+mVCLsmHg4EjdX0HCB+qmlYjZrucrkZSUX6zRHLp6cVKFx
    apRbewYOciTLV3zS0xasNg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=WXoUAGpt5n4LM7SFY0oA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 04/13] staging: iio: tsl2x7x: simplify
 tsl2x7x_clear_interrupts function
Date: Fri, 20 Apr 2018 20:41:44 -0400
Message-Id: <20180421004153.19073-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
 knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

tsl2x7x_clear_interrupts() takes a reg argument but there are only
two callers to this function and both callers pass the same value.
Since this function was introduced, interrupts are now working
properly for this driver, and several unnecessary calls to
tsl2x7x_clear_interrupts() were removed. This patch removes the
tsl2x7x_clear_interrupts() function and replaces the two callers
with the i2c_smbus_write_byte() call instead.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 95a00b965c5e..f37fc74b8fbc 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -271,20 +271,6 @@ static const u8 device_channel_config[] = {
 	ALSPRX2
 };
 
-static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
-{
-	int ret;
-
-	ret = i2c_smbus_write_byte(chip->client,
-				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN | reg);
-	if (ret < 0)
-		dev_err(&chip->client->dev,
-			"%s: failed to clear interrupt status %x: %d\n",
-			__func__, reg, ret);
-
-	return ret;
-}
-
 static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
 {
 	int ret;
@@ -714,9 +700,15 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
-	if (ret < 0)
+	ret = i2c_smbus_write_byte(chip->client,
+				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
+				   TSL2X7X_CMD_PROXALS_INT_CLR);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"%s: failed to clear interrupt status: %d\n",
+			__func__, ret);
 		return ret;
+	}
 
 	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
 
@@ -1341,7 +1333,13 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 			       timestamp);
 	}
 
-	tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
+	ret = i2c_smbus_write_byte(chip->client,
+				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
+				   TSL2X7X_CMD_PROXALS_INT_CLR);
+	if (ret < 0)
+		dev_err(&chip->client->dev,
+			"%s: failed to clear interrupt status: %d\n",
+			__func__, ret);
 
 	return IRQ_HANDLED;
 }
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
