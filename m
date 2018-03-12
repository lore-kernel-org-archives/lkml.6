Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826615-2-614092019594876239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826614; b=lq91/o2rAJWLJ//8pKb0kaMHHka5fFoGsC0dcr9tOMqBiUd
    A7qjIRP1uY0rAnPiYVfe+cWssl/3yT0cwr4sIN810NRdpmXxRfL2KbgqfdPyYuz4
    /xDJsLOrLcJDlftGfvbiAyYeeyeSurvZqq9f4kvbUln1crxfzQ4nriiMB+qQd28P
    0yxHQkdW+IAk4k7HGk7PrLyE80HrN6iFJGhoE8gmkTE1rItfI0+Bn+4CPUvdWZuZ
    IY77WnwLPi+uO3ystYWV7htdWCNOnSVOttQRzU3MeK5Z5iYiBxKFePkabnkOfNYD
    pr6W4Y56o2Y5FMN5FOv5u2fWwjTJaMwrZ9FXxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826614; bh=dIJxtEyvgh8gW9FYmf5
    k6aGREhW8DHlWtVUV/0Dwp88=; b=cePXmwFFHrhk1I8xgL6ZqKSb4MykdCoV8Xh
    mJ7QP2jOnAXheZLgO+n+g7DITG5BCNu6va4Tx9jwONR23oRcqAuqeahu+M5KheVw
    PSElAd6yVlwmoX0z+UR/MFmIDrUtkmbfJBLOGRoDoit78H5yViRZAc7duzM5blW9
    XY72gJYRbQCe/zsTBeskwHCoWQpLKvIhJzCSDUm1T3AISKYL9+wocaN6CGgTa2NH
    cuyJeTn08wOLZWHHLJOWCNwtSzlOQRNGouctXc09ebEwRxYZP8lqeYqckrfEALZ/
    KuhBjh4wkVzFU6o+PZzDSKaJ9mJgcbIoSSXDH9eBZxSLlYS8F8w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S932641AbeCLDHl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:07:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41020 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932520AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        "John W. Linville" <linville@tuxdriver.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.221407021@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 007/104] rtlwifi: rtl8192c: Fix W=1 warning
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

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 8a8e31cc22739d1a5780591c008940292edcde87 upstream.

When this driver is built with "make W=1", the following warning occurs:

drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c:907:4: warning: comparison is always false due to limited range of data type [-Wtype-limits]

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192c/dm_common.c
@@ -672,7 +672,8 @@ static void rtl92c_dm_txpower_tracking_c
 	u8 thermalvalue, delta, delta_lck, delta_iqk;
 	long ele_a, ele_d, temp_cck, val_x, value32;
 	long val_y, ele_c = 0;
-	u8 ofdm_index[2], cck_index = 0, ofdm_index_old[2], cck_index_old = 0;
+	u8 ofdm_index[2], ofdm_index_old[2], cck_index_old = 0;
+	s8 cck_index = 0;
 	int i;
 	bool is2t = IS_92C_SERIAL(rtlhal->version);
 	s8 txpwr_level[2] = {0, 0};
