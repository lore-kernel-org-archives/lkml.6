Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF04CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782AF2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="jB138+S7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782AF2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbeGWWhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:37:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45838 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGWWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:37:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16-v6so2193024edq.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p4CcBbI9qnoxMfBLrFAndFOAuVPK1L1aWfe8Ms7Ghvo=;
        b=jB138+S7sIR8M68l7mYfKwa5wiPeUEJK+chrfTJg9QIPWH7GBsDenksIFRN9Vp8pB5
         0atKC7O+VmLmQdqmsZqiRws4Rq+2e7P1ZTKtSFEmd628mltBCh2rkT0K8o0RRFczss8K
         xE7JdJSovuQK8xaW01InCbJNM0tk2phRxQHvQztBVvmDI+62hNwLPfaWqFH8nyXqMY+G
         vPYdCGXD2XpIZruaU7KLT29zWcD8C7G3lvSDkn03nx7nAmltN5eBt+WmOqMmhPVRcT9W
         iRsgEEW9l352oEeyt5przME2VMajt+jWr6jpL+iWxgwIdlp2eOu7vqaBn4H1KahxWSWh
         M3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p4CcBbI9qnoxMfBLrFAndFOAuVPK1L1aWfe8Ms7Ghvo=;
        b=dvTzXpxE/OMHNUCYyCSKAnCIS7x0sBQ3zDc9AcLOB5mlZnhkeyhmkoSFkKfT3ftkuw
         JtdFNtKtRwuJAYMdYJLh0LxwaVpkBRyazaD2GQ+UKdPa00TN/EZ8oItawSHOotPuI5KJ
         BAtOJ2cSmozCo80nda7DfgBA23Lkak0LAbi+620KxU22QO+LCFnckhGkKQiuCh7LiNzw
         Ze6ywrvbVQkuQF5E2hJxScjCNxZgaS5vgkEbKdfDCMpy7TsOpyncP1tX53eo4jhUP+eB
         0rt1OlC3XV4dVb2s+FEFXp1DiTg+uVpLwpiqInhvV4bztAAJ68Evcu57sNP8PibZnlms
         v7Ag==
X-Gm-Message-State: AOUpUlHA/EmJtfEGnanYzOBHm5NqLbg3k254oCgkzsfOKqTzNV2dysMN
        Z+FLfQaGxyHNYeX9j91EIVd45A==
X-Google-Smtp-Source: AAOMgpeJmSUdQ19q+Ofb7X1A5JpGdMME+laga3CMU8TZzX3LQo2Yox6wZSAkzfuIBILOuVo1kqANFg==
X-Received: by 2002:aa7:c1c5:: with SMTP id d5-v6mr15882857edp.270.1532381649123;
        Mon, 23 Jul 2018 14:34:09 -0700 (PDT)
Received: from localhost.localdomain ([109.255.141.80])
        by smtp.gmail.com with ESMTPSA id x21-v6sm4937420eds.78.2018.07.23.14.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:34:08 -0700 (PDT)
From:   Mark Railton <mark@markrailton.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Mark Railton <mark@markrailton.com>
Subject: [PATCH] Drivers: Xen: xlate_mmu.c: Fixed comment layout
Date:   Mon, 23 Jul 2018 22:34:04 +0100
Message-Id: <20180723213404.20720-1-mark@markrailton.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed issue with multi line comment

Signed-off-by: Mark Railton <mark@markrailton.com>
---
 drivers/xen/xlate_mmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 23f1387b3ef7..3b03bc1641ed 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -151,8 +151,9 @@ int xen_xlate_remap_gfn_array(struct vm_area_struct *vma,
 	struct remap_data data;
 	unsigned long range = DIV_ROUND_UP(nr, XEN_PFN_PER_PAGE) << PAGE_SHIFT;
 
-	/* Kept here for the purpose of making sure code doesn't break
-	   x86 PVOPS */
+	/* Kept here for the purpose of making sure code doesn't
+	 * break x86 PVOPS
+	 */
 	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
 
 	data.fgfn = gfn;
-- 
2.17.1

