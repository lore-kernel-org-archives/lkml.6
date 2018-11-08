Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86659ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5682081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkmqcX8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5682081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeKIAW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:22:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34557 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeKIAW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:22:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id y18-v6so7003517pfn.1;
        Thu, 08 Nov 2018 06:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
        b=JkmqcX8KZyNmO2n/uztZnRJdiSbewzm6GMv+1vFxX95JSFDLt6x5HLz2EN/e9Jpfmu
         iZCMGCe2weJQ8H4YFeusZ8Do9hmfAC+UeDCoic0wET0nGXs8cJlME4+p99owc0G1aqDD
         1P2sgBBSp7WHPXj5mpHc+lGT1W85JqqIdDwduXIFiWhvXc6Ep3aJd5wlUkc0XtDhY74Z
         0FJxfXdKSCYLU1Yuzj2Xx5IdQs5XMqd4yUXztSijafQQyyelKZbPiq+NBNv8N9yKp2F9
         2DN+4Y5h/H3PLmrEzP1dh2/JCSomFThLksiKIUDaU87jTX0fcrlJ4lQ+uy/R2SY11J+J
         Iy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
        b=mhqAjGiVr4j/4R3Py2aUZiWmsUcKg4fBXFOw9qG+LMLrVsD+XcGRHtP9IBpoZXkQDO
         3m3Q/j2YhnmGB/dhICA5Q6MZHna7yWrjDqV9i6YNntXvGA5ekji4cLET9FmFs5iDo3bM
         5KmJIVKQB+3I2XlSjAISgrM4wBVQjZByn4cif1g0ldx6CbDxI+eSPCfEcGQeiQ2jKfjJ
         9c9WPdtC970D6DnYObtIqrPG2Rz5vVbcEhLTfDHhfpeZa65mRB1xPQghQGTrjcl0n4MS
         dYsx6BrFqXbrTDa0rXq5gSIdMWLVJsao4GF3Slj2ScZ/omMgZ7qILlJwm8uqPrB/9qc2
         S/nw==
X-Gm-Message-State: AGRZ1gIzJ28ixkwyPch5ZL+0HmuUv0yLT4sqKt6bttASOHYys3cFOjlg
        YU/ccZPF3EAseVU3MxmSqRY=
X-Google-Smtp-Source: AJdET5fbrIVBuJI6Qp4ZjmIMOIFNQb21T3aRd5oUOxuTC+6IplUmqnGeqIy8/K/AJagGlPJnaalnxg==
X-Received: by 2002:a63:4926:: with SMTP id w38mr3857439pga.353.1541688427616;
        Thu, 08 Nov 2018 06:47:07 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:07 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [Resend PATCH V5 3/10] x86/Hyper-v: Add trace in the hyperv_nested_flush_guest_mapping_range()
Date:   Thu,  8 Nov 2018 22:46:32 +0800
Message-Id: <20181108144639.11206-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
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
index 3d0f31e46954..dd0a843f766d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -130,6 +130,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
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

