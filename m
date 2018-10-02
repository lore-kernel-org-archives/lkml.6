Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E5EC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D314206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hapSsxwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D314206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeJBT41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44128 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbeJBT4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so2155748wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOEYtA/I6Fm+wYElUl5x45bwyq3Cixn9jAS0SVOnGHY=;
        b=hapSsxwdWXwCXhX3cx/PcxUUNiBlkLbDk5Ol0GIiM68H9rsaDKFOhEppykmnJbSMIG
         hP4HvsnoWoqCLF1XH0klHSE3kJRDP7PzPV+P6sfrd5jZTa5O9wY0NHxHbg+ssowNWDAK
         jMZK0Qtbun2y4bsuxkmMQDRH3ZXywQU73104mMawS21UPnCx0hs79aj2FTAWAvr0G5Zk
         bxZmeY1y8kNyiwgFzrMFxb0Kd5/hqdAgiK5/yWb9dAnFsWl2bEa6+ntzVC/LqyX7KdsE
         qebdV3d2DvQAFlQK5j16Cw1+qqvmSmApY2GvOiRAmqs6XOLDd7R47nErQEM1ADlvsb3k
         CIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOEYtA/I6Fm+wYElUl5x45bwyq3Cixn9jAS0SVOnGHY=;
        b=RE3HtCMiHrieuLFlbJQ4QGN6Zmua7f9jGfXa0XeFa77cMmn9AJHDZj3kTKTgJZ8n2Y
         sAPWHDs43Zdh9lBK9XyTDXFvIv6bMn0RnXn3Q9YxUzXcZ+lrfL3VWq4SEzZVRkkW3meK
         PD0CfOfB4gGHHZmXULyw0kPGgAd8MZ9LFl1+Ah+jJ/s8hbXnLBT7ru7lWrpYp0qtFQOO
         hr1BjwRWPn3Sy3CT9f5FaLeojyrPJNt5E+/RBhDA1MFv0zUiyD/wnHX9L71JOcw7W+QJ
         wPPTYHx86bMH9P7VVY6cTeMb+7VMvTDyAIm82sNDt88O42ky7ELzd5mlUg1WEY/77eAj
         pvXw==
X-Gm-Message-State: ABuFfoiXPT4y1MhnSX0ax9SndJItue/+ex62JbyQ4el1TsYB78qa4yTb
        cFZXGlKkdOD0E/gnd+mslPeLIQ==
X-Google-Smtp-Source: ACcGV61mrD9eqhs6Y3Sph53EBteAZzSIYlvW15ySh9La2vNV0aqpQtde7IbKlj9BD/8p9DYuC53IiA==
X-Received: by 2002:a5d:6707:: with SMTP id o7-v6mr10890380wru.326.1538485974696;
        Tue, 02 Oct 2018 06:12:54 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id v10-v6sm17458681wrp.0.2018.10.02.06.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 06:12:53 -0700 (PDT)
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
Subject: [PATCH v7 6/8] fs, arm64: untag user address in copy_mount_options
Date:   Tue,  2 Oct 2018 15:12:41 +0200
Message-Id: <c16db382982a7c2888e1241a455341118cd63b89.1538485901.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
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
index 99186556f8d3..51f763fb9430 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2672,7 +2672,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.19.0.605.g01d371f741-goog

