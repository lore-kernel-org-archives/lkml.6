Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA78ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ECC2154E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FUo4oRF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3ECC2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbeITCac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34103 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732736AbeITCab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so6052871eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=am+xBk+R/9bruvmNQKPUrS/iZOmfupXPVgm7mOIjt2g=;
        b=FUo4oRF6ovk5j4s4ara7NOXSVcQu9YisGWLibUOwPWpu34BUaSx1s83uoIUFMW6Tai
         iwlrrSUcA+fRA0U8G2nY8xaAXyhTklz3BvzC8gxH0/FbZaBd5DXoS2AriIuwxrUCO3z1
         RAGXn5bievUWDBTdJ99IECCnBNxfLm9AO7o8FIgIq4WCSebUlHNpo5uLv4xv1N6PIcZH
         /byYgRRBZVVwVY0WXWbYJPRsxxpkztFJd4OMqDg2KGKKnB08ukKBN4+JUljxHsKy9nG0
         rNcoU0Zsv2G7MkNJ+KCmCglRf/WlKPQGRVLNT12MfeJEHw4JdDhWCkigJ/9fMR1LIH+6
         LnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=am+xBk+R/9bruvmNQKPUrS/iZOmfupXPVgm7mOIjt2g=;
        b=l0nycTTSpBZyTUvdnIlZqpdOfkDmgpHjEWDNOl/kdFRYL+6sh96Ncyju+qqsSgRKH3
         kAhG5zbxf9rk1PJk/3LjH45mYlj+MvYEZxhPBznU5qIn253zza3hkawILn/aPHT6Nstu
         Hl1Ne/yiqbo3crEtoXhmQLesNxZw65D9ejw5aEb+MgKb6gTkaJHpwuXkbi6bUwkSensg
         a6+IVXs85gBAUpswue2CkowFjPveV0Ac44ZBL1DmqcV7nKuuw7ubGB5b3Su8YXqxN9FP
         D6lFjlQEP0qils90H78Gi9qZ5OUgdFqoU5YUzPcAiGnTKC3hftSMf/54wQV8I3bOUozT
         OhSQ==
X-Gm-Message-State: APzg51CYtB3rN3nuU0kFOumr3ZKZU/Ql+7tZepPbxgNQU8lOD7f0PN9m
        /TpIx0qHY0jltJBXczbQuEGG4eC8+lQ=
X-Google-Smtp-Source: ANB0VdZWZ4HB1UsR1BYWju0GQLDl2tZx+LtW1PHkqjyILHKiI8+b2D/p5hkRR0581SgW+TwPhh39ZQ==
X-Received: by 2002:aa7:cb56:: with SMTP id w22-v6mr61029561edt.202.1537390251117;
        Wed, 19 Sep 2018 13:50:51 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:50 -0700 (PDT)
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
Subject: [RFC 08/20] x86/vdso: Restrict splitting vvar vma
Date:   Wed, 19 Sep 2018 21:50:25 +0100
Message-Id: <20180919205037.9574-9-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As offsets differ between time namespaces, we will need to flush vvar
mapping for timens page during setns(), unshare(), clone(NEW_TIME).
Forcing userspace to mremap() either all vvar or nothing and the same
for munmap() will simplify searching for timens page to flush.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556dbb12..8cc0395687b0 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -84,6 +84,18 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	const struct vdso_image *image = current->mm->context.vdso_image;
+
+	if (new_size != -image->sym_vvar_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -142,6 +154,7 @@ static const struct vm_special_mapping vdso_mapping = {
 static const struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
+	.mremap = vvar_mremap,
 };
 
 /*
-- 
2.13.6

