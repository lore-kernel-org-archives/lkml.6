Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909106-2-10680201600493169034
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
    t=1519909105; b=cBUT4g9WZhAdiEAmFV+P6PEFD+V0X0mceAqb1mZmbBQ3I/I
    xxBnnHkTYu2ppVu/eCgZUeyxDoXqAbaQPXyKu4dsUDhC+I49bR0QjIT2SJB1OvBH
    paDyEq2PSP7r0ZR6S4aGttyVp6ZOeN8Rzhz3PQ/9mPPrTao34FWQIEQPRkZbwM49
    A6lAAJcDKZAjM4djgxUpxBQDSvhKTVC7fgF5xzRep94o9mY6B0yXky/SKi1Ue5fG
    Orbcvt/9rkTNrjh3Il+0bW6JRjap8C+ZYRE1VDfXyNfmqGqKqCWhCEmL9HhHC/jh
    Td5u1Iji4TZlKlyPtlV3JXt3/BPLdgg5CMpIgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909105;
    bh=zPqSNl85WyC76XW1VxDfQh//hh1Bpcs4lU5Fv1YTRJ0=; b=tJY1pc1HDlAt
    acBTlRamw8dhfJh03/ZK+zAxv10n/ZKYzzJ6xaEu4ueSBalDp6e/w10Y7ngtsT4Z
    GFpOMLkAAb/i5/1bconaY7vWXkKW3L80ekwCjqQJZMfK86CRN/yuaa4EmoWWUQKl
    2EVhJAPYHL6RJRBxr4wHRJasiVsZ09lczt5adz60zZyqwdYWUZ04pQnRJAU1hdUo
    EDIJ6IXd/CPH3mOfofMxdNVrO9bsPUHmFFXsCEWUrZXWv/cCP1lE8NnQLh4Z+QlU
    XRPAcvz2Ca5cz/T50W3Gw+Kf4ruA/WzVFkboGIBrsXJzmnfGZdXBimYwZokMeuEm
    wsbkgLJ02Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=RMB40iPH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jt3ncCqB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=RMB40iPH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jt3ncCqB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030702AbeCAM5y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:57:54 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33581 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030539AbeCAM5v (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:57:51 -0500
X-Google-Smtp-Source: AG47ELsJvYuchbiD6Wc34ARdbng3MN1tTspN9l3MKVycqgyaT+4f2g2veQIyUu3anVE/iVwlWHGIjw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 20/45] arm64: Run enable method for errata work arounds on late CPUs
Date: Thu,  1 Mar 2018 20:53:57 +0800
Message-Id: <1519908862-11425-21-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 55b35d070c25 upstream.

When a CPU is brought up after we have finalised the system
wide capabilities (i.e, features and errata), we make sure the
new CPU doesn't need a new errata work around which has not been
detected already. However we don't run enable() method on the new
CPU for the errata work arounds already detected. This could
cause the new CPU running without potential work arounds.
It is upto the "enable()" method to decide if this CPU should
do something about the errata.

Fixes: commit 6a6efbb45b7d95c84 ("arm64: Verify CPU errata work arounds on hotplugged CPU")
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpu_errata.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c66a673c..8de43799 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -150,15 +150,18 @@ void verify_local_cpu_errata_workarounds(void)
 {
 	const struct arm64_cpu_capabilities *caps = arm64_errata;
 
-	for (; caps->matches; caps++)
-		if (!cpus_have_cap(caps->capability) &&
-			caps->matches(caps, SCOPE_LOCAL_CPU)) {
+	for (; caps->matches; caps++) {
+		if (cpus_have_cap(caps->capability)) {
+			if (caps->enable)
+				caps->enable((void *)caps);
+		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: Requires work around for %s, not detected"
 					" at boot time\n",
 				smp_processor_id(),
 				caps->desc ? : "an erratum");
 			cpu_die_early();
 		}
+	}
 }
 
 void update_cpu_errata_workarounds(void)
-- 
2.7.4
