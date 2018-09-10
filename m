Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96516C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2756320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnVLHXzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2756320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeIJX7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:59:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45279 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJX7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:59:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so18294847lff.12;
        Mon, 10 Sep 2018 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=fFXxcmavVApJK3pM931b7AtOy+tGm5tV8PQqCRvr3ss=;
        b=GnVLHXzfuG9Rj5gfMRzTWKHnSBmymgDZ26KXuYrxyPcs6DjdTtB24lcboHQt0NK01A
         EbKUBXLJP9nbbTphXOY183OCgB7WV3lp7rDljRuNCacd4x0HEyZ9AdrLKNIfjdpkzyC/
         WuO54l9nM/0nSQhnCQ/tr/ZjUGQdn5n/tg8Gcmjt5TvCLFDY6UQ9E1X6EAcp4k8LYZnE
         A5j93UYSSOxWozRwWl/jZ7LTm6sPLdQANX2l6MaEJPiJfkh8sROL4+LWzC2zLWvnq/kf
         nhGq+SHZweMOltKqeoCTpXPMvt3mmEDcy88MZPHAM+CY8yZ61qKIA6kXTsp5uKIyF0L7
         q30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=fFXxcmavVApJK3pM931b7AtOy+tGm5tV8PQqCRvr3ss=;
        b=gla/z8KWenzUufdJAw1thWcyhbKDQczRK0mFeMv45BBG3ymbW5NGpasSLAOQ4A7x0V
         DyKSK+1O2o0Sp3NUBwhCgVsBLbA+99VsEUUDfcg+1P7FKlnvbhee1vL1P6i2TI2csOfE
         XE3UfH4iWTPRWoUIQMtpxAxfcOggwz6KXT8WYQws30HQT4/B6zQAER6BOCZ65j4BODy0
         dsyXyta7c8ocv/ZeMhTK5nAoULXhkbT7dmB5OsI4hE5ePOQja7Nl3xaFjNxYa/73px0b
         /fnb22O/AvPALoEz9Emt6iUwLmeuaWe2CCVvp5vTbHm6WtwGxTaO96ntm6QX/jlxI9nH
         bkTQ==
X-Gm-Message-State: APzg51APlsqU/b2erApvb4FR16F/wnDDtGNk3hJiS/M8nUgGNIXHf4h/
        eeoBnyHUOcTi7QjBHCfuU1h4ttBs
X-Google-Smtp-Source: ANB0VdbAlxFBUrFRJc+WMb9vtvVWORaAvqOaUkp8PWA1DtASxfCsrJCZMr1it8Vor6PJTw5iG6ixDw==
X-Received: by 2002:a19:10cb:: with SMTP id 72-v6mr13957680lfq.113.1536606238922;
        Mon, 10 Sep 2018 12:03:58 -0700 (PDT)
Received: from vnote ([95.73.200.101])
        by smtp.gmail.com with ESMTPSA id v63-v6sm2936491lje.20.2018.09.10.12.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:03:58 -0700 (PDT)
Date:   Mon, 10 Sep 2018 22:03:55 +0300
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi: take size of partition entry from GPT header
Message-ID: <20180910190355.GA2166@vnote>
Mail-Followup-To: Eugene Korenevsky <ekorenevsky@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
According to UEFI spec, GPT entry size is specified in GPT header.

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/partitions/efi.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..29f7ec585e1d 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -428,11 +428,6 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 			 (unsigned long long)le64_to_cpu((*gpt)->first_usable_lba));
 		goto fail;
 	}
-	/* Check that sizeof_partition_entry has the correct value */
-	if (le32_to_cpu((*gpt)->sizeof_partition_entry) != sizeof(gpt_entry)) {
-		pr_debug("GUID Partition Entry Size check failed.\n");
-		goto fail;
-	}
 
 	/* Sanity check partition table size */
 	pt_size = (u64)le32_to_cpu((*gpt)->num_partition_entries) *
@@ -692,7 +687,7 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
 int efi_partition(struct parsed_partitions *state)
 {
 	gpt_header *gpt = NULL;
-	gpt_entry *ptes = NULL;
+	gpt_entry *ptes = NULL, *pte;
 	u32 i;
 	unsigned ssz = bdev_logical_block_size(state->bdev) / 512;
 
@@ -704,13 +699,16 @@ int efi_partition(struct parsed_partitions *state)
 
 	pr_debug("GUID Partition Table is valid!  Yea!\n");
 
-	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
+	pte = ptes;
+	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1;
+			i++,
+			pte = (gpt_entry *)((u8*)pte + gpt->sizeof_partition_entry)) {
 		struct partition_meta_info *info;
 		unsigned label_count = 0;
 		unsigned label_max;
-		u64 start = le64_to_cpu(ptes[i].starting_lba);
-		u64 size = le64_to_cpu(ptes[i].ending_lba) -
-			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
+		u64 start = le64_to_cpu(pte->starting_lba);
+		u64 size = le64_to_cpu(pte->ending_lba) -
+			   le64_to_cpu(pte->starting_lba) + 1ULL;
 
 		if (!is_pte_valid(&ptes[i], last_lba(state->bdev)))
 			continue;
@@ -718,18 +716,18 @@ int efi_partition(struct parsed_partitions *state)
 		put_partition(state, i+1, start * ssz, size * ssz);
 
 		/* If this is a RAID volume, tell md */
-		if (!efi_guidcmp(ptes[i].partition_type_guid, PARTITION_LINUX_RAID_GUID))
+		if (!efi_guidcmp(pte->partition_type_guid, PARTITION_LINUX_RAID_GUID))
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
