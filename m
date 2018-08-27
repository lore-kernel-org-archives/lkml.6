Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1C9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E12D208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+KQg1Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E12D208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH1B2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:28:50 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:56976 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1B2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:28:50 -0400
Received: by mail-vk0-f73.google.com with SMTP id s204-v6so183836vke.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qV3JoGz61p0sQ6oiJTV390o0vCa2imhWYbmiuJG+A7w=;
        b=q+KQg1Bb80iaJCCeaiM4fh8lw0JD6TuBoimns5twdHsntnhROdVL7eKYjycGqDMWuj
         pKEdBfHFaD/GfN4UZo5V1ojayR65fDTJ3/BfRTtn911Ly6yPpGC7OSxUzZVMRCyqgqGa
         tDUQSPhmom0C8n7NX4p5MWZpFvYgw19O5c5hXTSCrQQN+yLSbhV459FAo1sfocTBWAiw
         5ifZG3TuQWbCHcnWTY81Etlvqzp4t3OM9mlXIxhyUeZ2oi03yeeVhS+KPsZFPeGavH7l
         /6Wz3IyjBhGJihVS7iqEGgHZiihPJ9GOj9W+AUpsB8YOniiwWQ/JN6jX+0PG9Hyv5m9k
         5HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qV3JoGz61p0sQ6oiJTV390o0vCa2imhWYbmiuJG+A7w=;
        b=tB5jJ4h9lYNrdLpunLCskBLXfc+aXiD/+VakgG1bKwqd98CnO0odkwHJi1Ok3MiAlL
         gUfV5PJrmta4ttzAPaIa0ef4LGDJutz+h7km6seyP3U+WOLWyih0VDGMVrAw4UUWM7so
         DE+kRwasopxP/LETjRy+tkgluEpLKdx7FAym16P6MQbhq8Vqf3jVAEeyTz7VCWkZG7Ll
         Gj26lrPs1mgFuLhE7u2vHohTnKH2w9DcJOXgG7I9SQKPetlJH+1wJTwf2Tbr8aqkVA7p
         oPiNRV85CfF+bVy8/Nr8KN5xCRJA1vFcRvRHEpwjYXFnAmG2iDeK5lK+y71qGsXRlutz
         1HPQ==
X-Gm-Message-State: APzg51DlZ4SE8me9fTnVtYkL/hXrk2Lgwy5Bp0oJitQoDipViz9gcuYM
        8VvH76ITB/vIt/l+/3OBzqG82HWsLW9ouDAF4Eo=
X-Google-Smtp-Source: ANB0VdYq79DrbR0+mWmHQ6ERURXwXhez6E+rmtNS9MQGTLNGuIy7RN48SHzakPBmuVn1ZdDu4tUd9nLfW/V4Vzan4ho=
X-Received: by 2002:a1f:8694:: with SMTP id i142-v6mr319273vkd.34.1535406023317;
 Mon, 27 Aug 2018 14:40:23 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:40:09 -0700
Message-Id: <20180827214011.55428-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH] x86/irqflags: mark native_restore_fl extern inline
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes commit 208cbb325589 ("x86/irqflags: Provide a declaration for
native_save_fl")

This should have been marked extern inline in order to pick up the out
of line definition in arch/x86/kernel/irqflags.S.

Cc: stable@vger.kernel.org # 4.18, 4.14, 4.9, 4.4
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/irqflags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c14f2a74b2be..15450a675031 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -33,7 +33,8 @@ extern inline unsigned long native_save_fl(void)
 	return flags;
 }
 
-static inline void native_restore_fl(unsigned long flags)
+extern inline void native_restore_fl(unsigned long flags);
+extern inline void native_restore_fl(unsigned long flags)
 {
 	asm volatile("push %0 ; popf"
 		     : /* no output */
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

