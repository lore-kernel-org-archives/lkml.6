Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840861-2-12045961435313960151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840860; b=nFrGI1LKqkEUB3O+Vc+UtQlLIodIsQ/iqoS38SZk/s+sLyNCKx
    69F1pFanekKngkATipvgG0reP6MyKLO5Dp4ilEavaDhKbWH61MB5U0J0v3o+F4X8
    m+giBtGyNTnWD9yX4j6S9huyITRKIJR/jMNu706W9Mh5SRRHPnpJCFpGfZMR2L9U
    9QwFXWku2/j3clMVegqnxp7ohU5gUuS0bX4wRkTpOlLFchlzEyX+P+1V7XZ3+R7o
    zfgHJ6JfN2I/6G2rLYAaMDdtEh37tf+3x4kHkvBJdPwNtv+Lq7rIDa7oqb91VS5B
    HNDkRcxEBZ9Q/6xPQrG57mBTwUG63har8zOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840860; bh=uJFWWSm2LFcWiVnuS2l60bvRzwmx+9
    n0OzdQTEFhNH4=; b=EhL66/UuJPR6Z/jLIfJHQRvp41WUk9mWOIkx6LEsbHDNZf
    F2dAHNrvx8hDQNGq1H0d6xLNTRyUqyPGr+XiF+TSQsX4c45zr1BWRKHkTKVL/s11
    X4Ss7vN2RImkUdQ7PcqA1ZNgc5tK9frOAfbyMoBZQJq6hokE8Pjmy4T7qjsFwWi5
    yZHNaoR6K/lgOMclI58/X2hTDt3gQlXfTI1+mRvsCFWASVcfb67Tj2dpYuLObgWz
    9dVQKokFLwwOlEGFDozahT5MPJNvasXbsuT97DnSZzYSX0AMAruiZGVkNwVWB+rR
    HVpDAD0bqjPYwGDY9P3LdFeXkX0ctnM+DcIx1g6Q==
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
X-CM-Envelope: MS4wfPQTLkaWqB+44fcWwug5ftE6vAeIVhgZOfhW3HtQ+CWjALK9xtxo8Idivwy++qWfu1+aSkwPs0AnuhrUIT7FYY0vQgHN3y/mRoDVepM0ZqVd0Ax4iys9
    PaxQMXEZfDcf7+reUeQhA+lsgErUYjl1QgE7IXijSIUjZqg3CJjIt7LgJn6VbR2/k4fZiJ+uKXOaclo4tudmi0vbCn0rRW/hm0nPzJGsht6D09IAWL753twn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zd2uoN0lAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=ZzHiWCzbQ49twMczamMA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934252AbeD0OyG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934182AbeD0OGs (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:06:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B46921864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 26/80] amd-xgbe: Add pre/post auto-negotiation phy hooks
Date: Fri, 27 Apr 2018 15:58:19 +0200
Message-Id: <20180427135734.294800542@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>


[ Upstream commit 4d945663a6a0acf3cbe45940503f2eb9584bfee7 ]

Add hooks to the driver auto-negotiation (AN) flow to allow the different
phy implementations to perform any steps necessary to improve AN.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c |   16 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h      |    5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -437,6 +437,9 @@ static void xgbe_an73_disable(struct xgb
 
 static void xgbe_an_restart(struct xgbe_prv_data *pdata)
 {
+	if (pdata->phy_if.phy_impl.an_pre)
+		pdata->phy_if.phy_impl.an_pre(pdata);
+
 	switch (pdata->an_mode) {
 	case XGBE_AN_MODE_CL73:
 	case XGBE_AN_MODE_CL73_REDRV:
@@ -453,6 +456,9 @@ static void xgbe_an_restart(struct xgbe_
 
 static void xgbe_an_disable(struct xgbe_prv_data *pdata)
 {
+	if (pdata->phy_if.phy_impl.an_post)
+		pdata->phy_if.phy_impl.an_post(pdata);
+
 	switch (pdata->an_mode) {
 	case XGBE_AN_MODE_CL73:
 	case XGBE_AN_MODE_CL73_REDRV:
@@ -637,11 +643,11 @@ static enum xgbe_an xgbe_an73_incompat_l
 			return XGBE_AN_NO_LINK;
 	}
 
-	xgbe_an73_disable(pdata);
+	xgbe_an_disable(pdata);
 
 	xgbe_switch_mode(pdata);
 
-	xgbe_an73_restart(pdata);
+	xgbe_an_restart(pdata);
 
 	return XGBE_AN_INCOMPAT_LINK;
 }
@@ -820,6 +826,9 @@ static void xgbe_an37_state_machine(stru
 		pdata->an_result = pdata->an_state;
 		pdata->an_state = XGBE_AN_READY;
 
+		if (pdata->phy_if.phy_impl.an_post)
+			pdata->phy_if.phy_impl.an_post(pdata);
+
 		netif_dbg(pdata, link, pdata->netdev, "CL37 AN result: %s\n",
 			  xgbe_state_as_string(pdata->an_result));
 	}
@@ -903,6 +912,9 @@ again:
 		pdata->kx_state = XGBE_RX_BPA;
 		pdata->an_start = 0;
 
+		if (pdata->phy_if.phy_impl.an_post)
+			pdata->phy_if.phy_impl.an_post(pdata);
+
 		netif_dbg(pdata, link, pdata->netdev, "CL73 AN result: %s\n",
 			  xgbe_state_as_string(pdata->an_result));
 	}
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -833,6 +833,7 @@ struct xgbe_hw_if {
 /* This structure represents implementation specific routines for an
  * implementation of a PHY. All routines are required unless noted below.
  *   Optional routines:
+ *     an_pre, an_post
  *     kr_training_pre, kr_training_post
  */
 struct xgbe_phy_impl_if {
@@ -875,6 +876,10 @@ struct xgbe_phy_impl_if {
 	/* Process results of auto-negotiation */
 	enum xgbe_mode (*an_outcome)(struct xgbe_prv_data *);
 
+	/* Pre/Post auto-negotiation support */
+	void (*an_pre)(struct xgbe_prv_data *);
+	void (*an_post)(struct xgbe_prv_data *);
+
 	/* Pre/Post KR training enablement support */
 	void (*kr_training_pre)(struct xgbe_prv_data *);
 	void (*kr_training_post)(struct xgbe_prv_data *);
