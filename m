Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309ACC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80E72146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="HsAo0n5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80E72146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLGMtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:49:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40684 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeLGMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:49:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so3689746wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5NVvoOgAgdZo8wmN11QDMw/7RKccGkERCz5dFRhs3I=;
        b=HsAo0n5ZNHZaaJaRpG3bq8GeB9YXcLdfGtEPiqJR7TiK9RyHGc09ZiBOLVU2/W+GE0
         V5xYVxwH0yMcAuvTT3IRWHgbtyrUSJjJzeMXPG/c6Dl1235iHf6MF6F7qX3JO7jHRj0n
         bQjlCVGAQt81pNjjoJSFNzVRYe8zmL8APySTvaZrLtQNWX/ZSF6bRA8M1TcoReAIk29r
         yVPaYrUMimHnqJ5kgHtagJ+L9KMndIbDBFw7ZFg1lOKmc8PE6RkiyIJqBdovX3EYwv8J
         1tX5uw0LgZjnd0xFISAw71qw72AJlRkQhrupmJBtsifpJMophzJ+rkWe+16yl4pBfKDt
         jjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5NVvoOgAgdZo8wmN11QDMw/7RKccGkERCz5dFRhs3I=;
        b=LWuzXFtftytgnvmNTykv/lH0qb/RFSmqnzlmzJlfCaJ8DmKJdIc6YiEMYSjqVPrxTF
         exAUuEGH3Au+nxaTnEEFiUcsKWssgJ6BKfDZArwUCQYNiC7yW8GS02t6GjJsZBL2SrSp
         yQB8IPlIMAkfPSJBHvVoXJ2pZqs7CALcMrkrU2W8iLWWAExRlPKR8lOsoRCPI5JOSPlf
         Xzh/L12fBb0clVDFfdlQ36+yqpxYjbYDuUVpFd8fPz++8azK7M5ZfYZnKnWD7j3ZoFtb
         if37smcZDTQYeXeq9fGvmpVRtTTT5ua1nnQs027BnKLRfjtRQ4dHdxN/UaqPXbNdjVgF
         0m5g==
X-Gm-Message-State: AA+aEWYlUGJVh8RTVP8at9uFJeQNqv8DO2wVkxnwggWxVKUs55WP2uMr
        8a678aFeJHk6Y6FXvYb89PxLzA==
X-Google-Smtp-Source: AFSGD/Xg0iVjxrHzmepdWCYZL5IIBms+bQjq3bJau9vmc8enLf7nlyrhxgrAgU168RFf41hftAmKlg==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr1640907wrr.280.1544186947022;
        Fri, 07 Dec 2018 04:49:07 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id i192sm4362949wmg.7.2018.12.07.04.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:49:06 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [PATCH 04/10] KVM: Document Memory ROE
Date:   Fri,  7 Dec 2018 14:47:57 +0200
Message-Id: <20181207124803.10828-5-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROE version documented here is implemented in the next 2 patches
Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 Documentation/virtual/kvm/hypercalls.txt | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index da24c138c8..a31f316ce6 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -141,3 +141,43 @@ a0 corresponds to the APIC ID in the third argument (a2), bit 1
 corresponds to the APIC ID a2+1, and so on.
 
 Returns the number of CPUs to which the IPIs were delivered successfully.
+
+7. KVM_HC_ROE
+----------------
+Architecture: x86
+Status: active
+Purpose: Hypercall used to apply Read-Only Enforcement to guest memory and
+registers
+Usage 1:
+     a0: ROE_VERSION
+
+Returns non-signed number that represents the current version of ROE
+implementation current version.
+
+Usage 2:
+
+     a0: ROE_MPROTECT	(requires version >= 1)
+     a1: Start address aligned to page boundary.
+     a2: Number of pages to be protected.
+
+This configuration lets a guest kernel have part of its read/write memory
+converted into read-only.  This action is irreversible.
+Upon successful run, the number of pages protected is returned.
+
+Usage 3:
+     a0: ROE_MPROTECT_CHUNK	(requires version >= 2)
+     a1: Start address aligned to page boundary.
+     a2: Number of bytes to be protected.
+This configuration lets a guest kernel have part of its read/write memory
+converted into read-only with bytes granularity. ROE_MPROTECT_CHUNK is
+relatively slow compared to ROE_MPROTECT. This action is irreversible.
+Upon successful run, the number of bytes protected is returned.
+
+Error codes:
+	-KVM_ENOSYS: system call being triggered from ring 3 or it is not
+	implemented.
+	-EINVAL: error based on given parameters.
+
+Notes: KVM_HC_ROE can not be triggered from guest Ring 3 (user mode). The
+reason is that user mode malicious software can make use of it to enforce read
+only protection on an arbitrary memory page thus crashing the kernel.
-- 
2.19.2

