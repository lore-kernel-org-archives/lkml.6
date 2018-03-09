Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520639213-2-10061371270991660363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520639211; b=dXz/3OlNXtn06/H6avZQeci6eXO6wPqoxAxhYvgAy9YCTSf
    JvOJu2/yQJ9F9sOg6+Q1lDdyfJGl8eAqYyzW1Qp7Eups91C1tbEMMLDboh3qBF0l
    EVgwtZ2TIgsmtzYxaoRzVjEjD/SV5cRE1IQtrlOaWGgl/vboL2SFT4ue66iNXReC
    SLiGelb6P0Lb6EiKm8Bl581fOZPYbHG0WEWgKgncf8q1z1Ho9SfPjrT2OXUhP4XA
    6mDjtzECos9KQgCYqOw5tYqJQNEGYGz4JEcC0edZAVqhJFL4l1byeeMoyClJfGhw
    zoTEImC9Q0eOrYfPBtYdLNi6VNv0HPX8kR72wpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520639211; bh=k
    Rt0LTEDu2WvMucUI1uA6guYhRfqmvFK8CW7whf0EBE=; b=EqfRiYMhPtrmWv28H
    pu3Dsh+59dmRsVNCJV+Uq09Z4dBoY9hI0JXqebzkiLeHih+G+mD/ViZubdmkvzzE
    LLiUX/5SKKn92gZ0olthk8rDzGz31ir745tws89EJlBatONhyCqpnolqA0/rAmu+
    pM944RHvTaM9Ck4/U/VZFKWLyXdHPMYSR6vNu+J2rzmE/hbAwWn3PYIyjxDKwYJN
    gh55p3/yppg/YRePflMaE1TQDFjgl+2buuCUeGj3xarD+WIn2/GN7iGSS/AkqizV
    xykJabmSA/sMlEHjkiUdXnUM0zvOnAniQM3j5/sbQeC4nBIjSOf0XZXl3FXQ3LI2
    0BRFw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nODgtEt6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rjY8k6f5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nODgtEt6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rjY8k6f5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvCf58bdmRP61K3lUZc1zKkJVpUiR6ARWAnPz5T1sG701Lyn8hnWGg/SImwY99+QQ2FAKqMgA==
Date: Fri, 9 Mar 2018 20:46:40 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 4/4] staging:iio:ad2s1210: Add comments/documentation
Message-ID: <813ae9b3a8d6d9b0e6d4d4b6dda7fe354375fc8d.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
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
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The original code of AD2S1210 does not have documentation for structs
and register configurations; this difficult the code comprehension. This
patch adds structs documentation, briefly comments some register
settings and acronyms, and adds little explanations of some calculation
found in the code.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 32 ++++++++++++++++++++++++++++++++
 drivers/staging/iio/resolver/ad2s1210.h |  9 ++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..9bb8fd782f5a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -24,8 +24,10 @@
 
 #define DRV_NAME "ad2s1210"
 
+/* The default value of the control register on power-up */
 #define AD2S1210_DEF_CONTROL		0x7E
 
+/* Control Register Bit */
 #define AD2S1210_MSB_IS_HIGH		0x80
 #define AD2S1210_MSB_IS_LOW		0x7F
 #define AD2S1210_PHASE_LOCK_RANGE_44	0x20
@@ -39,14 +41,23 @@
 
 #define AD2S1210_REG_POSITION		0x80
 #define AD2S1210_REG_VELOCITY		0x82
+
+/* Loss of Signal (LOS) register address */
 #define AD2S1210_REG_LOS_THRD		0x88
+
+/* Degradation of Signal (DOS) register address */
 #define AD2S1210_REG_DOS_OVR_THRD	0x89
 #define AD2S1210_REG_DOS_MIS_THRD	0x8A
 #define AD2S1210_REG_DOS_RST_MAX_THRD	0x8B
 #define AD2S1210_REG_DOS_RST_MIN_THRD	0x8C
+
+/* Loss of Tracking (LOT) register address */
 #define AD2S1210_REG_LOT_HIGH_THRD	0x8D
 #define AD2S1210_REG_LOT_LOW_THRD	0x8E
+
+/* Excitation Frequency (EXCIT) register address */
 #define AD2S1210_REG_EXCIT_FREQ		0x91
+
 #define AD2S1210_REG_CONTROL		0x92
 #define AD2S1210_REG_SOFT_RESET		0xF0
 #define AD2S1210_REG_FAULT		0xFF
@@ -69,6 +80,20 @@ enum ad2s1210_mode {
 
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
+/**
+ * struct ad2s1210_state - device instance specific state.
+ * @pdata:		chip model specific constants, gpioin, etc
+ * @lock:		lock to ensure state is consistent
+ * @sdev:		the SPI device for this driver instance
+ * @fclkin:		frequency of clock input
+ * @fexcit:		excitation frequency
+ * @hysteresis:		cache of whether hysteresis is enabled
+ * @old_data:		cache of SPI communication after operation
+ * @resolution:		chip resolution could be 10/12/14/16-bit
+ * @mode:		indicates the operating mode
+ * @rx:			receive buffer
+ * @tx:			transmit buffer
+ */
 struct ad2s1210_state {
 	const struct ad2s1210_platform_data *pdata;
 	struct mutex lock;
@@ -82,6 +107,7 @@ struct ad2s1210_state {
 	u8 tx[2] ____cacheline_aligned;
 };
 
+/* Maps A0 and A1 inputs to the respective mode.  */
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
@@ -137,6 +163,11 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 	int ret;
 	unsigned char fcw;
 
+	/*
+	 * The fcw stands for frequency control word, which can be obtained
+	 * from:
+	 * fcw = (Excitation Frequency * 2^15) / fclkin
+	 */
 	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
 	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
 		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
@@ -158,6 +189,7 @@ static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
 	return ad2s1210_resolution_value[resolution];
 }
 
+/* Maps RES0 and RES1 inputs to the respective mode.  */
 static const int ad2s1210_res_pins[4][2] = {
 	{ 0, 0 }, {0, 1}, {1, 0}, {1, 1}
 };
diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
index e9b2147701fc..cbe21bca7638 100644
--- a/drivers/staging/iio/resolver/ad2s1210.h
+++ b/drivers/staging/iio/resolver/ad2s1210.h
@@ -1,5 +1,5 @@
 /*
- * ad2s1210.h plaform data for the ADI Resolver to Digital Converters:
+ * ad2s1210.h platform data for the ADI Resolver to Digital Converters:
  * AD2S1210
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
@@ -11,6 +11,13 @@
 #ifndef _AD2S1210_H
 #define _AD2S1210_H
 
+/**
+ * struct ad2s1210_platform_data - chip model
+ * @sample:	sample input used to clearing the fault register
+ * @a:		array of inputs (A0 and A1)
+ * @res:	array of resolution inputs (RES0 and RES1)
+ * @gpioin:	control the read operation
+ */
 struct ad2s1210_platform_data {
 	unsigned int		sample;
 	unsigned int		a[2];
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
