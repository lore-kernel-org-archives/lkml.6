Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834793-2-18022314810242598349
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
    t=1519834793; b=GBb4G7acOsNxMpH1r1bQ86LWsHpUJzoxavAWyBwIC/HslD8
    WRQyK7VqTLiZ/bsc/ohR0wmVmzumCx7py61qYst/EFqFq5aqCfju7ifjH5wi4t7K
    o9CDSQi/4Og/UjdM+8JtQNy5AxqOYOW0SegNTIga6vKpCPbW1buarObwue75xFWk
    kQtw16NM7Uxvw8pzt5LNIlOXCug14/n0hVw2ObYRRzrbcYk1yRS+viX93Qk8tXHJ
    yiTcSCtxiMn4LPcNMutbKL4AwJnZvVXm5OjHqALMtBjaAFBzEIGhTRn26yW9STmv
    mqko0XtLOoAp4wFYtgQx0i5A1Xkn7kgbYbJjpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834793; bh=vcT1ktBhZ4DPiB2J4HC
    ovN1NuPYkVf1yT+dpVddR9wU=; b=qaILle/7SvrVv/k/f7XQ5al7JwnFbH2qwgF
    9bWOqg2PQL2iEH04nIrfXDHqJ4I3yOaEYtphcjK45F+NabswMbXG/xx57qQtfHww
    0DhUBKZvYFLZFuc5gMsQ9po/RStDHE8ijNAI6hPtaWyCRS0SZpiVvjge0a4HfZOU
    Vmlvu+K3VRzuL/9B7s9mgCataHP572plCuPeyTDAWOzxxGCzVxzrH/VOzjCDyEX7
    So7J4WzTXUX3paZQBRtb+WveBiaJnQ6iTzc7ri0WbIwoXHsWgJJ6ep0Fz1LSxk4C
    t8dzbKgtV3qPJFkOqATyMKu3Xy//489FVQS/nkabreMbTJp9p2Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeB1QRm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:17:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35261 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932298AbeB1QRk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:17:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Johannes Berg" <johannes.berg@intel.com>,
        syzbot+8dd9051ff19940290931@syzkaller.appspotmail.com
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.184488353@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 206/254] mac80211_hwsim: validate number of different
 channels
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

From: Johannes Berg <johannes.berg@intel.com>

commit 51a1aaa631c90223888d8beac4d649dc11d2ca55 upstream.

When creating a new radio on the fly, hwsim allows this
to be done with an arbitrary number of channels, but
cfg80211 only supports a limited number of simultaneous
channels, leading to a warning.

Fix this by validating the number - this requires moving
the define for the maximum out to a visible header file.

Reported-by: syzbot+8dd9051ff19940290931@syzkaller.appspotmail.com
Fixes: b59ec8dd4394 ("mac80211_hwsim: fix number of channels in interface combinations")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[bwh: Backported to 3.16:
 - Test chans intead of param.channels
 - GENL_SET_ERR_MSG() is not available
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2439,6 +2439,9 @@ static int hwsim_create_radio_nl(struct
 	if (info->attrs[HWSIM_ATTR_CHANNELS])
 		chans = nla_get_u32(info->attrs[HWSIM_ATTR_CHANNELS]);
 
+	if (chans > CFG80211_MAX_NUM_DIFFERENT_CHANNELS)
+		return -EINVAL;
+
 	if (info->attrs[HWSIM_ATTR_USE_CHANCTX])
 		use_chanctx = true;
 	else
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -716,6 +716,8 @@ struct cfg80211_csa_settings {
 	u8 count;
 };
 
+#define CFG80211_MAX_NUM_DIFFERENT_CHANNELS 10
+
 /**
  * enum station_parameters_apply_mask - station parameter values to apply
  * @STATION_PARAM_APPLY_UAPSD: apply new uAPSD parameters (uapsd_queues, max_sp)
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -456,8 +456,6 @@ void cfg80211_leave(struct cfg80211_regi
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
 
-#define CFG80211_MAX_NUM_DIFFERENT_CHANNELS 10
-
 #ifdef CONFIG_CFG80211_DEVELOPER_WARNINGS
 #define CFG80211_DEV_WARN_ON(cond)	WARN_ON(cond)
 #else
