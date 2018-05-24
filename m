Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527164079-2-1746631701519541725
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164078; b=LIEHd/NFl3ehEds9kYy3r79UdtW25pZ46FiZf6bxoyd1bJ5WXQ
    3TN5xZiJeoTdzUc9VgjKk6cEymku4cjWIoczXiu6EGiHyBbQz/QwEoH55pnnjWLu
    Iv6HS+GMft3yVaVB+v/kQ4Uv1jL6AqU+3q9vGZ5PBAEcZc9gjunILqY87g+UBv2w
    IVi2dBZsAn68QcozE4ATyF74P1x96tIrJeRT23UFz0SgxKgzN66b9VqtXGuc9SZ7
    39IW1yOVWUYkgC7PKtsueQidmBkF1SG2y7QBRrVl0jyqyKNdM2jwoc9YzUKN92w6
    hNx56bJwvxdIjIbKJFL2mQuPyHxafmX0pEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164078; bh=e3qN3l5KPU6ngoRqA3GwFcUFgerv3M
    G/uUEM/LfUaKI=; b=FOMW42v0csjFxIB2N7vNlNAF6D4Zjf7CZ7cqS1mrLll8eR
    u8CKLhw8W9FYgv0bQ25oK87FCDie2u6F4YedOQM3LzuEth3Mzzq2DmbCvY+PmM9o
    kxpR1yNAzzqvF+r8OIl0hB2yGePM2IXF3APdZCYSGeRe+GKkZEZHT//sqZZRIKwk
    jnMsS81DWJlvAshY0U0M8bA/Wkf40FQuaOCIh/RlfwLAOmoemlAdgzprAhbOVNwH
    ylPDFXB6zomaCopNkQVywzogx0U2LBtotF9wH/DHneMiHyc3O+Yix5WF4E6LBwaH
    UtBHIEt2BmSt+YB2siU6r0qKMfIy6eeZ86CL8P9A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hGcCLEaa x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hGcCLEaa x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP7IgZMAw3MrCUowzwfJHVggznmpuxZZ+4VyyiyTfJzx5YvwJbe46WY85/1MX58CV2FWg6BYZXTG25a/iLEdADxCDIAs08tiyJq/Zw36w5NV0k2fvD5S
    E/KAc2Lkfeikku78+Jz//FJ9HuTJRhbs4fw1cAHbuDrWe4NhW0J4+s94pdiIdcH2PGBikwM3gUsQB4D85NqUOjIfRe6R+yn+OE0DU5TVAf0e3Asf8+hGN6fP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=ag1SF4gXAAAA:8 a=-O5xsKu7cXiJXXyVPtwA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966390AbeEXMOf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966338AbeEXJmX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+230d9e642a85d3fec29c@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3.18 43/45] cfg80211: limit wiphy names to 128 bytes
Date: Thu, 24 May 2018 11:38:51 +0200
Message-Id: <20180524093126.477631162@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit a7cfebcb7594a24609268f91299ab85ba064bf82 upstream.

There's currently no limit on wiphy names, other than netlink
message size and memory limitations, but that causes issues when,
for example, the wiphy name is used in a uevent, e.g. in rfkill
where we use the same name for the rfkill instance, and then the
buffer there is "only" 2k for the environment variables.

This was reported by syzkaller, which used a 4k name.

Limit the name to something reasonable, I randomly picked 128.

Reported-by: syzbot+230d9e642a85d3fec29c@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/nl80211.h |    2 ++
 net/wireless/core.c          |    3 +++
 2 files changed, 5 insertions(+)

--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2026,6 +2026,8 @@ enum nl80211_attrs {
 #define NL80211_ATTR_KEYS NL80211_ATTR_KEYS
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
+#define NL80211_WIPHY_NAME_MAXLEN		128
+
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_HT_RATES		77
 #define NL80211_MAX_SUPP_REG_RULES		32
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -94,6 +94,9 @@ int cfg80211_dev_rename(struct cfg80211_
 
 	ASSERT_RTNL();
 
+	if (strlen(newname) > NL80211_WIPHY_NAME_MAXLEN)
+		return -EINVAL;
+
 	/* prohibit calling the thing phy%d when %d is not its number */
 	sscanf(newname, PHY_NAME "%d%n", &wiphy_idx, &taken);
 	if (taken == strlen(newname) && wiphy_idx != rdev->wiphy_idx) {
