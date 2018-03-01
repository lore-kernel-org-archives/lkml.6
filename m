Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909101-2-10358348099328029898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909101; b=UQfWcQAQRACeIsGXMFAHuRcTyjrpof1tpWDJPTVDSmIanwU
    X1CpvjJWXtZkS8Xy9ilSMIecYdtJ4VzaUqBBZUfZEldZe/TsUiD7o4pFAOmKuvtn
    YJyjvQvM3DAAq7aQbmnJDw323/KctCJch4gm4t41zPKo+FNIUufZhrB+jhJdIe6L
    KldhrkEz4P/wZKQRKS5GrYi39UKPWLe4p/lCiHMguAVh1f3IWu76dKFke+9fNW1b
    ua6i/gj5HC4AZNFSxDjrpBqAJlCFAOMaAL7IafJ3dGp8+qbn22dbE8Z79h4/bdX5
    kmGnKq5yT9XVooeMM5z68HMBs/z0D4STPAqtZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909101;
    bh=mp5ELbwEmYRLHeQ3bnHDHxexdMKPPHMhOHF8S+YF3Ac=; b=T5cYxyXEpZ86
    2XwjFbT7c9xan8yaZyyRz9mKknn3Y3PQqXlvVQRZ7wW5lrq0yHkaJ8pL/yCy7lPk
    JbC3b1ooWUSuaXLo0JMVstqNc/Sv4hX06yJkvPvzcSQewHvYqH5KouZSwjQDeY6O
    Z0TNWjSuHHPTND/XGoUJzbMbvwWPAel/x24AD7hIqLaIe+On7tkeli0Y/Q2/I10Z
    ZAph7hfJ6aDSho/yGbXI8X+QdXiNW6xJEbG/10F/o+XVQqAWp8Hmo9XLEMyNjNcy
    vJ8oEtiBzuIR3R5BJ7BmQPk2LcK6bmkaTIufW4X+9UTFjBzTO4yQes2Nx7u1fRI7
    KQv4k41ezA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=c3I9UT93 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lhflu4O5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=c3I9UT93 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lhflu4O5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030912AbeCAM6A (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:58:00 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39799 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030602AbeCAM56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:57:58 -0500
X-Google-Smtp-Source: AG47ELs7YgzLn5cLVoeInqjpEZ1Co7epUq33LCDgtESGwVzk2sUQ6xDr4XwW8lij/bU7bD5Db59Tpw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 21/45] arm64: cpufeature: Pass capability structure to ->enable callback
Date: Thu,  1 Mar 2018 20:53:58 +0800
Message-Id: <1519908862-11425-22-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 0a0d111d40fd upstream.

In order to invoke the CPU capability ->matches callback from the ->enable
callback for applying local-CPU workarounds, we need a handle on the
capability structure.

This patch passes a pointer to the capability structure to the ->enable
callback.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fcb67e0..5c41ef6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -949,7 +949,7 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, NULL, cpu_online_mask);
+			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
 }
 
 /*
@@ -1005,7 +1005,7 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
 			cpu_die_early();
 		}
 		if (caps->enable)
-			caps->enable(NULL);
+			caps->enable((void *)caps);
 	}
 }
 
-- 
2.7.4
