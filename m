Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F2121A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwCS2rS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F2121A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbeHFSuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36249 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387521AbeHFSuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so14983035wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GegTTjbmNjbsX4HChAan54mquc/Z0XI1PkIXzAwJIOA=;
        b=vwCS2rS+pYmdg61bP8gDqGFfjdo/PBgT6JVV1eg1zZd9Nr82b0S2clR0RH2K9s8WZb
         lnWNV7aUQhgx6ozlH2TgLTj8ytb3Gbl/BbeMPpAYV9WOz45c2GWctVCc+0N88H5Go1DV
         rD7PN/GFtJgW1ZKKhPcgh/1w3TJCnnxeios0hCtkgXFGbIZ9WiU821qQgiiDf1vvJ6Ck
         dg4ElQes4DdNeBtawrfXt8Py9CeCHaFfZElhvErprQq4g+cVxwUqfhrZuceiB8lvps7e
         evQ7YS8E34ofUmAzfr6OXPU/0Put4HaH/XQyRfpB6Tbwh2n9YjSEjmLbiSHYQZ/AAk7P
         bgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GegTTjbmNjbsX4HChAan54mquc/Z0XI1PkIXzAwJIOA=;
        b=Lue6vej/sbLMLWgvIkhFusTuoGoFl0f530DPItYL0EHPk+iQ2t6rLgazVZbqMdptOp
         b9U7levNgUTC3DI3SxaZttOO9chaaCliB0+P2L6dSO0DcIOYD9zCWSLa0DyqUn/0zgHy
         kOnR9RVZNAunOVUeQvhBCOOYF+iVKCW4qTjSwlGjj5rElRIL64heOSnZ7IA6rZ5+W+/7
         1IuzzEAo3ivduhsKtjAzmV6HWc2ljoZmnFwYdz8lBeOXWNk3xxWG+Fnq7fjpjcJ5ZHWm
         82VghP7diwNayaC1BA74PZxFuWwo/dMcPdeVx8rvEkP6aOL6HZHWuZCSf0pql4PA/SnP
         T09A==
X-Gm-Message-State: AOUpUlF+U7RHe/XHCEgANPyjyRm1HkLKb7JWC3Whuixu6vIskRQOVGkV
        17s89Gyf5h8hQAPcVjf+poN5tA==
X-Google-Smtp-Source: AAOMgpdCs/vJ4E8irRmzR7MSfblRn+1H6Z0RIGz3mXzRBYhElgG2TSHw5K1OwojBrGMLhngHuZnOFQ==
X-Received: by 2002:a1c:a691:: with SMTP id p139-v6mr12041466wme.42.1533573655186;
        Mon, 06 Aug 2018 09:40:55 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id 66-v6sm16385790wmw.34.2018.08.06.09.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:40:54 -0700 (PDT)
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
Subject: [PATCH v5 01/10] arm64: add type casts to untagged_addr macro
Date:   Mon,  6 Aug 2018 18:40:36 +0200
Message-Id: <b3ec523879cca4f08d0a27065cfb5583470cdadb.1533573460.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the untagged_addr macro accept all kinds of address types
(void *, unsigned long, etc.) and allows not to specify type casts in each
place where it is used. This is done by using __typeof__.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fca99c2..2d6451cbaa86 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -102,7 +102,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
  * up with a tagged userland pointer. Clear the tag to get a sane pointer to
  * pass on to access_ok(), for instance.
  */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
+#define untagged_addr(addr)		\
+	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
-- 
2.18.0.597.ga71716f1ad-goog

