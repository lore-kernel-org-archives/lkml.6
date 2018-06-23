Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37FCC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC2D24AB3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFYlLg17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC2D24AB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934719AbeFWCUt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:20:49 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:37184 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:20:45 -0400
Received: by mail-pg0-f45.google.com with SMTP id r21-v6so3708186pgv.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+CuyitM4U+PQMgPnwkmGxBBf2FkG58yPNy8pZ5fB6pc=;
        b=WFYlLg17zJoEmmauuow7zxR6c9xn46WWF8s7hP36ZJ/8Jj902WSNjIn35dsLkRFlDN
         jFTTVjPi7qT0Hke2y92HHLHXI4JHGAQ5wQlBej9oxkOZnoNi39AdEduNT6weDU4BfM1j
         E6X0r7rClgksajo1rrr28O9MCkYndAw469qQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+CuyitM4U+PQMgPnwkmGxBBf2FkG58yPNy8pZ5fB6pc=;
        b=p1YpU1LkjwFq2HfBJn4+Tl3DhAZ2WMReAOyBxhGz9JBpRruFVS7ZeRIjCGMUMwiKht
         3wBE0JN6OMi3fP37b0GMQCvgcVuy2NJVJiEXW7Wn7kgozVOyEt4tV7XXHjpZH+F4A3tN
         Plg3pjLEvEuNAt5n0bFmu2+R89J5aUFTa+qpx5GtlERlDU0auqc+du675N1q63SQ6Yxv
         70vf2QODpWsz8OZs3EX3IcgM215cSFYoGKFGU++yEkbOR7XY076I8Gtgn4sA75Vod3d8
         sNAYu8dWtL7sgfsJMbVpK1ATl/1ybqru/+O825Un7pDwm+EJujf/nGSjC8IlRfnH8iox
         Us6w==
X-Gm-Message-State: APt69E1m0fanZSHZHSZZWONYltsm2cTgUkINBdYJ+YwdTmKNQ1nRc/rj
        mJJukBcPK5igWlWUfCd0GogHQg==
X-Google-Smtp-Source: ADUXVKIOLUouaSn4j7nyTNW5gpnwlKFdl2viod5adA/maqIKMcLzFvE5vV8NBtPxj9Wg0y0PZsQUCw==
X-Received: by 2002:a62:b90f:: with SMTP id z15-v6mr4124101pfe.254.1529720445440;
        Fri, 22 Jun 2018 19:20:45 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id s134-v6sm11434396pgc.30.2018.06.22.19.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:20:44 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 02/14] kexec_file: make kexec_image_post_load_cleanup_default() global
Date:   Sat, 23 Jun 2018 11:20:46 +0900
Message-Id: <20180623022058.10935-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
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
2.17.0

