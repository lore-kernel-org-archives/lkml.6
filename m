Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5874C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9031D20844
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMD4I/SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9031D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeH3PnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39796 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeH3PnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so1681562wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/jdbb2Vq3Kiym03/gav3BOUvcnL67E9+cfyfM7MhIU=;
        b=DMD4I/SS8lJ+d3U1+HP9Yl6kLLZHPhvAdJS/JxxXCHjmDxUF/UgLbg2LpoqOkcwLuR
         wQQPHq4FCtWNS5xr7a3yBgBLJiWBX59b39kyQUx1OqIRTZZTjyRpftdyJmGkxbABZFU6
         5KDwphISdpfEXbTOa+4UH4EiTU/0Wi30p9H0GhSfdYr6ze+w3YzNJGGCjrGlYOzyxLmh
         iWSjewMZmvPQ1GwgRIhyGXsGTzAm8HlL91OxzULxqV+6QAR/5fdqnSyQQBmOZsTukWgi
         9+fmCsSQzqxxTagM+2Wx2wT5yLGsY3A4DZXaZsUTAtgiarABDJqijOFj2slq5uuV7G9d
         s3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/jdbb2Vq3Kiym03/gav3BOUvcnL67E9+cfyfM7MhIU=;
        b=getfZdZobzOeEWd1u56V4YJzU4SQVEKKif/HSGhgfz8QIqkbxCUvj1czrHDg659FX4
         4bGEzEk8uyrcV5c0Ul+FqM9nOca1MfoPGzGJpOqageo+ezwJ5O5XESNxI2/oDnMm2/JI
         yUFoKsXJeyvjthz7/ZqZIuzXlKL3A4LiwGSEAZ2q8o64c5hPJesGH2stopIe8m0jL0Zk
         IVmL9r0rDBonY3hHlcYMcPu0wZO8i79Pur01DXEZkRa9Vrhfa3ss9Dy1qJ60pZAkxrf9
         Ci6q8urf7nVoA0NplMx/Qe8v5QwMs8DjxGPbPiuP8jQBh+GAJMIMIarRY8wSQGoVHSm0
         erGA==
X-Gm-Message-State: APzg51A9sY6Ue1cnh9ZKNin/8JPe06JJmwwcs7nnIew/eSONiLvusyGr
        OwfVHvVnHK8lhTYog3gNRvQMgA==
X-Google-Smtp-Source: ANB0VdZJCY9SDGNv4X5vQQOPslJfwglBfynr1JnV8gKw4PAQtLtDlI07kC0OD66facMHWBf1VWf6KA==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr1614151wmo.84.1535629293894;
        Thu, 30 Aug 2018 04:41:33 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:33 -0700 (PDT)
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
Subject: [PATCH v6 09/11] arm64: update Documentation/arm64/tagged-pointers.txt
Date:   Thu, 30 Aug 2018 13:41:14 +0200
Message-Id: <594756b2aa9fea948f4da3cd01ffa8a5acbc5805.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note that work on passing tagged user pointers to the kernel via
syscalls has started, but might not be complete yet.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..361481283f00 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -35,8 +35,9 @@ Using non-zero address tags in any of these locations may result in an
 error code being returned, a (fatal) signal being raised, or other modes
 of failure.
 
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
+Some initial work for supporting non-zero address tags passed to the
+kernel via system calls has been done, but the kernel doesn't provide
+any guarantees at this point. Using a non-zero address tag for sp is
 strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

