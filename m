Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837FBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B42E208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Q+eqld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B42E208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeJAUrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:47:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43666 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbeJAUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:47:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so9248717qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RY3HKB+TyUP3amVnvz9Y2c9t1655d5bAFZ+R+AscHTU=;
        b=f/Q+eqldULC5lasigz27PLcZVVOevnudQOQUgyy+LMUe0NRvzgqsSKg10PDsMQtcZ3
         aQIffzaazM8G+OC3Fdt7IHjbncTfjHTFoLbEofy1/LLzYnaB+p+4xxha3fOPCIhir2y4
         7hRBzQc0b6IFCUOywRLZHHhICsW7W3knjFYtDNLnRlkWxxlQ9fQfMYz3WURDLoIXSIIx
         nmLwEt0LcRRUDZhkDlq+p5IyG5CVDKCRveXPYtQAmxcgN8y1ZdedPlFjjfja727L/IGt
         1LH1H4HJXfG/tKWvgMACBP7Rw54rGDaaWprIHIElENoyfwY8UKu50Iw4mnlu38e58teL
         KCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RY3HKB+TyUP3amVnvz9Y2c9t1655d5bAFZ+R+AscHTU=;
        b=K+ar5QXGgaTWMEVGhsGihTBm6yz0O8mQp2Glh6p2GkrZBrx92n9HbnZRKwJoVNRWXE
         YkLXTHdmn8SZz0CDL4A7ybzauBaNF6P4lvGChvoH9IXB3JJmUSJnCPtTalCJlalRdZMx
         /3xNVRU9m7ySmNCFxH+gzeBN0d1b5Q8ZNBX4JTuYoR53agTBhZbPQ1x9L+fzSeQM62Fl
         XdggknXbmIjhN6PrJzQnpS/gHQj5KBY+kb2iHABVB4KrdKz5aCPMh7RNHhFWz3x+Nuvh
         HgN/0dI4O5rvm7qR4Q/a1Dx4dtaBf/vhsE0SZDS4ccD3j5YNv6KOJ4vUyGQ3NeaMyAiT
         ZyoA==
X-Gm-Message-State: ABuFfojdwrpkKQTPCqqxhtPx5vR03sQY2N5nVaw36Ku+gZWKDV7qFtDB
        Gm6Qg+KKwpJWFB02wTCe1g==
X-Google-Smtp-Source: ACcGV62+/LhwTeWdIHl0J/HbcLevvzUSuwR64skHH/zr/y7Yx7fOtC4wvBMLNhrOJgYc/2ACTlr7KA==
X-Received: by 2002:a0c:88a5:: with SMTP id 34-v6mr8611855qvn.220.1538402957334;
        Mon, 01 Oct 2018 07:09:17 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j19-v6sm5714496qtr.6.2018.10.01.07.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:09:16 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] docs: kernel-parameters.txt: document rand_mem_physical_padding
Date:   Mon,  1 Oct 2018 10:08:43 -0400
Message-Id: <20181001140843.26137-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001140843.26137-1-msys.mizuma@gmail.com>
References: <20181001140843.26137-1-msys.mizuma@gmail.com>
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
 .../admin-guide/kernel-parameters.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f4..4c4c5e6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3529,6 +3529,24 @@
 			fully seed the kernel's CRNG. Default is controlled
 			by CONFIG_RANDOM_TRUST_CPU.
 
+	rand_mem_physical_padding=
+			[KNL] Define the padding size in terabytes
+			used for the physical memory mapping section
+			when KASLR is enabled.
+			If the padding size is not enough, you can see
+			'Set rand_mem_physical_padding=XX ...' in system
+			boot message, so set the parameter as the message.
+
+			This parameter is useful for the memory hot-add capable
+			system. Such system may have more space than
+			actual memory size to hot-add memory. If the
+			padding size is not enough and a memory is hot-added,
+			the hot-adding will fail because it destroys the
+			system memory map. So, the padding size is needed to
+			adjust in such system.
+			The default value is
+			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
-- 
2.18.0

