Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A12F26245
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5qMXypd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A12F26245
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeFYWs1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:48:27 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:39278 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbeFYWlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:01 -0400
Received: by mail-it0-f73.google.com with SMTP id o7-v6so9191582itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=k64qpDQWoxqYXhctTCfAYQx6Gdl1qzC7yPWOjOPOVJY=;
        b=P5qMXypdbngYS/RnDB8D4hzLx9UbIhEe1XEuRdvO6NvZEsh1HNUol+M35decdWXYrs
         5gJE4ol9giVxngYsHrMT5V0BFEEJFqke6nyB6mGaU09DFT4tT9qlBgbNa6dcnq6pmjMM
         QSCkfWWrEtOPh6Zaj5LJma5K80VQNKN9eDIQ3lxH6j1k+SZsArFd2oWspYvlDg8Ry5Cf
         zg0acyOPhNa66uzPExAWK+Znqbgnu/c1YV/ySGKuHeWuOfWxkYXbm2dFaaA8UsxgVm7E
         zUOIgQAnLipl+ug+tBg7Pv7JF1VPdgrwn2rS1z1f+H80oEUQQ9t0sbIDcM8lERhE0DVW
         lnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=k64qpDQWoxqYXhctTCfAYQx6Gdl1qzC7yPWOjOPOVJY=;
        b=HBtRzkPcy/TFtzdC/55DB4p9nwNd/N8nhb2UGma4uMutqpvjNBPh2Pa8NUDnw01gnn
         4SkSm6d/jIoQqWXGTnSgYy71ZbOiSRVU8C4xB2oJu07az28MqCyB7cyuTSJCV/ecsfh0
         XewHsiGkqZtTMQ2KWr32uEAWr/LTnwTb1RSz3RgnWKKdixFnqLo6xzO7Wl+AzU2AZhX4
         KdWBjH/Rpc1gc+H3PIekJfS3H5mxlu3LMSSPUhpsnLJhNKlJp4a2e8sZWyC9OWDbpJ0b
         3wouxnwlbUBdOVCc/b/VAFUekI8+kDEkRlr4qy0vcEcrFxIcGw3cn7FyCvHMYtvSIm31
         hOwQ==
X-Gm-Message-State: APt69E2VCgJzWfi+vwgxY90Aip2tLhuH4JIU8vYy2BBoIRks5GS6LBs3
        i9H3gtsCoOkFtIgLOma4fRqm7T0nbWzx2A==
X-Google-Smtp-Source: AAOMgpfB3hq193GzaZUZSz0CnJ4gWsBK7SzjKke8rf14Sop8IgvMK1bj/2EXWel0PE8fWLPjBGw6EH77Q/Dfuw==
MIME-Version: 1.0
X-Received: by 2002:a24:5dd4:: with SMTP id w203-v6mr1226821ita.27.1529966461160;
 Mon, 25 Jun 2018 15:41:01 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:51 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-4-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 03/27] x86: Use symbol name in jump table for PIE support
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

Replace the %c constraint with %P. The %c is incompatible with PIE
because it implies an immediate value whereas %P reference a symbol.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/jump_label.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..dfdcdc39604a 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -37,9 +37,9 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		_ASM_PTR "1b, %l[l_yes], %P0 \n\t"
 		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+		: :  "X" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
 l_yes:
@@ -53,9 +53,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		_ASM_PTR "1b, %l[l_yes], %P0 \n\t"
 		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+		: :  "X" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
 l_yes:
-- 
2.18.0.rc2.346.g013aa6912e-goog

