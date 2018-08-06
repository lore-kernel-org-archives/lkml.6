Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838E1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3934A21A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AX+6UEOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3934A21A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbeHFSwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:52:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33691 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbeHFSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so12002118wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFRCrIeakYIo90pBPUFlidHqpT0Hqqs6ARXRy/1gDrE=;
        b=AX+6UEOD4pChSsOaVJW9/HUmRY/Hud5HGf4nl2GADVcqj7RWjxiy1PFox5NDqoN3dO
         vfpNrriAJ6/Xv52Jjqyqc9GZabpYl6HbtIODPOr9wrot2mbZmq+FrgNtfun2vMh/n8f2
         0C+SdMEFuWM5HRB7mTci48rybim2ePdWLxmoLET2gDdHVHgj6mmFfrEeaa1EVkcYnlhF
         K8cnjvJpET1k5OuNulN1TWP84QgVEtmWHZI2SiaPQ+4Aa4nJvZkzmRDejbEC8H7Bcu/a
         zEh/B23/FKOADejZqHo1wu+YxSnPzMHo8lGXhQkK1Kl7/IzBtzMyTM9i0BHxg+uHp1Yg
         rCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFRCrIeakYIo90pBPUFlidHqpT0Hqqs6ARXRy/1gDrE=;
        b=QfmzisPhJj84LzlpRa0L76VpM6B4kg2upFrnn0bNsD8GaidUjlw2SXgMNzDHM01fC0
         zNUaoySLNVZiWAbGAtxaVuLpmPjcT39rJ20FMLHx61oiC2/6yDD4sg9+IMsaPldO9HvJ
         D0+RwyxoBy77dgVPG0EeiXBUgAPBpIR6TjcfiLxA6VMo0U65FdKdeqPkZ5cu5fU+Ds3E
         6Gj46M/QtLEaxrq+7cEtTAkDgE81YUrbMGqz32YcNVs9byXqogYgiRnCakjk/ht8EYgc
         ChVPnzFQ1WHo3rfz4VoK2QYCYBTr6cS/J2a2w7SgX1Wk+rSDqv0LwBYVBcuQo7hkJjui
         sfkg==
X-Gm-Message-State: AOUpUlFCKAYjI++HBJQe5CStC/zN8kzegnJhC+U/su1sNr6IvvNhkoqE
        s51wGNwzI77xoJgPIMCzPz3ICw==
X-Google-Smtp-Source: AAOMgpcfIK1v5kRJhsLZ34SjY23HZ47OTWWZVSIMkNKjxkQyM4NJfzwreb6Ygxh/ZoTjJ068qYgKyQ==
X-Received: by 2002:a1c:f03:: with SMTP id 3-v6mr12283207wmp.129.1533573659155;
        Mon, 06 Aug 2018 09:40:59 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id 66-v6sm16385790wmw.34.2018.08.06.09.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:40:58 -0700 (PDT)
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
Subject: [PATCH v5 04/10] mm, arm64: untag user addresses in mm/gup.c
Date:   Mon,  6 Aug 2018 18:40:39 +0200
Message-Id: <64762ca688f8611c38cf6a8c8bf50a75d9f2fa3a.1533573460.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
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
index fc5f98069f4e..ebb87fb56709 100644
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
 	int ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.18.0.597.ga71716f1ad-goog

