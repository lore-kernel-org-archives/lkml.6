Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479050-2-15744155662371593671
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
    1523479049; b=gM3vN5sB/gPlDhQPaui1/M3fahtNte3bcK+rkkovm04IEhG8lN
    BKp0FgRT+NsbUg6ue1pyoFJb3tdPWXOfFP4GU97exv++ZbE5smzbkSKPXlh19y3F
    WHp6ijdrfwfoepA8XzyBu7MaoPkoOmO1OJizcUyQTDghhQXgpF4/BOmuJZZBPFLO
    ibLPcE4hajNEFEbTa/bWwb3r5vJ1K6U4fJbMEYAdsjpzNL9VCA+tRRpphc/p22Fa
    xpWMFlV5Ig0dSkybn/5g9XHWS2oaG7emJCR5g7vbv+GAh/pNEi4rgwi+fR+5gD36
    lyfFW6GGcBDhFUvo6qXdYrYJto7EO1ZZ8Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479049; bh=xybYYzktKuOhu5W65Hl3Hi8FSeh+Yq
    Nu9jJfwDAvqLY=; b=lJ+vQm0zQ5uQe1SITxOZWo0w6G8Nr8762uJeIA8gq4x+Kp
    vpAg/sHIEHOsymHch9mPOuckuM+OWyFx934U1grL3V5bEez2zsjGGA/MNMpWl0nT
    en/7qYL8g3Uqs000YzQixnx2dWko5J2KOgcPaLM9w1aHiYUUa/z9f9NFP6Pl9CmA
    lZyXmpylK+Qm48I8nepo9xpoyErVAwc2FsVuyF0tNQjO0ntp5FHXDnjE6ZN3kAHJ
    bnj4+vyELIz+WywOs2qDGAlt2WPIjXEVTsj93l6b3Tkhekh6ghNlmOOTNHQBUfEC
    FtdZpR4naLbsfj/MW8rvzxXUNEAdieS32zJEA89w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfMVBj/3SGyfNzDgjXnUj9L+m9XnxR1uIPFIS0mWLt1qNTjAr+gcaOwZglU/pWj2MEnxhYD5jIS1zkz6ouMDzabqkmd5HbwBbj+v/hklEGJ8f1rOBVTMF
    9WvroRjPKWXaRrCJKt8q5xH3s+Kj/25wBGOe/jAaga5Cfh12F0rDi14TJORsPlAYPSAO6AQqc3brNz0Sd6/mrYKphqW2W7jBOCc3qL0RY6Fhu2jJ7YALDQLO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=74eS_wq9n9ry9aIxH8MA:9 a=QEXdDO2ut3YA:10 a=bOnWt3ThIoLzEnqt84vq:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeDKSsa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:48:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756067AbeDKSs2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 114/190] cxgb4: fix incorrect cim_la output for T6
Date: Wed, 11 Apr 2018 20:36:00 +0200
Message-Id: <20180411183557.755784924@linuxfoundation.org>
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

From: Ganesh Goudar <ganeshgr@chelsio.com>


[ Upstream commit a97051f4553551d13e586ab3cb6ae13093a44a81 ]

take care of UpDbgLaRdPtr[0-3] restriction for T6.

Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -7711,7 +7711,16 @@ int t4_cim_read_la(struct adapter *adap,
 		ret = t4_cim_read(adap, UP_UP_DBG_LA_DATA_A, 1, &la_buf[i]);
 		if (ret)
 			break;
-		idx = (idx + 1) & UPDBGLARDPTR_M;
+
+		/* Bits 0-3 of UpDbgLaRdPtr can be between 0000 to 1001 to
+		 * identify the 32-bit portion of the full 312-bit data
+		 */
+		if (is_t6(adap->params.chip) && (idx & 0xf) >= 9)
+			idx = (idx & 0xff0) + 0x10;
+		else
+			idx++;
+		/* address can't exceed 0xfff */
+		idx &= UPDBGLARDPTR_M;
 	}
 restart:
 	if (cfg & UPDBGLAEN_F) {
