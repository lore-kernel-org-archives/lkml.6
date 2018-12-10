Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2182220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o94crt9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2182220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeLJMvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:51:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54772 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeLJMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:51:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so3380303wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6AqR+kzU7DWQeNGwKtE5aEN5/daSSLGL2wqVNM1I1o=;
        b=o94crt9sdWRW+Hm+QmVzs2SQOfXkb5I8ZA1YUWGR/rhiyXLta3D09PlbP8iJAgQz4P
         AaMOg13WCXc/3V43uJSupLTElnHz42/Ee7IzHa1JjP6TjqWFlUNN//X23cnby2HTY/og
         axjylPN+XFavkTnP0oGFHln3ZwFe2/juKQ5sJAgtxYNAFtsVDFeYuPsBQ0hII0bfcLEK
         XiMERt9XLjpmq8N8DJ1YK866L0D0OEONbAo9KCgz28iqGOX3iPjmbwdb16LAY28Asm+R
         C/Nun82fTDPABrkfsixYhSu9EPH9yIADCvsKOyVMjDxIqyFwkkJ/ZzoNiySiBB50PDA4
         tGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6AqR+kzU7DWQeNGwKtE5aEN5/daSSLGL2wqVNM1I1o=;
        b=ThY2L9M8w/ZZPLl0goYi76k7aWB6ovRyGoQYiDfYx9J4MGpdSyI9wUryUiqpY34UrQ
         YUWIRZcBiscuaraALQmihisEPVZ0+q1gWilQmoNmJMvOj61ghdqnoxvdZ05AoJp17Vz6
         biEiKhqp/30IrEo2iJEbR9xlxI3eZtd5tgDfr9juvvU5spl2M7eYOhNFuEiFa/9qO8/l
         qGIqpkfnMc7SKNUCEitaYBCOWV7MwIdjGRiG2Vs4UHZscZhY4Npnwa3A/DRYYKIH3DRD
         +8Hkk68+/kgjChP+7Zvk0leljTsHYwE4tUpnzq57AspW5u/RRrLrdKQOT6VyBDps790J
         4p1g==
X-Gm-Message-State: AA+aEWYWNFYWOdFAF7u3j1sB/nkavjOvdJ/SdIiav9TaTtgv02sGY92n
        VYXSaFioAXIRd2DYiEv+YQzlcA==
X-Google-Smtp-Source: AFSGD/Xve6So/1Ery1o5wmvM73iVMPQ4hP1b6ACBIixN+5CPW479nD99WkZw/3+pQqT8QAsR/mEorA==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr11011978wmb.139.1544446275548;
        Mon, 10 Dec 2018 04:51:15 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:51:14 -0800 (PST)
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
Subject: [PATCH v9 4/8] mm, arm64: untag user addresses in mm/gup.c
Date:   Mon, 10 Dec 2018 13:51:01 +0100
Message-Id: <f67011f11f676bf7b947bf819273e22b828b9b9b.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
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
index 8cb68a50dbdf..409aedb1e2d5 100644
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
2.20.0.rc2.403.gdbc3b29805-goog

