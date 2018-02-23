Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415985-2-6753623020638022813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415984; b=MVjDv0FA/sFH+y8moHIJd8Hbz7OJ/0bCV4RSlmcLqZYPQue
    3+cgbpCfzHQqHy3qVK5OLKlZHQen8dwr6JpgGYj5N5ycLIUg1qATzI+QEX3HLfBr
    e34i2HBDqk1EasmDEQv2k+IYGTa14K/XPrYiezvqBAUPm0UGCyWVdvgr+8rrKhK3
    dlWnLf8sQKM6e3pW8NbF+LtA1ly6EskJQNHC9Ohe/ngqEVADFizcXN+ajFyGWmgP
    2Pw+s4kMDnC4lLnQFBqmJq5Wp1DcJ75uGzyu4DvDHGdW3UQ2OazutZJg1aRgvvSO
    1Mkbnaw7uIf7hz6jkX6qwWrMAFaZ6cLcFVNtKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415984; bh=CGDaxHCLofWkY8w9PrcriRmiXk
    xqtsf69JtATwJLMNE=; b=HwvvznkuYJZ44YrfVLgYlFe2KOoZKDmXMnz4YZueQy
    UAwM/jIm96uiIPBYLlFL0jrm4V7PXlITQcZ2ITXUfWHRLF9UzLblp1YnZH/NbIkp
    nofb8BKbuUX/lwOYZ5AU5bfv2X4gTxZPo0XfJMyCsDfDea/n0UoNN70oMuxz7jzI
    3wrMGOr/gmNz8qYFos929jSR/X4LOfhhMWFVaJddGmGnzLWBuhgc7W0zkPZUotmU
    KUVPm6ZpJ1BnioUFsbsk0u3VOcMBGPBTInmuNfTjGVoeniwwcqqEo7ZQh6f1YXzS
    Wvy+ltVN6TFO/YiXSpXGpWbAjqUygl7OVCZNLAi13Ikg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeBWSny (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:43:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933413AbeBWSnw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 039/145] staging: iio: adc: ad7192: fix external frequency setting
Date: Fri, 23 Feb 2018 19:25:45 +0100
Message-Id: <20180223170730.008524296@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit e31b617d0a63c6558485aaa730fd162faa95a766 upstream.

The external clock frequency was set only when selecting
the internal clock, which is fixed at 4.9152 Mhz.

This is incorrect, since it should be set when any of
the external clock or crystal settings is selected.

Added range validation for the external (crystal/clock)
frequency setting.
Valid values are between 2.4576 and 5.12 Mhz.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/iio/adc/ad7192.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -141,6 +141,8 @@
 #define AD7192_GPOCON_P1DAT	BIT(1) /* P1 state */
 #define AD7192_GPOCON_P0DAT	BIT(0) /* P0 state */
 
+#define AD7192_EXT_FREQ_MHZ_MIN	2457600
+#define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
 /* NOTE:
@@ -216,6 +218,12 @@ static int ad7192_calibrate_all(struct a
 				ARRAY_SIZE(ad7192_calib_arr));
 }
 
+static inline bool ad7192_valid_external_frequency(u32 freq)
+{
+	return (freq >= AD7192_EXT_FREQ_MHZ_MIN &&
+		freq <= AD7192_EXT_FREQ_MHZ_MAX);
+}
+
 static int ad7192_setup(struct ad7192_state *st,
 			const struct ad7192_platform_data *pdata)
 {
@@ -241,17 +249,20 @@ static int ad7192_setup(struct ad7192_st
 			 id);
 
 	switch (pdata->clock_source_sel) {
-	case AD7192_CLK_EXT_MCLK1_2:
-	case AD7192_CLK_EXT_MCLK2:
-		st->mclk = AD7192_INT_FREQ_MHZ;
-		break;
 	case AD7192_CLK_INT:
 	case AD7192_CLK_INT_CO:
-		if (pdata->ext_clk_hz)
-			st->mclk = pdata->ext_clk_hz;
-		else
-			st->mclk = AD7192_INT_FREQ_MHZ;
+		st->mclk = AD7192_INT_FREQ_MHZ;
 		break;
+	case AD7192_CLK_EXT_MCLK1_2:
+	case AD7192_CLK_EXT_MCLK2:
+		if (ad7192_valid_external_frequency(pdata->ext_clk_hz)) {
+			st->mclk = pdata->ext_clk_hz;
+			break;
+		}
+		dev_err(&st->sd.spi->dev, "Invalid frequency setting %u\n",
+			pdata->ext_clk_hz);
+		ret = -EINVAL;
+		goto out;
 	default:
 		ret = -EINVAL;
 		goto out;
