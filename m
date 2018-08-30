Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957AE20847
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qutDpDCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957AE20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeH3PnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36487 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeH3PnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id m27-v6so7769525wrf.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peFGwkj0AlthOK6WcLkPIvSBY/FDPlGLSABrTryAHcY=;
        b=qutDpDCEJxZdQJGRz9onfIyHIbFL8b17YWKAy3SacXtKLfSDNYNiVlv1hK56myHKVG
         TpyquPNOuTBxR6l698HxJDFXuGfJTfgvMYNFFkc9/TXqGxKm8UfZZF8EYjbSu9sRM6Sv
         MeNf7eh1j8Y9rENXz6JmOCnaZ5acljWvTf1sWUnXx/3QzkRf3sWTGcV0uHPXYOL47Jwf
         fQ+ZkBLNcijn0SXu94/W9cZckIe0NxQsbfFYrLBOM2UywIlnvrmBr/qpaYtLINQomi0w
         NTY9nCRgU5N/y2QOVTs7v+xMJkt10JdgERM5cVwoecykkVi8kZaSlsRfS3mO1P/oW9A+
         Kbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peFGwkj0AlthOK6WcLkPIvSBY/FDPlGLSABrTryAHcY=;
        b=grZ6iv37yArS+2itf0ZeOngN+dtHeAgF769I7PeT8PoWZ9otuGLvLiYR/PianbRDF1
         bDAwN39IpJ0sMFkPGKe6NJvkxEfBfzBehnP3EiNZy3CMKrbzqUPEd+ZcPwrve/dlnKvL
         pkc5gR7rWXYA+0yNqwLzLop9UsayTKq1BeFM3m/Pm8xgh4X+LpvZC0/PBvJ2F66pM1Td
         dqgRaJk2KBanUQBOR54X/U4yQv7vr3wR8bLKqnGkW4shFfZOKy22I7kgzS5cNwg223Hs
         3PBlZCZStVk8Okul/nIX2QGVKsfDyp5fYclIv9BSBNe68YVbOj7sucnUEOqWHRBs0qPg
         06qA==
X-Gm-Message-State: APzg51CtDIpVSsLZLM1KOJLWjF8Fh1DTo+EeprONiv0NFyN41RlNdj0p
        Mmh6HhTcLwSITFZ9/EuXJ0fNtw==
X-Google-Smtp-Source: ANB0VdbPh4x5K+d73YTy+PJV6jm5VPTOj5FyfmaIwEvpFsYUqWJo2UphtTMIpDCNqc7+l23bjsiZqQ==
X-Received: by 2002:a5d:5009:: with SMTP id e9-v6mr7782028wrt.18.1535629286664;
        Thu, 30 Aug 2018 04:41:26 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:26 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
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
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v6 04/11] mm, arm64: untag user addresses in mm/gup.c
Date:   Thu, 30 Aug 2018 13:41:09 +0200
Message-Id: <163681302d7380fde6717daa26739965295f636a.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Since a user can provided tagged addresses, we need
to handle such case.

Add untagging to gup.c functions that use user addresses for vma lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 1abc8b4afff6..6f09132c654e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -666,6 +666,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -820,6 +822,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

