Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2626299-1525357001-2-3175154868541398164
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525357000; b=STy8AkmRv8BdePwI8FdwgHZ1wfukqSMEbg9+rcnkq8UZR3bu6X
    t137pAsTPA/FcbgU8Nonou/7dIJ6qRub4G4R/6R4YnRq4jXh1j6Zpu728tzeryFp
    XsN8XIysQGm77AmnTBP1tL2jGKYQGcQhSHy3CqV2eOjgyrJP2yo0jzMdGoFOmZeO
    v4hP8ctzbkT9upwq8iRmavK2iquqLeyzyP3lBqyzY043xtP3bwAIIseNU9bb/OMJ
    cWH7falpkJXx2iZEktq501uno4QZKQDLIbPdnKZnCsdNiG5z5F7xEFXbiFJVsj1/
    gXxslX7of2w5mmXsYHHF10goIgXL0g1uEPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525357000; bh=77I9n
    iV5eeclzpCiB+On7fQLQ14Ob31uOtdc/0eAuKo=; b=C7pci1P/yTIK+fOHbEEOP
    8Lgov4Xb8PvEiWHSqBoZY9FnOv0Q7SRl2kqnRkCuVjpQBhS+AAEBi60tH3j9JjJU
    rnV8EOLWVLA3siemEZGxq0B5+jEa95HZ5KoXSnU8IHZLFgPiom/Ys5Ovm7GqYKNp
    AYlF9AlZm68LiL/r24yHiE2E1ReEFtX+0V5TrR91JunFhn+7OZoOCZE5o2w0SFEa
    OTuR646JwUgvd5FT16WMT54OincwT2zJKFU7U7ekvSex6Ddu4rGmE7T+JrebqR9r
    svkqc1kqMHUCvEH79SxXz47HiPcHoJtTX+c9JvBOynmuQXJmr33RO49b1I6P765a
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrF8uWTl56xGwH+E3PQs/QuIjBbnfHMxU2YEkxTXskdF6hme+gRTT1tkSCoqgBmKoGNS/pqiMuX6Jrp37adpoY3Ak4+/N2iXgZpbox3HecbEgfkoURa
    PT3T91VHs2C98B83g+K1M+WfvRp6DIW+NGZ/MQC5IUMpZpBLHExJsKIljPCoKnWdAn/OSdLadwQ+Zc5Yd8QyTZF9g2or4dAzxRTOPWFP8Yj5z1XQ7MZm1SPd
    LJzNeGf9CLXyNGOwMXjCww==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=s7wyiga02AELGEiQm0oA:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>, devel@driverdev.osuosl.org
Subject: [PATCH] staging: r8822be: fix typo in variable name "offest" ->
 "offset"
Date: Thu,  3 May 2018 15:16:28 +0100
Message-Id: <20180503141628.32330-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

There are multiple occurrances of typos of "offest" that should be
"offset". Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../rtlwifi/phydm/rtl8822b/halphyrf_8822b.c   | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtlwifi/phydm/rtl8822b/halphyrf_8822b.c b/drivers/staging/rtlwifi/phydm/rtl8822b/halphyrf_8822b.c
index ae3e2278fefd..14c3fb52f5b8 100644
--- a/drivers/staging/rtlwifi/phydm/rtl8822b/halphyrf_8822b.c
+++ b/drivers/staging/rtlwifi/phydm/rtl8822b/halphyrf_8822b.c
@@ -29,7 +29,7 @@
 static bool
 get_mix_mode_tx_agc_bb_swing_offset_8822b(void *dm_void,
 					  enum pwrtrack_method method,
-					  u8 rf_path, u8 tx_power_index_offest)
+					  u8 rf_path, u8 tx_power_index_offset)
 {
 	struct phy_dm_struct *dm = (struct phy_dm_struct *)dm_void;
 	struct dm_rf_calibration_struct *cali_info = &dm->rf_calibrate_info;
@@ -42,24 +42,24 @@ get_mix_mode_tx_agc_bb_swing_offset_8822b(void *dm_void,
 
 	ODM_RT_TRACE(
 		dm, ODM_COMP_TX_PWR_TRACK,
-		"Path_%d cali_info->absolute_ofdm_swing_idx[rf_path]=%d, tx_power_index_offest=%d\n",
+		"Path_%d cali_info->absolute_ofdm_swing_idx[rf_path]=%d, tx_power_index_offset=%d\n",
 		rf_path, cali_info->absolute_ofdm_swing_idx[rf_path],
-		tx_power_index_offest);
+		tx_power_index_offset);
 
-	if (tx_power_index_offest > 0XF)
-		tx_power_index_offest = 0XF;
+	if (tx_power_index_offset > 0XF)
+		tx_power_index_offset = 0XF;
 
 	if (cali_info->absolute_ofdm_swing_idx[rf_path] >= 0 &&
 	    cali_info->absolute_ofdm_swing_idx[rf_path] <=
-		    tx_power_index_offest) {
+		    tx_power_index_offset) {
 		tx_agc_index = cali_info->absolute_ofdm_swing_idx[rf_path];
 		tx_bb_swing_index = cali_info->default_ofdm_index;
 	} else if (cali_info->absolute_ofdm_swing_idx[rf_path] >
-		   tx_power_index_offest) {
-		tx_agc_index = tx_power_index_offest;
+		   tx_power_index_offset) {
+		tx_agc_index = tx_power_index_offset;
 		cali_info->remnant_ofdm_swing_idx[rf_path] =
 			cali_info->absolute_ofdm_swing_idx[rf_path] -
-			tx_power_index_offest;
+			tx_power_index_offset;
 		tx_bb_swing_index = cali_info->default_ofdm_index +
 				    cali_info->remnant_ofdm_swing_idx[rf_path];
 
@@ -85,9 +85,9 @@ get_mix_mode_tx_agc_bb_swing_offset_8822b(void *dm_void,
 
 	ODM_RT_TRACE(
 		dm, ODM_COMP_TX_PWR_TRACK,
-		"MixMode Offset Path_%d   cali_info->absolute_ofdm_swing_idx[rf_path]=%d   cali_info->bb_swing_idx_ofdm[rf_path]=%d   tx_power_index_offest=%d\n",
+		"MixMode Offset Path_%d   cali_info->absolute_ofdm_swing_idx[rf_path]=%d   cali_info->bb_swing_idx_ofdm[rf_path]=%d   tx_power_index_offset=%d\n",
 		rf_path, cali_info->absolute_ofdm_swing_idx[rf_path],
-		cali_info->bb_swing_idx_ofdm[rf_path], tx_power_index_offest);
+		cali_info->bb_swing_idx_ofdm[rf_path], tx_power_index_offset);
 
 	return true;
 }
@@ -97,7 +97,7 @@ void odm_tx_pwr_track_set_pwr8822b(void *dm_void, enum pwrtrack_method method,
 {
 	struct phy_dm_struct *dm = (struct phy_dm_struct *)dm_void;
 	struct dm_rf_calibration_struct *cali_info = &dm->rf_calibrate_info;
-	u8 tx_power_index_offest = 0;
+	u8 tx_power_index_offset = 0;
 	u8 tx_power_index = 0;
 
 	struct rtl_priv *rtlpriv = (struct rtl_priv *)dm->adapter;
@@ -139,11 +139,11 @@ void odm_tx_pwr_track_set_pwr8822b(void *dm_void, enum pwrtrack_method method,
 	if (tx_power_index >= 63)
 		tx_power_index = 63;
 
-	tx_power_index_offest = 63 - tx_power_index;
+	tx_power_index_offset = 63 - tx_power_index;
 
 	ODM_RT_TRACE(dm, ODM_COMP_TX_PWR_TRACK,
-		     "tx_power_index=%d tx_power_index_offest=%d rf_path=%d\n",
-		     tx_power_index, tx_power_index_offest, rf_path);
+		     "tx_power_index=%d tx_power_index_offset=%d rf_path=%d\n",
+		     tx_power_index, tx_power_index_offset, rf_path);
 
 	if (method ==
 	    BBSWING) { /*use for mp driver clean power tracking status*/
@@ -178,7 +178,7 @@ void odm_tx_pwr_track_set_pwr8822b(void *dm_void, enum pwrtrack_method method,
 		switch (rf_path) {
 		case ODM_RF_PATH_A:
 			get_mix_mode_tx_agc_bb_swing_offset_8822b(
-				dm, method, rf_path, tx_power_index_offest);
+				dm, method, rf_path, tx_power_index_offset);
 			odm_set_bb_reg(
 				dm, 0xC94, (BIT(29) | BIT(28) | BIT(27) |
 					    BIT(26) | BIT(25)),
@@ -201,7 +201,7 @@ void odm_tx_pwr_track_set_pwr8822b(void *dm_void, enum pwrtrack_method method,
 
 		case ODM_RF_PATH_B:
 			get_mix_mode_tx_agc_bb_swing_offset_8822b(
-				dm, method, rf_path, tx_power_index_offest);
+				dm, method, rf_path, tx_power_index_offset);
 			odm_set_bb_reg(
 				dm, 0xE94, (BIT(29) | BIT(28) | BIT(27) |
 					    BIT(26) | BIT(25)),
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
