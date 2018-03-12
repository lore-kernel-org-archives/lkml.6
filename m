Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826849-2-7864188624705186858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826849; b=JBrJeV6en2oMHcXaYaapr6SRQbcSvy7P369Ybovm1+ikHkf
    kkV90ofuRY5PlOaZoEaZ9yxYzMPofNC4IxSP8FYx5FJW8/CrLlaQ5KptzFlnUDzv
    kZEhpbVg3G9qOlqNHf0pdQGrKfXeDmdZKU6UOsKHecZohF3UmcXvkEx8tKOFXaVY
    ai5wjmLb5yBOdijg5va+0jPOe/4UzZgBklwmG4oeYJW8MOAzTy/N41hejASGoQor
    KSOZFZzkKiOBjq1Asp5BqMjuGWZYx65tmJMfP0fEBnClnNw/CPmaXFOtIKUxK4No
    F8LAYiCz8o0mFw1tjnOKKvVc3KhTz0dn+TUVtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826849; bh=iux3RHiF7aVK5Se3JIA
    wOAGyJC3VgPXON9tR01TQH9U=; b=JARv4ULPtTNTroCyBA/B2c4XumlUaLOTALk
    UKZiYDhUZUX6rHfLoRWaDSseRd1P1PfzDNoYnozNrx8lddUwajpjmHd/74JxNw4h
    doip3/EFpY27WzSPT9fOvsFnW2iXLcppWuKiPWvPneyiidFjmcMGDDEUerBM1XBR
    JnYKo9kCVWJQ7FJqomLHmjK8T1Z93oI4dQL+xPyuNdsd5g3EtPE7PHnkUTvKVZnS
    94C1UXFoi5u6fWcnIMUkDbfEmrlx/oVvQn8qvyyAtPDWEYYLjSxQJ/4cdVjTvYGa
    nDC/yoXsafH2LN6cO7YKe3pvKqwzRSysKDc0R8I8Ne/g1llD5yA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbeCLDxF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:53:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41016 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932527AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Han Shen" <shenhan@google.com>,
        Han@decadent.org.uk, "Larry Finger" <Larry.Finger@lwfinger.net>,
        "John W. Linville" <linville@tuxdriver.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.760726474@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 009/104] rtl8192c:dm: Properly initialize local array
 and set value.
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Han Shen <shenhan@google.com>

commit 7c8f0db0d024efda38976fc2acf7743f458e1d96 upstream.

GCC 4.8 is spitting out uninitialized-variable warnings against
"drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c".  This patch adds
initialization to the variable and properly sets its value.

Signed-off-by: Han Shen  (shenhan@google.com)
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
@@ -672,7 +672,7 @@ static void rtl92c_dm_txpower_tracking_c
 	u8 thermalvalue, delta, delta_lck, delta_iqk;
 	long ele_a, ele_d, temp_cck, val_x, value32;
 	long val_y, ele_c = 0;
-	u8 ofdm_index[2], ofdm_index_old[2], cck_index_old = 0;
+	u8 ofdm_index[2], ofdm_index_old[2] = {0, 0}, cck_index_old = 0;
 	s8 cck_index = 0;
 	int i;
 	bool is2t = IS_92C_SERIAL(rtlhal->version);
@@ -722,7 +722,7 @@ static void rtl92c_dm_txpower_tracking_c
 			for (i = 0; i < OFDM_TABLE_LENGTH; i++) {
 				if (ele_d == (ofdmswing_table[i] &
 				    MASKOFDM_D)) {
-
+					ofdm_index_old[1] = (u8) i;
 					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
 					   DBG_LOUD,
 					   ("Initial pathB ele_d reg0x%x = "
