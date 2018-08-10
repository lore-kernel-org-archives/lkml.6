Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D55C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9EB22433
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9QiCFt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9EB22433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeHJSxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:53:20 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38025 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHJSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:53:19 -0400
Received: by mail-qk0-f195.google.com with SMTP id 126-v6so6732671qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7hXArw+uwlR1wUYUO8gp6LP77/CD5xiISij8yJBtAw=;
        b=g9QiCFt/KagNBQpa99M9CjpToFu2JWCQ1OSAiqRcyCHyTLg1Z3yGqfESe+8psyDJQp
         uK15FdJZ45H+qvjVN3RwKedlfKl/8aZZsEXva3RWS8LwHV9j+zMK5XZPwvS88wL9qSfp
         wTcvA+cUElPQIIenH6kune+e5HA5H6SIpwcHFCEphehzoK3jH+taY3ArgN9qZnFjSvKS
         VSAfZNh7wIjgx0MPmB0VzCST3YNszO2JbDGSOJZArvhVoUVvOLq3GYdcji1YDuFfPNYs
         0B24cIIxwIQG+QbXEt4aFA7m6PqDR2IrFf+aCAs4EiCW/HEhAL4aryxIkTijbBFXUn+u
         HfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7hXArw+uwlR1wUYUO8gp6LP77/CD5xiISij8yJBtAw=;
        b=J8B0o8aCnCV6KVZtvdIO1g+T4dVtb6nUVuKeqnR6LAA48OvWFT6C+AHM+S3D0mla0c
         ZUrYOZBoapPRVd79DJrlQ4V+e+Q/BOr55tlGfSGTTmMEf8GkXpJOIHSjHNcsblQIwyfN
         txC4KXtXirkmo3rwAqjTDXo4qXu49RNn8tRoDtZyXRpq/89m9mwqUJevXmg3EIymk2GB
         ATOThN4d9iuLnZGB2e7KY2pJT3VRAjNdwLBpq4dRpxz5M+F8vyUzaPcHwnElDJqDuQbD
         rbXdDiK6rzf4xVRU03Fj/xapILa774Z66QM7YegMnVhlG1Kjgt+eh2cNjuLgS3Y/cef7
         eZEQ==
X-Gm-Message-State: AOUpUlFvn6lgsJAw8cMYSWpCQn/ARO7bY8zhXwR9qGOC7HheFLkutRfn
        hrN+SWDE/MfxJGFSsQmhYQ==
X-Google-Smtp-Source: AA+uWPx9e6BWfuMxMzN9UbiHtMGp1PFlq+1do0zWDHkgaAoaVhQ8A2szO3W0XwwiboTpryByzQBWgg==
X-Received: by 2002:a37:6809:: with SMTP id d9-v6mr6289207qkc.444.1533918167858;
        Fri, 10 Aug 2018 09:22:47 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c138-v6sm5375962qkg.79.2018.08.10.09.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:22:47 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 2/2] docs: kernel-parameters.txt: document rand_mem_physical_padding parameter
Date:   Fri, 10 Aug 2018 12:21:38 -0400
Message-Id: <20180810162138.12597-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810162138.12597-1-msys.mizuma@gmail.com>
References: <20180810162138.12597-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

This kernel parameter allows to change the padding used for the physical
memory mapping section when KASLR memory is enabled.

For some systems, the default value, CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
is not enough. The option is useful to adjust the padding size to work
around such issue.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c..d977091 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3382,6 +3382,13 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/blockdev/ramdisk.txt.
 
+	rand_mem_physical_padding=
+			[KNL] Define the padding size in terabytes
+			used for the physical memory mapping section
+			when KASLR memory is enabled.
+			The default value is
+			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
-- 
2.18.0

