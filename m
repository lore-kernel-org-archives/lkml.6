Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F357A2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3gwK58H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfBVMxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:53:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41000 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfBVMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:53:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so2247479wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tCXxaQ0AcT215cB6TyMBJl5HSukg9TNH5t025IrNLw=;
        b=B3gwK58HnJ85CmTL2efZvH+J/Nm20KCnydLNY0dw7gbtvGIUGcldP8npiWTUpDXgKz
         /u11H7eQqGQOsrUx9Bjjx9CGJcxvqjtgzrsVE+c4Cnr2aH4wSMA3cBw28f4m5dvZcDtW
         dE9QsCl+18tkcm6KtqrSMoS1/n9nvYZMf6UFWkly4U8pHmTr2bgB/2tzCG5OvgHPbq1p
         LygIpIzOhXUWhS3SS/cArJu5XyCYKaSFAA2Xlb21EPCN/ry2nFAF1xMDOUEnala+awoK
         ndjVy074STqch02YUSBKRqql7aX75kVTJAVZrchuqsIoYuA52Cu849nBt6+cAxrGpU8H
         43FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tCXxaQ0AcT215cB6TyMBJl5HSukg9TNH5t025IrNLw=;
        b=ho2mu4b2veAXrjvyfb8UnxgkdVPBDZhYPYrtgC7KExHQgbeOMLbqkb9l8ky2V458kH
         HZ2F90kwj094pao/zBbYAM5uQvsYQQVlbMpXcoY+c4P7qWf89YRafJtUzJ1JLVCD+8lR
         tD2BIVzTqkrQiF/88jk/lvqdTx8B5zTfUT/1zwLZfZV87bclsStQ5ueoVf+s8ckAIJnD
         4JA7+biT3c00z6wRYkIDcn9uLoPAz1cPUF78jngVOMUH0KVIhEh2M93Koxpdxo86VL8w
         ia3i8rfrVcf9yCe7IAO7P585JzeYHofrNFCt2OsePlYRFyo6gr3bLcgQUGqkeLT+mZQf
         EShg==
X-Gm-Message-State: AHQUAuYpSioiesQEHYIzBNoPcjSbSxd9dIA963xX9GQ1GbTBxS4LWMUR
        j6n9LndEzfSi2Ofim0QzYJh7uw==
X-Google-Smtp-Source: AHgI3IYJ4JqjThJgosMpQUX8CWU96fplWtblPpUxW7NKKKm/ffsucHxns87xgSXmASXlP8q7nFWW4A==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr2881069wro.249.1550840027447;
        Fri, 22 Feb 2019 04:53:47 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:53:46 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 09/12] kernel, arm64: untag user pointers in prctl_set_mm*
Date:   Fri, 22 Feb 2019 13:53:21 +0100
Message-Id: <d6febfc14cf0190f4ccd84fc1bf9bd077a6d6a9f.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/sys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index f7eb62eceb24..12910be94b7f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1992,6 +1992,18 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
 		return -EFAULT;
 
+	prctl_map->start_code	= untagged_addr(prctl_map.start_code);
+	prctl_map->end_code	= untagged_addr(prctl_map.end_code);
+	prctl_map->start_data	= untagged_addr(prctl_map.start_data);
+	prctl_map->end_data	= untagged_addr(prctl_map.end_data);
+	prctl_map->start_brk	= untagged_addr(prctl_map.start_brk);
+	prctl_map->brk		= untagged_addr(prctl_map.brk);
+	prctl_map->start_stack	= untagged_addr(prctl_map.start_stack);
+	prctl_map->arg_start	= untagged_addr(prctl_map.arg_start);
+	prctl_map->arg_end	= untagged_addr(prctl_map.arg_end);
+	prctl_map->env_start	= untagged_addr(prctl_map.env_start);
+	prctl_map->env_end	= untagged_addr(prctl_map.env_end);
+
 	error = validate_prctl_map(&prctl_map);
 	if (error)
 		return error;
@@ -2105,6 +2117,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
 			      opt != PR_SET_MM_MAP_SIZE)))
 		return -EINVAL;
 
+	addr = untagged_addr(addr);
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
 		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

