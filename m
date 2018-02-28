Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834131-2-6927120914772756948
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
    t=1519834131; b=RPoC0WavWY3K4pXIFr7QNMOJjK1+sRORPezz+iDZps1CV+w
    pXnoAM6qaBrwJJIE/u6Nct6hDIqT239Bid3cfFr4lJACfgj+U61FMB1GHhw6leU3
    //RaS/XdHG9NAjdZyHkzbMgZdFt7H5/VEh6XljurqyBeGogU8gseQkzFvREmt/VY
    tCMmtaEQGt39eeb/WxqQi5dSKVVZEhe6hxsHYDImG+76SsOQYccs97le+WdlbxD2
    oKhXxekn4KDibuysSEREo/W52GOdRG0kIFhhhpbwylYs4Wz54CjRAM78ZdT31jCL
    DZ3V7Ol/NjwliAh5BSEJ3DQs0r0jW+90UTfw5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834131; bh=Q3hP4S7Cb3EGv3wdxuJ
    Y5qGFnNEBL1rw1z/u84ZBhQ8=; b=o3IeM23zH2AQUGqR2LxKYkUqazKozFlSLTG
    DUUTiLqTGjY8se1jNllnMqhuZYjswbJ/dFYennMEVdXKjTj+j8vqiqTpqenTk6gZ
    9CG8OplpqS6Oy1SsMPNI2EuvsTsNWhwIVxcVms+pO5CpQ8wb345pFgF1VBZFTV7c
    PY7rxcGEdCxy55Oq/z+f6xXfSQiR7j3+EUDi5UdDwVzLDCGl/y5F8HLOJYqBtRIT
    fN+E9hR34KAcpGutmGvrbbM9Hugs1sEvNcgEwmI5z2IG0Ef78+8rRL6h/k8oVz1K
    9MNYGic3U0CGgb2BeYI/2bmcgtUfa0uw/0+PfrEU7n4/dpf1GTg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeB1QIs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:08:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34965 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934597AbeB1QIq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:46 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.453003938@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 231/254] of: fdt: Fix return with value in void function
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

From: Ben Hutchings <ben@decadent.org.uk>

Commit 49e67dd17649 "of: fdt: add missing allocation-failure check"
added a "return NULL" statement in __unflatten_device_tree().  When
applied to the 3.16-stable branch, this introduced a compiler warning
(not an error!) because the function returns void here.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -381,7 +381,7 @@ static void __unflatten_device_tree(void
 	/* Allocate memory for the expanded device tree */
 	mem = dt_alloc(size + 4, __alignof__(struct device_node));
 	if (!mem)
-		return NULL;
+		return;
 
 	memset(mem, 0, size);
 
