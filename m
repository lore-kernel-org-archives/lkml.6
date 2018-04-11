Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477115-5-13450410580627602551
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
    1523477115; b=ITbw5pFP1v1k1ijIMaMDtkPDqToPXET2BdnYEAQdW0XsZ6J34/
    tt8OGxykutxGEauRNhLxPIzslobGxhMwUN9bqU6pOqWU0uSDIEN2OBm8PWsdJ961
    dNrMLO3HtdfHkzBRsRpmIi8s8of79YvoRa4EPV3QJCs8GIHiciSSwrCMnjVcChiS
    6YJsJKM6mCeBTnODmgxvZc6ODmc7gUp2RBHSA4QrOp5KLiXyOEKO7toy50DBS+Uy
    FPeOr7loX37TbZ4aXdxlqhUIsckRJtJZPwGu153OVhpUNh6gUmXb3SJjA6b9q65t
    nH8IHreCyHyl4ZUIdRKWCEIEQa4EGya/I4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477115; bh=wGUoa1860lkqPHGECj9R1c4e4KES9l
    QOnH9En37DD60=; b=oHdJRqUlVXWO4aXwfgD2/0Q5CYgg2KaFC2kDSNv3cgYFyZ
    DbaYH7O/zVLXEOCUJtq3SD6ErnagY6vL0PAYj+/6qMaSbc8E+hmmOXXJH8qB78Oj
    t7p2N3d9jMB50pP7oxask7vV1bt1UIM8T0Kg33BsKgL86SenGjLOkztGkPgN79WQ
    rXYV8ZivPK/mNPzhirjWkjfYPqcO85rrKcCI0vBJNUz0VtloMfgmBq1ZKtaeMoW+
    vjlt5ia9jwlnhd/V8Uy+SqCAq80AUtNvyMAT+2v1A/BrwrP3EMY4XEOID9G3HvFO
    KU3haSWzEi9P0CWnx4Sm56bGpGUORNJSiomZfyeA==
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
X-CM-Envelope: MS4wfEudpqOwqX/89NSEqwEKJFJ7xdWdlOzcZ8DKv0kQe38gUiQ/aMsitrSnG7JBHpw1mMhiMr56AeFxKbmTqgS9yFordAwvG1Q/avwityQtH8lGM5wXOV5A
    ti3kgalXhJy/pkkAK0ZzL4kXncwreS/7y6rIq15NrvhWZKniwuHeX9BJ2r5j+bDyiMn7H+98bq9amWyfrKdOU0MT2oMHSNRQrB9PPL2bQQkPI8o6AYYqaxLE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=R_Myd5XaAAAA:8
    a=ufHFDILaAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=kKWn2QJ-HWCYf74IPloA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=L2g4Dz8VuBQ37YGmWQah:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeDKSzk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933049AbeDKSzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Reza Arbab <arbab@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 038/310] mm, vmstat: Remove spurious WARN() during zoneinfo print
Date: Wed, 11 Apr 2018 20:32:57 +0200
Message-Id: <20180411183623.913625546@linuxfoundation.org>
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

From: Reza Arbab <arbab@linux.vnet.ibm.com>


[ Upstream commit 8d35bb310698c69d73073b26fc581f2e3f7f621d ]

After commit e2ecc8a79ed4 ("mm, vmstat: print non-populated zones in
zoneinfo"), /proc/zoneinfo will show unpopulated zones.

A memoryless node, having no populated zones at all, was previously
ignored, but will now trigger the WARN() in is_zone_first_populated().

Remove this warning, as its only purpose was to warn of a situation that
has since been enabled.

Aside: The "per-node stats" are still printed under the first populated
zone, but that's not necessarily the first stanza any more.  I'm not
sure which criteria is more important with regard to not breaking
parsers, but it looks a little weird to the eye.

Fixes:  e2ecc8a79ed4 ("mm, vmstat: print node-based stats in zoneinfo file")
Link: http://lkml.kernel.org/r/1493854905-10918-1-git-send-email-arbab@linux.vnet.ibm.com
Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmstat.c |    2 --
 1 file changed, 2 deletions(-)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1351,8 +1351,6 @@ static bool is_zone_first_populated(pg_d
 			return zone == compare;
 	}
 
-	/* The zone must be somewhere! */
-	WARN_ON_ONCE(1);
 	return false;
 }
 
