Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C730C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80FE21A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdFiCJWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80FE21A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbeHFSvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:51:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37009 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbeHFSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so14971519wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YhiwXQETzFyRuKUoiUientUUS69FHU4d1USosDKGiBg=;
        b=TdFiCJWQV1yY7auvDE3OMD8elRn00ZYfTJx5VBDb0vmH70JjcnkbCr00a2DIqbTxkS
         u7P78OkVA7gQ2mUn3ucxrt0JtyrX1cqTglzaw1x/dguRXxGb50g/t8CD+nUQK1HGE0Zp
         glmM2eLYnNtONsT7coR0+ZV/xEq9YDzXdaTDB163co13OWzCFpLqTdc6t/n/9mu5/ri7
         jX1FY0jxM1iC2UpEDrLPzuZMntSNz0ZVEPRb3jD0WGCqCJ9fJXFePlZnlDJrBFnRiOvN
         tvYvAMZWoxtpd7wNSEtF6rRizE0sA+pJRhf7h3xozmr3qrKnhPbxGuFUAgAjiDuMzDpo
         Jisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhiwXQETzFyRuKUoiUientUUS69FHU4d1USosDKGiBg=;
        b=YmmA10vnwsrBqcp+G5pHckN9uQAkjX4Q9NmYtRc31Q8O7ddK8Dh251vbtOM4r7RWY7
         w0B0BbiEa0Hj3m2dI0Zp9RtN7hT4H8I9v1tal/tbMbw4BZznFJ3AlCmtQANdwY72GD8d
         lon8Dcu89R4ajIp1Fb8ZQ6+WKlsVJzL4zaSWZzGkKsXl6XLE309zPc/JEuYxY4hGNGvb
         JXvPYzo0ukOBnuzG6kUZWH5XzEEz0DVXHJ9x4JRNB+8FO5gl2Ufo3mJ2XHJ0JNTSS4sA
         zihwFgf7i7koOjO4QAP9iCHXyRWMPr/oeJz2LyhzDhNcN9vyCrdtbQCs8XDaK5KRlBmA
         tNPw==
X-Gm-Message-State: AOUpUlFUSZswk7KfqJj+IK2y/DcHw/zloYGYfTEh09Mxad36HL8L0Rrz
        BH6NclrAaIWFQrLwhQheHKLUgQ==
X-Google-Smtp-Source: AAOMgpfgr6iQdZfaudH/1Dxp198cQUe5jRBwkr+pUFpoQTY/gYwoncrlREotSNcycesndSR3fYlmIw==
X-Received: by 2002:a1c:6d9a:: with SMTP id b26-v6mr11379886wmi.74.1533573663633;
        Mon, 06 Aug 2018 09:41:03 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id 66-v6sm16385790wmw.34.2018.08.06.09.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:41:02 -0700 (PDT)
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
Subject: [PATCH v5 07/10] fs, arm64: untag user address in copy_mount_options
Date:   Mon,  6 Aug 2018 18:40:42 +0200
Message-Id: <dbacdbf3f3d66c853fafcbfdbf5c1f0afb464981.1533573460.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8ddd14806799..fd070e65e529 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2733,7 +2733,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.18.0.597.ga71716f1ad-goog

