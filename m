Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 44E2AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E677A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE+Rd43c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E677A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934042AbeFKTjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:39:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41979 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932823AbeFKTjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:39:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so10770836pff.8;
        Mon, 11 Jun 2018 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=X2hLEhf61E8TNoM8JyZCeslkEPZdJuF3n+7rqdu1BKw=;
        b=LE+Rd43ci7ruw1AOF07ns62gSzUjqZVcrXw2tbfJ1fXyI6g7In9Zi37rN5rx/CsS6/
         D6EviHfuN/lEu9ygv6QMfG89QwQviR5rWpcxXgOcMx50wr1UIfGaTq1dClMcbukv4BQp
         fb/6S9TFfrFM0O2D9WJpd3WOS62SwAiecqqbePUbp5b9HpFdZTG0lv3CRW1FBcAOU3+S
         s6vKp/SRy5PXcxEkiEarr1iToeiEUi/f2vfqVd6s9qQrCStVluKmO44pDS1dDFcdu5mk
         4DV4WLj7TM2PGRQXM0W7wy/dPccsv2/qrnMEZvpO9ztmRQ/3FxpWfdIlMTCEMRs95K+S
         KV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=X2hLEhf61E8TNoM8JyZCeslkEPZdJuF3n+7rqdu1BKw=;
        b=Dtal2Vs9wBV+PVzlw0WTW6hSVe44l+6yIPnQxqUe3PLJL8vn+RzOUBrG9yKV1t+sQW
         3sQUIV5jmb70vzSGkiRHrnh2uJOsDjBsdIEvrIHCGWCxwswrDwMdMiyCwuNAw0kc1lpQ
         UAMgYxkLQzUJq4MAYTd1bDkSB7/+V/cnwW2v9ZmZjUk1xDKhC2gR7aDpmClUBaGnCdo7
         CGlEdAdPpclTlvBglpDHMhYAz9/8YMlRTOftSdiLFSGC9UQj/FcsAFw5jfthjh1wD+/H
         9W8f3I2UTa150LYXMrUC6+DTnhxJw1+5Ic5FZIFiS31ETAZP7jsNxQmn+ZIBeZ1UmSss
         MR/w==
X-Gm-Message-State: APt69E0A3OiClL8g5fyEOyzVpvaIP6lE2m1BA1I/QwTD+QfkwIRyuSE/
        R/MfJjRtEsVzbPv/NQcgWJE=
X-Google-Smtp-Source: ADUXVKKLcUvViXb7rzI/av9eJ4+cqyv9KSrechrS0HojBGe9z4oOm5IjW5CnlIoZwfJdy2TcYLw0aA==
X-Received: by 2002:a63:6e4e:: with SMTP id j75-v6mr424089pgc.125.1528745982239;
        Mon, 11 Jun 2018 12:39:42 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.65])
        by smtp.gmail.com with ESMTPSA id p1-v6sm9402809pfh.58.2018.06.11.12.39.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 12:39:40 -0700 (PDT)
Date:   Tue, 12 Jun 2018 01:12:04 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, manoj@linux.vnet.ibm.com,
        mrochs@linux.vnet.ibm.com, ukrishn@linux.vnet.ibm.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com
Subject: [PATCH] scsi: cxlflash: Change return type for fault handler
Message-ID: <20180611194204.GA18687@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/scsi/cxlflash/superpipe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 2fe79df..a4e4c50 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1087,7 +1087,7 @@ static struct page *get_err_page(struct cxlflash_cfg *cfg)
  *
  * Return: 0 on success, VM_FAULT_SIGBUS on failure
  */
-static int cxlflash_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t cxlflash_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
@@ -1098,7 +1098,7 @@ static int cxlflash_mmap_fault(struct vm_fault *vmf)
 	struct ctx_info *ctxi = NULL;
 	struct page *err_page = NULL;
 	enum ctx_ctrl ctrl = CTX_CTRL_ERR_FALLBACK | CTX_CTRL_FILE;
-	int rc = 0;
+	vm_fault_t rc = 0;
 	int ctxid;
 
 	ctxid = cfg->ops->process_element(ctx);
@@ -1138,7 +1138,7 @@ static int cxlflash_mmap_fault(struct vm_fault *vmf)
 out:
 	if (likely(ctxi))
 		put_context(ctxi);
-	dev_dbg(dev, "%s: returning rc=%d\n", __func__, rc);
+	dev_dbg(dev, "%s: returning rc=%x\n", __func__, rc);
 	return rc;
 
 err:
-- 
1.9.1

