Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F863C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5739A2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIAOJZ8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5739A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJMWdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:33:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJMWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:33:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so7180781pge.0;
        Sat, 13 Oct 2018 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edYmQmptl6FFGWDz2Nvl8dA2M4x32rlDzx++JvAzsf0=;
        b=uIAOJZ8NzyM0649O/t33OHU4s/dcTKtUTpcQLxDGeDQrx0ejP7RLn3TdxlOlcthasd
         yOa70X6VW0G17Dy72OvF0eOwQbnhM6Yu7wiCHSNS6jbFhngOJvdHL4dJWzpZ+cLxSOV0
         5/MT8gm0Uwn+htZ/Fyf5ooOPmvIZ5l8EyqA12R96Qtop/zbM/jKGTuj/z8pLKYJ22xmV
         DKOkToGi3emeGpFowqiroOBQVs0BQp0R0rWdXZgOrlwrXufCg1Qlb0cTAvwDZWMPsMyE
         hXuGRM1axytA9EcKwyN/rlnTIEDKMe8PEozm8WjAKftPWEr62Ix5mPXSyc9AsD3+jN/q
         mTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edYmQmptl6FFGWDz2Nvl8dA2M4x32rlDzx++JvAzsf0=;
        b=BpLuh47SeSStFo3XTW0YubfyWGjNh/7nu7Dk/d8HUZNZuATzL+fuWoq8FLU/SRO9SB
         05fy99OCHJzvjX9rXjDqn1V7a/f9a9oDsRVLExuP+GD3oH4AE7K+nk0zY0HDIcm4hAzx
         2j7D3nBTtUhvoIX2AKWDmxup5RycthJisBabF7+RUxIIj47oMOQpj3KT9fHNwINv+OBO
         AvDpZ/ZGRXNS219rpI1VMWyqfFttUe6eXDhBb6X4wbrCDPLBFsENdU4jfeMgVYpxD3Ou
         Pb81OwVbgD764jr93UP1L5jt+kA7GKqh8qlFdJRp4VP3s4xrdqAUHM+lK+JStkwoJQZL
         POmg==
X-Gm-Message-State: ABuFfojS0FRCTs1DqZDMko7yTLKed4EPBDWzpSUEbOuSUC8aAiTIpHke
        GQsmu3BsH8J9wPuAlJWjiL0=
X-Google-Smtp-Source: ACcGV638Om/Wez6O/eiw9a//a9MxRdrL+QZHotA6bRU7swiBWgU4GbcvKWmMWtR7zyyHb0Vto4LSfQ==
X-Received: by 2002:a63:65c7:: with SMTP id z190-v6mr9572294pgb.146.1539442535625;
        Sat, 13 Oct 2018 07:55:35 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:35 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 13/15] x86/Hyper-v: Add trace in the hyperv_nested_flush_guest_mapping_range()
Date:   Sat, 13 Oct 2018 22:54:04 +0800
Message-Id: <20181013145406.4911-14-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to trace log in the hyperv_nested_flush_
guest_mapping_range().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c            |  1 +
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index a6fdfec63c7d..4850c74508f3 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -135,6 +135,7 @@ int hyperv_flush_guest_mapping_range(u64 as, struct hyperv_tlb_range *range)
 	else
 		ret = status;
 fault:
+	trace_hyperv_nested_flush_guest_mapping_range(as, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 2e6245a023ef..ace464f09681 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -42,6 +42,20 @@ TRACE_EVENT(hyperv_nested_flush_guest_mapping,
 	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
 	);
 
+TRACE_EVENT(hyperv_nested_flush_guest_mapping_range,
+	    TP_PROTO(u64 as, int ret),
+	    TP_ARGS(as, ret),
+
+	    TP_STRUCT__entry(
+		    __field(u64, as)
+		    __field(int, ret)
+		    ),
+	    TP_fast_assign(__entry->as = as;
+			   __entry->ret = ret;
+		    ),
+	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
+	);
+
 TRACE_EVENT(hyperv_send_ipi_mask,
 	    TP_PROTO(const struct cpumask *cpus,
 		     int vector),
-- 
2.14.4

