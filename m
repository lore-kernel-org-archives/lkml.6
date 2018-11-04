Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50522081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM1DMh+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50522081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeKEFHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:07:22 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:41977 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeKEFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:07:22 -0500
Received: by mail-lf1-f46.google.com with SMTP id c16so4626214lfj.8;
        Sun, 04 Nov 2018 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=u99WQmpi84bDl0q3PHKuJ1xqPyAtqdp4Ojn1tCPeIRE=;
        b=WM1DMh+iF7Nhp9HIhh/sNnr2o87guhBKwpzVDGTJFdkoJ3qXjt4rANO/WanjgvvbTH
         DOIgW/YZOfJMzywJsQWAXDKkGs4RQr2l7QPLiAfY5AeRO7o/7to2xdsF/5D8D37PyfAU
         v5PcucBTqfN98oiGCaD3yr2lZzuh0tvz5ye6d/xJz9vcTQD+tQOPZMO+5kiA+1Uxc+K2
         xyAkDBAWhUGw2MZp9di6KUbtLKDFrbZOH2XmMzBGUbAPQD4k35fkaYb96BB6rWpY245G
         iTG3OqfkaU/15YzCEGT0LMTh1ZeiRlMqhVtXpV60xcZLTYc5ssepiRc93+LCFwJ2XMLV
         TtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=u99WQmpi84bDl0q3PHKuJ1xqPyAtqdp4Ojn1tCPeIRE=;
        b=skNdel0H7OtLYjQ3d61YnSYfdGHDG2KzdXyjR0SeqatA0i5MVOqpKijCxdZrUA5yp4
         el/nlTCk8wSs9QAd9Ct/25yK3GeA8rrRxeAI0U+a3Ij6+LTYpckuAfcsqmZ1wUPla+Ul
         V2w+DLKR6VXNfiiK2/0b4vrDjGonb8yGCDvw0lDZFolb2nN5POnKwnLohk0druqRhg2/
         Fr3HwYwAwm7GkmwQ7wVgk/HSFOpFqj+OP/uZ0Hr7iBIYSNamPffnhpyM7TPRiApFshrK
         ADZ4JGHBxEovVvsF6wFLojJYgZs4DI6xrQwIrvdzC7zE/0GiIolEE7Gv+ZPMfaMkfqkA
         aFXQ==
X-Gm-Message-State: AGRZ1gLDEoK6MC07XgG90mhmorBTcU80iuUbYiUjhY4VC8yKBfbimH4u
        pqxc0ad2KcP7SIsZjc6RUGY=
X-Google-Smtp-Source: AJdET5c5QbvwY2EY0pjpiBZAyhOUoCMFFLnVhg78ltmlQu27GekHQ71JW9qdwVUsRQ8Gbc460Y5Wxw==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr11545335lfj.83.1541361070702;
        Sun, 04 Nov 2018 11:51:10 -0800 (PST)
Received: from dnote ([5.35.110.163])
        by smtp.gmail.com with ESMTPSA id a19-v6sm6381044ljj.91.2018.11.04.11.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 11:51:10 -0800 (PST)
Date:   Sun, 4 Nov 2018 22:51:10 +0300
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 2/2] efi: take size of partition entry from GPT header
Message-ID: <20181104195110.GA15437@dnote>
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
Changes since v4: sanity checks for GPT entries; split into
patchset

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/partitions/efi.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 722117b32585..3858c042d3ac 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -447,8 +447,8 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 		goto fail;
 	}
 	/* Check that sizeof_partition_entry has the correct value */
-	if (le32_to_cpu((*gpt)->sizeof_partition_entry) != sizeof(gpt_entry)) {
-		pr_debug("GUID Partition Entry Size check failed.\n");
+	if (le32_to_cpu((*gpt)->sizeof_partition_entry) < sizeof(gpt_entry)) {
+		pr_debug("GUID Partition Entry Size is too small.\n");
 		goto fail;
 	}
 
@@ -711,6 +711,12 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
         return 0;
 }
 
+static gpt_entry *get_gpt_entry(gpt_header *gpt, gpt_entry *ptes, u32 index)
+{
+	return (gpt_entry *)((u8 *)ptes +
+	       le32_to_cpu(gpt->sizeof_partition_entry) * index);
+}
+
 /**
  * efi_partition(struct parsed_partitions *state)
  * @state: disk parsed partitions
@@ -745,32 +751,35 @@ int efi_partition(struct parsed_partitions *state)
 
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
2.19.1

