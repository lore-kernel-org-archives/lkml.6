Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477474-2-14345460242432393420
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
    1523477474; b=ncDQfr14Cu9p5mdbiypQvRPVpHIStY9EDBzua2dxjSVMubU8e+
    4aQmtK7kB0Nswin1OHf0tp0cNwEETq6mGAgeHMJa6asWSYFgX4Nfef+TwnBeIzt+
    6tkJ7CaBCX9W3wO72v/VBg8a8DMgaVFFPDljAKOfK5bESvv+NBlxTwOW6W3qgjA9
    6rQpYocgp8hJpLAIyGA5tjG8XkK4AF3sVEcCcgLRugWvKR06qHN34BNeo/bfOscm
    zTpFvI5zXxPV85jhmmhXh51Eha60z1BsL8hedBg4lDTK/YXqls7TEwEv+Xn/pp5E
    1B0FARCTJYyD+VOBI/Rjg1tCoNFNdinhpUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477474; bh=wuh+ntEJShgwr3Da4lrRVd2bp/bsKf
    Xmny2rG1zXH2s=; b=UkfRAkYCSwpli3f+DkKKkssYXMXNoZW5wycgpkQ8jMKodk
    E2sZjgZAV/WZqIi1Z762RlhyRvb99WNSvC01dYnasrvFPRiN9/odLtz1RkrCDqQ/
    FVlDdpGv46+d38WhWTbSVpeCxDZagrbb2LgCD7BLGIQi91sIFr11YELzE+XTrr4T
    bGgyS4MgBU2ZbS4S5thyqv3pk6gp3BsN0KrPMOM3waUMVANF/yQ1JvLMYEKW7BhK
    1l5/02tZfYTUJwlAp3vfjZOny0Jbus332HbB4a9dGkV7qLDbAIQDwEiuzpQU5z3A
    pRXYlpcrN0tS0sfES94jEQBFlNp0O/6EMCnAmVyQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIcnNwzmDN+eYxMAe9d4iUFQ++xjxZmfSuMDhlXF9xo4s2WvMV6HcP5I1PCItkb4HhFjLRNHMq/gvJDPfwcaxyfuvMXtky7FVFgctwPOIqUew1Hw7UO7
    93LkP6XNZC5Qpe2o1JZjtYGcfgqIC0CFFV+9XP5CxJj0+GTXL1ouj1JyYP3VZEsb8fr8WQWgUf9NUsx/4yj7ho7xm42fJhDeRNKO915dV7+/ec8yxL7Pd+3Y
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=-RvIgU9Ao91RJkrITpgA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDKUKz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:10:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933488AbeDKSyZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea della Porta <sfaragnaus@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 045/310] staging: wlan-ng: prism2mgmt.c: fixed a double endian conversion before calling hfa384x_drvr_setconfig16, also fixes relative sparse warning
Date: Wed, 11 Apr 2018 20:33:04 +0200
Message-Id: <20180411183624.197414726@linuxfoundation.org>
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

From: Andrea della Porta <sfaragnaus@gmail.com>


[ Upstream commit dea20579a69ab68cdca6adf79bb7c0c162eb9b72 ]

staging: wlan-ng: prism2mgmt.c: This patches fixes a double endian conversion.
cpu_to_le16() was called twice first in prism2mgmt_scan and again inside
hfa384x_drvr_setconfig16() for the same variable, hence it was swapped
twice. Incidentally, it also fixed the following sparse warning:

drivers/staging/wlan-ng/prism2mgmt.c:173:30: warning: incorrect type in assignment (different base types)
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    expected unsigned short [unsigned] [usertype] word
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    got restricted __le16 [usertype] <noident>

Unfortunately, only compile tested.

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/wlan-ng/prism2mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -169,7 +169,7 @@ int prism2mgmt_scan(struct wlandevice *w
 				     hw->ident_sta_fw.variant) >
 	    HFA384x_FIRMWARE_VERSION(1, 5, 0)) {
 		if (msg->scantype.data != P80211ENUM_scantype_active)
-			word = cpu_to_le16(msg->maxchanneltime.data);
+			word = msg->maxchanneltime.data;
 		else
 			word = 0;
 
