Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1727EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F124B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/nrV5AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6F124B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGCGVn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:21:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36864 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeGCGVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id n15-v6so471051pgv.4;
        Mon, 02 Jul 2018 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=I/nrV5AWHmn3hbdm+GZ+A4U1iZ4B2yX74NbonysjR2Xv3HcCE42EfQFDO0ERICaCQR
         54SzL+WePx/PqjympIbrAnG/GcFb6QGGOmmNquoJZ9cnIOASapLEyNg0Yi/A0humTn9n
         hZE+X4l/VkWLuhve8RhFhMMV9gfi+sGoLXuSUW7o4wT7r9AD6gyAglGroRCr2/u+e9Nx
         bOP04A2sNa9LCDvj+BiFFV3debUHFs396IBP4SXU32ETNDgiyCPIVJU5Khwp1BMLWqmd
         nMXKPBRe+XPeKpn6S5Vmcu3Fl7PxympUH/ZEUsgX9RROddFOxROSLv7TwpjJWzJdXY1w
         CRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDljZacJxZG2OWdhiAliNYhkc3j//3d2iZVEuKfWFo4=;
        b=N9FHXiiHJDuWsuG33osJnZBTX/SB32H0uCWvYr/OeDOZkC6V9mTYUxPHSvl253EIrj
         cB42bl6fR105cqCORkfQvB2QvEuWJwwTOLQszTFsJrdVB5zqH6CfJJ+oM4nnyoC9tudz
         VYx+GTGFeNKOeI/swfTeBOnygA9s/uFy+kl5ZZiITwukFhBqbJqhPmfnlSBLBI9ph0zt
         nLMcbJbmN/I+tyR2iRoP6FuozSi+n7LlrAvhkUE4I6bSvlywoMxgFx6CndJ2vkklXm22
         /0p8mdbdwiGUtojReUiQGusoMCId4JPr8KG7p1HVZ86dgVP3pnxLoX+evBnCcGVJQrO1
         XLAg==
X-Gm-Message-State: APt69E1DP6UNFcvKfBa2Qg4doDq9yhK87C4XersKHgBMMyf4INjT/SyE
        yQRZnB6GxEtqTfHRVdabWm/vHw==
X-Google-Smtp-Source: ADUXVKLD8llY3ogfzN7eHDLi9uOrCXZ3VStlIi2bhAvWgz7WokypoGYaL1q5bc49aLibTIkdy8diPg==
X-Received: by 2002:a63:8749:: with SMTP id i70-v6mr24766888pge.325.1530598897708;
        Mon, 02 Jul 2018 23:21:37 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id v89-v6sm1766427pfd.64.2018.07.02.23.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 23:21:37 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 1/6] KVM: X86: Add kvm hypervisor init time platform setup callback
Date:   Tue,  3 Jul 2018 14:21:26 +0800
Message-Id: <1530598891-21370-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
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

