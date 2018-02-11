Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324646-3-2291458907528821210
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324645; b=Mng83aAe0ybbnE9cLvgij0/HH4CrkrXJnzCKNEkNLWmaDzm
    zGUXO8j0D8dEyYR9pPk3vWuXuA4GfbckwNWAtult1Bpwv3sO7Sk+u2adThli/yGr
    xBRviGkGKvp6GDYNrqeFYQzgxF47eGxOGZn11ePva2LZYAUIJbNmzZui+DxaoPc2
    G/jOUTU2k06Ny72q2lRoii+On9RWTg7F6r8vTNzlUnBAuTRAqL13jADvzJSBhz+n
    OlsO68n+49yBjjPp7IPV04TCiinAnS6N6YBk564B/bLLMEN2TKLgkkbBhy3r8oLH
    HRZmsz/3j4JxkOgbJ/CFR/6uxcZtcxtEraB6XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324645; bh=nD4jn2Fqb2z0cQCEbxG
    LKN/F4ucXtpnHNDChjmn3BvI=; b=PKcrDNc79YdJln6VZSKEpLu51W7kTXUoqOm
    y1DD8TX2lyYOhAZwBgLZj/sjuwyRkeZsFGgKuKgeBwxwoHiu3DFDEJ6mPuo81K6H
    LsN//+kZR7aJxs7zMgxsM8pbzkrfcnGg4OMT1sVhZnFoRwbsPBWVA8mCp/kbmWJi
    F3uxI0+gzNKVnW15fUgRk474iYhh/1ATUe9YIfcSVEfXJ0yKrcqBK4E6cOyEE9pf
    A0snMqaxdciekEhbQbH7pOTeslX5XqFV+1cCsdmBrgbcR8nK+Ibe64bhkrwYmbUx
    elgH/ZPD81upZ7wkUHGVycRz6aV2ouJKkDRVGG3W9JUii9g6vhQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeBKEtm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:49:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41807 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752833AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Johannes Berg" <johannes.berg@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.830922146@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 100/136] nl80211: don't expose wdev->ssid for most
 interfaces
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 44905265bc155e0237c76c25bf5ddf740d85a8f2 upstream.

For mesh, this is simply wrong - there's no SSID, only the
mesh ID, so don't expose it at all.
For (P2P) client, it's wrong, because it exposes an internal
value that's only used when certain APIs are used.
For AP, it's actually the only correct case, so leave that.
All other interface types shouldn't be setting this anyway,
so there it won't change anything.

Fixes: b84e7a05f619 ("nl80211: send the NL80211_ATTR_SSID in nl80211_send_iface()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/nl80211.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2341,10 +2341,32 @@ static int nl80211_send_iface(struct sk_
 		}
 	}
 
-	if (wdev->ssid_len) {
-		if (nla_put(msg, NL80211_ATTR_SSID, wdev->ssid_len, wdev->ssid))
+	wdev_lock(wdev);
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+		if (wdev->ssid_len &&
+		    nla_put(msg, NL80211_ATTR_SSID, wdev->ssid_len, wdev->ssid))
 			goto nla_put_failure;
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_ADHOC: {
+		const u8 *ssid_ie;
+		if (!wdev->current_bss)
+			break;
+		ssid_ie = ieee80211_bss_get_ie(&wdev->current_bss->pub,
+					       WLAN_EID_SSID);
+		if (!ssid_ie)
+			break;
+		if (nla_put(msg, NL80211_ATTR_SSID, ssid_ie[1], ssid_ie + 2))
+			goto nla_put_failure;
+		break;
+		}
+	default:
+		/* nothing */
+		break;
 	}
+	wdev_unlock(wdev);
 
 	return genlmsg_end(msg, hdr);
 
