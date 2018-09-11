Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E902C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A0020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5oPAkZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A0020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIKVPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:15:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42728 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:15:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id z11-v6so20812841lff.9;
        Tue, 11 Sep 2018 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=wz44kfLkKQJU68NWsi2wFVq4c2klOJNm/qjEh5ldOUg=;
        b=L5oPAkZezgdbG/LqZPy0DTZQzHZx1Pip8le51lvDcikPjRrt9capG3cl2e2zwCSQbb
         SFg5FJZLsLovT0p3S9KIUSVVcC6V/WY89k8lg6p/IPgwtJZKVqhVvjtDpsqR1U8YAtzi
         LOIkQ+IHq7j+k7rPM7rNI1KR3lvurMZLuPLnH05dJ7WkWZ/3S68uPS3Sjcc6edL9Dg7y
         f3se8697WbomRRTuo4Jj+dJws6GCaqsR03b+7Et+J125Zc3vQDXZCGpOjErWWjHY+J+S
         jK5dPCuGQrTo4WXjBhZBDZrR/rC2u/Ei6pDvB0kvFfDb7hStThhOJ0KxNmwKbcMuy9Mg
         nFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=wz44kfLkKQJU68NWsi2wFVq4c2klOJNm/qjEh5ldOUg=;
        b=VUVK+xyT1a2yFMX+JYm1QmZ637sQRXRuOvb8Ed/k50DV39k1EXcM0NftkkU0j/SRzO
         xanc3uKAmFeg461uzPyE/AYAwmiXsirIaTwZ8Dyb86INbwHq2Ta2Itb7r8J20wXDUDPw
         3rxYpZ6AZ161TTT5JlvBu2PJFCCofcUgWvoCrmKCjTdUkt6NJGAXid36Ltx9WRG87dDO
         xym/EpBvP7gu4lV5NrX53zR4Gu9BIWEabiHZy5DKL3zsovseZzU12KzJ/LRqnADFVOn0
         8ZGSstaqHGQI+Dx2fnC/sZdhMVjl1KbQZIE6zB8zM4asQODEWwhHDjGJBMy93j3wT0tT
         bLUA==
X-Gm-Message-State: APzg51Cc0N+4eT3VIt2QXMOnPPx7tb++VRIU5RQqwoPs4kFcW97SINKJ
        ZMBUOZaBtBYsM2e5jkv6NDg=
X-Google-Smtp-Source: ANB0VdbsSfbM41ZN5PN3PSU1XUtfu41ywe3W2SXrEahJXrXcuRCs2I0b92FVzmUi1nFssFV7hNIXVw==
X-Received: by 2002:a19:f20:: with SMTP id e32-v6mr15754294lfi.2.1536682530878;
        Tue, 11 Sep 2018 09:15:30 -0700 (PDT)
Received: from vnote ([95.72.40.207])
        by smtp.gmail.com with ESMTPSA id r4-v6sm3333027ljd.70.2018.09.11.09.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 09:15:30 -0700 (PDT)
Date:   Tue, 11 Sep 2018 19:15:27 +0300
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2] efi: take size of partition entry from GPT header
Message-ID: <20180911161527.GA30689@vnote>
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

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/partitions/efi.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..724f7c0805a2 100644
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
@@ -670,6 +665,11 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         return 0;
 }
 
+static gpt_entry *get_gpt_entry(gpt_header *gpt_hdr, gpt_entry *ptes, u32 index)
+{
+	return (gpt_entry *)((u8 *)ptes + gpt->sizeof_partition_entry * index);
+}
+
 /**
  * efi_partition(struct parsed_partitions *state)
  * @state: disk parsed partitions
@@ -704,32 +704,36 @@ int efi_partition(struct parsed_partitions *state)
 
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

