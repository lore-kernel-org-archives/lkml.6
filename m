Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29032ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E715A2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSTpJoAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E715A2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeKIAMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:12:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeKIAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:12:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so21511147wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMfnGtGqvRCyrqlswY+Q1yEYdnjSJs7L5yVY6s2C8lo=;
        b=OSTpJoAOkRI0ha5rclaP8H3RmP+9ftj4eIBMetkNB1rSZYKkx6QyMUtvsfT1I3Kbsi
         nqq49Yy9O0XIeGCBlu0DPUC39BhChXKHgATeWUk2Fi3gh0t1QL8BYV6K4jiy3T2i6GNH
         VRkY3HLu0OXnhKnVS6lf3PrTZZrby7lQuqhxR85J0t5SJLDHDokRqms7hvRLEo0fiOk5
         qXqzsjE//9TlVAWpqziY4CaFF5r83iPytuR7OvbTtP/y28wAZdWtDZB4Xu6aS0GvYmpk
         /IynZxRnIUJET/vhUgCb7aqU51FOWJpPnAr9pJIHVMZ/tONQTR1EhR7OVdPJRK9CIslK
         04FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMfnGtGqvRCyrqlswY+Q1yEYdnjSJs7L5yVY6s2C8lo=;
        b=ezkF5H5lw7xZswn4eePwhDNvj96Yho7irB97MFeBt0/CFk388RpSpbb4X7QfaY1gGS
         X3Y9fZMcdBaOZEUYqG4jxvaKTmLIfwCsqG2JqnA0eTxh/CuNEVc82tp7BfQj1my4bmQq
         wZ6RmHWPs5+L5CcpeutzfLCXVYKKOr7GEUSFR/O6sl5b8hhzPsW8beB5D0QcILaBZteV
         Xm3+mCqhPx9uFzffnnwArpMNbBL+xn8QDes5dLdPXgJd0EXQf9NTJUkhJs9udsFbWD2D
         le1rT7g+3eP/YdMJNfriHLp2xsuN60bFpM8CSL+ZQQ2kouoI8O8vxRVRKEy1eXYXXHGl
         aw3w==
X-Gm-Message-State: AGRZ1gL/wj38kylfBgonYGQKBG0jnJQscpiYETRdKSeiHuLpQX67b+Yv
        GR1zKaqp3UD1uiwX7PNnF654EA==
X-Google-Smtp-Source: AJdET5eI6mep1KozRP67zq2F57bYi00Ufy/TNGQH9gCb351dH5ClKuaGSs0MjfRiBrsX95XmOTVJkQ==
X-Received: by 2002:adf:f382:: with SMTP id m2-v6mr4327147wro.111.1541687789216;
        Thu, 08 Nov 2018 06:36:29 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id k5-v6sm5421068wre.82.2018.11.08.06.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 06:36:28 -0800 (PST)
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
Subject: [PATCH v8 6/8] fs, arm64: untag user address in copy_mount_options
Date:   Thu,  8 Nov 2018 15:36:13 +0100
Message-Id: <12fc6c9e4896b394800776c54b16b26e2003a9df.1541687720.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
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
index 98d27da43304..1f1f998d15ed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2674,7 +2674,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.19.1.930.g4563a0d9d0-goog

