Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD2C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74184204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ9kCkoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74184204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJOMnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38485 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeJOMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so5588790pll.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmMbl5f1nYfYN3o4x7JAmMnBJ9NZVxf2yLh5FU0NkjE=;
        b=LZ9kCkoG7BDZOwL1Ler15292BzRUslicnv13ssUGrCMYmZw75BJva1nbC/ogEIrLrj
         FARRIDuYeep9tgLTLqhl/fdLjf4fHCI7zs27Mnc8SNnojFfG6hKFe8M/bicwwBA6jvWg
         B1jqgH6X87Y61D2ooSIdVMnWMaWISTs2uZ3eNAvkcWG0UkhvhbxuZ1Tuc5J9VjFWPg6W
         OGsfbKgQZBrE08uODy3MmKR9+MuRDFKUoTAcaRVH4oJP1uNGSELO1dkXVdiXGC9qkrIl
         J39PnGtJ1G9h39eCI+MG3Ft+zeMHufioLagF7wkXRpRUN7sFHSvjG/qdtGHfHB8XS4tx
         gbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmMbl5f1nYfYN3o4x7JAmMnBJ9NZVxf2yLh5FU0NkjE=;
        b=bCFuMhzkbviUNukN0vVOsDNzY+WOMLi+V6kKEGU/n94uUBBEkXccH18+65pD8RusMU
         UZ2BVBN2zC7mZzfs0aJrhw2BOYhQVDvslk8QKy6BxRlUphH1y9H2qm+rig7s9o7xaQXm
         GOnwpnQIasNUw5ZcvN9ZhijxgdAD6wHKDWXTGqdJIIgjxtPbKQYo/s808SWIvp3d7+g7
         8iaQGH/C+hC17tMG1tGAcMh0g2Vb+APN5Qn1b0B7MzqTc6rZD22R1geNMBRIampo7wpS
         pD4gTh43mFGHgrnfZmeYX9FDW9mBRxI1ReydLA0xypIRqls4cEUO0bgJA50/QcqHpeHY
         LDtA==
X-Gm-Message-State: ABuFfohEjIYW1P3/IVFjZiduK6r5/OQEQc9+8RO3MwhY/TyeNr0vgaeI
        2SO2x29B6tP8lLNz9qh++e5GnmDJ
X-Google-Smtp-Source: ACcGV61jRIsTm03Bh7nq5PFf+qhUAxmQSnq00KyevGEFOK31BVQ+9+OQyWk65xXw5wSdF98A07O8zg==
X-Received: by 2002:a17:902:744c:: with SMTP id e12-v6mr15691871plt.186.1539579604104;
        Sun, 14 Oct 2018 22:00:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.22.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 22:00:03 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 10/11] staging: gasket: sysfs: fix attribute release comment
Date:   Sun, 14 Oct 2018 21:59:26 -0700
Message-Id: <20181015045927.156790-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Comments for gasket_sysfs_get_attr() incorrectly describe reference
release procedure.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
index f32eaf89e056b..151e8edd28ea6 100644
--- a/drivers/staging/gasket/gasket_sysfs.h
+++ b/drivers/staging/gasket/gasket_sysfs.h
@@ -152,8 +152,8 @@ void gasket_sysfs_put_device_data(struct device *device,
  * Returns the Gasket sysfs attribute associated with the kernel device
  * attribute and device structure itself. Upon success, this call will take a
  * reference to internal sysfs data that must be released with a call to
- * gasket_sysfs_get_device_data. While this reference is held, the underlying
- * device sysfs information/structure will remain valid/will not be deleted.
+ * gasket_sysfs_put_attr. While this reference is held, the underlying device
+ * sysfs information/structure will remain valid/will not be deleted.
  */
 struct gasket_sysfs_attribute *
 gasket_sysfs_get_attr(struct device *device, struct device_attribute *attr);
-- 
2.19.0.605.g01d371f741-goog

