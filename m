Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB564C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38C521712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJk1wUHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38C521712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeI1CyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:54:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40381 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1CyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:54:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so2483925qkd.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A02TIKhCJ1KxFn1Gl3XOqnK4jHIjvZ/psvE3+KrarTE=;
        b=GJk1wUHr3vtVyUipSg+lee+klhXybcB+YeGwMuAPVeeila1rt1qAlygsvNOvpJhaqO
         Cf9DRQIiDJlzsH7uFYGqOXbg5z1hE/uDXCEg22aMyrD5nAEO/MRVG86Vh5ofdFkwcjbR
         ult/vMmAf0yfpo7ma7TxfpZtP7ThONlUj9nNiJODy609SsCrGR0VqwSeTAyzKBeyBBEZ
         ceMjZhCTgJLeqtUZKX2EuA3kbwi3jZpaslvjb4gzr5LVPYNPCjD6VPbCfQkvWUBG+Hdv
         daoyLf0CnYCMqwvlCDob1ZZNvF/085qwuEeOPGSVCF8W2m3dWrxJOs3DXzjuvGNrAMqp
         edew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A02TIKhCJ1KxFn1Gl3XOqnK4jHIjvZ/psvE3+KrarTE=;
        b=jj8xO6NnBxDk2Z2cRhqShVttIsf6/DxTvRivCzf2pZEtzfLK1cJZTxOK3UAG6OEiAD
         Xe02EeYNTEpqpCeHMydR5k2dQlUo96Ojq4DYRxe6E70qwO0BoHSIkf5++jIpvURxF/c4
         1OIwa2FElIg94g47Kv0lTKfCgbayQgZde7KY1t8nhpggrziUIoGhVkloofNKmWg41vFd
         T224LNSsF4b9gKYuk2KqmeHTNdOkxG+UUAb1hRF/hPwaKiKbHx3RaBhjnh7KUX6f+6gh
         rb7e8t7yVHfrun+O+iarXCWLOQyyBJo0ICRGzRp+sbTFAujbYoPZOdrhdnmLYYIhuRca
         ODvQ==
X-Gm-Message-State: ABuFfoj/aQBXrSQuUIq3967BlLik+yupbWY8UUW8ciw3tWhYsKwh4xya
        P2nyUW4kngkMcleTHT5+GA==
X-Google-Smtp-Source: ACcGV62iSp4KZklf7t45NtN17cCvxIfcUIwIxUSh4vrlSecm43ULI6mKfqxSKpJzfymkJscODEKnsQ==
X-Received: by 2002:a37:30d4:: with SMTP id w203-v6mr5961816qkw.106.1538080450560;
        Thu, 27 Sep 2018 13:34:10 -0700 (PDT)
Received: from centos7.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v187-v6sm1649374qka.73.2018.09.27.13.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:34:10 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] docs: kernel-parameters.txt: document rand_mem_physical_padding parameter
Date:   Thu, 27 Sep 2018 16:31:46 -0400
Message-Id: <20180927203146.12201-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927203146.12201-1-msys.mizuma@gmail.com>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

This kernel parameter allows to change the padding used
for the physical memory mapping section when KASLR
memory is enabled.

For memory hotplug capable systems, the default padding size,
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING, may not be enough.
The option is useful to adjust the padding size.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f4..de43cdf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3529,6 +3529,13 @@
 			fully seed the kernel's CRNG. Default is controlled
 			by CONFIG_RANDOM_TRUST_CPU.
 
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

