Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527155268-2-13787124728202459349
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
    1527155267; b=bCjNi8T6ugS7Io4lrwqpuAOBIl4oMtW17JLJQM+c+PjxYelV5h
    2kx+dWE5gI+HFD26uPkA8gIjafMyYOaK3jwm6D0sDdxNEu8d+miCbCgJhspghmmX
    fz6YdGw5NAJuE6+oiXOEDkcPdR/xGeZmnzzK6JXN2BzqGOG3dLu0hqnEiCTyg4P6
    xknYgmitEBvIoaYxP9S/0uLNLCKBu00fomuKUZlsEmKh3CGciD0U+lACiBESsWlo
    frCxF2HbYyYs00/nX7a8NuwRo/aVy/huuHEjhUboiFwz1c1fWZ8PYbdxiR6p+m5j
    R+UsaBIMOP8F2Zn0MxGeW9M4gh1IUhVV5/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155267; bh=7FeMTOkCB703Nfx6tQ6huhjSmJSWd4
    BhcKPVO1IXlx8=; b=Behm3JlkEJvk24iI0OXmBZk0Dwo+Cv3UpbLQ07ak1+5e6R
    3p5o33HMJvCU9LbSFYWHlkYIUMr1+KnsN9SC3WamZciEaMovkHFJUSBpZqnCMFeY
    DBvzDmrzTO5TKRdGTXiVioIcLsvzs5Aus/tX8W30cUJleLifZCe7sD0KHBdhOLIP
    emG701XTPJbQkt1C0RkpozWCTf+U2sOC9qBF067YS5HWWE/1Qt/6Et7BoOm6NZSK
    NDiwFXdsMWxN919P6XXUMRyQgKfK5V1jWiVCmYJ53KAWylb6TYlHQ9bGaD7IN9dl
    luPU2jyl/85xDChdgwP0f/DCe23X8A4eC2O43hrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=N/GiUzre x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=N/GiUzre x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHY1j3NgnwCXe1OpfQHbt/7G6kxDk8Pgg+It+9d1rPSTNXSALlVxQUZLeDBlU0+pileTV42xIgSoQ3L10y2+IfNZ9ndkRHpH4GneJ04KOzpwazmByY1r
    702QmaLDBlmDC2aWtugpJTyN+CgcAjelzwHf6dr7G3QNr02/Hrx51Z8LJV4imwa/zH7fGJLaDPe0KriZQKjFHtKMG93/ko61yy0VRZSPzo/XPPYMgVIhLe4G
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=ag1SF4gXAAAA:8 a=-O5xsKu7cXiJXXyVPtwA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967091AbeEXJro (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967084AbeEXJrm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+230d9e642a85d3fec29c@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 21/96] cfg80211: limit wiphy names to 128 bytes
Date: Thu, 24 May 2018 11:38:04 +0200
Message-Id: <20180524093606.821735070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2379,6 +2379,8 @@ enum nl80211_attrs {
 #define NL80211_ATTR_KEYS NL80211_ATTR_KEYS
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
+#define NL80211_WIPHY_NAME_MAXLEN		128
+
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_HT_RATES		77
 #define NL80211_MAX_SUPP_REG_RULES		64
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -95,6 +95,9 @@ static int cfg80211_dev_check_name(struc
 
 	ASSERT_RTNL();
 
+	if (strlen(newname) > NL80211_WIPHY_NAME_MAXLEN)
+		return -EINVAL;
+
 	/* prohibit calling the thing phy%d when %d is not its number */
 	sscanf(newname, PHY_NAME "%d%n", &wiphy_idx, &taken);
 	if (taken == strlen(newname) && wiphy_idx != rdev->wiphy_idx) {
