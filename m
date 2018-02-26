Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519633672-2-8488228527936709022
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
    t=1519633672; b=AnbuDzh3VMpWAiyW9wpLxXQt04lClzPdh44Fe3pPYTlD00O
    /ac1e2Co80XKh1qweITKPPaR7rfAXUr9DmvMCr/N/Zi3i28++Qqf50IGh9UA4Yz3
    BJeWTNn0mVmyO+wGpzCxzwwxZYhvsY+YbzHw4G7QM5FIcf1G4Qm7FIDog3Pe1iBG
    LpbHz5mMLFytJN0S+HZiuaFwCaLihDydcNcfVvg2NrvyU34LYDlti+nPwar+9hJk
    pUKW9ln1+BIe4H1Lwp9lvN+8xTQUQ8egfvT+fsirJPrmkIPo6Ab7krvbmbspkA+w
    ipW/ith2z+ogcFLfWRCe514RFD9S3H7PnJnlyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633672;
    bh=TZy7LbCE06w5P4ocO94iT/5aR/zA6c96V+vApCDKSFE=; b=qPVyNiPyHdYf
    u8E88PKTSTViIGa/RXCfdohM6QA9BG3EyvJSeS8enjXsBCCs7S4qUfWPIotRrzjq
    I3zPgVzdK/ctpx45SaZv6nQp4gFcxK38DYBgf28+y4bOwtz9fQu/P8V0xem8zFBK
    MoVlm850yV+KC12wmVAoJFDgYI8EHXlEvWAtr+Zj2C2w/NXqe6PNVMXJ8Kr+YiXI
    p3Yovw8++X0tGsL5WAgWjkebxheYRTRXOulDZ393+p7p9m4Fkl0VFvqftoLI1Duf
    RHN2FhMtMobzoHwR0eGrZ0gygt7Oguqf6nU1pmapIYxpg+tPzKrGeiVQUkxhP7xb
    gz2d6Fhutg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OfTMe6MG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LTSdPiz/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OfTMe6MG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LTSdPiz/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeBZI1n (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:27:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44756 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeBZI1k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:27:40 -0500
X-Google-Smtp-Source: AH8x227MqUeEVCGm07uKULLGNfsMO2P2X4nMU9d1Psa9gsiwLW+FD51YIOlRxQxM+BTMd6EKlfmoew==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 50/52] arm: Invalidate icache on prefetch abort outside of user mapping on Cortex-A15
Date: Mon, 26 Feb 2018 16:20:24 +0800
Message-Id: <1519633227-29832-51-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

** Not yet queued for inclusion in mainline **

In order to prevent aliasing attacks on the branch predictor,
invalidate the icache on Cortex-A15, which has the side effect
of invalidating the BTB. This requires ACTLR[0] to be set to 1
(secure operation).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/include/asm/cp15.h | 1 +
 arch/arm/mm/fault.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 0672ddc..b74b174 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -65,6 +65,7 @@
 #define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
 
 #define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
+#define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
 
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 17fd0c7..a9c924b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -409,6 +409,10 @@ do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		case ARM_CPU_PART_CORTEX_A17:
 			write_sysreg(0, BPIALL);
 			break;
+
+		case ARM_CPU_PART_CORTEX_A15:
+			write_sysreg(0, ICIALLU);
+			break;
 		}
 	}
 #endif
-- 
2.7.4
