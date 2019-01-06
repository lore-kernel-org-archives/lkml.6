Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D90C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760EF2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="phMLnkSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfAFTZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:25:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39189 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAFTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:25:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so36026501edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5NVvoOgAgdZo8wmN11QDMw/7RKccGkERCz5dFRhs3I=;
        b=phMLnkSEvvtwWkL0fnAjRUATdL1D/Bn+8aLCy+6+BQz7JyW3U4Z0u9f2f4oRGDezjG
         /S/rcpFxh8NhvkwQJMYOOnaclL+09CZtCQmpFcrj6c3UWn4QrIIv5U5T57k/pBYeu8eG
         YAEjvCtKcwcmhQndgcG4nCaf56lNs33p/h1dSkIRTEoGSM5vYwrR0mLfiu017EyiD43s
         j/1vN7JKhz8LXpnNLsoNZrLjpRBxgFSEzIewi8wa/jLySA3V953esHQCqcxgxQWh3xkG
         xJu64Z5cjs5mWjxSM205ELqXpMrr6ioRzOHJp+To7SlshbPi9DXkufKwxRj/gFNiGeYM
         yLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5NVvoOgAgdZo8wmN11QDMw/7RKccGkERCz5dFRhs3I=;
        b=KJYNm2IPqxOza4NCNSLIiCmpYvUOzcg3dn7NP44z4Yo09rMSEoBkcW6bKw4qWS+lYW
         Os01T0RGhYB56TSmznbORZ9kHUtjWg5eXTZCcMQlfQXYiP8GNI0zdVsiHV5Laq99w133
         /uQJDLAWUlRGnB8IaS2ixNQVYfcotdMzKaSolyJ53Il3h2Ilf670FMQqpx7hBC4Ci8Za
         w2NQit7DgHgcGwf6Yaa31cVAcc9DaCK1quqRkTCNUXUeOcVcd4pdqI/wNGnovylt8ZOD
         6IaxzlfG9BS13fS7GyDGKwbG8llF5DnRzstQdiilEfNvsC2OTaiyTTpShNd230xDNSAa
         9c0g==
X-Gm-Message-State: AA+aEWb74UDZdzRTkgBC0Aodg3xBLEyOZJ11mbra7JmPKo6dc270wB6W
        w7VdUB8ccOVm0lFnRMcbU+2aGw==
X-Google-Smtp-Source: AFSGD/VXv7SQ19vCkJLUFO247vGcMt/eFi87pi1euFVRwuQCrK4iDy1yR4RETyRcp8Ovq1HBaDnlKQ==
X-Received: by 2002:aa7:d684:: with SMTP id d4mr51091724edr.59.1546802716691;
        Sun, 06 Jan 2019 11:25:16 -0800 (PST)
Received: from localhost.localdomain ([156.212.65.252])
        by smtp.gmail.com with ESMTPSA id b46sm29994035edd.94.2019.01.06.11.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:25:16 -0800 (PST)
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
Subject: [PATCH V8 04/11] KVM: Document Memory ROE
Date:   Sun,  6 Jan 2019 21:23:38 +0200
Message-Id: <20190106192345.13578-5-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
References: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
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

