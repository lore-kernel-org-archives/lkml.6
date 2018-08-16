Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F608C41535
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6B2214EE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htb7qIMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6B2214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeHPDvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:51:09 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:41716 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeHPDvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:51:09 -0400
Received: by mail-qk0-f202.google.com with SMTP id w8-v6so2839681qkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 17:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V5Q2yH6ejYwjDFeugDxnLuwETsEuK1MNcNhvs1eBg1c=;
        b=htb7qIMv17iKMChsz50TUxPmcllhd71PfyviOE0loninFqhf0itE/qVy4uUxfLCjy7
         6RD2yL12kU+xK55G/COG67r2dYisV1UVC2fJ5DwSLc1vbQUvuZ6wxSIt43sxjrXr7jLW
         Ha7qQgxmdzchLIrDN7NWCvwsVnSArwCFsRGmNNWMmR6FjiXCoLdbkSSRRwVEdbNqz9Fc
         poTAPuyn5/VVrTVhQr1Z7sVt467QpcdW39zGCkYdOzAIbmBpBmF5cL616xMuZvVHG2l2
         niIKOVWbGlKdUM2/0g9U+vAkZgFc9nJFU0L+WVG846LYMzcdXIiYWIl+6FrNy+fhLnaD
         +VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V5Q2yH6ejYwjDFeugDxnLuwETsEuK1MNcNhvs1eBg1c=;
        b=TrJF69B5BPZwdHhit9Cbj4uElz9EsMp8AHHNs6Q0+k1dwyaIMlDj5neP3xPuMmEDcc
         ctQzFGuptUiOpdiX97wQqs+H+6L5xbFI5xROGDQNE6CDwDlguTmtLMBNtLQryqdyuW3I
         9Spdm2+HlPNs3JWz6w1Z5Gah0e/t5ApmA6KcNiSqR03fBTjymWfjZGNAid5epdQkpRUL
         g/1r5vopoG7fsFveSgk2AQiC8iNsS5F+wwn+Rj5nXceYxtEw7U7d0tMH2CyA/3aZezh2
         Zb6YU/zXAsD47SO27Zko+qX8OkzuBNgSFIO1iG1t6CQT10szBZmM8VS0fsYXXLOFzY1H
         9qhw==
X-Gm-Message-State: AOUpUlHP03nTcnsKrJiSWK+fSR9He0ujIdc9nQG6DHOGCjFTutfViCpM
        BGJzRjZFiWJg7zEpogML/A5J34EUM4rHQw8t
X-Google-Smtp-Source: AA+uWPzOIsASVzqUYTGVAbF3W4LdJvA98hS1n9bjWmXh2ZoYyQu+2Xg4NsZXnHfpi/k1pKwdtypd+RGSoh2qqom8
X-Received: by 2002:ac8:7111:: with SMTP id z17-v6mr15729790qto.58.1534380983671;
 Wed, 15 Aug 2018 17:56:23 -0700 (PDT)
Date:   Wed, 15 Aug 2018 17:55:48 -0700
Message-Id: <20180816005548.151269-1-erickreyes@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH] ALSA: info: Check for integer overflow in snd_info_entry_write()
From:   Erick Reyes <erickreyes@google.com>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel-team@android.com,
        Vinod Koul <vkoul@kernel.org>, Joe Perches <joe@perches.com>,
        Al Viro <viro@zeniv.linux.org.uk>, alsa-devel@alsa-project.org,
        Erick Reyes <erickreyes@google.com>,
        Siqi Lin <siqilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4adb7bcbcb69 ("ALSA: core: Use seq_file for text proc file
reads") heavily refactored ALSA procfs and fixed the overflow as
a side-effect, so this fix only applies to kernels < 4.2 and
there is no upstream equivalent

snd_info_entry_write() resizes the buffer with an unsigned long
size argument that gets truncated because resize_info_buffer()
takes the size parameter as an unsigned int. On 64-bit kernels,
this causes the following copy_to_user() to write out-of-bounds
if (pos + count) can't be represented by an unsigned int.

Signed-off-by: Siqi Lin <siqilin@google.com>
Signed-off-by: Erick Reyes <erickreyes@google.com>
---
 sound/core/info.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 9f404e965ea2..08832c973a53 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -253,6 +253,7 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
 	struct snd_info_buffer *buf;
 	ssize_t size = 0;
 	loff_t pos;
+	unsigned long realloc_size;
 
 	data = file->private_data;
 	if (snd_BUG_ON(!data))
@@ -261,7 +262,8 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
 	pos = *offset;
 	if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
 		return -EIO;
-	if ((unsigned long) pos + (unsigned long) count < (unsigned long) pos)
+	realloc_size = (unsigned long) pos + (unsigned long) count;
+	if (realloc_size < (unsigned long) pos || realloc_size > UINT_MAX)
 		return -EIO;
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
-- 
2.18.0.865.gffc8e1a3cd6-goog

