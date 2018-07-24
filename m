Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8216ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6809220852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxgjVzY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6809220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbeGXICS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:02:18 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:45481 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbeGXICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:02:18 -0400
Received: by mail-pl0-f46.google.com with SMTP id j8-v6so1264647pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIzV6aso3cBbRwIPS8DL9LqPtHHeWZam6wO8uhZIhTo=;
        b=cxgjVzY3MX0woauM2mQ0DdwelCWnuhJ3LX8wat27L/s2w/g2I5byL+3gKHF6y9iFVA
         HSpNiUSQsbulmADcHfeQ3KBclHJadIajI1bNqZwznx3JvdbU0PnhNY6dpzou+JJTZLpa
         fFvq3a6BiD/aBwwtqo4dCjGCLHdqEb59HY8pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIzV6aso3cBbRwIPS8DL9LqPtHHeWZam6wO8uhZIhTo=;
        b=r3SLCsjVH2AMvpsY+Gih9vjqYk7za3Nv1kRyH0CWbwwOX0M6+3y/xHtFRpVji1+yL/
         DcSKJEf89Pm+bZIAoTweurnnsG/RzbvnhD29Jx259fdckKdRNtp9pO1EAgndbjc87UWf
         xBQuHfqk2ulTTIl9ax7oTmkzLQ4vVU+Z/8vAXUAvYg5e+hv0o+QQ/ntB0dZm1rOaJiH2
         Gb5sJkkqPmVFLUrGwXWgTBXMg8hFpJahgkYiinY4iWEoAJuYmsfOpwb0hm9ye8gNjAb6
         pxxgaDKi6zURjxHZPBlXHajEm2kHGSC2oqmGtnl/wkMZR3xcf7cmjjAvSSiwM4BfYILd
         scHQ==
X-Gm-Message-State: AOUpUlGdf94XQtcIHICoRzlLdaVMkug3Rv8m6s/1BL9zjhC9eBSEiC5a
        AgAclTfmgNaqC/DpVghjYIlhrQ==
X-Google-Smtp-Source: AAOMgpccEHK0X4LG2sCssROyMS3DTku3sl+Su6+x8gDwvPTU9oeupQxycIsl3XZpnapXnzG5Z/MvIw==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22-v6mr15898099plo.190.1532415440585;
        Mon, 23 Jul 2018 23:57:20 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f126-v6sm15721472pgc.88.2018.07.23.23.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:57:20 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 02/16] kexec_file: make kexec_image_post_load_cleanup_default() global
Date:   Tue, 24 Jul 2018 15:57:45 +0900
Message-Id: <20180724065759.19186-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change this function from static to global so that arm64 can implement
its own arch_kimage_file_post_load_cleanup() later using
kexec_image_post_load_cleanup_default().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e4e638fb505..49ab758f4d91 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -143,6 +143,7 @@ extern const struct kexec_file_ops * const kexec_file_loaders[];
 
 int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len);
+int kexec_image_post_load_cleanup_default(struct kimage *image);
 
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c6a3b6851372..63c7ce1c0c3e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -78,7 +78,7 @@ void * __weak arch_kexec_kernel_image_load(struct kimage *image)
 	return kexec_image_load_default(image);
 }
 
-static int kexec_image_post_load_cleanup_default(struct kimage *image)
+int kexec_image_post_load_cleanup_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->cleanup)
 		return 0;
-- 
2.18.0

