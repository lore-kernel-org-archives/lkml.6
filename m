Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EBBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C67208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDbkmhRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C67208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeH1DEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40248 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeH1DEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so444335edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4wY5SxtbqayXTNKr6tydWliEBo2ImNu84K0iwTVEJ0=;
        b=bDbkmhRMDJdTfb0iSLX09SNXUQbyQDYWbT2xTDanb/ZG7FkQvP6yBRpOZE5/JS633E
         BoDcLNHNaO57jdCWrZ+xzKTnGBSsbYcV2i3DkWMPJ1+17xSVi6TAGnUobjOsy0fhusKU
         L8JmZ1lMeH5p/yQ/eAUnkV/6YSUw0V8n8yjpvmduJ7ReQ31aOuE03iHNuNm/9rVPnk5d
         NZtMs4ifI9O8rD1k8FgopT4x+SExI5g4GtkKj0hlg1p/VjyTNvO2GiTXebwPRclh/S3X
         WpNwEn0yDUl8ZEDok5jTTfpu1DIWruLHIiI2QDj8PmxJ8IAUhspBfQ8t/O4Uuw+llfpz
         fGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4wY5SxtbqayXTNKr6tydWliEBo2ImNu84K0iwTVEJ0=;
        b=HkfgmHfX/lt8Sz3+WW6cwqtfACJAwXTL8sDle9CVw7wVed5pIZ5xqVoqCAU4rR/gx1
         ZKBrQN2pXSF/F8gBQjfyVEK9g/QXpyIS9+TEvOZJzNzjMgHeuaC31d+NCjcHI6CMCVnV
         owVxVpZ/rQioDAFNTj84BmH4cObigp4lZyscJiKjMuvkZ8Ij6Mh0sYJvUAGSXfRRO8dD
         /tmUaHDQeWTza9LVqRb4GxXKNfiGWjAJdWr9kSN4faZO/gVnaMHGFDcSIcCnY1DlHyXc
         VlhbNDPRdh0An2sEmtrl+91dOTsBeac0WhKZYoo06yZRCHnPpx9mtgytkLGCcwSpFj4O
         uRMw==
X-Gm-Message-State: APzg51CiflRY4xu5rWYDkJAcTXr8Zc869we32JKslyff40Ixt4i1NNlw
        9MsWeKkC2fAa1HrHPmKmfJkuc0Q=
X-Google-Smtp-Source: ANB0Vdb7eMUSMPsaLCR+5U4267GHc/vXhGD3TM1Kzd9Vcm72vBwplsQc8q0C29TG76Smej0UxiXqeg==
X-Received: by 2002:a50:9034:: with SMTP id b49-v6mr19704662eda.174.1535411743588;
        Mon, 27 Aug 2018 16:15:43 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:43 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 13/13] proc: convert /proc/*/task/*/children to _print_integer()
Date:   Tue, 28 Aug 2018 02:15:03 +0300
Message-Id: <20180827231503.26899-13-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark pread /proc/1/task/1/children 2^21 times on the same system:

	6.766400479 s
	4.328648442

	-36%

(need to remeasure on a controlled set of children)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/array.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d0565527166a..045ce2cac1dd 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -710,9 +710,11 @@ get_children_pid(struct inode *inode, struct pid *pid_prev, loff_t pos)
 static int children_seq_show(struct seq_file *seq, void *v)
 {
 	struct inode *inode = file_inode(seq->file);
+	char buf[10 + 1], *p = buf + sizeof(buf);
 
-	seq_printf(seq, "%d ", pid_nr_ns(v, proc_pid_ns(inode)));
-	return 0;
+	*--p = ' ';
+	p = _print_integer_u32(p, pid_nr_ns(v, proc_pid_ns(inode)));
+	return seq_write(seq, p, buf + sizeof(buf) - p);
 }
 
 static void *children_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.16.4

