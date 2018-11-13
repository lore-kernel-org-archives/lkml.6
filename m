Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A99BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8432243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PJcGYpju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8432243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbeKML7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:59:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44030 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbeKML7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:59:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so4900037pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=z1/UIs3s95nj4fpqBhO0b+gijTrwfsBw2mC/yrzV+uw=;
        b=PJcGYpjuiJEgki1sUH6Ps/OxW+uKZsZpdT8/5VFUfLtccEhdI4hEe7LQ4gJ/344Sje
         velnDB2Ci9clB3U8RmC6LUpwODoM9pOCDZuMGCQx2VSuoAwKNu3kCdG4cbG7HtQ2ybid
         vBfpuBSVXWNOMFOyhYdSCoaLmlQsBHLXU/acI20NUSC3IDI0e2lFUr0zksycuTao/O2I
         U0Z5TlMeSGKZS6RYv49+zvJGhFTH7V44wph+Pa4LM6I+ANjViJLl38AkocErnYfTKqyI
         fifq0V+oFxf1bQL6mNp+LG53CAJ6j1Vnd4w5qAQVnJYCzX1Qc1VvxxJOsrqZE0/p8GOM
         yhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=z1/UIs3s95nj4fpqBhO0b+gijTrwfsBw2mC/yrzV+uw=;
        b=YK1n04wZibFdNUI7nLZoXSbWdDDGFIlxzygKXdepBcGpbmA4gE5Kch4TFDMF9SNopa
         31QfqYHoyPuS8HT3UKw/5HCk4BAXByk6797x3mkzraZmDdeB9XPnJ1n1WGmxoZPCdp2e
         TT/OatMja3fWE7DWJCDfVrT/GFaePSHM7M6ILuov8Eo/M/XiJAkLUamtz54+UXsjO8mh
         K0ZdqiL0LpKKVvOTrgkl1UWstofsiAfxp7h7jfCsBrTYfRAdb3k4D7a76+VJIevmsRlk
         pKYClCgpN/crH6HfF3qgNdFSCIpkiEJi8jgmcCx5KpFA7ELIYeY/k3jE0KFo/2VNfvjV
         KAnA==
X-Gm-Message-State: AGRZ1gLX9DPyhsOeiqbiR4K0jWXEwDiAQVQ44UB2+AaJ4PvG5Jw24YAW
        mCGatXvuFHWW9Zn3dLhqiT58lQ==
X-Google-Smtp-Source: AJdET5ct8ctnBfDREcAnPKrFHawmpructpZQJT2RsxPhQnRrzxVtPOBTDDjCdJ6kSMH5pN66S4Z/hw==
X-Received: by 2002:a65:560e:: with SMTP id l14mr3024951pgs.168.1542074629519;
        Mon, 12 Nov 2018 18:03:49 -0800 (PST)
Received: from localhost ([216.9.110.13])
        by smtp.gmail.com with ESMTPSA id d3sm16479347pgl.64.2018.11.12.18.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 18:03:48 -0800 (PST)
Subject: [PATCH 7/7] doc: Indicate that RISC-V support pte_special
Date:   Mon, 12 Nov 2018 18:01:13 -0800
Message-Id: <20181113020113.29640-8-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181113020113.29640-1-palmer@sifive.com>
References: <20181113020113.29640-1-palmer@sifive.com>
Cc:     corbet@lwn.net, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, ren_guo@c-sky.com,
        andrea.parri@amarulasolutions.com, Arnd Bergmann <arnd@arndb.de>,
        jhogan@kernel.org, dhowells@redhat.com, jcmvbkbc@gmail.com,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        rmk+kernel@armlinux.org.uk, Will Deacon <will.deacon@arm.com>,
        jglisse@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was suggested by features-refresh.sh

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Documentation/features/vm/pte_special/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 2dc5df6a1cf5..3d492a34c8ee 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-- 
2.18.1

