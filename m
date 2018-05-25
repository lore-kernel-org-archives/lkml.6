Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4125545-1527268982-2-13282648702521271117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527268982; b=dMBigt8mryofePjymEuJE/KO/vrXJyMnHCO/MzhWcbqCISlkN6
    80tZiWGRMRpe4TRBH9pHpwUJy8nzIeoUBCopt+UatwS91TXM282AmXw02g9n1PCv
    xpmrPzIpHEQwoOeryb+taCDCfkF6a7idwkVLDeAYQ1vAXYM0YWjw1wBn0UN+gocw
    Ki5+LBnqPLM+Y0iUoIisogOi0Ll0Y4AVRms0sDI9VJPYmTajrG1QZfH2eAc98hf5
    OUZXGKu3s95RyWVjV1aAAVUCXg0JYqVLnvU81qOZx/KDdm66ZYZ71mXzFRVSk+ex
    9IXgdnFQzlfUgQODJfkviPVIIehWISvuUlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527268982; bh=
    lILut2XwFIpu+wyBXiRPzyeQQvgUlNIl5NNAqzVkiro=; b=m0W/aKc/uBqfFBbK
    hS5D63UPKrpkSM+55NYB6kc/meFM/OPGD1nFGsk7AaL6vvHo6ZvwSuel0v1K/VZ/
    yQ/XL9xIz4SojbHUBLzSNVau7ZzQOzyqpAbltZXp5LNSQX+vZZRsc4BSQWhngB/s
    5hNvDcERBhfrkZI0du6FykWhyK39da8QD3z1TYizHZS39ND79wXSH9iNSTh0Qy47
    a+HPsQRrxvafiaG9LAUJwsGLteGdZ2X2T9Y9hXkHQUgpvQ2tm1Vr2v85TCoFELCg
    DhoAjVOnC2MBKbZ7EPS77mKQYK+EKW4CJCYBwJ1ohrTHj98XZRvAr66mLmI+7pQN
    ra3g+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=bxIlA/zE x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=dNUUuw44;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=bxIlA/zE x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=dNUUuw44;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA8Ki6v/6Wb0wRsxV8FIdTvXigpvUja+TffUvpRVeiAz4xjClLkitgPemdFVRULtmPUhv0ZIaKNMMdmEut+IdDEe+8eN+BeWvVKFzVVOZTbuVMZCu3r9
    6FZ1XSJvJPq+rOS1ajkMYt61e+BK9om+tmzAHrz+GZS5MfLtAw+netIIJps8czGCzUU9u92CbC++x06/7pFT5nArd+Q424absqD3K7iCNaA+UxTbgxjHYV7h
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=dzDzyOxCJpUTUqJDoQQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967666AbeEYRW7 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 13:22:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38672 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbeEYRVW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2018 13:21:22 -0400
X-Google-Smtp-Source: AB8JxZoNyGldGXQkycJ5mcoEPhF9vnulrogiFTAP4ZCnDO2Pj/NdNxHxwUAovLOaOe9xqtcrTu6nAw==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v3 1/6] arm64: add type casts to untagged_addr macro
Date: Fri, 25 May 2018 19:21:11 +0200
Message-Id: <3207c33dfa90a225b57121041d425b21ec142f62.1527268727.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <cover.1527268727.git.andreyknvl@google.com>
References: <cover.1527268727.git.andreyknvl@google.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
2.17.0.921.gf22659ad46-goog
