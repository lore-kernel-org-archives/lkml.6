Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D78C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1A720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gls6f17i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1A720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeLJMvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:51:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40619 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeLJMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:51:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so11057235wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGAUj6PSqqPDQJ5J6R6pKlBVa6bTvYS48OkmKh4Sulk=;
        b=gls6f17iFdY+aaMHKZj2c6iqSD/1QrF4roruo3c5l5rPA1aVvvzHjI2CFqg/lmlOS5
         QV5WzVIcjFGeG5EZOAQBUSLUhKGejG5O9B8bsP3m0ZDDbDXlypr860QwpgdjRFT3VtOy
         XxeDJnbsSvMDNeVg7Zd3WWKgfoYfCaUgEKOfQw5HnKoHFqbh4YmdPnz+wYY39XjVd+O7
         nOiFe7/AFJYVdSf7VYpOu//HoHkRLNS028ysC6yapgWia3lzb7Jo2WuChJRuNCDkW4mV
         cPqpApKuM6RsIoZYmQ0wgoKMKNyLL+EL+mT4Ax0maE+25TL9RSBHw3MXHz8+SN4ZTCt0
         F53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGAUj6PSqqPDQJ5J6R6pKlBVa6bTvYS48OkmKh4Sulk=;
        b=NV9oTCBTXIE+E7W+SKeHbnEww2KEz4GoxMRL3q252ZtnuqZxRz5azxpHyCIsygR43j
         80n3ryitjIgWFZA2eMUqVw1ZywSXJzepqFrETX8DucI2myThNVFwFkjvTDnRrk3rlfnN
         jFHCj1FfGbHhgaxDaj2062Qcu+gwQpSgDS99+aOD7xoqYFNpR1GPmRGCkfASJYid2cRo
         s4jYrkGJdc4XHOaZ9BXrpvKJtbFXI894LfNlggAz5OENx2r/uxdnqrOXnz5Qr8ZlxkcX
         l0l6sVmzuN05aAm2+xyNcBXFA/TmOd5FKmFtN8QmUCEJUWx+2aiW88CTFBm3fvy/cNY2
         Ruyw==
X-Gm-Message-State: AA+aEWZKBbvMuXyAEHDSdtPVLWlaPtxTmTffoh9zCy5y8ERc1hx+BCSB
        OL5jp6NT6uHpu3pbyzpCACKM9g==
X-Google-Smtp-Source: AFSGD/Wfd26kZrXesEpia2lo9KfLrUJNSZ6LeKcsVzx9h0ZIx3ectSG+FrTDJ+dLbEuGhtbGIsbJVQ==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr10123577wmj.138.1544446271115;
        Mon, 10 Dec 2018 04:51:11 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:51:09 -0800 (PST)
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
Subject: [PATCH v9 1/8] arm64: add type casts to untagged_addr macro
Date:   Mon, 10 Dec 2018 13:50:58 +0100
Message-Id: <07836d7852b5c2d9588e28e4081a6f783689377c.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the untagged_addr macro accept all kinds of address types
(void *, unsigned long, etc.) and allows not to specify type casts in each
place where it is used. This is done by using __typeof__.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07c34087bd5e..3c3864ba3cc1 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -101,7 +101,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
  * up with a tagged userland pointer. Clear the tag to get a sane pointer to
  * pass on to access_ok(), for instance.
  */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
+#define untagged_addr(addr)		\
+	((__typeof__(addr))sign_extend64((u64)(addr), 55))
 
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
-- 
2.20.0.rc2.403.gdbc3b29805-goog

