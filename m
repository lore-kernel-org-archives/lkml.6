Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A95C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9B82084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vM2W1vbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9B82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeH3PnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53288 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeH3PnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so1651117wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppVHi2qDpVAko4oywEUyVH03nYNtDWMaAZh6pkh+TAI=;
        b=vM2W1vbB7o60flHuNJ/bgTQROh+Zt2m1p0PT33/imyxEkZK1/Esv7iYw9LpWqbIh3m
         hobo1vU1c+v0Sblwfgp+dimNnJPZy/F0NvOautf7atu0tq8HTohJpgdmmMrdl4AYk151
         y1FKxABUZJiw/FShkiF4Vjx+avpapwRzC5R32XJn5fMZrR+LCeV7OWD7REcGraJpxEGx
         pZQS5IbOZ+yijKZDr2ka3/sxT/vVG5mZpKvFVey/NkAxEkpyZY7MDNEqyN0Dv5ql+VJW
         4UYj6K8/zcqE3BRWKLrn8aXymf+gcl3zDhnzQaYNb/VkQUlbBIQ8Zyx56geVgZccD9MO
         FSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppVHi2qDpVAko4oywEUyVH03nYNtDWMaAZh6pkh+TAI=;
        b=dTCpw5tVDRMISpKipPNVFR8bnpmR9nEKmA6/0czqW4RVvkwxTgCS+pkjagrNATsYe5
         YPwjUFP63XKdencFgIkGoq9vyXsbW69TvbXw++Ugf6zDemY1vmY/+B8un788Dfxw5LP1
         XY8Zp8Q3CMiUMlqct6iTrLhkrDPYz7l9hnJ8Ec3xLIo3Qmr59uWP0m2cfI7BuUK/kMc8
         09vst6pvd/M0gwX98MDV8V8RVXqAsqQty+FVqPMwItOxJaTdfCFKqtjTXOgPPhIbKRFC
         3k9nErOaYNcJl543nNVVbLoliqzSkXTtd4vxHWfA0QL9fHhiqawSNDOxkCnY/wEsfjbZ
         pfuQ==
X-Gm-Message-State: APzg51CghfEVaILkveqtVHysBeU42DcZsro8PXvyHfwDh4fDjfIsiIMS
        UsIhNXclbyNRc9ysu44QR79qCA==
X-Google-Smtp-Source: ANB0VdYOFoy1sxoEnv1Wgj/+prhG1/Y/jGlov/9lPGGe6D7gsNtu3J1gP5Nihdp90zj4LxikZG+9lw==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12-v6mr1615687wmf.57.1535629291034;
        Thu, 30 Aug 2018 04:41:31 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:30 -0700 (PDT)
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
Subject: [PATCH v6 07/11] fs, arm64: untag user address in copy_mount_options
Date:   Thu, 30 Aug 2018 13:41:12 +0200
Message-Id: <89806bc1c1f85fa97c62887075cc2d46b8bdeee2.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
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
2.19.0.rc0.228.g281dcd1b4d0-goog

