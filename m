Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62761ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E8320869
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8alelYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E8320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeKEC2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:28:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbeKEC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:28:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so1101144wmw.0;
        Sun, 04 Nov 2018 09:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/PEiWOknyyJFIL6QHknHD9RivhxJlGWUrrDq5I+qUo0=;
        b=I8alelYdRaS7htEJKfw/TWJp+qqBX6UGfMtfbw69N1p0PDaM4P8FKzDrIt63zBGWgu
         SZPJbHPOIi2zu0K3TopeSsnMwWSfb0R2rK/hAYmR0JEfILZJM4XVfRCT1sU5Vccdv+DY
         a3SfwWeeBSC61Zw7mHIvnPjnS4MQhUYOW0RJIlhcDyDISdQlvy8iU/WowxaG8PnK2roW
         gm0UwqgOhrxqRbBe9WURQwSkmo3FOCMEIXyaPAeduwUKmXm0yzUepurh8NU3EhMIUTdM
         nk0urse7K75QagM8e1nd6L7EU0tekX1lpFUzNOshy37y2vyn2uMcdbZLM3Sev77FsalG
         Lz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/PEiWOknyyJFIL6QHknHD9RivhxJlGWUrrDq5I+qUo0=;
        b=pkNiTlPv7fG2ldk2t9b8YucfKwfG+rbWKKDDMOe+c2doi3+EzhpiVk5RYMSbnUvqXy
         lu1DVTuIs123P/aeoAJ+SYISLcsAZCuAToxhnlk8Ni2ZWrgBmBKSdJyUBSTU+VSmiCpz
         PP4QKcs8kGYXozcp+8lkTUWeHfcXtszsRQy4oJ0KVnfTr12HBofg+E1tXqbnRcUgHKKE
         Glrxrjf9ZkVGH1rWSAXxVQZRpbrUCC/mKWavveExCFGgVGpj/dvkdqGFFmXn59VsDQhV
         u11ps63qi7soG0y3sDkvLcMp90Fd1tpg+DCD47Kz7dF8QxTdBpmwCmoli5JMEbQLz+4v
         uypw==
X-Gm-Message-State: AGRZ1gKLvPrEOigItpdfKsKlLUhTMs9kcn/gD37qhJx8u6atgF1XMFyP
        FkSN5W/IV7J8+DfYiWZTR3w=
X-Google-Smtp-Source: AJdET5dQiFY9UiMhXkmb90HhcNiWUlbNLxCU3J5X4n0z+Gdgw6s8b4RU073xvVFVBn7SiUe6vVkvSA==
X-Received: by 2002:a1c:4407:: with SMTP id r7-v6mr3774993wma.16.1541351540687;
        Sun, 04 Nov 2018 09:12:20 -0800 (PST)
Received: from localhost.localdomain ([41.35.162.9])
        by smtp.gmail.com with ESMTPSA id r2-v6sm23707749wrq.1.2018.11.04.09.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 09:12:20 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        "Ahmed Lotfy igor . stoppa @ gmail . com" <A7med.lotfey@gmail.com>
Subject: [PATCH V6 3/8] KVM: Document Memory ROE
Date:   Sun,  4 Nov 2018 19:11:19 +0200
Message-Id: <20181104171124.5717-4-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
References: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROE version documented here is implemented in the next 2 patches

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 Documentation/virtual/kvm/hypercalls.txt | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index da24c138c8d1..8af64d826f03 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -141,3 +141,34 @@ a0 corresponds to the APIC ID in the third argument (a2), bit 1
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
+Error codes:
+	-KVM_ENOSYS: system call being triggered from ring 3 or it is not
+	implemented.
+	-EINVAL: error based on given parameters.
+
+Notes: KVM_HC_ROE can not be triggered from guest Ring 3 (user mode). The
+reason is that user mode malicious software can make use of it to enforce read
+only protection on an arbitrary memory page thus crashing the kernel.
-- 
2.18.1

