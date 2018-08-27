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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C297208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg7O27oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C297208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeH1DFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:05:12 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43271 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeH1DEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:25 -0400
Received: by mail-ed1-f48.google.com with SMTP id z27-v6so432765edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gNlPfOGxOIZa+4NOTZu7u0ClBakEI0ySfd7crmTmBok=;
        b=Rg7O27oHAqvTc2QZKHSjlxFLrmKULHaU1aOLu9oSlBPKM7aigUgtSMIq6Wyl/J7WGX
         +AB2VHAp6ttxOqrhL6rzmhmJHW7Ti505h6UWsuA+vF9icyjW1IZ/xcVJmRyl935vmtk/
         hVGiCPG4gbI3y2zEfgRJYKuKS8jIbUWfWngwvli2TJvk7d1D4a2MNVzkqzpea8QgoFkU
         OQpWmOWdKYAw8QpUZTXW5ukhQo5aOVXAPPc07q7OuN8RRHwh1UPcvqL1g1zaEEl7N0yE
         bpxaQjM0uHIQEeWHJ7M9eSCJMHnsjd5MrryxWZZ8f/KHm/00UZqquK5EIkxxmMJh6XIH
         kk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gNlPfOGxOIZa+4NOTZu7u0ClBakEI0ySfd7crmTmBok=;
        b=UbK41udXPJhbx6FYdn4CjfYCvQEfwrs6yK7t+zK8w97wydFNAv4CJNZblMU3oY8Sf5
         zUpO1Tjoxgs4MM/28VIF9JruqJO+5oYJq3KzifYPiiKfBvGsxbhDHnMoyh/kU4I4i8+O
         RFW75cOtD1ne1Ia/AnCokEo8NDPWTskMy86YrnWsC2XBTay8+F4AiH4ev25Tszihy5QC
         YEmN0r4a31ogI9pYPYZrPESIDf+DtSw7/ZCRpOHqIqDAyPAbovRvTfPMSeul2OiXh7WO
         CT3Ek/77HzTNCcuQWaEl4meLaL6ZrrzoaDHap0NKDlut3j564YpK0IqnySyE06qGj5gV
         A/cA==
X-Gm-Message-State: APzg51Ckxpno3/RMMb4EibSst7CCAI32URDNsCA5AzcxOYTDzks6mLA/
        nGqbMBZDV+1yHgnqF586HA==
X-Google-Smtp-Source: ANB0Vdac0p5hyBOLfo05i3orDI+iBN1/Bys+K2bJI5LKmGs931F6cBLFQrZmA6UJfFM2Hji2ZBVyfA==
X-Received: by 2002:a50:c44a:: with SMTP id w10-v6mr4992624edf.274.1535411738158;
        Mon, 27 Aug 2018 16:15:38 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:37 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 07/13] proc: convert /proc/thread-self to _print_integer()
Date:   Tue, 28 Aug 2018 02:14:57 +0300
Message-Id: <20180827231503.26899-7-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark readlink("/proc/thread-self") 2^23 times:

	9.447948508 seconds time elapsed ( +-  0.06% )
	7.846435274 seconds time elapsed ( +-  0.07% )

	-17%
---
 fs/proc/thread_self.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index b905010ca9eb..03dd644d8ada 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -15,6 +15,7 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
 	struct pid_namespace *ns = proc_pid_ns(inode);
 	pid_t tgid = task_tgid_nr_ns(current, ns);
 	pid_t pid = task_pid_nr_ns(current, ns);
+	char buf[10 + 6 + 10], *p = buf + sizeof(buf);
 	char *name;
 
 	if (!pid)
@@ -22,7 +23,13 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
 	name = kmalloc(10 + 6 + 10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);
 	if (unlikely(!name))
 		return dentry ? ERR_PTR(-ENOMEM) : ERR_PTR(-ECHILD);
-	sprintf(name, "%u/task/%u", tgid, pid);
+
+	p = _print_integer_u32(p, pid);
+	p = memcpy(p - 6, "/task/", 6);
+	p = _print_integer_u32(p, tgid);
+	memcpy(name, p, buf + sizeof(buf) - p);
+	name[buf + sizeof(buf) - p] = '\0';
+
 	set_delayed_call(done, kfree_link, name);
 	return name;
 }
-- 
2.16.4

