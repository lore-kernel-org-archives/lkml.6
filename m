Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC29C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2F32075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdeC2+jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfBVMxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:53:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34855 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfBVMxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:53:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so2276485wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCJNq7ywB4uaUqF1MkWtAuFgMYZGYk6wr0hn7fPLDX8=;
        b=BdeC2+jNB/4V8eMU3JsQLO0s40wh5+ubv8EL/H0OL5QAdcdUFTEdOl5givygFGSytf
         jcZdXVsDWgmBZF47af5N9ErRJWRqDdGFbYzwStmoYfWu3LPhdR15RoinUqaGl4Qjgq0d
         YCeMM+dJno0mPLko6w5cnWPaCxS3AA2Rfd/ZMWou0m13PSErWQBsV6d5R8egW63k1+91
         6M6Xf0kf8IIz0JxRxyv6eb8DSW3uJPeZp30Ea6z0EgQHP8RD6UikV9fQtwyB6NNbFht8
         Y6QmzmWpqBZaGR9Y754fPqzonuZULmj8ckN9DYzx0pIKOjOjbgjMmJB8O+P6iH8eCk5e
         9R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCJNq7ywB4uaUqF1MkWtAuFgMYZGYk6wr0hn7fPLDX8=;
        b=biEHzdzoPPHNzn0KSlOp97jmWo/SEzgKumhe98GYdWZpjwPs1MtM9Y2+HA3Ge0s2sE
         9Zv8IJEWy8zUd7yRSyqx8n1jbZYN2sG1ydFN4l6rmeZg5TO47ZN1m5b9Kc3cIzJYXJL8
         IVAjWr4OhqqAUJxqXffBPEvD+/eAq7ZbuGKmHjzFcOlbfw7OHYa5XcmPsEMCcSOBnHJl
         kl2PeQneI/5iuO34rAxlymRwGewCOJq0waeZ0LPXrWqRC/YOE+M2ZpuTWwMhAQ6j8A9s
         Qz4XEtZCoQQVCmat9LqYq8g8wvuEvXDZPUQCrtysfkZQRdqWxrF6pAqfmKkqNDbS4G+p
         iV3w==
X-Gm-Message-State: AHQUAuYKR3fVMJwSXih+qCkZgrryYHwY/0WVYwK0APne9NGHGU/caZ57
        xtP/OThkLyYjF22GTk2lEp+wMw==
X-Google-Smtp-Source: AHgI3IZgI7h36o877UM1PUQ4BYpfOXhaodse0zlvLXALYRj1MboJwPC5054Yq8NVsgrx2Fr3cstKRw==
X-Received: by 2002:adf:efc4:: with SMTP id i4mr3192098wrp.42.1550840023746;
        Fri, 22 Feb 2019 04:53:43 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 04:53:42 -0800 (PST)
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
Subject: [PATCH v10 07/12] fs, arm64: untag user pointers in fs/userfaultfd.c
Date:   Fri, 22 Feb 2019 13:53:19 +0100
Message-Id: <8343cd77ca301df15839796f3b446b75ce5ffbbf.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userfaultfd_register() and userfaultfd_unregister() use provided user
pointers for vma lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 89800fc7dc9d..a3b70e0d9756 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1320,6 +1320,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
+	uffdio_register.range.start =
+		untagged_addr(uffdio_register.range.start);
+
 	ret = validate_range(mm, uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
@@ -1507,6 +1510,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
+	uffdio_unregister.start = untagged_addr(uffdio_unregister.start);
+
 	ret = validate_range(mm, uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

