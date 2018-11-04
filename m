Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13EFC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5A82081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8+mQWbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5A82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeKEFHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:07:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38882 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeKEFHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:07:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so4646921lfg.5;
        Sun, 04 Nov 2018 11:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=BJH7TByfzPsX6krZ6CDbMD0Hb9sViuTig98Bh11Iu00=;
        b=M8+mQWbQ8ZiY/3wVpwD4JbVRa3H3HXaYW/3TIn5A3+Xc35MHEdgUffu7NtS3TwENWl
         GVOMMQc+a7JOfBDe4b1letgyN7G02zqDgVob6p4irNo2L0+HvAI7Q2Rm53eFkZA8ZyFo
         I6RwKbIENTmnMJoSWl1LirGSAoL6n6QutkTyBdxV7czOKRln00WcCF1haXTQgPUjr9xk
         3xhowZREXsM5YzdOpgn4hsTGK6+mBYJtznccVBTUBaWjbkYzxw6a6GM/1FxSzbfybxSu
         CEJXwTudKjSxWIe5+oBq1urFCIPSU+gLKxlsx1VAMVqkIFurEwk6v8ZvYQZwchosMi7P
         Su0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=BJH7TByfzPsX6krZ6CDbMD0Hb9sViuTig98Bh11Iu00=;
        b=ohy5PyoME1lKSFaW+ATFOjd6bU6jEuM0AylgEy1isrnDtknZUydN4wTGY7Bn8H/925
         tUKNRvv+RZKp+t6P6YC5eDqmetgfqO7KFLiqm1WshA/KnB0ZUwcGWAFt4ebNr/ClTlSz
         D37IvhoYAggP7KwcPCQEAHN03lqSL/Io3dUgKzAvSJMwWfGcsXxN2QS1HiCEggFBika6
         F/K3nkIMI5mNSZqJvYFhkWrzm/ereo2+LkABov0qqk2Vywam4cSM6o5a5NOX8endtrVF
         RfL98f98jDHLd+7iMGhRBKLoSopWuqnx07d2acnHRz1PMSi2Br5M4vIXSqteNRq7YtwC
         s8ww==
X-Gm-Message-State: AGRZ1gIYO+PYHMdwj04Q24ZG0Mr5E7jRMGjHFCVqaICKtfjMw+2TkoB1
        WyGQOwxCb1awwPqD0l3rwrs=
X-Google-Smtp-Source: AJdET5cyiGOyfMhSxOrEa9cqsdYmToiHv1WStwt8z2vihzItgY/UkWsrm6oneFDVDcgMAMu85i943g==
X-Received: by 2002:a19:9c92:: with SMTP id f140mr5497206lfe.41.1541361055798;
        Sun, 04 Nov 2018 11:50:55 -0800 (PST)
Received: from dnote ([5.35.110.163])
        by smtp.gmail.com with ESMTPSA id z8-v6sm2862689lji.51.2018.11.04.11.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 11:50:55 -0800 (PST)
Date:   Sun, 4 Nov 2018 22:50:55 +0300
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 1/2] efi: add sanity checks for GPT entries
Message-ID: <20181104195055.GA15428@dnote>
Mail-Followup-To: Eugene Korenevsky <ekorenevsky@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obvious sanity checks have been added for GPT entries.
GPT entries should not:
- collide with GPT header
- collide with GPT partitions
- override the disk size 
These checks also ensure GPT entries are not too large.

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/partitions/efi.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..722117b32585 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -338,6 +338,24 @@ static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
 	return gpt;
 }
 
+/**
+ * disk_regions_collide() - tests if two disk regions intersect or one region
+ *			    contains other
+ * @firstlba1: first LBA of the first region
+ * @lastlba1: last LBA of the first region
+ * @firstlba2: first LBA of the second region
+ * @lastlba2: last LBA of the second region
+ */
+static bool disk_regions_collide(u64 firstlba1, u64 lastlba1,
+				 u64 firstlba2, u64 lastlba2)
+{
+	if (lastlba1 < firstlba2)
+		return false;
+	if (lastlba2 < firstlba1)
+		return false;
+	return true;
+}
+
 /**
  * is_gpt_valid() - tests one GPT header and PTEs for validity
  * @state: disk parsed partitions
@@ -352,7 +370,8 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 			gpt_header **gpt, gpt_entry **ptes)
 {
 	u32 crc, origcrc;
-	u64 lastlba, pt_size;
+	unsigned short ssz;
+	u64 pt_firstlba, pt_lastlba, disk_lastlba, pt_size;
 
 	if (!ptes)
 		return 0;
@@ -369,11 +388,10 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 	}
 
 	/* Check the GUID Partition Table header size is too big */
-	if (le32_to_cpu((*gpt)->header_size) >
-			bdev_logical_block_size(state->bdev)) {
+	ssz = bdev_logical_block_size(state->bdev);
+	if (le32_to_cpu((*gpt)->header_size) > ssz) {
 		pr_debug("GUID Partition Table Header size is too large: %u > %u\n",
-			le32_to_cpu((*gpt)->header_size),
-			bdev_logical_block_size(state->bdev));
+			le32_to_cpu((*gpt)->header_size), ssz);
 		goto fail;
 	}
 
@@ -409,17 +427,17 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 	/* Check the first_usable_lba and last_usable_lba are
 	 * within the disk.
 	 */
-	lastlba = last_lba(state->bdev);
-	if (le64_to_cpu((*gpt)->first_usable_lba) > lastlba) {
+	disk_lastlba = last_lba(state->bdev);
+	if (le64_to_cpu((*gpt)->first_usable_lba) > disk_lastlba) {
 		pr_debug("GPT: first_usable_lba incorrect: %lld > %lld\n",
 			 (unsigned long long)le64_to_cpu((*gpt)->first_usable_lba),
-			 (unsigned long long)lastlba);
+			 (unsigned long long)disk_lastlba);
 		goto fail;
 	}
-	if (le64_to_cpu((*gpt)->last_usable_lba) > lastlba) {
+	if (le64_to_cpu((*gpt)->last_usable_lba) > disk_lastlba) {
 		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
 			 (unsigned long long)le64_to_cpu((*gpt)->last_usable_lba),
-			 (unsigned long long)lastlba);
+			 (unsigned long long)disk_lastlba);
 		goto fail;
 	}
 	if (le64_to_cpu((*gpt)->last_usable_lba) < le64_to_cpu((*gpt)->first_usable_lba)) {
@@ -443,6 +461,29 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 		goto fail;
 	}
 
+	pt_firstlba = le64_to_cpu((*gpt)->partition_entry_lba);
+	pt_lastlba = pt_firstlba + (pt_size + ssz - 1) / ssz - 1;
+
+	/* Check GPT entries do not overwrite partitions */
+	if (disk_regions_collide(pt_firstlba, pt_lastlba,
+				 le64_to_cpu((*gpt)->first_usable_lba),
+				 le64_to_cpu((*gpt)->last_usable_lba))) {
+		pr_debug("Primary GPT entries overwrite partitions\n");
+		goto fail;
+	}
+	/* Check GPT entries do not overwrite GPT header. Note: GPT header must
+	 * reside in the single disk sector according to UEFI spec
+	 */
+	if (disk_regions_collide(pt_firstlba, pt_lastlba, lba, lba)) {
+		pr_debug("Primary GPT entries overwrite GPT header\n");
+		goto fail;
+	}
+	/* Check GPT entries are not beyond the end of the disk */
+	if (pt_lastlba > disk_lastlba) {
+		pr_debug("GPT entries are beyond the end of the disk\n");
+		goto fail;
+	}
+
 	if (!(*ptes = alloc_read_gpt_entries(state, *gpt)))
 		goto fail;
 
-- 
2.19.1

