Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652724-2-14820906180746046104
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
    1524652724; b=eHM9nVw0vx7ZIhdcggez44ONW37YNxo/4B6J9c5DxgHV8yMzqM
    eyxECptBgonkA3r8QA6VvWlzHgACCb3h61SEAUhRlUXAnnTWtNFHGrRUj1AquRbU
    fn7dzWAAQjIKtT1URJaN7YzVCMDpCwygA9QX7UvqqRF33738P9+fpTkyH4dLfykj
    wbHGSWwRrdudjLlg5hoGpp1IEoORu+3svcEMcHzGhoIidtklEWHbuJIRziplkzXF
    H48jo7TvyKJxJAWPZv0zSyIpjHpFMeNCHybbBVSFCzrR45W1s68WJOMquT7Bctmx
    sAvAjje3+MuqcNvtyR7mNRgfPG9quwj2W9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652724; bh=fHrTNWMCIB/EmXuePiO5TofuznQYSL
    7Xw8f3mdjz+oM=; b=R5/Q1aKLcOhdffTmQ0ldwzMSQqOjH839JW/DgRq56iPfUl
    stGer9ZcY77OxEabYCwtQY2gbjIAcTN2+RjBpHOx7mPiNOnxjJEF8wLDH6WjDQ9a
    8LNnlD/4f67N339OI95q8iie2uGvLyGHQmd7ypfgnhEX4gN9mGpM6WQfl2IjUlmi
    FX0EScl1UBlTFZNj0F3CnwA6CJqiRF/KEYyvKy6TWILQMA7ujrIdO8YYsbcz+7K9
    5xApWOiKL1571xTW0lf2jMYGlKNHaSoQGBnE6ndiYxLweU7JHRmF+SKiLrMgbAaH
    A/QT6M1ZFnz5UV8mCfc9YVkYyEte7efumAKOLeOQ==
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
X-CM-Envelope: MS4wfMQ5spaEvWVJPNuiCCA7i+J3nBpb7gqIw4bGkTjq37uLPqn5v0Ux0x0SzzDnZXkkeUBKaagsQetKw3GfLrwPguAjw9ahEZ0jNR69cx/pzZ2P32lYggb3
    y6d2Dag0Mb1qDZNlc1KvbzN8idnFKyOVQbnYajH7m2W9oZECg44xpjgVv1KDLjV3qhC6mVanAJoUg+bFuEDt1S2C5ar6yKQPD6VSKqye0qPHyQAG3Uz94MBc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=5G0AJqgLdFttAFhcDZgA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeDYKil (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:38:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753407AbeDYKic (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:38:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 042/183] perf record: Fix failed memory allocation for get_cpuid_str
Date: Wed, 25 Apr 2018 12:34:22 +0200
Message-Id: <20180425103244.258042823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Thomas Richter <tmricht@linux.vnet.ibm.com>


[ Upstream commit 81fccd6ca507d3b2012eaf1edeb9b1dbf4bd22db ]

In x86 architecture dependend part function get_cpuid_str() mallocs a
128 byte buffer, but does not check if the memory allocation succeeded
or not.

When the memory allocation fails, function __get_cpuid() is called with
first parameter being a NULL pointer.  However this function references
its first parameter and operates on a NULL pointer which might cause
core dumps.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180117131611.34319-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/arch/x86/util/header.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -70,7 +70,7 @@ get_cpuid_str(void)
 {
 	char *buf = malloc(128);
 
-	if (__get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
+	if (buf && __get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
 		free(buf);
 		return NULL;
 	}
