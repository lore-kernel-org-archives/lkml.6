Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9643FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D35C21524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bXXT0tOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D35C21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbeITCaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39068 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732942AbeITCah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so6039558edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dx2d/wZgSqIYrio8IY4E3MJRlAAmc4ecMawhw4fgCjo=;
        b=bXXT0tOB6yvbrxrUDz6lxy0ZpnOvIPlzXdQq8241W91yHdYh4SIDx9xSpS5MRZXbxm
         lC9t6czOD9+qHHtSjmKPp2h6rZAmYpPqLvW7ulFQ4uq2W7DclU7pcUkXt0NTbARZnUCu
         ITxa2Wq1CQA0nryzHNgq9DaNby+2UGI50Tgx5mcNunolg3RCDSO92mHfc7g8oFm+AMb5
         /QSzMETaQonkARsX/Tod6oqvebyAYAigFKFJ+f0H320M7fK/DXiaF9s6dHLs3yzVFZfg
         g4ze3AoCzgjeDEGr/MT+9iJOqSo+uvapXwnFAhJL3BvP9a+l7LL0UcgGxsGlegoOJiCG
         3Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dx2d/wZgSqIYrio8IY4E3MJRlAAmc4ecMawhw4fgCjo=;
        b=KfTB01yQgC6PFCYxDs6M+KLz5pV7R8RpQn8U2Ci3fB/f7DHOhBFNMFe4qwM7iCXjxt
         hFZTPBasqTiIW9vG0J2eG7BzRBhRFjar/B/GtqsxrsXEQ3bGT9T9z5NvvtEkOyaOFE3j
         rvUi7iOjN6al8JH1S5IpYTZYfcynuJNLWE5Isach5S9l5R5tP/1NdfiAlo22th8e0c+p
         85kePqML28NftZXw40wfVs+up99d2guvSApi7wR6nda2WA/PeIf9Zy+l1ZHJ8z/L8vrP
         DazVESJx3qJl6FwTYw9ormRSes5WnK0S0eo3e49YZlGuwRxM5ireNz1qlPo6kyQxmdfH
         2rIw==
X-Gm-Message-State: APzg51AlwvnHnoez1tE3N3RWwHU8DnNxv5uI5YVrQX0/ao4UqZlvMnMD
        KU63CTa5yrA+AYZsCzR6WA85nN+blC0=
X-Google-Smtp-Source: ANB0Vdb2UP6+MqFu+qQ7HlTGC4Py0dEEyPTw7wsmKOU80c2mgit8/bYtk4M3J88QdcDY1G6xnCoTOQ==
X-Received: by 2002:aa7:d707:: with SMTP id t7-v6mr62634260edq.250.1537390257030;
        Wed, 19 Sep 2018 13:50:57 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:56 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 12/20] x86/vdso: Look for vvar vma to purge timens page
Date:   Wed, 19 Sep 2018 21:50:29 +0100
Message-Id: <20180919205037.9574-13-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As vvar vma may be moved away from vdso, let's search it, rather than
calculate purge address from vdso position.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 90eadcfcb7f5..d1e2392a4905 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -159,7 +159,18 @@ static int vvar_fault(const struct vm_special_mapping *sm,
 	return VM_FAULT_SIGBUS;
 }
 
-static void clear_flush_timens_pte(struct mm_struct *mm, unsigned long addr)
+static const struct vm_special_mapping vdso_mapping = {
+	.name = "[vdso]",
+	.fault = vdso_fault,
+	.mremap = vdso_mremap,
+};
+static const struct vm_special_mapping vvar_mapping = {
+	.name = "[vvar]",
+	.fault = vvar_fault,
+	.mremap = vvar_mremap,
+};
+
+static void vvar_flush_timens_pte(struct mm_struct *mm, unsigned long addr)
 {
 	spinlock_t *ptl;
 	pte_t *ptep;
@@ -175,31 +186,31 @@ int vvar_purge_timens(struct task_struct *task)
 {
 	struct mm_struct *mm = task->mm;
 	const struct vdso_image *image;
+	struct vm_area_struct *vma;
 	unsigned long addr;
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (vma_is_special_mapping(vma, &vvar_mapping))
+			break;
+	}
+
+	/* vvar is unmapped */
+	if (!vma || !vma_is_special_mapping(vma, &vvar_mapping))
+		goto out;
+
 	image = mm->context.vdso_image;
 
-	addr = (unsigned long)mm->context.vdso + image->sym_timens_page;
-	clear_flush_timens_pte(mm, addr);
+	addr = vma->vm_end + image->sym_timens_page;
+	vvar_flush_timens_pte(mm, addr);
 
+out:
 	up_write(&mm->mmap_sem);
 	return 0;
 }
 
-static const struct vm_special_mapping vdso_mapping = {
-	.name = "[vdso]",
-	.fault = vdso_fault,
-	.mremap = vdso_mremap,
-};
-static const struct vm_special_mapping vvar_mapping = {
-	.name = "[vvar]",
-	.fault = vvar_fault,
-	.mremap = vvar_mremap,
-};
-
 /*
  * Add vdso and vvar mappings to current process.
  * @image          - blob to map
-- 
2.13.6

