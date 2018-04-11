Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477819-2-17682933926617991661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477819; b=VYRHRanvsvQweyhVIHYDMM0rXF0MvWAq5C9STqKso0BFBwdJnn
    pth2sALSZJD6Q2Yhio+cmSn8XKT8ePxkdUaDvacBBukMBqXJaJUUEtHLJyGn6STo
    Tg9PPyqrYotGk5PAmG7XwmwqBaWmhATH9gWEXOzfkSqevCx9DV5RxaDulHeE3Q98
    BFh9vkW/5oPxLQ2a1nEgjgw9XULY6sTpe43IRagJZf3ojsy4xpa2zxKqQKbOsWzi
    /CtycGMKjm4QO+imC5T5wTWV7SHJVi0fY+GZVk5faXIfofg2klnW+Ted46cq6mLq
    CGYYPzKx7I0DlUy057fByvPyu8V4UqDDWiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477819; bh=RHumeLrNZRbeFDbv4I/6CXjcR2N543
    fFUDNmfiJ4JYc=; b=X3IAwfceKZfE8lykqsPPaC/WGHPqN3yC3sLlZ4U+k+z/pr
    M9pI91UADLrLz0UKf/WZbSlAhhO/mc8vpzzgcCJSPDBdstRX/2/rxuGZFvcr4aRI
    XAfDiEUFqfEzlHiZGHA3Sez5FGUFetprPLMua5PJzDquCKjxo3WmJD05a10vTpIE
    fTMGUkQ5FrHhckxhvXcKowv0C0q/usp9p8pFDDAelOZpNwpglL7C7mcTc8O9C0NR
    g+3nXu2I7BLAyW/dkqkCdtbDn/fJ20qSuwIfGXH/mQkz/B/tPFjWNDZgRj92roQU
    SHv3GOQJN5FTsmRRLDb3Ce4J2tX+w1j7jApC2ttg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBc9ZGjvdheG7stx/ZtbAHCT5dJNFu2WsXIstp3Zku1xjYkfogO7KtmQOdZDqUkoTSDq6+87SeHaod8xEZhfUcvkhGV5ae8uGh06BYE48L4kAauwfRK7
    Oeunfcs7zSodatjJij3UAartgQABqXmVtzUvyUY1wo4qONl3zTCvmVSyQgrSLv1ntCMgD50s3CoAvVQqlP68sANS5PnRI7yNcsoZF/h3dstIIKK4Ot4gBaPj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=k1kETvRik_gOXROq0yoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933158AbeDKSwx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:52:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933117AbeDKSwv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 013/310] mac80211: bail out from prep_connection() if a reconfig is ongoing
Date: Wed, 11 Apr 2018 20:32:32 +0200
Message-Id: <20180411183622.879087040@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Luca Coelho <luciano.coelho@intel.com>


[ Upstream commit f8860ce836f2d502b07ef99559707fe55d90f5bc ]

If ieee80211_hw_restart() is called during authentication, the
authentication process will continue, causing the driver to be called
in a wrong state.  This ultimately causes an oops in the iwlwifi
driver (at least).

This fixes bugzilla 195299 partly.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195299
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mlme.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4332,6 +4332,10 @@ static int ieee80211_prep_connection(str
 	if (WARN_ON(!ifmgd->auth_data && !ifmgd->assoc_data))
 		return -EINVAL;
 
+	/* If a reconfig is happening, bail out */
+	if (local->in_reconfig)
+		return -EBUSY;
+
 	if (assoc) {
 		rcu_read_lock();
 		have_sta = sta_info_get(sdata, cbss->bssid);
