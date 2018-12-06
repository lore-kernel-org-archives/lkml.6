Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2626C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681CC20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlnp9BJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681CC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeLFNVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:21:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44105 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbeLFNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:21:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so158059pls.11;
        Thu, 06 Dec 2018 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
        b=Tlnp9BJSUa7XFAwwW+GKNzzbXZKtZmfeo/5Fv/ovAsoFzIKqIjwypNVHiyd8+gfLPH
         Fb7gxuUGSIyjYPawgXDGQLme/G7CS1zch9eFiaKR3eqZzxwNMw+mwvBmpkEFO9fyaneg
         OiKaViiD9vXZiBlOie/V6BWRbKxML36lqpoJ8ecYC07oRzZlgbr0wxuh+KVfLrzla7TL
         fEFs607cmdp+xLpu/F3LiyEdN90SStH2c2b+HVYB1kjqezE+VFYvSrdpdsrMXhdyP129
         WKMGcGUEquPFViD0K0PBC7PYykx4TcQ+5CHmO8cT1Nn4YOBv4JJuWfOvwvS6lzwOiB+m
         /kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
        b=QAXxUeBtu5parFRuy99hMejHipDoWPotYhnFwChvEUCFpT6kdxwpcO1vEWD5HnpAKe
         Z+/bZ0OJDQkQIXGnZVnP/rGtQRsQcTkEpzfoMBlmwTolvyFUgcGMagZb/YOjby/NiXM1
         ecPXvx++4y/c1h/KbGdWTw7UvgJk6D4G9sB2klwPfJSz8M+EwDPPCMy/FGaT+n59H1Jp
         suKOiWe4wfTYm43qLqP+M3ZM9sDmxIuywAQXXAA7IWeV/IyUbb25t4soWYqYN52ep+gb
         vB7PbxnX9PKaNiMgKYg/+JWaqeqDxNgeNdZUVOwbbzHvghLrsOQ8oNf/4jF+X1I52fMm
         /cWA==
X-Gm-Message-State: AA+aEWaaErPc3lnAY/u3ya1eNwzwLQc00Pzu+rgLXJpm5FwINmMWTDd0
        jSrIXo7JyWEKFo5Etme3yrE=
X-Google-Smtp-Source: AFSGD/UK1m2QlD/ekJ26senJEbu6Pb+HfQlL4cpRyq7HPE9fC51Z5WuWvOTYycdw7BrwYcyq06rLUg==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr28951899plb.335.1544102511104;
        Thu, 06 Dec 2018 05:21:51 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 05:21:50 -0800 (PST)
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
Date:   Thu,  6 Dec 2018 21:21:06 +0800
Message-Id: <20181206132113.2691-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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

