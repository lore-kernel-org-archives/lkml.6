Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDD0C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B5820989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U56Xs3AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B5820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeLFHez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:34:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45382 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbeLFHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:34:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so11346742pfd.12;
        Wed, 05 Dec 2018 23:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KeUI7p8v5yfWvHehp5ot1Y8paMaTzOKHfaUhlRjkC70=;
        b=U56Xs3ALHhn4bCRVPvKCuzjcxf31hqcBfPz4bxbopmrW6x8BYj+r7bPr70zAqNPTmA
         2/YQX7tyzVcR7ZCDZDFxxeo7L8KDjseyCd9WlzFhedImjTzK86KTBJDkiSukIxoute5B
         XjfDcIsZAPzK8v9bGzmyN4RJSlOkMueInslNM5b5J/cQD3D4Vy23sRAOa8FkaA/160lX
         4irb6h49XeT+6A6AWFyPdT9FBiZlwAg1laT2UF/CjSgBhneET9ODgdKy9Nx6zkAkTTLO
         gT2q1VBLPewiKIOx2coO1bRj+XpTI2YywedtUhZtW/Ap4RsT6Vgbk4woLJMwl3G84kEu
         vuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KeUI7p8v5yfWvHehp5ot1Y8paMaTzOKHfaUhlRjkC70=;
        b=ssft8NiBxhKbTvu+OD5/q1VpYim+LeZ7OCYEUEQNKscJVNM4+GY9mMcTs//ygS/lTb
         bn9YCX/Hpnufbmmr+wglPaVhM7pnt+0hE5J3p247pqxTCTLHROHkmBvOA/kNnb4TljRQ
         0dPrdPlQ/o1AniZpNYuydRvh8npyWKsVDunFuz7PlogQag5bvNFCReOrkRLjX9uhitMP
         8Myg7Fk+kgIPQjnOqwZ6MG5Z5UpiaIXYnauqog84x3Gf8hCGjC4vaQYZiHepD7gVHIbR
         wKbyAqqqK0yYAN3IQ1ds7f6CqIwj5ooIxnzFtBIA8oCW94e8Fe7/b3wMPnXBt3e1azdh
         nGMA==
X-Gm-Message-State: AA+aEWaa/bF5d0feX1WeloSRxbSdPv9PMDA69eYjeZ2dTtEbxJnu7LpX
        cjglLpoGSOBNqhJvOsWzoh4=
X-Google-Smtp-Source: AFSGD/X8t/jRZiBv7nwKWrYJVBYTDH54PvA2J7PC3wVyFpS84Pbk6wYwQR+HyGB/4nF3HetqA1lzIQ==
X-Received: by 2002:a62:c683:: with SMTP id x3mr26936107pfk.10.1544081693306;
        Wed, 05 Dec 2018 23:34:53 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id x3sm70418768pgt.45.2018.12.05.23.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:34:52 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V2 2/2] KVM/VMX: Fix max line length problem in the vmx_hv_remote_flush_tlb()
Date:   Thu,  6 Dec 2018 15:34:37 +0800
Message-Id: <20181206073437.1995-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206073437.1995-1-Tianyu.Lan@microsoft.com>
References: <20181206073437.1995-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Fix max line length problem.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6577ec8cbb0f..2356118ea440 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1596,7 +1596,7 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 		}
 	} else {
 		ret = hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
+			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
 	}
 
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
-- 
2.14.4

