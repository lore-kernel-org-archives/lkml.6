Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC3C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED522146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R96hg86I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED522146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIMBP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:15:28 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37568 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMBP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:15:28 -0400
Received: by mail-lf1-f42.google.com with SMTP id j8-v6so2819318lfb.4;
        Wed, 12 Sep 2018 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=ptJv5GWvO+DKFjfxIt2FV/EJLq/ImAHAd4PHbfD0T7g=;
        b=R96hg86I+YqtHJ95eD7wHSROw4RZkLsdnyBHskVWirOCMmgYLntQ457l6TOxr+9jk0
         7jdoLiI82S91kioxtL6gkHQbgy5tupPThUr8mwn9bFLzWxOoyncq+yBK7Vj3Qmqou4jb
         XzkDVJTyoDCsLCF/bT1IIJpXPmSYREpQvw/ZZcpgfzIaheqFPeBpQxYn7vT0nN265YkR
         MSYl9RvkzBK47Ku6sg/xGIOhu5PCgvNZ96VEDSzzy0mJog2kv0VdPk04AzXGWPEV1h+h
         +ko4a37f8scMLSOIuVF5MVtM+7NEut8uT40n4snWq5+Pg4CPQJrkINLIZC37HbjfwKbB
         WSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=ptJv5GWvO+DKFjfxIt2FV/EJLq/ImAHAd4PHbfD0T7g=;
        b=gCSmDHfsnhb1y1Oa4dLxvSLZzlHmR35gqqWvkbxWolgyMhSPFlBTcm6LB6e7XXmmFo
         WrsN3prX8qJ7FKAb1VvbaDzg6wHgA84Ixo9/K7BPRSieiUNqQut434aZfgls95X3JGk5
         S4Qbcxi8+Glbfp8z1Bp/M/huPOrtjxBFaiZoS7udxKhgzHHeLTz3LG+UwZfYljDKDHHu
         DQwmuY8GOUpF0OyLYC4huvD3NlV07QjdWRZmBmGRonSl3LMsYmxSNyrwpICFssGm+BUt
         JmdIO6kUjtm+PDtN4boW9nKlItck4f5sSNWnKEv4KaHDpK0PQz/bis2qFON52FxYK/Wr
         DmlQ==
X-Gm-Message-State: APzg51ATrfYHQ1IvAMktu5ELxbbOXrGDouEzjoSIt4fmpa7SY8v1id2t
        eGoWC637EduAIW2AFoS23KY=
X-Google-Smtp-Source: ANB0VdbMdG+ZmS201oqfeySdOI/tZDKQmDfiycsObk9/kYj/xsaSPVwcp6IVjv8mRudFz40ceB7PsQ==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr2511733lfh.125.1536782957817;
        Wed, 12 Sep 2018 13:09:17 -0700 (PDT)
Received: from vnote ([95.72.40.207])
        by smtp.gmail.com with ESMTPSA id a4-v6sm328017lfe.54.2018.09.12.13.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 13:09:17 -0700 (PDT)
Date:   Wed, 12 Sep 2018 23:09:14 +0300
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4] efi: take size of partition entry from GPT header
Message-ID: <20180912200914.GA16693@vnote>
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
Changes since v3: style fixes

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/partitions/efi.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..0d10a582b5bc 100644
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
@@ -704,32 +710,35 @@ int efi_partition(struct parsed_partitions *state)
 
 	pr_debug("GUID Partition Table is valid!  Yea!\n");
 
-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
+	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) &&
+		    i < state->limit-1; i++) {
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
+		if (!efi_guidcmp(pte->partition_type_guid,
+				 PARTITION_LINUX_RAID_GUID))
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

