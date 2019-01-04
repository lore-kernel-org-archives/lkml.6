Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A891FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70047205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJdZL6kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfADHUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:20:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44942 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:20:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so17044335plt.11;
        Thu, 03 Jan 2019 23:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=in93+ZbO83mU26scLNYjtEZ+QGioI7fVcWjhWTbx6fI=;
        b=WJdZL6kVZMkjXkyiHQgbIFJLzySsAq7Dd5TjsZtQVxY486COz8AdP/UlWVAJUcKNIk
         MZZrBRCAjmxAx9PDWbMDz3efx9h36P4SDqQBvwaUN83LBEknGmjYYm+EhrFbEhqh8UM/
         4FgAEyxoMoBYs5KUU7BzshwHNH43fRsUY+jONAc1og7EXWstYgF5uUUbVjLUZSn6U3lm
         TpVrb/q4aKXIwOmEk9xFby9Vlf+CTpzhhRSPedlJ93dYjDTEjFGVV+713Pn/LsgdOO2S
         B6ClGwJ38QXkx5JWHytUWHrC5y/Ph0QlP+BYe8lNQrap0kpKpcwH+ut509WwSpCPyzO1
         RDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=in93+ZbO83mU26scLNYjtEZ+QGioI7fVcWjhWTbx6fI=;
        b=i5yJELFbYnmoKqiP5+pD0BKU+QZ2tLJ2fTuxhFS/ru+BYcOo+Q0puZSaArJnRmrHF7
         yeuhDsPR3p79QidvQ5wPfXxSM/JjssprY0HBRVMR5vsg6FUFzUEWT+7fLHJkWKR7pNKU
         Y5SQ3t+/Ex2xYSl71fNLBZ7ZhggGribDR+IQ6sFydN4Ac5XNW8en/8iMnHONwpxRWVur
         eD+qbe/h+TDWI2+d/yvj2Hm9glatJTOGKlSxBX3t0cVDVX8PChypXPyiacs/Nk4oG2ti
         CtwCluR2tlctD1dQqH1xqywjq0CxyllmAq/4PBhIQEUP4+3xnBJwxpwkCH+7SYxYXCXr
         AK9g==
X-Gm-Message-State: AJcUukdY7lMXMGdzksGcNR5CpiskJl0PExd97Jrh8rBDeZ6D3xRcN3Ml
        eqfavw4OedHER92qpXlGCDA=
X-Google-Smtp-Source: ALg8bN54isRcp86dR3guXw+6f9C5rEzpsY37W2YBPpVkTM6GFfUU6dCqzpJwD8K061LdZ8HUyaoraw==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr49445598plo.96.1546586452482;
        Thu, 03 Jan 2019 23:20:52 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id 83sm98588764pgf.57.2019.01.03.23.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 23:20:51 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM/VMX: Avoid return error when flush tlb successfully in the hv_remote_flush_tlb_with_range()
Date:   Fri,  4 Jan 2019 15:20:44 +0800
Message-Id: <20190104072044.1800-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The "ret" is initialized to be ENOTSUPP. The return value of
__hv_remote_flush_tlb_with_range() will be Or with "ret" when ept
table potiners are mismatched. This will cause return ENOTSUPP even if
flush tlb successfully. This patch is to fix the issue and set
"ret" to 0.

Fix: a5c214da("KVM/VMX: Change hv flush logic when ept tables are mismatched.")
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 59b98c76028d..384f4782afba 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -467,7 +467,7 @@ static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
 		struct kvm_tlb_range *range)
 {
 	struct kvm_vcpu *vcpu;
-	int ret = -ENOTSUPP, i;
+	int ret = 0, i;
 
 	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 
-- 
2.14.4

