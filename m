Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B88AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A9521A6A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmzurxSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A9521A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbeHFSu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:56 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33452 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387642AbeHFSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:55 -0400
Received: by mail-wm0-f52.google.com with SMTP id r24-v6so12002175wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHhNjwTAQ121lFvWu3hMTAeIOaL1SqLvmyhWDld+/fA=;
        b=nmzurxSKJcYDsYV1+eQXo1AFKsb89KkGcBuugkQwRDCSRWjpnPT5FmuaK8hAnWtRDA
         8/kdbUdOeJA1T1BUmRPPsYuEcN3Kf4vSMrWGCIeeWUORWVyj7dCOJBssyjuH8JPfu5d4
         oo9z4xhcuG4G4MuRRRIMSo/OxcZmT2KNXiczN+sEe4P2Pm/xXP4k9NmziQ6vBFSg4gYw
         KSvZQ0EjS6wIbckSFwBHy7RkDJgcDfgN1QmlhoruRTi126+u8b2e0oSpg+Spg/tf2+H7
         TKeHDNyXPqvg8KF+N5zbST5JPqKK0xbhHR/FCBhGHa+94zaC7S4DCqWFdC5El1TiFThF
         mylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHhNjwTAQ121lFvWu3hMTAeIOaL1SqLvmyhWDld+/fA=;
        b=Y4qHbEtp0H3+cLccpduqrm33KbGP4QRvUeHQvoHHh0+iug5L+FLb4OjHYfDloVnUbA
         mcB2v6jvPiS0yi0iiSp2bR1LLvx3LMfWihqvcQODe2uaCzsNvZ5mE6CLmklm8vxXelha
         X/nr/cBe4gN69Xs6+l9Sjp6vFWag5+yfe7LQDtSfkHlEP5RKndJkQlIeV7XD+1KI1JIb
         axSAGteMKQgdZo4DNpHqwPvWqIBLtgHSUwG8y4MXuhBWDooo1LrPFtOX3Zi/kl06bu/s
         4h2vmm6yj+Zk8xyEuxkY7GGYr9M4AkUuiCKawKXpbhURLirtYnmUCrxlJBTxmnt/0CM5
         5OhA==
X-Gm-Message-State: AOUpUlFyWtMTCXlcDU62Wm+ntmWlBWNuIHbphho7ij8ava21L5fIlrSq
        HpWHnm8eflg664kiQMVI1i95ZQ==
X-Google-Smtp-Source: AAOMgpfcqP6DQGXwm4G0u2QWpeaFGKnbiUme9+ppvLZU345bSzHiJYtDTNzNNLOci83AySBymYgP7Q==
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr11662280wmc.48.1533573660613;
        Mon, 06 Aug 2018 09:41:00 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id 66-v6sm16385790wmw.34.2018.08.06.09.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:40:59 -0700 (PDT)
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
Subject: [PATCH v5 05/10] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date:   Mon,  6 Aug 2018 18:40:40 +0200
Message-Id: <6a59f7eef9a056c632a515a3a51ade3f6420b462.1533573460.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.18.0.597.ga71716f1ad-goog

