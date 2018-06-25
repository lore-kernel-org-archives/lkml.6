Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A496C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EBB2620A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwlBoU3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EBB2620A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933962AbeFYWlV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:21 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:49609 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbeFYWlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:17 -0400
Received: by mail-qt0-f201.google.com with SMTP id c4-v6so14400754qtp.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=v6b72n2f2EAxkRCYn4/780M6Y/KmmSRu7vq7OG4VW7I=;
        b=mwlBoU3LYQoY9/73Pz7zpswHUyS5t6Sh1bRUMlcepYrC3v/THRagCEucKD78arZqYq
         uFJJjFTNOM0GBVmAEx30oLeb8sV//xZA9agdkh0/dk6wnTp+Xj7o1oeCGA2HWuDP/DH7
         tG+gQb2G/71sWz2i9Ta3m3HMPdlt+8asrhF9wyM1kr9rWvabcMaBtG8KAJbK2yGEe+3F
         2qKL5nimS9eUnk3tnGQGwwxf6PqDVLQ9f4oP6wTxDb3wCkbgYE3N/s+6Vl/4lQPG7fFw
         fjqBHNrl2akOn9VKwkk4QiwhvW0ugoE9YNm7tT37Y7g2sQ5OykCa11KZe3tZW5dSp20h
         +yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=v6b72n2f2EAxkRCYn4/780M6Y/KmmSRu7vq7OG4VW7I=;
        b=Zd2eMfWdMRrV4LdUUcK9pkGhBVYHktRJdNs50Awdwtohz9GOw5Sg/YMLniARJwoold
         E8vtvKTB4i3MqlythY+2Kl8iSScOOiNvBe1MPSemG3TjIJkkLstN3069cuEsxAh0TusL
         /kcJkRfuEaSs53LhUQQygaW/iGV9OqoWEwrzRozuQK/mbgm66jds87GuJtSJI6G59SMC
         BspwEK3xClM2+PtKRKl/7GHAlmeg7QuyTP+GAIqjimjsU0ld0uS6F+XC66P822z+Hn1Y
         +4a3AvL8L3Kkln9Ca1hzPWYZyVO9zViwkFPyCWrG6XoXKobFL6Cjv/MGuw5jNcO2iT6v
         gNuA==
X-Gm-Message-State: APt69E16CstF7pAg1kVTj3xZa2dWITxyWz268m6CkTc4BHqP9MdR+ka5
        3XmZGlcPhqc1mKmz573EXjhjPferS7vItQ==
X-Google-Smtp-Source: AAOMgpfYYA5EAez9c/nNR8r7eO8Ap6JP/Uqeen0/fnjzKbo5jCkC6qLY9BrS1uKv0tnnQQiD6+OUQPzZI69hzQ==
MIME-Version: 1.0
X-Received: by 2002:a0c:f94a:: with SMTP id i10-v6mr8204013qvo.4.1529966476283;
 Mon, 25 Jun 2018 15:41:16 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:55 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-8-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 07/27] x86: pm-trace - Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change assembly to use the new _ASM_MOVABS macro instead of _ASM_MOV for
the assembly to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/pm-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..972070806ce9 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -8,7 +8,7 @@
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
-		asm volatile(_ASM_MOV " $1f,%0\n"		\
+		asm volatile(_ASM_MOVABS " $1f,%0\n"		\
 			     ".section .tracedata,\"a\"\n"	\
 			     "1:\t.word %c1\n\t"		\
 			     _ASM_PTR " %c2\n"			\
-- 
2.18.0.rc2.346.g013aa6912e-goog

