Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523480206-2-2180872138655850531
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
    1523480204; b=fKPFqvNwFSeveyLW69P1EAwtqCd/Kb7XCgvT+p2duvbTKu9MoQ
    B3uRjH9/j1wT2K0HCRiGridy42SrSigOi4iSJiAjsU92Vvt+zb/2QjzjEK70ozIx
    dmoZn/jBAt4XdJUe18eOXJg8lXHTJFXfkCAyDfvuqvKJYu0b57GhbCUJzvMgR+hp
    j094zV+eic5PtKL+bUmTNbo92zGUxLKIrJEkNnj//oyEHV2u3gvoLf7EWs4D4Bpm
    F4GEEKqnepUYylgXsV/vVANO3vOVNL6g/jQXnbTtQN+UYLq//wWR5Gz5JpLQGnYP
    ux6fXcR3eJZzZluDZe8vcg2i3I/B7U+2N6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480204; bh=h5uj8d6ZKpp4tAsT9zLqewrvSzqPfM
    HTNViIoJDN+Dg=; b=vrPkxDTOVCqNvVd+BfGGk9wAgaXCjoPSTJGPSF9A1qroco
    qxmgg1vqNvt2t2wFXycbVQLTGDUKwXwmr3FW8kJOOr+9lUa+M16qPDfGQaJdOflR
    WKoT6i9MODQnBuvYal5FNpCHnkMnz9kElLvqhhpybD1hM4dO16AQd2Qd0dhEeAuZ
    c8zUWsYtP9Zqmfq8KW6r0KZoV4v4Na2Gnbv56JDUf7xwkQo+6TDRYb6TJLS3VE5A
    q+83IzKT0YBsycmw7EniCES2S790Q5Nb1nYrmtpferIL20bPwrIeNZfNxXK6+9wy
    7lw5x3lXTzuE53J3/OErthp6TNlT65B8aRc0ZQUg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMWS8WF+C67NQbNEwbZ1tnVVFa8Y4muzcoaBLQxHpwJHejStN+Kx6Rua2SrB+rXjjQM01JRYjucXDx49Ai4mUoKCwpOfHi44zYb6IKRXtSHiuy8P1Gxj
    bD82NLTadGf+5A65r2f1hjP+L+jXL45nbJ5bQ3FO1YuNvrhByuJQaT7hTXNLoAt1oJLmn/9+JuwOzTebPgotNRkf1QLe/vbLJorCYjd4AMFoFLK+YXfjg4mp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=k1kETvRik_gOXROq0yoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeDKSoh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755426AbeDKSoe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 008/190] mac80211: bail out from prep_connection() if a reconfig is ongoing
Date: Wed, 11 Apr 2018 20:34:14 +0200
Message-Id: <20180411183550.536813653@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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
@@ -4326,6 +4326,10 @@ static int ieee80211_prep_connection(str
 	if (WARN_ON(!ifmgd->auth_data && !ifmgd->assoc_data))
 		return -EINVAL;
 
+	/* If a reconfig is happening, bail out */
+	if (local->in_reconfig)
+		return -EBUSY;
+
 	if (assoc) {
 		rcu_read_lock();
 		have_sta = sta_info_get(sdata, cbss->bssid);
