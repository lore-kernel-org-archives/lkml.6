Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804779-2-6420950604731557378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804778; b=svnnbd02ONaHZuK2UDHP2tlulQtLt/6/dQVM7HzKxG207pG
    PhiVTjrffiAsp5fLdVWxYE26snmUKaPd0aRhPIJqzR5rEHoDci7cv74Wfe344otP
    MMsxYVib+MbiRs0LD44i9Ee5AU5DK7OxWAeCWeG+Er/qJofdJovsImGhGqpD3wL1
    yCSM75VQTAPUUvLfBmHZiFEe1TlotFsrf7bqzt9cnG+nGsQqlsjyFzX8ybbCL8Oe
    zCpLQveSq4ElS/rgzspIs3iinajxxwZmB691+6ztxfiDnFa6vFAMBRsudbmX+wU5
    Z+YWeWT6UTvpcrlW4TmrxcSSQjCtA6tdgkP1wBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804778; bh=GfEy9T1eCEr9OvTvhhaWq9mdNG
    sVb+MivhBl80U0a4I=; b=Hu6EiFkjgzoDMp8kHdRyeF/a9+jhr8kwc8uAOOe4tN
    ytiWgO8JEUwoTJFBe86Br62j3R9BaY8C8iRHuMjoW23VlcCu6iMqlNHqExLfSRfh
    ADHNkN8wrlewTJ5ruVpmOl+bYNAS575nbR/Kzwnf0y6EB/+EUOwzkvAlOy58sNBY
    UhLL+HbdRYGIj8AuhR+0PxfMLhMYhKUPJIqeXWZDH3u4Rizrqj0/qICB7PSWUHZo
    ZlRkSdXEgMKES3kt1sG9poSog2bFuzZcKRY7AiMSUPXPmZOl2EFT//UPRKwiaLa/
    UUoRlSMq4bt0UKYPrQgOQZmdlB0SoqnpNUjM3tQW3uQg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755062AbeCWKFn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbeCWKFk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 028/177] ath: Fix updating radar flags for coutry code India
Date: Fri, 23 Mar 2018 10:52:36 +0100
Message-Id: <20180323094206.423733296@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>


[ Upstream commit c0c345d4cacc6a1f39d4856f37dcf6e34f51a5e4 ]

As per latest regulatory update for India, channel 52, 56, 60, 64
is no longer restricted to DFS. Enabling DFS/no infra flags in driver
results in applying all DFS related restrictions (like doing CAC etc
before this channel moves to 'available state') for these channels
even though the country code is programmed as 'India' in he hardware,
fix this by relaxing the frequency range while applying RADAR flags
only if the country code is programmed to India. If the frequency range
needs to modified based on different country code, ath_is_radar_freq
can be extended/modified dynamically.

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/regd.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -254,8 +254,12 @@ bool ath_is_49ghz_allowed(u16 regdomain)
 EXPORT_SYMBOL(ath_is_49ghz_allowed);
 
 /* Frequency is one where radar detection is required */
-static bool ath_is_radar_freq(u16 center_freq)
+static bool ath_is_radar_freq(u16 center_freq,
+			      struct ath_regulatory *reg)
+
 {
+	if (reg->country_code == CTRY_INDIA)
+		return (center_freq >= 5500 && center_freq <= 5700);
 	return (center_freq >= 5260 && center_freq <= 5700);
 }
 
@@ -306,7 +310,7 @@ __ath_reg_apply_beaconing_flags(struct w
 				enum nl80211_reg_initiator initiator,
 				struct ieee80211_channel *ch)
 {
-	if (ath_is_radar_freq(ch->center_freq) ||
+	if (ath_is_radar_freq(ch->center_freq, reg) ||
 	    (ch->flags & IEEE80211_CHAN_RADAR))
 		return;
 
@@ -395,8 +399,9 @@ ath_reg_apply_ir_flags(struct wiphy *wip
 	}
 }
 
-/* Always apply Radar/DFS rules on freq range 5260 MHz - 5700 MHz */
-static void ath_reg_apply_radar_flags(struct wiphy *wiphy)
+/* Always apply Radar/DFS rules on freq range 5500 MHz - 5700 MHz */
+static void ath_reg_apply_radar_flags(struct wiphy *wiphy,
+				      struct ath_regulatory *reg)
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_channel *ch;
@@ -409,7 +414,7 @@ static void ath_reg_apply_radar_flags(st
 
 	for (i = 0; i < sband->n_channels; i++) {
 		ch = &sband->channels[i];
-		if (!ath_is_radar_freq(ch->center_freq))
+		if (!ath_is_radar_freq(ch->center_freq, reg))
 			continue;
 		/* We always enable radar detection/DFS on this
 		 * frequency range. Additionally we also apply on
@@ -505,7 +510,7 @@ void ath_reg_notifier_apply(struct wiphy
 	struct ath_common *common = container_of(reg, struct ath_common,
 						 regulatory);
 	/* We always apply this */
-	ath_reg_apply_radar_flags(wiphy);
+	ath_reg_apply_radar_flags(wiphy, reg);
 
 	/*
 	 * This would happen when we have sent a custom regulatory request
@@ -653,7 +658,7 @@ ath_regd_init_wiphy(struct ath_regulator
 	}
 
 	wiphy_apply_custom_regulatory(wiphy, regd);
-	ath_reg_apply_radar_flags(wiphy);
+	ath_reg_apply_radar_flags(wiphy, reg);
 	ath_reg_apply_world_flags(wiphy, NL80211_REGDOM_SET_BY_DRIVER, reg);
 	return 0;
 }
