Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3778089-1523494396-2-14819346122702175864
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494396; b=NNqQhszLLIQw5pM66DvOjIj7HkZRd3I89tpkgPhZvum9/v/CmI
    g68ABroD/s+wcduWEJXRwWVzh/oCOUCj3td+S+3jDn1DMMspvWnI37Az3dXXh0ys
    XEdvraUZYaYJR0EzZ9T3NkqlySyz2UwMVQ6YmP6lv06YuH0DHci0WY+enxO3qqR1
    Qt7CA6JpmKyzBEBS0K3PTrRVoI6+tXjQe2ScBS3DEV2+cmJRSO4V0yOYxuVRQv3H
    tAqX1LM7YoGcNneoyOVhH/rVV8a71nHXXLwtlENN6BnpYt+Su2pTU7v+HADNELe+
    a8VpTN23ze1sCcFmUElYb02djvEf0G0L/s7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494396; bh=a1t7O
    ocBJ6+E1megTANmioUfzvO4M/DnyPUKMB05XLU=; b=mPNPHpfDi0cDk/yYFKgib
    DyEx9D0esbxY4zg2TtgYRkPBFVblay1UVGxe19Mh7fTMjRjzgFBcKPhE0hDqtyTc
    BkAvDzGkpONsz08Qbb6nkbCi3du95zepsFe/WcWh9AoyWuoPjqscYSvKqD1H3RHm
    BM3R/qIU/UG/mmTJLUeqWPaahajG1nyxEuzQ9LqPmNfCdAO4kaEmKYhWYtMIGxRR
    t/VfYFjjlVKcCU2cdtNssFvzxu6N4eOlyz/c2W9qJ9P6e3hsAE9kKZ9/DU2Auxbr
    HjTnXo4nEM/evxqlnI+0pKVPY6bPR8kIjfxQhmm4yBETLEVh+cMbBvjcC1zpHQ1o
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPutzI6OCBkjAPIMHH7AQl2cSiBhKNJW3dDVegEA3Qhn6tCaOJWgXBvzp5Rt0JOqPebzE5/QhRsqxusUqkzaBKnPSznzNjTi5OH8c2G/Vh/MwgckZkGw
    9JAWiON+RaXgt1522hTFSMlEPi5WfYojEldGU544/0f6c7W6vOsIZKWotuqGH247z3Yg89I/lQCPFDv1v0F8i/7OuWGNM27uFUEpFNqi52NPOvA5HXi0VBwp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=tBb2bbeoAAAA:8
    a=vN2yByN_uQbfPlsXDnQA:9 a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeDLAxA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:53:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39752 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeDLAuO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:14 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <ed5a2015ecd360746ab52e8d3f5e8b6f5e1568fa.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 02/10] m68k/mac: Fix SWIM memory resource end address
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The resource size is 0x2000 == end - start + 1.
Therefore end == start + 0x2000 - 1.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mac/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 84bd9161bf23..4a544a6c72dd 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -1011,7 +1011,7 @@ int __init mac_platform_init(void)
 		struct resource swim_rsrc = {
 			.flags = IORESOURCE_MEM,
 			.start = (resource_size_t)swim_base,
-			.end   = (resource_size_t)swim_base + 0x2000,
+			.end   = (resource_size_t)swim_base + 0x1FFF,
 		};
 
 		platform_device_register_simple("swim", -1, &swim_rsrc, 1);
-- 
2.16.1
