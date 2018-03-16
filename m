Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214705-2-11758837376538634748
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
    t=1521214704; b=avkfiSqHr6M7KWuBd96NvOamHsnOLzt3WlKTAuYks4LBQOM
    9bpCcrglDfnwYGBKp0dQXEcJOQE3A+wGQLRG4UyFrnoq6eyhPkr1ojVaF4d13k3K
    OSMXBatNxrwmec7kbwGP38VFWzsYOxLYYCckZAHSnu5edsDb2bJjRidqm6pUjLmo
    /0z6t+0Ukjq6E9aPjAVxjzFsGwXS0vnt1O4H5slS7F5ofWLoyzpip8cTj1X5kHb2
    foeiSVMbOH/VdxOkLHLHYV3LjMln7WH7uTBhpQLlF/Tz/ZjlLSW+zEHI5UZpoYZN
    9OoCO1qa47AL4zPCOKm9L/ez6BFFk8g+xmcf+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214704; bh=g7rCfQywEByIzB4tgG/CHsFRz4
    MOYu4bVh6E5mVBkHY=; b=pBZWZc/u/TOOA/okp/XHwIfJ4BGqMUCoSCXklNHF00
    ZJpOA/FfdcvnF8kVkpBOFscBYNvumh0Gc0X4fMe9fhUlLL0wLZflhpmc742CVkxe
    WGbVVNiHAr1Q8pkGx624tMwKMp7WJDY22tNt0+b4ncezInjC1FcbMpbUJN1xcizS
    yEq/lRZD1iYyVtOFuacuzlP8dNqA6iKFzxD4aMWcc+0zk60MgnmJZ1FUv+ZVx/yN
    TCQx60BGpGcQzrGh04FQ2qvQbp+RUJMvTehrg1rjlSEjzYyv0KnxzlXPwDnI6Qri
    KZFQEnyVKdKqflj8RCZlZLTICzYJ9GoMcT4T8eq7nJrw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbeCPPiV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:38:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754501AbeCPPiU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:38:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adiel Aloni <adiel.aloni@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 097/109] mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED
Date: Fri, 16 Mar 2018 16:24:06 +0100
Message-Id: <20180316152335.151840596@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
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

From: Adiel Aloni <adiel.aloni@intel.com>


[ Upstream commit e16ea4bb516bc21ea2202f2107718b29218bea59 ]

Enforce using PS_MANUAL_POLL in ps hwsim debugfs to trigger a poll,
only if PS_ENABLED was set before.
This is required due to commit c9491367b759 ("mac80211: always update the
PM state of a peer on MGMT / DATA frames") that enforces the ap to
check only mgmt/data frames ps bit, and then update station's power save
accordingly.
When sending only ps-poll (control frame) the ap will not be aware that
the station entered power save.
Setting ps enable before triggering ps_poll, will send NDP with PM bit
enabled first.

Signed-off-by: Adiel Aloni <adiel.aloni@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -727,16 +727,21 @@ static int hwsim_fops_ps_write(void *dat
 	    val != PS_MANUAL_POLL)
 		return -EINVAL;
 
-	old_ps = data->ps;
-	data->ps = val;
-
-	local_bh_disable();
 	if (val == PS_MANUAL_POLL) {
+		if (data->ps != PS_ENABLED)
+			return -EINVAL;
+		local_bh_disable();
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_ps_poll, data);
-		data->ps_poll_pending = true;
-	} else if (old_ps == PS_DISABLED && val != PS_DISABLED) {
+		local_bh_enable();
+		return 0;
+	}
+	old_ps = data->ps;
+	data->ps = val;
+
+	local_bh_disable();
+	if (old_ps == PS_DISABLED && val != PS_DISABLED) {
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_nullfunc_ps, data);
