Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3678C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F820836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeFYAaHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4F820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeFTA6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:58:07 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:40210 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbeFTA6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:58:04 -0400
Received: by mail-yw0-f201.google.com with SMTP id q6-v6so1033575ywa.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4i9Hw9/LDH2j4RtXKs7ySY6W5TSRQ5EvN9DnQLvFl2g=;
        b=KeFYAaHjbJ4ASBZMJkk1POx5ta/0P5MJ0kSQTHHB8c71Iz7DWXwdN8go/1ziA+uFgT
         vKADRMrE6m8+fhXq+JquWgcxtEgxW+MiFp2Ak7jw76mguL1Czu5VvX+7hRRD5nHFlXBU
         /W62MpcrAQiKECO2s0cc1sPrajHRwJIx/ZhIB9YODHOIKiTekLjxtvWI2JlevkKUBqau
         ccHao56G5WyLrb7AvbSz6zGqxZJ8ecM7nKX8gv9/BctFl3HMCGHIZ9CT05gNk30yZGnL
         7EtnKuuy9bMthssfENaR0wkH6yM9EPu0ENlMe39/BSIbkmu4mfugvAyt/XoCSTu1LZwb
         NQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4i9Hw9/LDH2j4RtXKs7ySY6W5TSRQ5EvN9DnQLvFl2g=;
        b=XJUnvNoi+isMZjvt1oaxhwLsc+WPrQ58VaFQ02BYHrtrLK5vfebZ+67z+OaaFq/Tif
         hLNVrTXrgVtXI1sHj4MeizuF1OplBuEAWK77BJu7s5V10Os/PkMRxMfZ8pen78/xiV89
         0OPSJCyK/ASVDCesW3dnQp4a3BB65016Io486brgDZPJ+n+yM5cMmD1Ep25VdWr3M7oj
         2f/+VidbycJrhTCsHkUQOmy/QpZGcisKjBcCHZslNwSmDx9kmgSV0cccRMcagXahNMPc
         14RKtnTjCpQtvn2aQBrsMZZhzLr/uc8g3VFadjVkg4hyB1079N15+1CpFn9bhg6Qfj/Z
         ur5w==
X-Gm-Message-State: APt69E0iarw3400HZ0xFx0SIizIJImD5vGTmlyIUNa6MozCVjP4fgTd0
        bZOBkGeUl182puf280fMINgQPt8RDhiAoj5W0GRL0MOCbeFX+4PRUnfnXhY6nWp9XTln+1TH8J8
        BJX7oP5SF+ggdY0kQ+33/4xHGbHY2kzX9zIpN01opOhoRyea55tibRExXjcas4CEebetFmzDSHs
        URww==
X-Google-Smtp-Source: ADUXVKIHHuup0rkt9ljWhGy2koEbTTO5FsofrtQtdccqWPMSErNSLivho9L4kPmjXtElRYXo5ZotcQ+7u9XSbgM=
X-Received: by 2002:a5b:54c:: with SMTP id r12-v6mr1016158ybp.53.1529456283361;
 Tue, 19 Jun 2018 17:58:03 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:57:35 -0700
In-Reply-To: <20180620005735.219840-1-astrachan@google.com>
Message-Id: <20180620005735.219840-2-astrachan@google.com>
Mime-Version: 1.0
References: <20180620005735.219840-1-astrachan@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH 2/2 v2] staging: android: ashmem: Fix mmap size validation
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Strachan <astrachan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ashmem driver did not check that the size/offset of the vma passed
to its .mmap() function was not larger than the ashmem object being
mapped. This could cause mmap() to succeed, even though accessing parts
of the mapping would later fail with a segmentation fault.

Ensure an error is returned by the ashmem_mmap() function if the vma
size is larger than the ashmem object size. This enables safer handling
of the problem in userspace.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
v2: Removed unnecessary use of unlikely() macro

 drivers/staging/android/ashmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ash=
mem.c
index c6386e4f5c9b..e392358ec244 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -366,6 +366,12 @@ static int ashmem_mmap(struct file *file, struct vm_ar=
ea_struct *vma)
 		goto out;
 	}
=20
+	/* requested mapping size larger than object size */
+	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	/* requested protection bits must match our allowed protection mask */
 	if ((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask, 0)) &
 	    calc_vm_prot_bits(PROT_MASK, 0)) {
