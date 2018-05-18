Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4043076-1526653413-2-13525659529150809447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526653412; b=N1UzrvZncB81HqZs/QOHTkm/9sqyvY3TT5a+q4dMCBppyQRTGf
    muJ7LdCBpaDKMxHsYOiGpxj1k5trojh6EIrGkFB8Hs1qhFb+ETBMnbQB6pEXqnGM
    M/23lVsj2XYZ0hFbBCqpvzJnbHsRhflupmMi/+Tdx+4dBM1+VI3K7o551ALhC4Nz
    jt55tM6Bdzn0E/F4Au3yv9ULfAUkFbiBQqn3gN7M+9CzyG+EbYgDvIj+WocaXBOs
    Z265gxl2AbpWbWPKicVxPliUcyyoJuwDT+PD8ORm0FysL36fCGtkGfwFc/ihq6B5
    YiRPVVpngYcz64nbEyw89b98bHnuW5xGGTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526653412; bh=q95MUy8eN6IZtsNCddHFFeeThj42/E
    zVTWUzUIEWC8k=; b=Y8Bz+yWEKm2ZxwMxqu/bj9Bi0Y3n2UrwHHwUFnGdz95EAL
    1RM5xIxJfRqVGBwMCKszdV4/0t2gJo+sV7j3Mj8qYzSExZj1pYIMYZgNu4UNCLcl
    DdH/cbqQmHBjxwlU2V+hYNYqkdR1nR9J3nOj6RotrB/O1Xq/OtTAef/ALE/+yGjW
    LDwQQE3YNQaBcmLaT6KKC2T+cRPNRnyot0AHStWEXoWX7g8p3gtVgHAmS94EB+qL
    161aFO1+6dn56Nk9WDYeqPxtKcnkbAU30sG+Hp7AI+GlrQMTEGDphY5ACPvSZH2L
    JmT5WK64qbvK9iBsvsQUNpX/37XK1Tzhtpka6LHg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=ZSSJlURd x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=fCowBlG/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=ZSSJlURd x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=fCowBlG/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFp4jppKPUBLXHTMZVAiLAKRvEpqMCurIgRf2UBL1urmdohW0e0evFMoW2375xOSuQr5tZYaHXLbewizgTFAeU4RvVulKQem6nATesovtAQxqzD5+UkQ
    JfalZxM7Sn8SdDX2iCXw2SzSp8ulytMJaHakRSBU5Xz530srn99CDWo1cxcUt+CH0d8q+gxuFGk18CjcDmgn37VqyKcxv/jBsCj57MgVqvd02+sJDtY8zlns
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=NCkSHYsgAAAA:8
    a=6wHSZF7M1drVXR-aaNcA:9 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
    a=AnMw66Xr5OuzjdxB04dI:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeEROXb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 10:23:31 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33215 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeEROX0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 10:23:26 -0400
X-Google-Smtp-Source: AB8JxZrq6A5JUZY2pC7rftVxcDobD1UslqMbGN5FI3PqJpUbE+IY2fcmDlUHD8994HHSeLQAXibQvQ==
From: Alexander Potapenko <glider@google.com>
To: jthumshirn@suse.de, jejb@linux.vnet.ibm.com, dgilbert@interlog.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-scsi@vger.kernel.org, dvyukov@google.com, hare@suse.com,
        torvalds@linux-foundation.org
Subject: [PATCH] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
Date: Fri, 18 May 2018 16:23:18 +0200
Message-Id: <20180518142318.200260-1-glider@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This shall help avoid copying uninitialized memory to the userspace
when calling ioctl(fd, SG_IO) with an empty command.

Reported-by: syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c198b96368dd..5c40d809830f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1894,7 +1894,7 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * sfp, int buff_size)
 		num = (rem_sz > scatter_elem_sz_prev) ?
 			scatter_elem_sz_prev : rem_sz;
 
-		schp->pages[k] = alloc_pages(gfp_mask, order);
+		schp->pages[k] = alloc_pages(gfp_mask | __GFP_ZERO, order);
 		if (!schp->pages[k])
 			goto out;
 
-- 
2.17.0.441.gb46fe60e1d-goog
