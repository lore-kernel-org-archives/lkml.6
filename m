Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC7ECDFBD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6071B20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCRhZQU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6071B20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbeGWBqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:46:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44770 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGWBqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:46:21 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so7475988pls.11;
        Sun, 22 Jul 2018 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=UCRhZQU57k9FZSbidw1iYEO504K0Gc8Pb41aE1noNpQ8MaG1ARdlfX2NZdVIOYNC7U
         OVDfvqomLizu3TcT5oGlYfsqNc0M7RU8xjjNdQ9vj+Sq5ia71lydd+uaWFpGJWtt3OgG
         bF1xYkX+ITqxnjyjyIlGEVS6XQHxmNgtLRNs+ALdBNih2UrpXwEqsBOwad7PKnmP1JSe
         J2591Kqif40I0QNT8zF4PWOb+tOr3Ohg3EBN4XjojSyp/mxiyqAbALgaXf3ydcsxZbzF
         k5Pg2/JIhgf1He9ZtPTRM3q7AnF3cHrxphlDX4QtnY1/ThQ/ZO8QyJ39U+Gv/MKkHVQT
         W/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=DcWCsupzO4I+Sl6cJhRyQAvwT31ZzK/2fefuIWVjsSlw9XIlSjdJMZNile7I3G1aIV
         l9yFwmIIe8UXkA3rSczfeOuzkpzPoxivx2yymutdnJngJm11y2p0TuZySBHUe6udc0aK
         YiYKGv1KjX+peA3CkxChmo7vX5l4QIv9UVAhxdFgaoyp6fD+d/E+uNkURm+5SByVDFcT
         Ane0btK8STJR5WDcgDHh+xtJt0lJBVAtq/m0kwSJMy/nT/zDS1Z5yBJq5jySENjsnCWE
         nIbL7jW4794QOYT/w4SB/Pe0/6ntAv7T8mmfujgNi/Z8A1hgr6UKkW0ZFssaBgCXS4Y4
         AaZw==
X-Gm-Message-State: AOUpUlHvN4LDmvGwizPixU8cIEjTYAdQQFoyonrBJnD3d6XFLdFkwN+8
        jdRkP/ayUwao7RotkJyG8zYyC7nj
X-Google-Smtp-Source: AAOMgpdPsHtnaQIi3nPJS8akPpcqNR8dF6vrDzMwoPrQWwVhu8Mdj58SOLNtmD+8/6fZCCAE2KlitQ==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr2776525plb.299.1532306865990;
        Sun, 22 Jul 2018 17:47:45 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id e82-v6sm11646069pfk.87.2018.07.22.17.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 17:47:45 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 RESEND 1/6] KVM: X86: Add kvm hypervisor init time platform setup callback
Date:   Mon, 23 Jul 2018 08:47:34 +0800
Message-Id: <1532306859-31166-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
References: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
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

