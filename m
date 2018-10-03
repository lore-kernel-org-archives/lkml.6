Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7814EC64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFE32098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E48gdS6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFE32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJCITy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:19:54 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35323 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeJCITy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:19:54 -0400
Received: by mail-yw1-f68.google.com with SMTP id y76-v6so1647697ywd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmlSZUo7cNLbA474YXzQx5KF+ma5lZ/e/QYfMgpUoYo=;
        b=E48gdS6DkZbJNIMYy+CpAODfmSt0lCblZb5zD+nwRVfVVM78iwH0YF6q+uYYnC650S
         8obIjjCm3PZ667M1z7BqAhOXOKbQRuFNHEKWmfuLqXFqRm4eucjkPH782XX5zEMElXC2
         IBOt4dBBWfdYAWpp5zauA9I9o6VQiVTJNCMynL0TadoAD86iuvieCWymTXfoVZLI5C8b
         0HUI+2xJzV/IXLTJPD4ljM0If7Gfdz/K8eOBYthwOYG/BR8UEUQ9HyBKH/qHk4cfRj0I
         KA0XnWo3OZjZ6ycaaBIT2n2gw2YXAsQA+Ntszrek0VMtKLM4pXlZAregwlw2e+Bo7t+8
         +/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmlSZUo7cNLbA474YXzQx5KF+ma5lZ/e/QYfMgpUoYo=;
        b=nIQowvBYFvD5ehUwC613B1U9GsedT+JFKh0tKqvnucrrV1DM4WZFj0vMQk9/CFpGLg
         rXJVRQiRdEcfMFi3DSqw0l5cX46acClGQeM2jHPgxArlL8xUpfQtCBaGgAn7DxBcOWpN
         HeP9Cuy/SLEWB9c9HNI/7EO79nXYN40FTRVTxaPLxt6lRaOY1mqLa0WnOcHjSFx6x9uF
         0mVMDLq659RoaH8yxVnjhT3JYKDHpzcED1vvs/7KO1fuBddDVv7fdIzqCACWIFQv0STI
         l0jdIw/lGsN7Dh89LodxHhf0SjloMv0Fh2Ue1WX8YTLQhuxuFA8wEprLhNoVUjsU0khQ
         mH2g==
X-Gm-Message-State: ABuFfohh0ASgf7rNzql8MLkYdJQFenyT8DBgJaCaNvyD73n+lJwyG6iF
        0Sx+43VHmWJiJtTs3qkigA==
X-Google-Smtp-Source: ACcGV62+RQ6VeOlxVW2sfLyu8GDnvkxjo72Tz9pOh2fAzSIY2PuaqwMN0dp8XZ3WDDqZJZd32dOu6A==
X-Received: by 2002:a0d:f9c1:: with SMTP id j184-v6mr9962872ywf.286.1538530424385;
        Tue, 02 Oct 2018 18:33:44 -0700 (PDT)
Received: from gabell.hsd1.ma.comcast.net (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id x64-v6sm5908556ywx.103.2018.10.02.18.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 18:33:44 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] Documentation/kernel-parameters.txt: Document rand_mem_physical_padding=
Date:   Tue,  2 Oct 2018 21:33:23 -0400
Message-Id: <20181003013323.4162-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003013323.4162-1-msys.mizuma@gmail.com>
References: <20181003013323.4162-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel parameter allows the modification of the padding used
for the physical memory mapping section when KASLR memory is enabled.

For memory hotplug capable systems, the default padding size,
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING, may not be enough.

The option is useful to adjust the padding size.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 .../admin-guide/kernel-parameters.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f4..f0930e3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3529,6 +3529,25 @@
 			fully seed the kernel's CRNG. Default is controlled
 			by CONFIG_RANDOM_TRUST_CPU.
 
+	rand_mem_physical_padding=
+			[KNL] Define the padding size in terabytes
+			used for the physical memory mapping section
+			when KASLR is enabled.
+			If the padding size is not enough, you can see
+			'Set rand_mem_physical_padding=XX ...' in system
+			boot message, so set the parameter as the message
+			suggests.
+
+			This parameter is useful for memory hot-add capable
+			systems. Such systems may have more space than
+			actual memory size to hot-add memory. If the
+			padding size is not enough and memory is hot-added,
+			the hot-adding will fail because it destroys the
+			system memory map. So, the padding size needs to be
+			adjusted in such a system.
+			The default value is the value of
+			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
-- 
2.18.0

