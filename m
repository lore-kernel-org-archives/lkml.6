Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162747-2-11608589890701401865
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
    1527162746; b=h7ywjsOhoUBjpCnp4KvcAXc21cVY6cGJ4QH7oJIrfh5Kvq8Qd0
    vS6HaXMks4A7RaXxY8sqjWQY0QZ/ClUf3/NRIIS4cKXBORpB4YYyd11PzuvGDW5r
    LifAoJz5olin2jHeUDTwtPpNnrgvjNs0SEFVpcMuC0jPZOPwt0rcKmRq5+c7cflO
    hGrCT9yvK/iceqSuETUJn4fj0swCbW4aeygyPvf2eg0ad1FHyI7m6H1+NMcVhSJr
    ZuK5fJElmg7maqC0xRruMmXEJT6dGdTQyqnBBNCNlVWFIROxlv0g2AVvj4Ir7qFn
    9qDx26LJLozANhDcda+VpLYPZnyjuKc9FJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162746; bh=dlm1bc7RDiPFpBPTedxUNx+hCPf1N2
    vzhSBjVkzWIIs=; b=N0q6Ox9WGapujoyyyJBXZUqcXaSSgeqh2lgVjGn8Tj2mDZ
    AYEsGJRamdbF1pvuUHWvlTfuSBYbuQiI25oqjtVV7gl7XK63zYhkQaus74yLdYWY
    Q+dL1hNK2q1tIrPbe+GdpJUZ/FGkOvywLqpRREjVdOyYwKeNZKKkDv83I0qXzz3f
    oPm6KqqQ4/sGkf9/XlwmCMEyZ8Gd1yssJgnYdWhSmRb665OP44GJolOiakE6b0JH
    Nzjb71xeD4CQmNLBlAx6HYZxGRctiaF6lYK7/CZMVN60daqkkREmlx0J5+Dj2t59
    QjhP4o0wi6dUpsYUifJiP80fImPe8T3okSBSq+5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JcW2viWy x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=JcW2viWy x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLI9MgCWZ0DpOObSUTSmXIXQHRPAQIObV/iRfnwCWOvFXyNilgMb6+NIcR9BcmbAvWZd3LGsu15EJ8KbUYMyRVbobhUAFCS3NRo+R9e7/znJQwRHg6sV
    AdksEwTJBj1aPAKpQ8gAA5hrypVaEeXcIsh8etoWsROonXnGZX4nQmJ041DOQoxdLbOevRU8G2yNp9NUYyl0hIDc96XNzvG7hy3gaWWS7tw+o497aliWtPX8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=ag1SF4gXAAAA:8 a=-O5xsKu7cXiJXXyVPtwA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966992AbeEXLwE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966932AbeEXJqe (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+230d9e642a85d3fec29c@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 90/92] cfg80211: limit wiphy names to 128 bytes
Date: Thu, 24 May 2018 11:39:07 +0200
Message-Id: <20180524093207.848496574@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2195,6 +2195,8 @@ enum nl80211_attrs {
 #define NL80211_ATTR_KEYS NL80211_ATTR_KEYS
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
+#define NL80211_WIPHY_NAME_MAXLEN		128
+
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_HT_RATES		77
 #define NL80211_MAX_SUPP_REG_RULES		64
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -94,6 +94,9 @@ static int cfg80211_dev_check_name(struc
 
 	ASSERT_RTNL();
 
+	if (strlen(newname) > NL80211_WIPHY_NAME_MAXLEN)
+		return -EINVAL;
+
 	/* prohibit calling the thing phy%d when %d is not its number */
 	sscanf(newname, PHY_NAME "%d%n", &wiphy_idx, &taken);
 	if (taken == strlen(newname) && wiphy_idx != rdev->wiphy_idx) {
