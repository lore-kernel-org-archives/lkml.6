Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981274-2-1538019489591714595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981273; b=DX25wK5waquxPTyULOsiuUGh45aYdZtQxs8TfG55+3GTfmIW7l
    p9a7Kisu2Xjt+OJxnuDuf+XHr8F3AvawI/EnAqdXlh8h7r6u03PpwM6EM9Ackq70
    9b/4TV/u5GAnfl2kg8N9bNBkjh4c+gTAWYWvGzTAWDQZoGTitmwrBPKNoAHxBLjM
    QMjLCNLhWJqPLJcckCphEWu9sQhxPFUcLXAtflT/XEfYYQQeAdXTQVl7A0R+4yjb
    h32VT6vgcB/Su27uz+EupX4+knV7dGpcniGPwCKIAdzplqgLqiaUx1nrtFQtkpNf
    OQsloIhAKEEPSb9DxcSBfkX9l7MrqAQJ7ILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981273; bh=fOhv79XX9hfQv1SqgVp2gHnAtkH/p4
    k999FehQ2sJw4=; b=d3R3V3hhLUTxLHfeFuNnntFm0uci2B7ip4czcWqHZOdxfp
    nB1+wSOAxG7MfWCduGhIrlD5zlnX2Sx2fkkwxAOpsJoUBYbh5lRF5MOkdoOEqX/n
    j5LGZBLidLudgbdGCHeOe/OPcSZJySgskFUQnNbwCMlTZo08pgGBcJJFY4MkLlzc
    3vpTMzcOjBhNq8P+k0pxB4CNksZ+boS2OPuOzZ7B0QIKajTfKqn9wJ63O+vNHu6e
    dQOEyHD1UCETdvdABfjN/wiT8zevOlQjADaLJpXVApah/aGv3boMUcWlSCqrTStC
    MmvkrV+GSI0SBHiCQHZLYXng+C5XPNzRLx9p8akQ==
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
X-CM-Envelope: MS4wfMxkhJA/JgvnP0j4UUB1jiIWNSb0rEns6AuElAY/q7/sxlEQWj6K5B4x9eLualdxo1FX+3q5A9hL0AOWGNHswaHUXZFyMfHaDtKhRzXFo7QMIlBiIarL
    FSlg5BIxsBnQykeiIiJJhSVx2z/yKBwb3E5zv5f8zBFXanLYwGWk38iOG2tkmOjk7+a3JAYWRvKyT8uK9dEiUetWP19EV8RbGJk3v/ZgbQjMIv33ITRqEgBe
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4eeuYZFJtmdMlgBYr9EA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755270AbeDQQHs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:07:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755252AbeDQQHq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:07:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 30/49] s390/ipl: ensure loadparm valid flag is set
Date: Tue, 17 Apr 2018 17:59:09 +0200
Message-Id: <20180417155716.458687977@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
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

From: Vasily Gorbik <gor@linux.ibm.com>

commit 15deb080a6087b73089139569558965750e69d67 upstream.

When loadparm is set in reipl parm block, the kernel should also set
DIAG308_FLAGS_LP_VALID flag.

This fixes loadparm ignoring during z/VM fcp -> ccw reipl and kvm direct
boot -> ccw reipl.

Cc: <stable@vger.kernel.org>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/ipl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -799,6 +799,7 @@ static ssize_t reipl_generic_loadparm_st
 	/* copy and convert to ebcdic */
 	memcpy(ipb->hdr.loadparm, buf, lp_len);
 	ASCEBC(ipb->hdr.loadparm, LOADPARM_LEN);
+	ipb->hdr.flags |= DIAG308_FLAGS_LP_VALID;
 	return len;
 }
 
