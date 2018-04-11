Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477518-2-5282812317623602827
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
    1523477517; b=a8yTwlKKihtk/2PzIbt461K36BfvP00m2DrGT66CbaPArDy2Cj
    WB1BWWXL4m9Awv4gZL2Luu5Pl/8L/qW+HNfOCTw8BlM8aJEapC4ODMYhwB5fNpll
    vZW4+YzIFeMnmjgkyneGSSDb+iMqJ8p1e62s8kVDF1IzgLtnwhYhg2nWEObg0IcD
    0PKMvXRR67OQruHx28FfeHVTStZG9NKTTllRF2CYYLo433J8DX/NNbyA/lsGdiqE
    q23L9Uwscn5L4A/5/DpvjHfcIWP8eAriRzZWgCih8UiUe/JgmgTCCDQNdr2/Oh7Q
    Q9OIGf6jRL6WRfsntrNYQgtm3MLz/WB32ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477517; bh=gP8g68QuaQ9I0IXe/nBHnknWr1t8aU
    /LPvH+pn+RxWM=; b=KDJr5o6aDTuDkyGsKMaAxiYbdRqDh/DKlcDLq7ZupajKq5
    8cce6Tat4SxuXDEDf2MBIsr4e2Uyd8NIgTc8epXKwqdlGnCec1gEGK5lzmfpS4K0
    uklTnkhnLynngDRVPLiwSiHmMhoq9d9y33pVHJ6MwhkI1CN8iMPZ3dNvZ5ggCYi/
    4tbYO8+tDf6FELVi5/+SuZQDuEte6uwUVceGqC7uwFCRyf76kLzwYDclEJqTRyvV
    CY4vL5N7iFYGq6ZKdkOqQNFcHi0L65aLYsOuG3UQmXdhYkxINJ24h5ZUi7DJ+CZq
    q1GMgbpfO/3MzuGDljZA5tlQB4xCTyPUjYNkLTKA==
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
X-CM-Envelope: MS4wfGnIjYkYe5VUv8ngsb+nfZr1+v/CtXPePLiLoY3Yc4QONS5PGo0RVaGsSx2YrSy4IF//9gzW00vt6ZqZuoHzTKHk6YNKn7eSifRbTXYJn1o/t5KTitle
    aZvHkgMM+PvxGT7uCekJJ0n/PnphuNsjrXMnLPuBfzRhaJCnMGwTuGeTVyUVYmmMpP4/niyoktwPBj/J2XnpBZnACSYRPp6NE5QGpqs9ZAfQ44bGcmwVn6of
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=CaJNc-nyaQXWHGQ9a10A:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeDKSyN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932610AbeDKSyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 040/310] bus: brcmstb_gisb: Use register offsets with writes too
Date: Wed, 11 Apr 2018 20:32:59 +0200
Message-Id: <20180411183623.997275327@linuxfoundation.org>
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

From: Doug Berger <opendmb@gmail.com>


[ Upstream commit 856c7ccb9ce7a061f04bdf586f649cb93654e294 ]

This commit corrects the bug introduced in commit f80835875d3d
("bus: brcmstb_gisb: Look up register offsets in a table") such
that gisb_write() translates the register enumeration into an
offset from the base address for writes as well as reads.

Fixes: f80835875d3d ("bus: brcmstb_gisb: Look up register offsets in a table")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/brcmstb_gisb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2014 Broadcom Corporation
+ * Copyright (C) 2014-2017 Broadcom
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -127,9 +127,9 @@ static void gisb_write(struct brcmstb_gi
 		return;
 
 	if (gdev->big_endian)
-		iowrite32be(val, gdev->base + reg);
+		iowrite32be(val, gdev->base + offset);
 	else
-		iowrite32(val, gdev->base + reg);
+		iowrite32(val, gdev->base + offset);
 }
 
 static ssize_t gisb_arb_get_timeout(struct device *dev,
