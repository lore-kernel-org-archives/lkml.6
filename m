Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D50EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589C221019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJfmqzLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfAVPaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:30:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44044 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbfAVPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:30:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so11638555plt.11;
        Tue, 22 Jan 2019 07:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TLT2/IdH4vIWNkPiXrnofB5eDwW2cOUdQoiq7/BcHg=;
        b=FJfmqzLSsmWO0Y9zj1QMVVt7eKb/KBMhDqWQi6LMc0v53TthSvn/mi3xh93cudJK43
         wNw5DPlwu2qQSIps7BrnnJZDHSOoFw+0kyMQ0aK6wCydfmsCefKADUurgCOmUMmbsr87
         aqtheMmAs99adjrivDpeg0JWGCcg6Zgd0SVDOp0gZni0zfvkYNTHcjzZt9AGjWfIu3yQ
         a651pOwNoj+VEqkyw+a7ou5Thsz7rB2qSywGAbJMVg5CHEqhr6iHDaUKyTZpkozVfjhr
         F2OXOHa5O7IC89HvrhXEOLtuzNcMXo68AjVcFjdddqeQVUtiuKAfUD5nU2JBE9WQjSLe
         IUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TLT2/IdH4vIWNkPiXrnofB5eDwW2cOUdQoiq7/BcHg=;
        b=AsQHh2ZZkjWMcu5IaJm6dGXXkk3Oo+fSfSY0zUieyl8SZme+DXWEee0vmVH6gbn6SO
         oYIduG7tEfW3w/dfVB9kCrR2nhTH+cduxW6P/HgoTuBOlFUZADx8f0/r5AcPaOfzN9n8
         H5q4k61fZY9rm0plWrVw56Lhtuczy6Ted0nJon2/GmLO4KyhZQ0ZElqRIM/JXGLA0X44
         61pPZFGe5QWPpmbVXHkq61KKfq360bKhh8GJK69lbFCQAbOBfd1+QZ5n2XL+mI9zvodx
         NQXBUp9dVexWtT0+LXbW6JJTW+M/SWHtHSVzfWiQjwNVMPzKiCLzaoxIKgWV47n0We/o
         9xug==
X-Gm-Message-State: AJcUukdWTbvzE3LBXmdKRvZPzGyROOnK8f/5FYr/kicYyycRZYBTQyqp
        Worjx090F2KJcbTP5yE3qUU=
X-Google-Smtp-Source: ALg8bN5ux96+ZCGVAUXKpCSDcSSUAZh5F5E4AM0lfOcDkjCABDaQ1Kc81k36Io5D8EVQO1NoI8O2LA==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr33395835plg.250.1548171019388;
        Tue, 22 Jan 2019 07:30:19 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id l70sm41220697pgd.20.2019.01.22.07.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 07:30:18 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     pbonzini@redhat.com
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] KVM: VMX: Fix vm entry failure caused by invalid vmexit controls
Date:   Tue, 22 Jan 2019 23:29:52 +0800
Message-Id: <20190122152952.8011-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c73da3f ("KVM: VMX: Properly handle dynamic VM Entry/Exit
controls") has a typo that cause invalid vmexit controls. The
VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL is against _vmentry_control.

KVM: entry failed, hardware error 0x7
EAX=00000000 EBX=00000000 ECX=00000000 EDX=000206c2
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 00000000 0000ffff 00009300
CS =f000 ffff0000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT= 00000000 0000ffff
IDT= 00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
DR3=0000000000000000 DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000

Fixes: c73da3f ("KVM: VMX: Properly handle dynamic VM Entry/Exit controls")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f10e584..0762fcab8fc9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2344,7 +2344,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		case 37: /* AAT100 */
 		case 44: /* BC86,AAY89,BD102 */
 		case 46: /* BA97 */
-			_vmexit_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
+			_vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
 			_vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
 			pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
 					"does not work properly. Using workaround\n");
-- 
2.19.1

