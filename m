Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3783C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBF3214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnCHgufR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBF3214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeHOSbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:31:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39555 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbeHOSbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:31:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so658614pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94YhK6GsKh1vtNNFk3bCeEJLqsgPPHkIQuhL2jwJly4=;
        b=QnCHgufRxxpOTq7RWDn5OozQu+vfSS+R9XGRDrApSIqr8D1N4IVGA7sj0VWpQfTNaJ
         LeayJ7/fQ4gzrEh7DhuvFi41cEYM2EhYJhD1BSwMPjcfgDYcIuTzE6V4ACFjIbP/ySyN
         EkPzNMl/22ULN5uREitgXO/HbPGKLQx34SExZqjqAoKC3FZN5ndIEgf5/71QxODgJWoy
         erIdjjlLmnFYK/OuOcuYFA1lmW8xfmmFBSbXHT7c4e1gWhTON6w2HMC1MQWTE2iYje7e
         zxLzd19YhYuTD8dxyStzIwQ427knoy4E35Cyo711juionASeB1YcicxAcmKmImAJggEs
         WhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=94YhK6GsKh1vtNNFk3bCeEJLqsgPPHkIQuhL2jwJly4=;
        b=RS/pm3DO6jtYDLDhcZ9CeiBia+5+bxrVolXj8zVnPF9VaCof3A3mrAWzZi8/vZlSJP
         k8uZgrJGcwgPjPf6O/rgqVUWYVYTjfDAsOU6rW/J/xFYYXyoyhL+Y3AqTQo5b58X0mOn
         /TQrDjQyfG1W4qK5/a4tZyXf0q6R24ECRz7BRlDWC3WYKZYUsPncU4Y+/RG2N+cTWd8t
         F5uWPffBdYOx2x71mio05m47oMQwpZ4MMIaVJfcOksmSYYlPw5l6w/mt94XoYuvoKuu7
         oo+NJ0J0fa+8KVTm4LiTUYfjidVD2hUPsqOOHq3qIZlT9qJYZi8dlaXJPlHi7hkSq2vb
         /yTQ==
X-Gm-Message-State: AOUpUlH3LlElqRsr/kGccPLOdQkhVmR1kaC0iQcMTFqPzGbIMBPWQlLK
        AGS7cBO3aWDi4x5FzBW0bRs=
X-Google-Smtp-Source: AA+uWPxJO8ZRNDwxTOBqimmBZ4CThJ6WsAaIXl9qleNSULHnVev0jtqjfXqrinRXRqEXTfqKY87wgQ==
X-Received: by 2002:a63:614d:: with SMTP id v74-v6mr25398462pgb.328.1534347522409;
        Wed, 15 Aug 2018 08:38:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 16-v6sm40056716pfo.164.2018.08.15.08.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 08:38:41 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Meelis Roos <mroos@linux.ee>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RESEND] x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is disabled
Date:   Wed, 15 Aug 2018 08:38:33 -0700
Message-Id: <1534347513-10120-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig+CONFIG_INTEL_KVM=n results in the following build error.

ERROR: "l1tf_vmx_mitigation" [arch/x86/kvm/kvm.ko] undefined!

Fixes: 5b76a3cff011 ("KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry")
Reported-by: Meelis Roos <mroos@linux.ee>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Sorry for the early resend; widening the audience.

This problem affects Chrome OS builds, and I'll need to apply either
this or a similar patch.
Since I would like to avoid applying a patch just to revert it later, any
feedback if this is the correct patch or even the right approach would be
most appreciated.

Thanks,
Guenter

 arch/x86/kernel/cpu/bugs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 27830880e7a7..cb4a16292aa7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -664,10 +664,9 @@ void x86_spec_ctrl_setup_ap(void)
 enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
-
+#endif
 enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
-#endif
 
 static void __init l1tf_select_mitigation(void)
 {
-- 
2.7.4


