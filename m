Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451843-2-7419080696328872445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451842; b=OeORkq7Gn41NXAhyl4TMTRCqCEjSLBCdzqxGzfS65+PUp8Q
    KrPDioFA8b+/OX2zOQkRbqhTICbwOx3u8YrMw1I2IoBuSv90GOh0FEr5pWCZoU0f
    Ax4s6+z8VPJN9YSMfKIlX/+yv/6freup0ByStRc7f+LKeLzQDTwl+xSuNqVEV9/M
    Y76OdSkawYkAGauLPoEQX50XokyF7mm4qsYJX9cSkaHhEDqhvbE8kvVlX8yS+WFB
    5r4AI2xH+RCYuaaDdWYGdmFnUPaf2NzNxaNPyjbRT9AXKtghiWWoaGscfCYacSjf
    +X4iMZT8jSATVuSa9wWXGedwh3o/pT3zRDwMkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451842; bh=agTTyaNY9G6+XtgxspZIrt3ODW
    GbCEkPQ/zSLw/Ovl8=; b=kBBBCL7dlC3qwz5+67gnfsIS9yStg4EPiF/CspdklI
    0QTjyF8h65Ad7hm1WJkC7VKFWFgoD0hgyCQT/DyIdCn97fq3sVgTyWx+cAESDqx1
    dkPIjmG9vFT1Yh+UzCa//zxWN+HqIXQyiD+F7k1McK0ZJVB2HIUCWZBSwLVidFon
    1zMoM9jv56ZTDS3bNAi8Ep5FBrTngLAA4YvWk2N9O5xJXr8xZ/sMY9WXuMEByi+x
    B0QFG/DPB7Gaz9XJ71L0DkIwKntrEUH0jYcLlwZ6lIFWlASxaKSbAkFjqX/ayo2k
    yBVhJ3qreQ3po2tm1qnZEMcweK7gn3+6JSuSyFmsk/Aw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S934803AbeCGTnx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:43:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964997AbeCGTnw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:43:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 079/122] cxgb4: fix trailing zero in CIM LA dump
Date: Wed,  7 Mar 2018 11:38:11 -0800
Message-Id: <20180307191740.644113692@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>


[ Upstream commit e6f02a4d57cc438099bc8abfba43ba1400d77b38 ]

Set correct size of the CIM LA dump for T6.

Fixes: 27887bc7cb7f ("cxgb4: collect hardware LA dumps")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -156,7 +156,7 @@ int cudbg_collect_cim_la(struct cudbg_in
 
 	if (is_t6(padap->params.chip)) {
 		size = padap->params.cim_la_size / 10 + 1;
-		size *= 11 * sizeof(u32);
+		size *= 10 * sizeof(u32);
 	} else {
 		size = padap->params.cim_la_size / 8;
 		size *= 8 * sizeof(u32);
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
@@ -97,7 +97,7 @@ static u32 cxgb4_get_entity_length(struc
 	case CUDBG_CIM_LA:
 		if (is_t6(adap->params.chip)) {
 			len = adap->params.cim_la_size / 10 + 1;
-			len *= 11 * sizeof(u32);
+			len *= 10 * sizeof(u32);
 		} else {
 			len = adap->params.cim_la_size / 8;
 			len *= 8 * sizeof(u32);
