Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839058-2-8504093222653644051
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
    t=1519839057; b=gca1QVaq7b7dl+rnc+Wy2SLZxnhwVWyx7G9m313+zxN3GmH
    X8OzyTGyMFPEv47G1HFs3K3luCFUV3c2Tc25ydfOOx1tUZME2hVf9i0fBRBzVzcF
    AinWKkNDe+nosnhyeZABpptHhlR9iR5YfBDVKufFJJj1Rkyu4cV7l+Q8jixh4TLH
    RT438GlTEwR9Wd3ny+XEb3seT/FVoCF3wcjyxvpTfEYww69yYtuVMrfpCIsYga36
    GWMj+BmuZxrmbmclkq/CRTVkPzieWaVmL4os+3sKof/KCePJ4kMoNJ2kLCxf4PPm
    ciUviT47hVemPxDywWI7zN4bcG0OicwIrbPHtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839057; bh=Wk4CXV/4/2hndvrAxpS
    w5MBMWEfe/uUxzmipXuO29ls=; b=bCkjCFFjwuF17cOKUt8RDWmDAK/WmVjcr4x
    nybLPBGZ+2hyBF1J3NKlGuWBNlfjs8gjEFP7Ng+cVQEFC/5M8XcgJoDJ23f9sbia
    aM7/qfjO52eebgJYMVJycpXDqcvo5nHNMHzVuadFtzz5QkzhWFRisgdL61i3kUfx
    g4OuXqfkwupfGFYBubJb70f5pGcGIq8qlfzWYou7ioS7ua9awB/C1nEqoo26WfbS
    ew993rwmfRWBGSHFeSLq6Awy+oFeCnW16KZlWnYecEuDahuVTXfDxEyAKSeZ6yIb
    ip3zcWXExdWii6hXLi6WdTr0jqU1NZ9YLwdkSR0y2r3R9oV9BZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeB1R3J (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:29:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33230 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932585AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Johannes Berg" <johannes.berg@intel.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.941880526@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 111/140] cfg80211: fix station info handling bugs
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

commit 5762d7d3eda25c03cc2d9d45227be3f5ab6bec9e upstream.

Fix two places where the structure isn't initialized to zero,
and thus can't be filled properly by the driver.

Fixes: 4a4b8169501b ("cfg80211: Accept multiple RSSI thresholds for CQM")
Fixes: 9930380f0bd8 ("cfg80211: implement IWRATE")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2:
 - Drop change in cfg80211_cqm_rssi_update()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1265,8 +1265,7 @@ static int cfg80211_wext_giwrate(struct
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_dev(wdev->wiphy);
-	/* we are under RTNL - globally locked - so can use a static struct */
-	static struct station_info sinfo;
+	struct station_info sinfo = {};
 	u8 addr[ETH_ALEN];
 	int err;
 
