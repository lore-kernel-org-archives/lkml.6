Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835407-2-4916568111738442061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835406; b=Bre/jTPDBowE9nI8KMTJ2Mp3obr7VOssF73ux0MQCjRUehF
    pi+Vw6jHqFA9fqkHpusdgmBtcpZ9N+d9mww4v9Y7hbtuZ7FscisVZPgOmtYiJAUD
    b2k+6TWQAw8b/ID9aNad3CUSjqqjVLhSeGWZW4vcWa5l8q534rdHhnhpkuW8jLm+
    iHXAnhtEsklHVvdSbuFucDLC9H7ZgjAfRUOVjyp4E84B9eoEDewd38C64IKEZY9t
    Grs6gv2rcc7fXD5CaSCr887PtzS8G0CSF/vcFc2w3/4eVcBeNElQedH1Cc9Azvpp
    lptKzTbQCHXCYZJvLrVKi/rozhMpyRSKO4uF5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835406; bh=xGRDG/rNXxTH3arx1/x
    TgY2CJu8mOxxQPr8UB6Mr+MU=; b=trXngOT2xlIBQVOmRRQk10RakxXWiz4oai9
    R5iEDuM/n5aRyo7BQxcJGp+aqWt2unKLVj07uCQt+YWv9G2TLF7ku2oYKtA5L53A
    PMXvIew78EzCt7eY9lbT2lUvSGFNFlr3FxJmjGqRmxsr8ErSCPN22V/rtJ5AQETR
    8QOVzVIAqcc3TEjJid0NWyolYLN0XSmnxqE8BELDZVH2Vz4IJPsTVfc+YlRv6Ss2
    VV0EoYYIRMp4+Mx+T8nwVGqh1UgtyU1+67P7Xucsnzt2+yKKDcwViXUaHm9nJtki
    l/C14MJxu1YEUK9vbYQq5N6057oCKZ4HuRbSwbptOX7K28QSUXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbeB1Q3z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:29:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35170 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934792AbeB1QPU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:20 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Johannes Berg" <johannes.berg@intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.631518194@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 205/254] nl80211: take RCU read lock when calling
 ieee80211_bss_get_ie()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 7a94b8c2eee7083ddccd0515830f8c81a8e44b1a upstream.

As ieee80211_bss_get_ie() derefences an RCU to return ssid_ie, both
the call to this function and any operation on this variable need
protection by the RCU read lock.

Fixes: 44905265bc15 ("nl80211: don't expose wdev->ssid for most interfaces")
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/nl80211.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2354,12 +2354,13 @@ static int nl80211_send_iface(struct sk_
 		const u8 *ssid_ie;
 		if (!wdev->current_bss)
 			break;
+		rcu_read_lock();
 		ssid_ie = ieee80211_bss_get_ie(&wdev->current_bss->pub,
 					       WLAN_EID_SSID);
-		if (!ssid_ie)
-			break;
-		if (nla_put(msg, NL80211_ATTR_SSID, ssid_ie[1], ssid_ie + 2))
-			goto nla_put_failure_locked;
+		if (ssid_ie &&
+		    nla_put(msg, NL80211_ATTR_SSID, ssid_ie[1], ssid_ie + 2))
+			goto nla_put_failure_rcu_locked;
+		rcu_read_unlock();
 		break;
 		}
 	default:
@@ -2370,6 +2371,8 @@ static int nl80211_send_iface(struct sk_
 
 	return genlmsg_end(msg, hdr);
 
+ nla_put_failure_rcu_locked:
+	rcu_read_unlock();
  nla_put_failure_locked:
 	wdev_unlock(wdev);
  nla_put_failure:
