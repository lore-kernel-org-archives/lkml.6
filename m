Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELv4zM5dto0hIsqluSU9fz3+5NNsDv0JT5y+H2uhaHI36S83apCe3EMhv4UI0+cjhrn63wvL
ARC-Seal: i=1; a=rsa-sha256; t=1519881585; cv=none;
        d=google.com; s=arc-20160816;
        b=z/I7WcFcf3JgAvrdHaeH1LF0pCLihzfkAw+j4/M+RvvbM70/ZLTYC89ZoOd1tzEE2T
         0aAU6pqqDddOqRW7CUvEIAaPQeujRqSpinOupmTpT/uapVMmi7z0GzCfGOfGwqM78YPL
         k5/lfX80pywMGcdDK6nbeLdXqjm9B97Fi4e9xn524a4NK7WYWHQd5qw754+RCuFtfRNS
         QTBm/pFkyvlS//L4COUXk3CTUrYMQfd+1u8+wfhpkjixvFsjVX4ONQPSblaDPCgBBSui
         wmc6KAEaYoFzi+NX+I3NFP/GxTs5tdZ85YS5kdnEfL5o9fyT+rDyMgascOWuBRNRho87
         5PLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1GtaAxVs7MgHRKdoHcFvWR4m94yCeISZpPKMutqHSm4=;
        b=Isz+Bko7tkg1oEJ5N63R12Lqqwqe3uf8NGeJ5Ue2NbCdsvaPTWK31uP1iqlFPmkWLR
         E+yku2c5vMX9BGeS3wEL4FxwGwumbWorFvyZzQzNY2PdkF37TaOhhlO1l9wJYgS6ZrGG
         sS69ehFQGbPayB35p7xsJLn0tfub/wLpmtl2/TX8axGcKeyN3qYGlho7AXU1hDajutOi
         Hv+NaqTGS5iJKqis8vxAkhUAIFRx8qAcKBbOWEcHwH9bWprUv5pMsiHKLk0pJ0lY2UCZ
         b5jcImzUj65w2/SHl06c5UXI8qQgxOcOYaD3gXW6eQY2wUi9FVU3gD/A4GsSc1JaAzFS
         Kb2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 3/5] staging: ks7010: Factor out repeated code into function 'ks_wlan_cap()'.
Date: Wed, 28 Feb 2018 21:19:09 -0800
Message-Id: <20180301051911.1314-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301051911.1314-1-quytelda@tamalin.org>
References: <20180301051911.1314-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:S6CuRABQLxT4vwE5mMRywGFLAt/kQIzOgNcXDnPnur55iDZ9kTg
 DMuy11e2QFt6ZmSIImaXatR430+7d81E4TD5ygm5pc/hWkfSwV8YzjZqDJREiEKCNl2Qk0H
 E+c1BjJd8y6tX8Qxq9CNisKFR7N3ESeeGHiDaQ/DCvD+VJTwnaOElCyN2CFVqkx3ngzvBPs
 WVfY0zJ820jUyE7F0KyUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5hEme2/MIhc=:Arj6LKuOvcIEdcXU7M+lXV
 HVo1cdf/tfODYxpo0osXRWcNvxfBk8dTu7DzFvvc0sAan2wRhmtFAnRLQ2IMp8a08gNBsCGr8
 WTtQgfirEauB/dJFEyynRX7oqsCF2iVwPNI4ZGK7ATqHyKyicV4GPY4IjLq3Um8AiH4YUQUh4
 hBsQoJk/Z+IwFtgTDtTlNgML9stjmP9q6fFrbu+raGlwLBVrMqv5lt3aUzA/BEnTkzK90I07Q
 MBafmPEd0iREaZP7KvmwORqm241SNoa0A2EJA6EC8Nmz04/7VT/JdASPqxqiVZO1wKsYwn/lK
 tph+kwIaSt1r9OfmeJPCMQTwJBx1oeN3JJMoqp16gTcukPuz3Mo75Hr1JuDn+zTvgxI20DpHI
 +EkMI3w2tRBWLR2H9g6lmm8KouSXQNp/zycq1ZnE9w0HI16wsMTMoZZJoQzBsA67oPi3hoRhu
 y1khQru4BUX4GYmAxHigi20ZB1wGd1/gW7SgbFBLa7ex1yrz4A7fDyPRM4+jpgxNkZsmtrb20
 tJNenbELcPw9gh16qNp/6mUk1Y2teB7ONy68VUAPeI33uocQiw4gyquLC+w/DH+HMYEJ+v8B4
 VnWsDM3Rfejx6285/89UTbqMFaM042depNf2JOf27hgEx/SUx6QNv4TRqmyf2vLmob8L7Lblb
 +dbKpsdHwE4bonJV4xq2t35DjA5dWhS8aoxjYpfZ6THAwWlVLe/quqd6dKGzyF62yfqcSLTSD
 BwEOMRPuq21lfk95QMiQ6j0Mc8DbwFaaP4vqRQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593711353553441871?=
X-GMAIL-MSGID: =?utf-8?q?1593711353553441871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The code that generates a WLAN capability mask is repeated in five
functions.  This change refactors that code into a new function, which is
called now in each of those functions.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Reviewed-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/staging/ks7010/ks_hostif.c | 88 ++++++++++----------------------------
 1 file changed, 23 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 59f7c4e422d3..4d11627a3d72 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1381,11 +1381,28 @@ void hostif_start_request(struct ks_wlan_private *priv, unsigned char mode)
 	priv->scan_ind_count = 0;
 }
 
+static __le16 ks_wlan_cap(struct ks_wlan_private *priv)
+{
+	u16 capability = 0x0000;
+
+	if (priv->reg.preamble == SHORT_PREAMBLE) {
+		capability |= BSS_CAP_SHORT_PREAMBLE;
+	}
+
+	capability &= ~(BSS_CAP_PBCC);	/* pbcc not support */
+
+	if (priv->reg.phy_type != D_11B_ONLY_MODE) {
+		capability |= BSS_CAP_SHORT_SLOT_TIME;
+		capability &= ~(BSS_CAP_DSSS_OFDM);
+	}
+
+	return cpu_to_le16((uint16_t)capability);
+}
+
 static
 void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 {
 	struct hostif_ps_adhoc_set_request_t *pp;
-	u16 capability;
 
 	DPRINTK(3, "\n");
 
@@ -1398,21 +1415,10 @@ void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
 	pp->channel = cpu_to_le16((uint16_t)(priv->reg.channel));
 	pp->rate_set.size = priv->reg.rate_set.size;
+	pp->capability = ks_wlan_cap(priv);
 	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
 	       priv->reg.rate_set.size);
 
-	capability = 0x0000;
-	if (priv->reg.preamble == SHORT_PREAMBLE) {
-		/* short preamble */
-		capability |= BSS_CAP_SHORT_PREAMBLE;
-	}
-	capability &= ~(BSS_CAP_PBCC);	/* pbcc not support */
-	if (priv->reg.phy_type != D_11B_ONLY_MODE) {
-		capability |= BSS_CAP_SHORT_SLOT_TIME;	/* ShortSlotTime support */
-		capability &= ~(BSS_CAP_DSSS_OFDM);	/* DSSS OFDM */
-	}
-	pp->capability = cpu_to_le16((uint16_t)capability);
-
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
 	ks_wlan_hw_tx(priv, pp, hif_align_size(sizeof(*pp)), NULL, NULL);
@@ -1422,7 +1428,6 @@ static
 void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
 {
 	struct hostif_infrastructure_set_request_t *pp;
-	u16 capability;
 
 	DPRINTK(3, "ssid.size=%d\n", priv->reg.ssid.size);
 
@@ -1439,18 +1444,7 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
 	       priv->reg.rate_set.size);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-
-	capability = 0x0000;
-	if (priv->reg.preamble == SHORT_PREAMBLE) {
-		/* short preamble */
-		capability |= BSS_CAP_SHORT_PREAMBLE;
-	}
-	capability &= ~(BSS_CAP_PBCC);	/* pbcc not support */
-	if (priv->reg.phy_type != D_11B_ONLY_MODE) {
-		capability |= BSS_CAP_SHORT_SLOT_TIME;	/* ShortSlotTime support */
-		capability &= ~(BSS_CAP_DSSS_OFDM);	/* DSSS OFDM not support */
-	}
-	pp->capability = cpu_to_le16((uint16_t)capability);
+	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1483,7 +1477,6 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
 static void hostif_infrastructure_set2_request(struct ks_wlan_private *priv)
 {
 	struct hostif_infrastructure_set2_request_t *pp;
-	u16 capability;
 
 	DPRINTK(2, "ssid.size=%d\n", priv->reg.ssid.size);
 
@@ -1500,18 +1493,7 @@ static void hostif_infrastructure_set2_request(struct ks_wlan_private *priv)
 	       priv->reg.rate_set.size);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-
-	capability = 0x0000;
-	if (priv->reg.preamble == SHORT_PREAMBLE) {
-		/* short preamble */
-		capability |= BSS_CAP_SHORT_PREAMBLE;
-	}
-	capability &= ~(BSS_CAP_PBCC);	/* pbcc not support */
-	if (priv->reg.phy_type != D_11B_ONLY_MODE) {
-		capability |= BSS_CAP_SHORT_SLOT_TIME;	/* ShortSlotTime support */
-		capability &= ~(BSS_CAP_DSSS_OFDM);	/* DSSS OFDM not support */
-	}
-	pp->capability = cpu_to_le16((uint16_t)capability);
+	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1547,7 +1529,6 @@ static
 void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 {
 	struct hostif_adhoc_set_request_t *pp;
-	u16 capability;
 
 	DPRINTK(3, "\n");
 
@@ -1564,18 +1545,7 @@ void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 	       priv->reg.rate_set.size);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-
-	capability = 0x0000;
-	if (priv->reg.preamble == SHORT_PREAMBLE) {
-		/* short preamble */
-		capability |= BSS_CAP_SHORT_PREAMBLE;
-	}
-	capability &= ~(BSS_CAP_PBCC);	/* pbcc not support */
-	if (priv->reg.phy_type != D_11B_ONLY_MODE) {
-		capability |= BSS_CAP_SHORT_SLOT_TIME;	/* ShortSlotTime support */
-		capability &= ~(BSS_CAP_DSSS_OFDM);	/* DSSS OFDM not support */
-	}
-	pp->capability = cpu_to_le16((uint16_t)capability);
+	pp->capability = ks_wlan_cap(priv);
 
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
@@ -1586,7 +1556,6 @@ static
 void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 {
 	struct hostif_adhoc_set2_request_t *pp;
-	u16 capability;
 
 	DPRINTK(3, "\n");
 
@@ -1602,18 +1571,7 @@ void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 	       priv->reg.rate_set.size);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-
-	capability = 0x0000;
-	if (priv->reg.preamble == SHORT_PREAMBLE) {
-		/* short preamble */
-		capability |= BSS_CAP_SHORT_PREAMBLE;
-	}
-	capability &= ~(BSS_CAP_PBCC);	/* pbcc not support */
-	if (priv->reg.phy_type != D_11B_ONLY_MODE) {
-		capability |= BSS_CAP_SHORT_SLOT_TIME;	/* ShortSlotTime support */
-		capability &= ~(BSS_CAP_DSSS_OFDM);	/* DSSS OFDM not support */
-	}
-	pp->capability = cpu_to_le16((uint16_t)capability);
+	pp->capability = ks_wlan_cap(priv);
 
 	pp->channel_list.body[0] = priv->reg.channel;
 	pp->channel_list.size = 1;
-- 
2.16.2
