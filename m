Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4936BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB202089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/5+TE8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB202089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeJBT4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39417 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbeJBT4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so1428748wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+fzLalqRaXGFiw1By6nH8QQrYEhVoORFRhjy/6ZtCk=;
        b=g/5+TE8qrM0S966GF0ehpYeatmN6rBIDeIbCUA440M2nraTgJHSOOqRefWma3H2QFk
         db/TLUMgW+3DdtgV6yDyHfsewvdoZ7XQ0S1jqS57d41YAflXkP1pp9HlkbzYwNkS0JIY
         pRVdhsSySSV0TihlxSpRvVQSVaJywiekWjskRHndBNzF7BevnT1qmGTO4DaIhzYUXxry
         LRsUaYPgQ3TIeOamcd3WNyixCIR5UKwYktsOiGG1HrBcYgd/3s9nCOH/IZLWx8A6pH7v
         c1a8+L2HtBSCHGIVd4jnex5QRuAgpohMaN8a5DeTpNqK4l46AuDUGWCyxe5giES9UqQY
         RTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+fzLalqRaXGFiw1By6nH8QQrYEhVoORFRhjy/6ZtCk=;
        b=fGSZr+nMaygE4waBNHGRu4oR63bplQr5GMR2mo0nhY4flBgygBaaGACGCkKoR6uwGx
         sz7VrRMsqu1fe0O0OLnN/qEfpYaLUDI/EPMAB/3hJ8LoqSxTRLfJAIVxcPNKO/vpaCcJ
         /vDToF5mMNXhZRsH/grdUJ5JzZTKp0ecucd9kQQ6yx1M4p/LnNoXUGBS6N8giBGeGWXR
         rhqqBQoVX+LV3mz6YaBHAfMBR4G99kuNV4WDVdAAwrxe2bpYVSNUMY3xLkRn6qWfLPwB
         0AgxOnY508s6HRE8Hnt2yEVb3ekypMf8wnsQUFm3vVt4CtUizq7vTl+UE5HqwF3KRyB/
         BVXA==
X-Gm-Message-State: ABuFfoiboO3WTgjJypoRCK2NlB2t98G/ezS7mPyVYGHDDkOepz485iOU
        YpqNtshwyohDw+1jmpMyVFRkxg==
X-Google-Smtp-Source: ACcGV634rYLGlFVKrv5iDfl8Icy0xrHVGOhV9Puza2K4wNp0CAyWdiFG3gBDc0/36ZWC9rHQ4ru4hQ==
X-Received: by 2002:adf:8022:: with SMTP id 31-v6mr8356555wrk.16.1538485971887;
        Tue, 02 Oct 2018 06:12:51 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id v10-v6sm17458681wrp.0.2018.10.02.06.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 06:12:50 -0700 (PDT)
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
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v7 4/8] mm, arm64: untag user addresses in mm/gup.c
Date:   Tue,  2 Oct 2018 15:12:39 +0200
Message-Id: <405ee9e84a83178e762d8bac97dd1b36ea09074e.1538485901.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
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
2.19.0.605.g01d371f741-goog

