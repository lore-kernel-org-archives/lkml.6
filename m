Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363EFC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43A420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fieGMiYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43A420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeFTRMu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:12:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51472 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932308AbeFTRMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:12:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so750211wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7NhhzkOypGj4T9BlKUs3HdRK3pfINPpCX3kyylWdlvI=;
        b=fieGMiYga0CiLdnIbV5WGtuPaWtAtTq6aFfyBeHxbph5fmoXYLuFrpr40IW+IFuGQ3
         maU/+/KFCJBOEfJxumcHvnqFFj2lbZQnCQcnyl7XQIwKQuZEa7apNeAQxW7bwNs4uWCh
         A1jkrHiIQn7hKqwA46xub8ri5SSraZrPjfUu/vmmFOxZ5V8gflnz78qujOnLp70ePBGF
         DyGKF3gThhpSHjAlJ8UY26uN45DJ/hrDq6vOCdeLsKQwkM4+ctnzrnWR0RQh6DAPvPKX
         Qb71e5SpmUhGJa2aZslSBV8I+plol6pxc3HBcQZPGE5YBu9Z8gSplGoUoz1+2mdDoGRk
         eeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7NhhzkOypGj4T9BlKUs3HdRK3pfINPpCX3kyylWdlvI=;
        b=rw5tzle3+cRtt/oq179BPW2PhwSvzaekPvi/VmdfbyLuzEWqzGyZm+/sVFO9/UTlO1
         S0zz5xg9FeHikmrtDzUJ8isDdWt4C0O+TLnFLV42sch0nAlBQxVP1BVTzlCQNcrfRPXq
         66t7jnmlW+MTboB72PzK3fQ2i7LdRvoNY0kelhvcWXHGxYCA8DHUffVDzs6wb9WZoXXp
         UVI5FmR09VYbTkv7n8emnbDHR0Uzz2srhkAvmACzCSSCSxeNjbQNPCh0dyhti7bYyjjQ
         t7l7qNwVCLkWzeh/85oQWEee1ckbzuY9g4BiizaunYKyQ3mZTActJzb02B3NCJ14/DcX
         bXnQ==
X-Gm-Message-State: APt69E3n0rHqDzkJzeTwNgPoklSjj45TsJiRNXCeInj1Iin2JnnJZu6E
        Xss60hTq2eSZF1rQYkCZA+KLznNT
X-Google-Smtp-Source: ADUXVKK0TSEHFjwFzTcRp9WcovDvgQfKnZjLFdzRsetYOcaRK1fyou0uohvuSMH5ClQGyjKje9bd9w==
X-Received: by 2002:a1c:ad50:: with SMTP id w77-v6mr2527740wme.54.1529514768581;
        Wed, 20 Jun 2018 10:12:48 -0700 (PDT)
Received: from localhost.localdomain (8ta-151-217-222.telkomadsl.co.za. [41.151.217.222])
        by smtp.googlemail.com with ESMTPSA id y5-v6sm3539270wrp.51.2018.06.20.10.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 10:12:47 -0700 (PDT)
From:   Chris Opperman <eklikeroomys@gmail.com>
Cc:     eklikeroomys@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: improved readability of function prism2_add_key
Date:   Wed, 20 Jun 2018 19:10:26 +0200
Message-Id: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
X-Mailer: git-send-email 2.1.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability of prism2_add_key:
a) Reduce nesting and removed goto statement by using more return statements.
b) Added temporary "key" variable to reduce line length.

Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
---

Improve readability of prism2_add_key:
a) Reduce nesting and removed goto statement by using more return statements.
b) Added temporary "key" variable to reduce line length.

 drivers/staging/wlan-ng/cfg80211.c | 40 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 4291225..b46db65 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -147,41 +147,27 @@ static int prism2_add_key(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct wlandevice *wlandev = dev->ml_priv;
 	u32 did;
-
-	int err = 0;
-	int result = 0;
+	u32 key;
 
 	if (key_index >= NUM_WEPKEYS)
 		return -EINVAL;
 
-	switch (params->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-		result = prism2_domibset_uint32(wlandev,
-						DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
-						key_index);
-		if (result)
-			goto exit;
-
-		/* send key to driver */
-		did = DIDmib_dot11smt_dot11WEPDefaultKeysTable_key(key_index + 1);
-
-		result = prism2_domibset_pstr32(wlandev, did,
-						params->key_len, params->key);
-		if (result)
-			goto exit;
-		break;
-
-	default:
+	if (params->cipher != WLAN_CIPHER_SUITE_WEP40 &&
+	    params->cipher != WLAN_CIPHER_SUITE_WEP104) {
 		pr_debug("Unsupported cipher suite\n");
-		result = 1;
+		return -EFAULT;
 	}
 
-exit:
-	if (result)
-		err = -EFAULT;
+	key = DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID;
+	if (prism2_domibset_uint32(wlandev, key, key_index))
+		return -EFAULT;
 
-	return err;
+	/* send key to driver */
+	did = DIDmib_dot11smt_dot11WEPDefaultKeysTable_key(key_index + 1);
+
+	if (prism2_domibset_pstr32(wlandev, did, params->key_len, params->key))
+		return -EFAULT;
+	return 0;
 }
 
 static int prism2_get_key(struct wiphy *wiphy, struct net_device *dev,
-- 
2.1.4

