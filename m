Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B067CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683C2208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6xAXMkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683C2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbeG0STe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:19:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41626 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbeG0STd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:19:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so5708618wrr.8;
        Fri, 27 Jul 2018 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F60zzfijjf8lEv4dG1kQPzWErD4tLNfeR3zJX3+Xs3Q=;
        b=f6xAXMkvLpOTWxxgd/C4yc5V/FNkGIjL6FzQ/y3ISfoXY7lgSOD7VQ+hnsOCRe6p7j
         zGf3k6oXM1XCAz+VwYd2a+23mXGTPS5n31SNlseWiqPTKkZ9Wi9ga4vLeUgwsxTqjG1F
         kwYF4mCpdTSHI5E6CY6FnF0O4NMK8LZ/IgVnqjndByQxb0qQ/qaMU7MGCqjpkhQGoeXj
         6336WFAl5YVKi/KcPIx4mWUf6VvTNEDkWRM/jmcTfwW06zz6JmRSMlYwq0cJDeD6dAgy
         bI92AaNS0SEEqHWVABo6LfEINtM2P4HkpIHXe5G4BwmNczErIGM1aCeL9HDAEMqWjTTN
         LSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=F60zzfijjf8lEv4dG1kQPzWErD4tLNfeR3zJX3+Xs3Q=;
        b=cLwGe3m8Kr/axixeNo6MX00kcKgtsJkdiOWLmuJ+t5kgMCM3Xg1NXF57lbKTLlwJb1
         ZGuW0w+jRGT2qaA1BvuO31Balc4YoTxjq053wsJ1rQC3IVd4qKOyhoIOyyAqxQ/46Gz6
         qkE1eGkhRKajJRMI1LM7MPuylR80IG3IH3bfBbG8HiXrrMA9LoCOtStKvqbup7BHm+EI
         UDOKJVgHba/uAWCeax1TW9RRAg9/I7UTLLqafpdw/Mj0WFlnI/ESGDOG7VlBPavlSs2q
         H1z9WYFJckoXzcqevlz0DnF/TRgyqUCs+wXGqdNFhScC83xkR2UzGjssFir5ftM5sjvC
         aNPw==
X-Gm-Message-State: AOUpUlHIE7KadgiBUxDCC2xE/Cb4P5aEXxX8l3Ig9ImtqnwotG8Yz6mI
        djSAJ1C4QHmxr263oet/aMkUXIOH
X-Google-Smtp-Source: AAOMgpfDzgJL4Vh9utrt7pOueQ6ySI3DaWDm6LjX4meGhlEWuciE7TdgqAps/ZjAjSprvS/yCmM85g==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr5725385wrs.137.1532710606349;
        Fri, 27 Jul 2018 09:56:46 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id u185-v6sm5528184wmg.25.2018.07.27.09.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:56:45 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com
Subject: [PATCH 2/4] x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
Date:   Fri, 27 Jul 2018 18:56:39 +0200
Message-Id: <1532710601-45449-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
References: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

kvm_init_shadow_ept_mmu() doesn't set get_pdptr() hook and is this
not a problem just because MMU context is already initialized and this
hook points to kvm_pdptr_read(). As we're intended to use a dedicated
MMU for shadow EPT MMU set this hook explicitly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 0a40afd71d74..b013aec73d46 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4816,6 +4816,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->root_level = PT64_ROOT_4LEVEL;
 	context->direct_map = false;
 	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
+	context->get_pdptr = kvm_pdptr_read;
+
 	update_permission_bitmask(vcpu, context, true);
 	update_pkru_bitmask(vcpu, context, true);
 	update_last_nonleaf_level(vcpu, context);
-- 
1.8.3.1


