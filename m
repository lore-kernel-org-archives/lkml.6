Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B9A2083C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlVrQke1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B9A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeH3PnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39650 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeH3PnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so7757313wrf.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfYH6Tzsb0z/vmKFOXCsrYnHaggF5QU419/lUUKCb/M=;
        b=SlVrQke1WhZ6O7NRIVjFhSxayQWj+0CsRGKGIwkcT2jBX14NAIHkWVjXQWA2EUGecR
         8YqeRKcb8aU1JvFpetpYruAgMrf4QvtMgcPKs2lMwrnQ6FIp+2emSvfGBtjXPmoanpE8
         OgWrUG9Oc+AUrCcm5yUGPEAYrCSRnOYb1EPJRWzGK2ELv7RFjTJkVuUxlpj+FaR0K4Fm
         T26n780JhZ9e07DlSfaMe4HZCX09HrgO6FY/a8g4OjQ2ZtelwTDFoRt5VxT22TP9pWpS
         zR5Dfk+GoIfpdC6OSm47yVm6eaduuRwduGf5yZ7D1k8y8Qfc/Ij6G6VYWM9MeB801lDc
         YfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfYH6Tzsb0z/vmKFOXCsrYnHaggF5QU419/lUUKCb/M=;
        b=j9N64geTdOXW3bRep3qka5ibMphq4rhaaWkGpfIsqWMKEUVm9u5RjLupoHn+TXVL6d
         RgsyT/QLAOyAnG4lfKRpYKO8LV4n5vArRb++cYnSRH121omFdOk0wbDHUnj01mVs/hx/
         ve0tVlQm/Ft0h5RvPy5Js0FQyd8UtZWctfGGwAdkq2ELUhgts6DkE2BjzO3w5UCnsUy5
         B01r5EgwHupJy+GC6VPR9ZWLd/oQazLDk7uugHjaoBSysrrYVUranX6JytPBP4vsIzHt
         CsvEIwLWFGIBg564JP7K14k3Vp3K023t8CGOMsUHwlZygf/ZspVonE/E69zL611I/mtp
         pUDQ==
X-Gm-Message-State: APzg51B4wvNxVo2NuvzTLY9C2PuYQ0sQ9HikIPqDyjDs+x8ZTb4caH0F
        G5TIY81w8VcRUkWLaWvwByiBSg==
X-Google-Smtp-Source: ANB0VdbfT2UavtupUozQmcxh4AV9vSkbNDCltsV+0dOIrgUtBjrUTRDGUHsynILgINfK356aYp5UZg==
X-Received: by 2002:adf:add0:: with SMTP id w74-v6mr7745481wrc.73.1535629283942;
        Thu, 30 Aug 2018 04:41:23 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:23 -0700 (PDT)
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
Subject: [PATCH v6 02/11] uaccess: add untagged_addr definition for other arches
Date:   Thu, 30 Aug 2018 13:41:07 +0200
Message-Id: <bf96f9150ad04fc8db64ddc02fd81ec7568f5c39.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow arm64 syscalls accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for other architectures besides arm64.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..c045b4eff95e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -13,6 +13,10 @@
 
 #include <asm/uaccess.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) addr
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

