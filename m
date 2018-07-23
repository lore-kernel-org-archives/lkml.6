Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E71CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E800820858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWKXLpzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E800820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbeGWHjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:39:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33385 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387838AbeGWHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:39:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so7847289plb.0;
        Sun, 22 Jul 2018 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=WWKXLpzW2P8TJVzw+otdmQn7P/POYpDTSaOxqd1lOvJZvXCw56vqNueJxqaLU2MlQS
         B+GTQdye6nOAYPUTaZFtfJ/JOIazrA3r0oXbnKo2ayAfMRrfVq4e+R+HHl6wkF3Z7jZm
         3MKGmDliYma0AcoZ2/FwdQpOgVOQ1Lcb49wFjJQQECOdO3a5AuGY0zP9NKQGOh0mRopG
         flWgggcbsaUnw9WHUl2Np2i+8cMe1M7uP1avl0+ZplUNQXuhNKc5kZEWWzMtb4FyRjXF
         stec2ldwC9zhn4a43uin7RucJ4VAXdwXQEiN2u150XeZ9f4orYy+0Pias9VeTPhWaHsj
         yUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=D2EI7xnhdFOYJJLp8fWpaozQdJlrd/fawrUssQAbLIpR31rdaOFQRBQJmlDZ/+8uUq
         LlyS/EOYfYbY7po6ZyRUn4E5Kjhkrwq+SHz2G54aE/RhDUBbMrJTqKCdiH3vQh7QF/h4
         USUndplZDN1ABbdbiFJsoBVGX1VAHRynKU7JpkN8TutU9pcHtOficItsXY8kh1upnLpH
         ZwBxyMJB3WeSnug5V8G9g6hoSLGU6RZCUjK7sW9VzYJ9Yg2oIyrNEq8XsJw0vreMj+HR
         OevGelT3Um9ANvMocSxLoXcHQW5K1WKXVO1DfXi+F9cd/NwiCnKbH4cVnUd1Z6z6YeHq
         Mo4Q==
X-Gm-Message-State: AOUpUlEFxxpU72OuXzJw3QPmyiq7HpKmNOG1Z52R0jRKE4qw915EEqZW
        TIeYCwnAW1B6Hufiyczzy7CYtKZW
X-Google-Smtp-Source: AAOMgpeQMzjRz+HXPewKBhMJOGweYwlHcnBEsPRJ/e91uHY6pk7xB53E8teeUna1TTT+7Z2nYSMs+A==
X-Received: by 2002:a17:902:7898:: with SMTP id q24-v6mr5536423pll.222.1532328003471;
        Sun, 22 Jul 2018 23:40:03 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm8165598pgv.26.2018.07.22.23.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:40:02 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 1/6] KVM: X86: Add kvm hypervisor init time platform setup callback
Date:   Mon, 23 Jul 2018 14:39:51 +0800
Message-Id: <1532327996-17619-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
References: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Add kvm hypervisor init time platform setup callback which
will be used to replace native apic hooks by pararvirtual
hooks.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b2300b..591bcf2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -624,12 +624,22 @@ static uint32_t __init kvm_detect(void)
 	return kvm_cpuid_base();
 }
 
+static void __init kvm_apic_init(void)
+{
+}
+
+static void __init kvm_init_platform(void)
+{
+	x86_platform.apic_post_init = kvm_apic_init;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.name			= "KVM",
 	.detect			= kvm_detect,
 	.type			= X86_HYPER_KVM,
 	.init.guest_late_init	= kvm_guest_init,
 	.init.x2apic_available	= kvm_para_available,
+	.init.init_platform	= kvm_init_platform,
 };
 
 static __init int activate_jump_labels(void)
-- 
2.7.4

