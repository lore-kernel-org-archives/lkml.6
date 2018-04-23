Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133588-1524487910-2-7567218678136841183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524487909; b=e0wWYDqzGjj131pHH1uBY2xkF4OpMSdMWbqxWEBK8OhlqiS+l7
    yQvu4irL8d2jFju1mY2sCdySXLnjfXdeOn6PcSQhtaYt6lFFraFok8vacp/SfBe3
    tLyO8dYeRWhv4DUUzseVa7M+dlrJ7PChY9rbGmaFPG151H34+eJtWvlGlUz7tTR9
    U0WCoBTwUnQSYR73LW9H04NIS6qfFWLb+vJUH1zDX7s+m/92MYosQWZG49Da1URv
    4Y2zOFHnzJxsjLjL/lKcChf7fvxjJYw/hN71zGwArEh/Fyjzo2AH6jht84IX8y9C
    88hKpn5X8g/hYBYjUgVTFsBvnvoJ9wKJWpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524487909;
    bh=jQ1Mx+7I94IM56NvtAwfxB/wAOdLqEMMCG4S2WP6CfY=; b=f+WY9x4Bt+GO
    ZfN2Z+rWC2s9OF+8GZih5KeSqSkJm/M8P2lbb8/ZWwo1Vb7SWvY/HbIS5DKV1c4x
    mtiwPAYDbAk44X/wo+kIJ8Cxg8Z9Knr1g/xLzafH28Fg89yKtQOuos9qdpA9s1mw
    eNusxdiR8HmZCkSrFiNLOZP/HLmNNVeRKV9W04IPQjZ4Jab6nJHWW43uNjlCQho9
    lxZff7g1rlS9v6ISpnTNiqfWWxnuurSGY7ZjQDe4s+yOv/se9dCMy32RvMXPc5tt
    jL5lb83owxSU1djqWfRoPavHr0CbpUKcBdngO9F2qam2QiXWPlG9OzRkJzaMz0Ap
    Zyf/mKYxdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=embeddedor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=embeddedor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=embeddedor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMQ3Pg1ug8wEaayaWMjOvj4l8h5WTEvaBVvlJIzA5DXSXVy8Hy0eCfMVZhsvXtErKbBA3OsGOD7IwkiusF3sQy7DcCS9uj096g3dJ29EnciLZdvd5KxL
    +9+cm6Osooqi40ox2TKKoaN2Wt2sWqqTv9mAdU1WbXlOmR5BpBL1JEd2Abvw83jngodSdp8XrldZxnrKQIwC2KUF4lWd/9/iDNamGLQa2vGf8xLk9w8NyRk1
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=_Wotqz80AAAA:8 a=VwQbUJbxAAAA:8 a=6ZC80VcAS2A6KgSF8f0A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=buJP51TR1BpY-zbLSsyS:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeDWMvq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 08:51:46 -0400
Received: from gateway36.websitewelcome.com ([192.185.199.121]:25455 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754718AbeDWMvq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 08:51:46 -0400
X-Authority-Reason: nr=8
Date: Mon, 23 Apr 2018 07:14:53 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] usb: core: hcd: mark expected switch fall-through
Message-ID: <20180423121453.GA26629@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.48.65
X-Source-L: No
X-Exim-ID: 1fAaMz-00401K-PJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:45246
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1468266 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/core/hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 66cd3f9..1c21955 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2819,6 +2819,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	case HCD_USB32:
 		rhdev->rx_lanes = 2;
 		rhdev->tx_lanes = 2;
+		/* fall through */
 	case HCD_USB31:
 		rhdev->speed = USB_SPEED_SUPER_PLUS;
 		break;
-- 
2.7.4

