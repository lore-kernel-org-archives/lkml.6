Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803969-2-2912605388333350952
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
    t=1521803969; b=FRyZV38+QRwWc6JSqZNjz+6ENNzIxYeEhCZSPyrBw8XTPlp
    6xhNFAqC1xJ0op3svYPzEgSm7fCtdq6sQ3FQUav3FkrvZaUQylOEzXE2TRiia6DH
    xmk92dM/KocOOHZsWrsFrh8vAKZ1Ck3h0vZNbkii+6lM68ptzxe39fb9kAYZdmy0
    TxV5MJCn9isaLHDhoWZABPVmVXE7JSE6ZRfp1GtiqvqnArFd1U/ad9leuD5pudkR
    rquOF0qaC8nVMVDGkKsC0vhMKm2vz5XzJG12k2zg+QV2CrEse1n01iUgfX85fnqr
    q5H3Fz7vx5vFps8tPJeluorp6ZGUx/AUOB0nbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803969; bh=llIwnrIlDPxmBoR6X49fZ/nkhy
    Vj4iTtnrA6hm/+r/w=; b=X1srHaa1avX3MKQqLI6eBRhnBb5BoOLH6RMfXhfCcH
    rF230S4J2t1dL9fYTugZavsPitpCv86iXQt84p3lQtDsZ2jI1hnRKLskS0Cla9WT
    cm4OuobCr01nQwas/dF/Kc4RGoPNZ3kFbjofqVpYxJZYE3T2nvwRZvs/l4AtyoKm
    RgEHCMF0R683wseEbm18ZZCUUNQEdl4Fdyfga0M2huGYOnqB6cUBBIw8sjavS5i+
    Jz65knHuyKHCzMYO1udIU6JE/xJy3WUy7uTtTQ9SyQoHrVHPyhOr3vAi8ojeLGvm
    3NBooykb3xjUW4eY3BmfhTYxpV9+r/il+yHYapiskhzA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeCWLTJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:19:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755238AbeCWKI5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 092/177] mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a
Date: Fri, 23 Mar 2018 10:53:40 +0100
Message-Id: <20180323094209.348809340@linuxfoundation.org>
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

From: yangbo lu <yangbo.lu@nxp.com>


[ Upstream commit a627f025eb0534052ff451427c16750b3530634c ]

The ls1046a datasheet specified that the max SD clock frequency
for eSDHC SDR104/HS200 was 167MHz, and the ls1012a datasheet
specified it's 125MHz for ls1012a. So this patch is to add the
limitation.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -432,6 +432,20 @@ static void esdhc_of_set_clock(struct sd
 	if (esdhc->vendor_ver < VENDOR_V_23)
 		pre_div = 2;
 
+	/*
+	 * Limit SD clock to 167MHz for ls1046a according to its datasheet
+	 */
+	if (clock > 167000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1046a-esdhc"))
+		clock = 167000000;
+
+	/*
+	 * Limit SD clock to 125MHz for ls1012a according to its datasheet
+	 */
+	if (clock > 125000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1012a-esdhc"))
+		clock = 125000000;
+
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
 		if (clock > 20000000)
