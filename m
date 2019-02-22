Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA64AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADC02075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnTgPPWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfBVMy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:54:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40975 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfBVMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:53:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so2246961wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDDn0ivyVadTQonBIumHfFBd6mG/pAa/u+KuaaJi/B4=;
        b=fnTgPPWFbhryzIzggFc58E4JRsSfK1IU6Sw4LOT9BmgUYGkt3wEcfANoHsXQNUfzc9
         iq9GnYboQsHAKfaKEMrayX1hTXWMMzN/I+6xp02HRbDpZSbRDDjWtj8CtbTOO+dIfC18
         ltrqDIgvui1Exhs0Vsi5guo+6E3eT4Wtp8hwz3ZjUu7OWeuvZHwtR/+mz7N5pObt7Jyg
         o9MWPu/ZGZA22IZSghjyRMXWOy54fhII2IqGEsHjXbEZzuq4hcuupqXge221UVGDnEs4
         VFRnbwlpME12B1w6MdCak9Bm0Q10KMMEgKTJkafiFF5n0MsmyUqd2OoKz/ClD7ZF5Nsp
         o7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDDn0ivyVadTQonBIumHfFBd6mG/pAa/u+KuaaJi/B4=;
        b=k7GXyfwpT7gXwoF+uoECo794TUDKPoyRqW3upcsRbRj2gIRzU8NS5sgk7O+8DqEV+4
         nI0s3ZHAa+owsGGMJ3VzytN9tGb8esnzrvpByTPdUp6Or4r83k0MWN3CGIJghEmSzaIw
         CJ2qUbaEx23QoUNpCuLvx9qFD0XBcworK7RzMw16TtBE5frS1jwsyqjG2hgszHKaO3in
         ekpxqUOBNS/PrndUnzpznzXWGEwmbtqxfsG6pXoL1/Za6Iwtoj1yBB4aziv9KesztqGZ
         xrCIApTcT+qF2R5S2zZ7RvGaUiALD7OpzxCdU8gN8IoOHC8sifsDPcyQd6tgkP0/hHCk
         zd8g==
X-Gm-Message-State: AHQUAuZdWiiRhRFeYRTQeUl/N3jaQ9XfYY/WEZbpZHBbH9WVTnJRpfsb
        2xhq4oJlKnBCFmXoBaQGF4q5CQ==
X-Google-Smtp-Source: AHgI3IZUynwk0jQkzXh/fkOnLsB6yWgKr9nX+ibOmHPHqGghLVkrUAqVS0J+X+P7S91mSoisvLsmzA==
X-Received: by 2002:adf:e548:: with SMTP id z8mr2994894wrm.52.1550840019712;
        Fri, 22 Feb 2019 04:53:39 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:53:38 -0800 (PST)
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
Subject: [PATCH v10 05/12] mm, arm64: untag user pointers in mm/gup.c
Date:   Fri, 22 Feb 2019 13:53:17 +0100
Message-Id: <12759ef1c30887dd9fc7a04498f5a434a67f98d5.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
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
index 75029649baca..b6eda1608bea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -683,6 +683,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -845,6 +847,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

