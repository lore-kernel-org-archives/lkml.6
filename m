Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842143-1526449749-2-12816760597478687220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526449749; b=NzD+b6Q6ZlVP6wgMTsHUTgcmP2aAUMc+sCfwXuzUWCGieGV5Bb
    LyV7zDfaa/5NptcMWBJxvFLt3lKYzSGNJ5JbOugu0YK9y0wuyRA2KW8dgxKEvBRw
    hTb+XlvAgTFtOYUXe4lDC6qSf/5mSVnhmRTjzZj4bpBOgGXv+LzSHRMvhqJPe9p8
    s3rHKr8EC7wpTHBDM0wVj5jPZrdcrgOMmR5Af99RAtwuhLshvQOGU5Q+IL2fB+df
    jdrD8gSWqUOoK9NXfiABQBMytAvK4T1Gns+hXCN/czsSuEGhSa+XV4a2uuN1n8Cu
    DK1Me8RKf88jXd+t33FiatqTbaTxZNhpqIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526449749; bh=
    CC/ntHmYzNQwCAwLL+nfpnfujOwwKYtst5e+wiRdrPM=; b=PiOdUyD/gHc/8T3L
    ZKE95JHlHZMxKcNaelFzUSGM02iZ+5odnmalE8oZlAHa9RAxfjF4QbmPVmVG5NbK
    1RfWht8PbWdazEFeEV2VRylccX8zL+gWLvZYcMKocsMCRZ/2RNKpqGH0CMg/48eL
    JC7Steq990J6XIhidfH2agxymzl7addwFQPNnOZJK3BFHWHAG03nqAcVyyPGEb41
    WqrXFIL00ikg58nAcubT9wo2F+DAclTgpWf4+rtTmWAF4WlAHm0emLWZFTPLIAHt
    J9ispCPNpcSvwmgWAGeIrQ6iLWqIcvFJNPiROlGKOYc6xHhhIC/6EZhf9WnxB5/i
    HKJRxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=QVzBrkHZ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=QVzBrkHZ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDYR6p5L5k9PBAdOvXg65hRAv6r5rLxSevObDnPG4eZNkd9G4nF177pNgfXWBb7PBtK5W+/6wpLPIwj5osWFSGzdX4VePIiMQz/yE7Li/2rGm11Z0uuz
    YyB4m1d/KEmpR9Txp+01W6F9wW8N6sKM3XlwjfhDTgNZ57Vt+SldbeJV1K6XC7srrOcDtQeMeGDMz5MFKVYoYQg2PCF0PBYL3EYGwtwh7jkvi+aQkqkOe0w/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=5MAZBOqbw5rav4LXe_wA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeEPFtG (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 01:49:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeEPFo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 May 2018 01:44:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, devel@lists.orangefs.org,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org,
        lustre-devel@lists.lustre.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 04/14] mm: remove the unused device_private_entry_fault export
Date: Wed, 16 May 2018 07:43:38 +0200
Message-Id: <20180516054348.15950-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516054348.15950-1-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/memremap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index db4e1a373e5f..59ee3b604b39 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -65,7 +65,6 @@ int device_private_entry_fault(struct vm_area_struct *vma,
 	 */
 	return page->pgmap->page_fault(vma, addr, page, flags, pmdp);
 }
-EXPORT_SYMBOL(device_private_entry_fault);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 static void pgmap_radix_release(struct resource *res, unsigned long end_pgoff)
-- 
2.17.0
