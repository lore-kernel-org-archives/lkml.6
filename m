Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826447-2-1778712710628121285
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
    t=1520826446; b=rrR11Qldz+97RG28oHdfrYKF3GpeHyEGxfByOwp/vbiatbt
    1/2JoG8QgCrZzGRZ/I+T4fcn5NRXs80pOF/boKu22HUx3qwRfmlSEY2ZHBiCZzoD
    Qwyo3ofAH1VUNaN8CQTmAjtlQxeCcZIJjg2xIit8P4jP4PHbW9OBMUi0M4b7dZBd
    8/7a4pZFUH7Wm47ThvxxDm1wjRsTdI1d0gHu2uHVpQiSQeTSUzLV9JLleRIK2pBT
    ztzDC47OjlvYav6ypSwZUDRwhqYM+4tyjVqWA+Yi0MNYgMJzsm8ydpl0OXzD+yOe
    x1pthk+bQCX3EZFjjVN3yg+C8rWtTlkTXNyb3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826446; bh=gF7QtJ29baozW5eClGA
    fLwKEBvTgj1llYEkqHfRGAms=; b=dyGbQiojjDU/98xy/6f0DGON3UUBroww2zD
    6bqecW8NpFljESderov/0iCWCLShcILXPO75L1hme5lg9IhH8ZnHdA7hh+zGebBq
    RxFiWDXQ35U0NpfhpkDHdFkklF8yVd3nkLTshi3gCWy393rYMaya2B1B1GqqnAE5
    gKIwGFiuvM5alsDjD8iNM8BOMdQinmymSDNBTZ/HaEjlLEfCSOzLnDsX8PByIWNE
    40snJGU+5avl6zHMCNnGIzstFwTrcp3p50A7i4fP8Q/KDv1RSgC8yD+cQ7/21uhz
    7gV+PRXekccjoexukO8lgAHUCPfD9cGRwn3aV6trj7e45oKCANg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S932683AbeCLDHm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:07:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41023 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932526AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "John W. Linville" <linville@tuxdriver.com>,
        "Yunlian Jiang" <yunlian@google.com>,
        "Larry Finger" <Larry.Finger@lwfinger.net>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.70393716@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 010/104] rtlwifi: initialize local array and set value.
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

From: Yunlian Jiang <yunlian@google.com>

commit ec71997eff2231098212a99934c0fb987a9e6b04 upstream.

GCC 4.8 is spitting out uninitialized-variable warnings against
"drivers/net/wireless/rtlwifi/rtl8192de/dm.c".

drivers/net/wireless/rtlwifi/rtl8192de/dm.c:941:31:
error: 'ofdm_index_old[1]' may be used uninitialized in this
function [-Werror=maybe-uninitialized]
     rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];

This patch adds initialization to the variable and properly sets its value.

Signed-off-by: Yunlian Jiang <yunlian@google.com>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/rtlwifi/rtl8192de/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192de/dm.c
@@ -844,7 +844,7 @@ static void rtl92d_dm_txpower_tracking_c
 	long val_y, ele_c = 0;
 	u8 ofdm_index[2];
 	s8 cck_index = 0;
-	u8 ofdm_index_old[2];
+	u8 ofdm_index_old[2] = {0, 0};
 	s8 cck_index_old = 0;
 	u8 index;
 	int i;
