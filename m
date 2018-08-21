Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B29CC43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B509120895
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7yxL/xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B509120895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeHUQoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:44:24 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44745 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeHUQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:44:23 -0400
Received: by mail-qt0-f196.google.com with SMTP id r13-v6so1336624qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7hXArw+uwlR1wUYUO8gp6LP77/CD5xiISij8yJBtAw=;
        b=r7yxL/xD805kkBSqtvP48dt/rN3QBcWWbqca3C5O4/sT9+CXPnfdB+XSgrbvqVHhIc
         EI2GujZWmguDuXdmGve8HQotS3zjwYP+w6yPNCzaW5E3r59AJGvRZxHIEuPcSSX5sSs7
         ORlZFCilj+Y2nKl+hURUNbB+7HEGH4P7uhtAaBVjTPg6/32gMk1KNJjaaZ09tA8Qe4ZK
         rrZD46lNgABdf5gPaD8VroxhZQLs1dXsl9b6rqN0FrZCVscBREqetx51JFKudbrTee6U
         lGoRUpCNzz+ZlmLe/VEZTBI+Ag5b1VrNtdEr1CDuP7TXVCeFMuWMmSnoClNFHixBLWCu
         Wjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7hXArw+uwlR1wUYUO8gp6LP77/CD5xiISij8yJBtAw=;
        b=RlGwykxZzfENIUWwFg7qAi5xr06iFJGl3BjaVVSZioN5eY/VhCsgIigQEBObSe8mhU
         czFGNso8OQ65VMFx3zx1id46v7B32P9vMubr8XG34etaSDqvvDWDFTZr5gv2N4/OBFCk
         E2HaBwm73hvGvRB4bYZS2NgA0aj/JUIkGnWb/RXgZ8ZLG8fLs6zKu8A3/mqhVExnnIty
         kTzYbhUgxkSl+95o78qx7fgxtfsZNm/w3WUoO/EEnAAqPpSsW+DKv//hOnUJe+wJJlu6
         BxD/IS2HcKJq8vxiUt17dWU0PLgkKBDtOMECmQMNKL2leoK2pNm98plkhbTQBY6rTCfx
         jO5Q==
X-Gm-Message-State: AOUpUlFad60WzHkKmbDBZh7RmRUXtKzUK8fPC15u/7vSJc/lf/2oOtXq
        4riPWdhzyl4YPYw94ohB9g==
X-Google-Smtp-Source: AA+uWPzGUh8IV/Bj/aVfY0PuycpmnXUUTKB2Z/dYi2qFHDrrfI1Yyw8k5wd9I5nZaSWRoarwnG/sQg==
X-Received: by 2002:ac8:6a05:: with SMTP id t5-v6mr12070790qtr.249.1534857855267;
        Tue, 21 Aug 2018 06:24:15 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m5-v6sm2601801qkh.30.2018.08.21.06.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 06:24:14 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [RESEND] [PATCH 2/2] docs: kernel-parameters.txt: document rand_mem_physical_padding parameter
Date:   Tue, 21 Aug 2018 09:24:01 -0400
Message-Id: <20180821132401.14563-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821132401.14563-1-msys.mizuma@gmail.com>
References: <20180821132401.14563-1-msys.mizuma@gmail.com>
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

