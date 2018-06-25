Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6470C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C0326209
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCQ/4bhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C0326209
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeFYWlL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:11 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:35345 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbeFYWlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:06 -0400
Received: by mail-it0-f73.google.com with SMTP id 7-v6so9233916ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=vk4hdGJcBF9byvX9Poax+QR39SxzTgmO3KuPWRuR0HY=;
        b=DCQ/4bhHOw/muiK7kspbA0sjJJTN0BcN+Ji9r9aZtfGBSYGGcI1mbTDxDgl/Cx6QtD
         lf5enph+X71paArPqPPrOyRpfEgIthqBxrd21PXx5MKPeFdUXwYVQ/yQMIWmtCEv7XTR
         yoOeRS2XZW1btZohEAwyX5vl1ns/X1NQZ07I9LcvrJxpJcpffiEpvVKpU1cDvhrfUsZV
         llTX878+DjeJnZ2j/t9cevfJmDyJymQnuMyOXjrW4okB3ydI1j17+RXzPM2Oc6PnS/8b
         je12fxFEbIIYn3SOTaT0DZlOI/cQSX74ve5IboargmNkLhAuv5t38zgUciDB58hW/RrO
         p75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=vk4hdGJcBF9byvX9Poax+QR39SxzTgmO3KuPWRuR0HY=;
        b=O9k3HUyEyzMWmw9Zpheih2q2hRhSMKAcfeLJMWwRZpAtYG3MawsiZ7GusBjwPz+meB
         OY2WVjLlzBzf1NtEFK565N6sleXzu1PiuVgEjtKYUI35l+TICjo57g4encYefvI7maP7
         mulCsvpWYiwaEzJuSQWlETev0hHAwFk3sgzI9oo2BNih2GCMPAO2qamRReojgMhFe4Fq
         6W2i6VXubYP1WJp3S8H9vQTP3p1YMbWWPoXgF/SK67HyOhqIZ8y3FLRW1al1hwYJf4tI
         dlhPdYzgHwEI3xorsC1hClzu/L8j2tAJfZkPOvrhKvH9QINP5ins+6UGbwaAJywEd8rp
         QKPw==
X-Gm-Message-State: APt69E39xphTkAU8FcXoGe9vsOmaBSHNPIfkeBX1PJG01FfgYvF7uIOc
        WdTFhXcIPXbyWV3OmXUMZlh8Xu7/Z1/c0Q==
X-Google-Smtp-Source: AAOMgpftgvjv7WHYbA3wCjtq0TO5TmXCVDqm9p3dREhuzh7oQ62XXf43leUEZZ/ZAo5YX0it3xz9VrMXxranaA==
MIME-Version: 1.0
X-Received: by 2002:a24:424e:: with SMTP id i75-v6mr1205659itb.29.1529966465124;
 Mon, 25 Jun 2018 15:41:05 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:52 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-5-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 04/27] x86: Add macro to get symbol address for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new _ASM_MOVABS macro to fetch a symbol address. It will be used
to replace "_ASM_MOV $<symbol>, %dst" code construct that are not compatible
with PIE.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/asm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faaec51df..4492a35fad69 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -30,6 +30,7 @@
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
 
 #define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_MOVABS	__ASM_SEL(movl, movabsq)
 #define _ASM_INC	__ASM_SIZE(inc)
 #define _ASM_DEC	__ASM_SIZE(dec)
 #define _ASM_ADD	__ASM_SIZE(add)
-- 
2.18.0.rc2.346.g013aa6912e-goog

