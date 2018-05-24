Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160594-2-604811628105005034
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
    1527160593; b=OpcjemHRjGsNESTvcJIVW9EGTH6wOmJAYhmlANXMtKIfSUbZd3
    E5FKkTQ6jijk6stg8w31tdc7wYQfKLyW9tMFeJ3Oz5g1zGd76h1bwpiBZB2syYkf
    y4HfB003KeP3Sx127H0GKTe9q2vcMK98LTw15YOzmaRw19s6OiRIDBUapBBpadhB
    psBfXnIoCsl9EAepsjwpxQu7yC/V2GulaCi7bD49qfhLYvDFUPFWOkNx/2SC+WbJ
    epPrGD/mrsVhiRc2up1MG+zIKhTl1pSbS+sAN2wYRSbFnZib6FutyhqQKvoCzHXV
    ADp81yx09g7KT+/fBTNV7sYyh/B/e+t/YJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160593; bh=QWqU9g+aevjRoEzVBnpuhLm4Jajndp
    t99nLVm8ljuuU=; b=flM/93iO3zb33EWOnhsU+nml4Tr8XU5wCOv/Am/xxwNP3x
    HsEQwwEfDsX8vp/L8go8UXUJABwG/96f0gvL4ej7FoR+l/6tc04fKW7oqgy4QwML
    dq5gelLRn8Vr47oRzsPbtzjwd8QADjub/SslgslosT9yxktRK9jOiVeL79UibwX/
    8/Tr4nlmbuFxoiW2fxwm943Yy1ZYI6B2BXAUWsP53pHptg/IrKOdeDvCEFjUvmXc
    WWHFj+Qt2q9FmzHU/HIsJ2lmFglXfzozVQ9D8mKS2ZjoyBlEOF6dCBMDw2c0sUdI
    AyrGDOAZESeWhXyjB9KwD0QgjbaT7+iNQSRJvcfQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SQrhnUiK x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=SQrhnUiK x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCKQl97q+vxA4y6SEIfSGXvORldOFDGmguSFGxkRNLWA9V/y/widFhrrNWyaZYE7Yo6sCBQEnzMDmIkqVo2WBxDThlm0nn8flzyttbz85KEyRogLgTOD
    kkpXM8bmD4RfWn9OIGn7mT6Eiaempyqj4B5iXoyzwK7nXjzTe0DXiuEl/HNjZ0jRHkr9w+iyZ0Xa4y1PvTduyadwYjn8MFcQOaJ44w1iuJVGH6e/p3Ay9O0C
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=ag1SF4gXAAAA:8 a=-O5xsKu7cXiJXXyVPtwA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968044AbeEXJxc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968037AbeEXJx1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+230d9e642a85d3fec29c@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 051/165] cfg80211: limit wiphy names to 128 bytes
Date: Thu, 24 May 2018 11:37:37 +0200
Message-Id: <20180524093624.091129328@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2604,6 +2604,8 @@ enum nl80211_attrs {
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
