Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC45C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4CB2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+wpn7aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4CB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeH3PnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40102 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeH3PnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so1658614wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83X0Ly3GNFYkIBH/BFHbUkVhejW7zXmTm47ETsZa+AI=;
        b=K+wpn7aJOFLmPZBtmJEtbDEIz8wwRyqKm90YcGp+HMvxjAN9pVZ9cCtV/gejD6CHx8
         CCRwiS6KNOavKWrpApClDZVkUNnM1PpPI0sPj53nn54bQD/sBRG7JsNHHoX4PU66BtJs
         sWQPtl9p71g3J5ENln6J0XiGFBCetgKOUOzChKveAkosXimFhJVQQlzelgwZoNQSSMrk
         bcDUcVPQoIRyS/FnXWMTu46L+C5BZMmJ8YmSSpruskuUgtBE+n6hxzvCGEZKPoQmzw5o
         IloxmtP6GY49QXdlXgn3aXUqKYfzJKfo4M4OVXaCo+jBOHmqanbdshjSYmo4j7v976ox
         Mgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83X0Ly3GNFYkIBH/BFHbUkVhejW7zXmTm47ETsZa+AI=;
        b=RGZ9yiMXsoQwSOtox2eFzl/oFio5VyPsTyMeyNFYCOJQMwBcUJ9/Y4ZmKTsLIKuCva
         by2uSFP28197tJF9YfzL7/X2K0Ey/dWilM+08hNUSqFM3CvIqu8bgckJs/QNonoN2H6I
         qgPDN0aByxUOn6qoPxiPQ2RM+QWeJT5GJViR/Wy0ndhe8xkxj1hK2JeVhnPa02sybTQa
         lxCzah3vY/4nu8TYx/tcJHrZITsyNHbCoSvF4rV/LcfXuTEj/1O9DXhSFW841VGQEx7v
         /FXOgnJ+CByVsnFBX0MaxkOehIQni2R+u5vPMTkrdBBHPHZ9MfQnwJzl3HnsnjJPkqPR
         V9QA==
X-Gm-Message-State: APzg51Cc3q0Kr7QplP/ip8clQ4iCBe6IJf8yk62XeQOLN8kzCZBn9287
        dC2SuIupLsrwGNsdKgTLOC5gfQ==
X-Google-Smtp-Source: ANB0VdblrnnClBYraLmPvStLXRnR3nCTmyxCJTD1zNjyPyVzvdcT/vtJe4+4mlXiStIG6mJaA/B2LQ==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr1596295wme.70.1535629282357;
        Thu, 30 Aug 2018 04:41:22 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:21 -0700 (PDT)
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
Subject: [PATCH v6 01/11] arm64: add type casts to untagged_addr macro
Date:   Thu, 30 Aug 2018 13:41:06 +0200
Message-Id: <fb5fa982f99419a3099031cf20ddb9957e627886.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
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
2.19.0.rc0.228.g281dcd1b4d0-goog

