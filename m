Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602CBC4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E23020854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi9+z1+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E23020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeILXlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:41:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42221 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:41:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id z11-v6so2568712lff.9;
        Wed, 12 Sep 2018 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=ecIsW9IyKqy9C+GprLkMa0/3hlbYSHkBLQqcH/0CXKg=;
        b=Mi9+z1+vebXim6B8HqKVMhkYp/yJEyF1BDHEzr0hvgbQWqAimCSFIfkrJdfG1bbt5y
         wS/UneehNE48qrc/Q40/fuXyDKuz6OC0dlL7/83y4sX3QFo0CU52on+QjP5MROMwtG0u
         KjxQ2hwIJZpAHv4IZefy/ZrNjwSmkXZxUPZkJ6mzQpXqpiYJxE6UaiB3wyMng1RUeh7q
         1I/V3CfKlzbHf2T8w+2jkMP8vQDuwrfczPA5vRXzzD8X9Y3SKnMYsgRWp/Zc5+bDfgcQ
         DHdZAqiEpzHqNJmQ5MrKojyKruxbMD52toTokQcTSNPLLdLy4W9r08C17aE1XkNpkBHm
         Fv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=ecIsW9IyKqy9C+GprLkMa0/3hlbYSHkBLQqcH/0CXKg=;
        b=VprI11/cbRj2Ln0zavTlVh0lQfdAEgrLDTShlKWXuz51OrgQS2qSAnDMUYa/e4cWqC
         u75W9MRTR50HGVdz+rliMt5m28f4cy8hd2ezzuhbenU6GjLNF1HhMtASKWgeVMxODPR2
         QAaAk7/RlbPH4hsZzZCoWdtP6hu2Y9JMBkumJQ0hwjbMZ4rqWOGKeJ2tqp8u5pNDYH/F
         6PkMh2aY8WGcYIDFzkBXAlj7jvoaEbs3w2daHlLbeGv0S/zn/ppOuUPfXwy/OAeSbv8g
         jnqtavnluElTPVF0N5iSSlgqTel1Wt5gfbCArBtCEhcrVxMGnfl0cCx4KvoktMq7mpFV
         zPbg==
X-Gm-Message-State: APzg51BSQsSeU6y0ETlu/GCsAv/beIjzTqXElpaHyxsVissukC/wOdkK
        Q/6nza19ZExiAG4Nrnj2s8U=
X-Google-Smtp-Source: ANB0VdbZq96+DMyOOhycAW9X5+F9qPnd6AIFhZQGvUELshDPkmY2qZDJN7O2QPhRtBQOB/Q/L7MNIQ==
X-Received: by 2002:a19:18c:: with SMTP id 134-v6mr2320546lfb.16.1536777323797;
        Wed, 12 Sep 2018 11:35:23 -0700 (PDT)
Received: from vnote ([95.72.40.207])
        by smtp.gmail.com with ESMTPSA id r22-v6sm295052ljh.22.2018.09.12.11.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:35:22 -0700 (PDT)
Date:   Wed, 12 Sep 2018 21:35:19 +0300
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3] efi: take size of partition entry from GPT header
Message-ID: <20180912183519.GA31506@vnote>
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

Use gpt_header.sizeof_partition_entry instead of sizeof(gpt_entry)
for GPT entry size.
According to UEFI 2.7 spec 5.3.1 "GPT overview":, the size of a GUID Partition
Entry element is defined in the Size Of Partition Entry field of GPT header.
The GPT with entries sized more than sizeof(gpt_entry) is not illegal.
OVMF firmware from EDK2 perfectly works with it, see edk2-tianocore source
code.

Changes since v1: refactoring (extract get_gpt_entry function),
                  fix (&ptes[i] -> pte)
Changes since v2: use le32_to_cpu, fix typo, sanity check for
                  sizeof_partition_entry

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/partitions/efi.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..c8ff7860973d 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -429,8 +429,8 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 		goto fail;
 	}
 	/* Check that sizeof_partition_entry has the correct value */
-	if (le32_to_cpu((*gpt)->sizeof_partition_entry) != sizeof(gpt_entry)) {
-		pr_debug("GUID Partition Entry Size check failed.\n");
+	if (le32_to_cpu((*gpt)->sizeof_partition_entry) < sizeof(gpt_entry)) {
+		pr_debug("GUID Partition Entry Size is too small.\n");
 		goto fail;
 	}
 
@@ -670,6 +670,12 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         return 0;
 }
 
+static gpt_entry *get_gpt_entry(gpt_header *gpt, gpt_entry *ptes, u32 index)
+{
+	return (gpt_entry *)((u8 *)ptes +
+			le32_to_cpu(gpt->sizeof_partition_entry) * index);
+}
+
 /**
  * efi_partition(struct parsed_partitions *state)
  * @state: disk parsed partitions
@@ -704,32 +710,36 @@ int efi_partition(struct parsed_partitions *state)
 
 	pr_debug("GUID Partition Table is valid!  Yea!\n");
 
-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
+	for (i = 0;
+	     i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1;
+	     i++) {
+		gpt_entry *pte = get_gpt_entry(gpt, ptes, i);
 		struct partition_meta_info *info;
 		unsigned label_count = 0;
 		unsigned label_max;
-		u64 start = le64_to_cpu(ptes[i].starting_lba);
-		u64 size = le64_to_cpu(ptes[i].ending_lba) -
-			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
+		u64 start = le64_to_cpu(pte->starting_lba);
+		u64 size = le64_to_cpu(pte->ending_lba) -
+			   le64_to_cpu(pte->starting_lba) + 1ULL;
 
-		if (!is_pte_valid(&ptes[i], last_lba(state->bdev)))
+		if (!is_pte_valid(pte, last_lba(state->bdev)))
 			continue;
 
 		put_partition(state, i+1, start * ssz, size * ssz);
 
 		/* If this is a RAID volume, tell md */
-		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
+		if (!efi_guidcmp(
+		    pte->partition_type_guid, PARTITION_LINUX_RAID_GUID))
 			state->parts[i + 1].flags = ADDPART_FLAG_RAID;
 
 		info = &state->parts[i + 1].info;
-		efi_guid_to_str(&ptes[i].unique_partition_guid, info->uuid);
+		efi_guid_to_str(&pte->unique_partition_guid, info->uuid);
 
 		/* Naively convert UTF16-LE to 7 bits. */
 		label_max = min(ARRAY_SIZE(info->volname) - 1,
-				ARRAY_SIZE(ptes[i].partition_name));
+				ARRAY_SIZE(pte->partition_name));
 		info->volname[label_max] = 0;
 		while (label_count < label_max) {
-			u8 c = ptes[i].partition_name[label_count] & 0xff;
+			u8 c = pte->partition_name[label_count] & 0xff;
 			if (c && !isprint(c))
 				c = '!';
 			info->volname[label_count] = c;
-- 
2.18.0

