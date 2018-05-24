Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156058-2-11240389578138142374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156057; b=bigENgbUcoSQkNvW1PuKjSnvxnykl3Ii0FXglSXHb7QZVzRe0P
    rQZJ8AADk5yf1E95jwou6iYxbOwPgOWgPuTHM5zRqrmGN1+arpW596l02WZQR0TL
    kb9UAXBoxSVdm8vqcCnF1SmDHMhQ3bU8LqJFEgoFDi1aB3tlg5HFEUxGcyPEXVql
    awg5O0+cH55wHDqWP8+WdWXQ5HkxzzFldh6wVkrfqLP4zm/7BrgzECJJnVMrEtth
    Hu97EXC2XAaUoYtFebLe0qU0AYJK0FG1h3UA3G4bT+CuLN3yeCdydtzPahiPhzFX
    JqJgoQktyBctfr9Ndc+NxbIRO2LfOLyvTO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1527156057; bh=PiJ3d8GXdKbX0OD+IoFl7+TP5fF+feLGdMM9SNUDLEk=; b=b
    K6rMwWGiH2bFANqLTTAKV8OIF8NTQ9x03+N7L59GotX013/Y9p3+dcqa7zKHLUbb
    Hdd1F+DN2Ki8fzmK7i1Vvhure398MJdr+1xqAA0X3hrS9LK6NDJWI8kymbuAJq21
    9Q+r6uY18TfW4v6NKU/mhAgXfnvEJOtpCz0CE3vkJCb4ZphD16YpIxr/TdS3QoAM
    lPwgIVGUhSuJ+phYi6pK1Rl51G3w2jfJNOxxDc9EMeU/YHCU3EFAaEnPrbEttAVm
    w8hi2FyAFtxDhOL35X/fE+chxbH9SsdEBIcMCohL8osFbE/gnRALAStQNDBtFXPX
    x6k7ix9QNkG7Ve0oUn1QA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rpK7894z x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
    smtp.mailfrom="SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org"
    smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=rpK7894z x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=pass
      smtp.mailfrom="SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org"
      smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFvJCauNX0OEOgo+fgvSrtSsS2YBLZpeZoMQQd0rHn6sKvGCC9HOIKhlPJ5yfDMCn/zeTN1+Y7re37wsdvHjHOwkmG359XyBZNivHb/QYEYcdF6HA3j2
    X7ecunhq731F+gh7eAUM93Rp0A+ntSuYAfV2vq12xLV94o7ymtiEQwFZYpRiiwStnW3CtWZcdvNxvxcbpc6m/Sq6g5zrWdJMUN+KJJGXCexQ+87ji7KjpEJn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=a8smshC77bAp1VTUYNYA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	greg@kroah.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 047/161] powerpc: Move default security feature flags
Date: Thu, 24 May 2018 11:37:52 +0200
Message-Id: <20180524093024.048578311@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit e7347a86830f38dc3e40c8f7e28c04412b12a2e7 upstream.

This moves the definition of the default security feature flags
(i.e., enabled by default) closer to the security feature flags.

This can be used to restore current flags to the default flags.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/security_features.h |    8 ++++++++
 arch/powerpc/kernel/security.c               |    7 +------
 2 files changed, 9 insertions(+), 6 deletions(-)

--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -63,4 +63,12 @@ static inline bool security_ftr_enabled(
 // Firmware configuration indicates user favours security over performance
 #define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
 
+
+// Features enabled by default
+#define SEC_FTR_DEFAULT \
+	(SEC_FTR_L1D_FLUSH_HV | \
+	 SEC_FTR_L1D_FLUSH_PR | \
+	 SEC_FTR_BNDS_CHK_SPEC_BAR | \
+	 SEC_FTR_FAVOUR_SECURITY)
+
 #endif /* _ASM_POWERPC_SECURITY_FEATURES_H */
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -11,12 +11,7 @@
 #include <asm/security_features.h>
 
 
-unsigned long powerpc_security_features __read_mostly = \
-	SEC_FTR_L1D_FLUSH_HV | \
-	SEC_FTR_L1D_FLUSH_PR | \
-	SEC_FTR_BNDS_CHK_SPEC_BAR | \
-	SEC_FTR_FAVOUR_SECURITY;
-
+unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
