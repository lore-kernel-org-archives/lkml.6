Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1E4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D429B208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGm5jD9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429B208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeH1DEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46711 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeH1DEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so421315edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zr+Bw9zcrgyZNkjKwCaNpun0BBxJG2M1r0qHuQ1HOUc=;
        b=DGm5jD9cVxoA9dGhv59FVeI+sI4Qr2hV+fUNNksjFlgVfmkbgntNAmt5k/MDge//gM
         0Q5ziVyjghzMkHtMRgFsjyU9hX/U3V5IieKXxVHw6+f9ygBcXsZqeNXJG5hsFYojIYfH
         ltofCN3fdEeBcDATk2X/hpyImXAeANbwKvijzuX8b45/lDuVurICO8i2VRaIxjdiiy6C
         evWRpI3On7+6Izvf+AhVbNcEx8bl2hP+CdyQGBCsuw4VWa8FY/xP0FSpX2XftA10EB54
         0Qj80VedEB+iUZAcBwy17F613rE84YJ5k5Ybtkm2l8BfTj4KA9Fmpk0UtmqlxP3SdJby
         UxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zr+Bw9zcrgyZNkjKwCaNpun0BBxJG2M1r0qHuQ1HOUc=;
        b=JjkJ/+B0fnwM41WGRSJa7rHZeULo+F7dVSfiQOnuEVhm2MmWOZ/JSJyk6j0knlu0Pt
         KhZzLuSy9+41vp3fBQyURWjw9bxbLW/a67yg+TBKpXy55jqtRrTBOM/Au4SWkFjY3dHu
         Fnknd+NTgobV/tkP1y6yJEg9PCgRBSKaoEwpkbOI3nZvSo03xoQaDfPupnLXe+/Viw9C
         K6/mzHinUWar8jehhB+I6UL516oSTz0QMpuxAEt4gf3Hmxbovm784VX7AyOQthcvLlOP
         rHKOMUYwI53zf56kceKnb7cCAQs/9BVPYXZCSwzW9gl9nRFJn6MdiXJyfi7LuJXOoY99
         NPLQ==
X-Gm-Message-State: APzg51Aj94b/DfbywSC1BsnckRpZePo2CSN6tryNy8KlAUTNnNSJBCf7
        wSBwcYJHTw2ebMKuyJj3FsgDjWM=
X-Google-Smtp-Source: ANB0VdYlZa8fHxKwdE5kYOskUqMOBp2LqsCEHahbYHuo6+jQPcb18ClkKlUD12pwDV6wq4cpK2k7lw==
X-Received: by 2002:aa7:d391:: with SMTP id x17-v6mr19213780edq.144.1535411737276;
        Mon, 27 Aug 2018 16:15:37 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:36 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 06/13] proc: convert /proc/self to _print_integer()
Date:   Tue, 28 Aug 2018 02:14:56 +0300
Message-Id: <20180827231503.26899-6-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark readlink("/proc/self") 2^23 times:

	8.205992458 seconds time elapsed ( +-  0.15% )
	7.535168869 seconds time elapsed ( +-  0.09% )

	-8.2%

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/self.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/self.c b/fs/proc/self.c
index 127265e5c55f..b2279412237b 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -14,6 +14,7 @@ static const char *proc_self_get_link(struct dentry *dentry,
 {
 	struct pid_namespace *ns = proc_pid_ns(inode);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
+	char buf[10], *p = buf + sizeof(buf);
 	char *name;
 
 	if (!tgid)
@@ -22,7 +23,11 @@ static const char *proc_self_get_link(struct dentry *dentry,
 	name = kmalloc(10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);
 	if (unlikely(!name))
 		return dentry ? ERR_PTR(-ENOMEM) : ERR_PTR(-ECHILD);
-	sprintf(name, "%u", tgid);
+
+	p = _print_integer_u32(p, tgid);
+	memcpy(name, p, buf + sizeof(buf) - p);
+	name[buf + sizeof(buf) - p] = '\0';
+
 	set_delayed_call(done, kfree_link, name);
 	return name;
 }
-- 
2.16.4

