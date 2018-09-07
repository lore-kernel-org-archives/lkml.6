Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D83C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56E820861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vrs7iPZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56E820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeIGMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:37:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33141 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeIGMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:37:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so6640154pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5amHDmg026JB1zJ+Ct9rVxm5mNHAXQC5qrpdWEXy5zI=;
        b=Vrs7iPZaJs2lX7U8ETOMXsv5z2KiZmr2IZAgRk2mnxfHL1v2nrLT18bqKI8Eg8Uv5l
         0Ik6D/GqZpiGZipS29hvfmytB2YBkFmVbfrny6kOaANMXudo3ez/gpzvTsJIuqqu9aJ4
         PFJS+uH491XkCYfqNC5s1RlwuoiCpGd6aAf8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5amHDmg026JB1zJ+Ct9rVxm5mNHAXQC5qrpdWEXy5zI=;
        b=SBrLZaoRYBejJXITgcGkGRZy1FxtmPNvkzbqURyq3Ia8RC+tvEB38j0la6yAtgStcT
         SU0mI4V0/I6q5es5xCq6xCa+cjpzg/jbh5yACqcXymfTmpBC2ExoErImCGCCwfpdXQNS
         5P/I258bwykLVjYNeCNbVHJ6ztwT4FzowyopYzJxfO+VpiZHMXkoYdImPE08wHWRK0ZL
         +hXvteNrxztCXevLdankjWyBqWfdhF0TYQz5eLYnuD4tNPd1HENcaG2cAzQY0fHqnJSL
         KvgN4CXtxjjmXGzkah3woWN+aJFSsyJ1iGLYW8wXdnR6ItS/+Y/gsFnHoLFcXNdX4cKL
         kg8w==
X-Gm-Message-State: APzg51APP8PusU7RU+NrReJozVjUSwTO9kE3FmIJvvt6D7i+roZzYLKa
        AWYgtwG3D0lA+C8d+6EER4LbJQ==
X-Google-Smtp-Source: ANB0VdbCgm41LDZoU8tOguOWLvaYE1LKIBw9q9WLBZ3VcVy65hAu/fzYGTFkbGjE8BVPneGB2L53PA==
X-Received: by 2002:a62:1605:: with SMTP id 5-v6mr7168821pfw.11.1536307037247;
        Fri, 07 Sep 2018 00:57:17 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id x9-v6sm12684384pfd.31.2018.09.07.00.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 00:57:16 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v14 01/16] asm-generic: add kexec_file_load system call to unistd.h
Date:   Fri,  7 Sep 2018 16:56:38 +0900
Message-Id: <20180907075653.4696-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907075653.4696-1-takahiro.akashi@linaro.org>
References: <20180907075653.4696-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial user of this system call number is arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index df4bedb9b01c..acea91e49523 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -736,9 +736,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
-- 
2.18.0

