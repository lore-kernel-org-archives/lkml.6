Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281ADC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AD2208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yi5PvRI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AD2208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeFTPYr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:24:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51523 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932308AbeFTPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id r15-v6so221206wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k+iZynWQRXvZ5615wlWaB9aY3Mmlz8ffNowSv6lWV9c=;
        b=Yi5PvRI/WvQZWuC7LBADIW/4S61zU6FsZnonsBPtHh1OnZr/tsw7/vgcilAYEPpp3P
         H7MOwSQfZAnX4kMMjr5GbcWRcrWLJUjgyo9MQQymOZwV6IhhzlVDJWd0fN0dkju/J6fP
         kuuowXeWkDK1Q1Zbw606Nm6H1UdvRSyROBOfOtpK/2ddCELHQLRsilicNU1P20TUmB+i
         ijMKrVL6HDf/W3bvGx1eijAeBX7IOub0BlEIuDAS2sPkjYisHX3IPc6514252u+k79/j
         36kdUCz1UAbQ63TLoKQyKpwPU9dJP51RVzpkdc3SjxmH9ukUghNG1YH2/xltV/ZzVLLO
         uf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k+iZynWQRXvZ5615wlWaB9aY3Mmlz8ffNowSv6lWV9c=;
        b=jXVUg6QJJV+MOeuH6qxOkdCsrHmQihYKLufq2S7G7gTTCnf30Iv4XUyM0bMazKksZ0
         VlrzFPqE6gfWjEDCOWC/0Ium0Z+NKLGl/rjBacuXSOWIzpqMIHiScUI5AUNGAmoyuKN0
         qtqHelufqmulyo3Bo6VSlBtVOFjYQbYbxfMhO82m9T6+PtISpfa5p7f60BIKtxy5jD7i
         oU/lvju06lYp6aRUvY1ScyCbr/mFX4ryx2FZYP+UTcKY1u2AwpIpCJSgtbk5iwDw4AV5
         xaihZuXsghUOkBaIT7QiZFBT9st74nnCN4jfgac86aLHAqxkizJVDUjWXX8Z4ch2XE+k
         7vHQ==
X-Gm-Message-State: APt69E0DUXsCFpIVR/zy6WDDt/i873ERi94ZzSc87uh1L/dS8fVC0Kh8
        lbMzeaTeSUDr39lG5qpxfPeDhw==
X-Google-Smtp-Source: ADUXVKJXc6AKKDoJ+FdN8W93tAEIqcHbvpdSefvagKsbEhUe3hdApwEhSHA+uBzxdDaEIYJpEXocQA==
X-Received: by 2002:a1c:3693:: with SMTP id y19-v6mr2024605wmh.71.1529508279217;
        Wed, 20 Jun 2018 08:24:39 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:38 -0700 (PDT)
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
Subject: [PATCH v4 6/7] arm64: update Documentation/arm64/tagged-pointers.txt
Date:   Wed, 20 Jun 2018 17:24:25 +0200
Message-Id: <ac42b33affe34c8146ac9a882f6c6be270726dc7.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
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
2.18.0.rc1.244.gcf134e6275-goog

