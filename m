Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839388-2-13247371981585165727
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839388; b=G9z55oeyw/7AgvaSz9LvpohOheIrl9P95IMaeKtxXIt1Eia
    ffhvMd5anvIpB6AJy+1iFB6NMM/Pvf084QuRWd1KftEAvicuVoq2sZtcYGurI79/
    HR85Gu+yEEXo2UMj6cpE9P3jJUcFPCKU61TGESoHt+3FAiftrPHFOij4pOVdu+N0
    DHxVt+xWJKEeUyRP8UHwbLOujIYXf5kJp7NC2m79OHxUBL2cYutyEcZwr0pTDPHB
    HeqTCo5PThowE04MU5spBws6ZapaN7Jlla/vSa5Y8vxe2gSLUjEeAG6Yqk0GPWz0
    JBdoj75GUBD2dYR4ec4e5UJA6+p/BTqnpJuFx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839388; bh=wOQJ8lMnIvmIDMq0SH8
    UqReoeth5G8jfd47kWReg5rc=; b=qmRC4mwGpN5sA72o1zxHZhk3or40fkWy8cZ
    f1Hg0LvXuu9+UOjjlJT4DFOYhBZtfigt2sRGNYo4h7uVSKIRsJSBaDzYzdg5ebUa
    IU/gZp2wFv56glx4vOWM7/cNi5EFgG+vC6Ick19nNJpe0fHOb/hgK3mCWyU/aTJk
    I3TU+qh7YYPV6tx7qlceP4pMKworF96O+zLDumTGPPFy8QKoFAzUflnaLXsgDSlk
    hRvUNsBSsi6lQ+m6dooKZCuAfNpKwPlhnXAlyAwyBbw+aSptWcsVcNAIoyo8hY2H
    XozZiWYpd58iJ6txpuFucjg2Rk3t7v6GB9Guowi3EooHpr2QVkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeB1Rfn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:35:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33199 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932552AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+1ddfb3357e1d7bb5b5d3@syzkaller.appspotmail.com,
        "Johannes Berg" <johannes.berg@intel.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.981908245@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 099/140] cfg80211: check dev_set_name() return value
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 59b179b48ce2a6076448a44531242ac2b3f6cef2 upstream.

syzbot reported a warning from rfkill_alloc(), and after a while
I think that the reason is that it was doing fault injection and
the dev_set_name() failed, leaving the name NULL, and we didn't
check the return value and got to rfkill_alloc() with a NULL name.
Since we really don't want a NULL name, we ought to check the
return value.

Fixes: fb28ad35906a ("net: struct device - replace bus_id with dev_name(), dev_set_name()")
Reported-by: syzbot+1ddfb3357e1d7bb5b5d3@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -329,6 +329,7 @@ struct wiphy *wiphy_new(const struct cfg
 
 	struct cfg80211_registered_device *rdev;
 	int alloc_size;
+	int rv;
 
 	WARN_ON(ops->add_key && (!ops->del_key || !ops->set_default_key));
 	WARN_ON(ops->auth && (!ops->assoc || !ops->deauth || !ops->disassoc));
@@ -362,7 +363,11 @@ struct wiphy *wiphy_new(const struct cfg
 	mutex_unlock(&cfg80211_mutex);
 
 	/* give it a proper name */
-	dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+	rv = dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+	if (rv < 0) {
+		kfree(rdev);
+		return NULL;
+	}
 
 	mutex_init(&rdev->mtx);
 	mutex_init(&rdev->devlist_mtx);
