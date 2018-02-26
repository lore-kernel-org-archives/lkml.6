Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387526-1519633983-2-1325053748702360137
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633983; b=oftYkTM0v3BCFQ6StiJI21NmiTrC6pCfAXROwRdWG+QNvLG
    H3XTW2QK6exTjBnRofNNZ5uWsC9+e2HGkt74XHEpE8B5cb7vATYPUBHv3WqvpPu2
    Iw5cDzKhDvSU4yYYFiEKAaprm4uWN/5QGwJP6cH+GK6eOT08d51G+o5FTbEC62zW
    fbaqOPlrbMIzTO6jcYc8xogX0FDKw29Z7GZL3PySy0RK02tPoUW8sqfa4xoEJzTG
    zpNzHWsHk58VavXpoXzJMCqVESTzP5ChISD57kreiN0WsQeIzZP6n7dO2lgM6/62
    DBxghwZnKXYr1/VqQmN0SMvUufLsCPbNhp6iFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633983;
    bh=+xR+r110x92nrh5KbxC/qh/uHxgkGEZ0it5ORoIx2gk=; b=KoTOExaI9thw
    IN9vC9I+0rJhGxgAISG58NDX/i/WPt4wUHR3h2z6Tha+UhTlXKHeLIe/7ng4EYOd
    04Kmvc5JZTrXsrVy+sAsE9gXHt+3Pp/xuecTGbpXVwryJAZtIPg3mvm0SNmocDJq
    lo2vTD7MuglmXehtpVgmGGvGWuadgSvv7MVnP6b2H1Lf+6HHlEMWxqExwE+n8kYU
    4FW7UbvYUBUaEXhDGMYMl5kvdSMDk5LVDY69hiL25dMc0gl7CoZ8yvcSPzMHQQID
    Ij7+iEYvvTBlE/oezbfLF1yf8JSB1EN+r81wmOdiZyqV8W4P4oLjgUiMd85gqZzr
    hrz/4/hj6Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gUwGegbt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WIOfNH2g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gUwGegbt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WIOfNH2g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBZIdA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:33:00 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37123 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbeBZIXk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:23:40 -0500
X-Google-Smtp-Source: AH8x2244lxR4SWTphcHaCrcokI9VJbLJDFCasThtbj6HojPPjsHfMrW0W4KpHT3cziFeEdWtQuu6wA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 21/52] arm64: cpufeature: Pass capability structure to ->enable callback
Date: Mon, 26 Feb 2018 16:19:55 +0800
Message-Id: <1519633227-29832-22-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
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

Conflicts:
	arch/arm64/kernel/cpufeature.c
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
