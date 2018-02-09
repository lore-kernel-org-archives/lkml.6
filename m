Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1323216-1518183638-2-6493214803138038071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518183638; b=EPyq+yaRWrTwJEwJlInLfMURqrWvd7d/VgNSQjubS2aiSft
    fEy4IGEvstAXcWd0VQnMfSMcBldYNP1f8wawLximK7h9QCS4jkoiZJTdKULqZy5a
    HMzL0EWusxiQKzOlIrndBTW1h7JBRcUD/V8+KMk9tGPAJYLtU3gXN43hpC+usXqA
    QL4Y5V0yPdOjb6oIMpLbx3K5aExngCHgS7Q3HjyO00JYA2T8Oj61ImPKQYLJIaET
    kw/qu3QFPnOcqonsmpZ42PFS/jwwQ8QV1jgN88aDSoQs7uCr4XfYaIECXi9mccq9
    u+WgREJQ8HX1jmm7LnUADOoHBEqJ/9BHTI7Srow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518183638; bh=BYSIzYMXyOnOTYT9wpBwi3MNMN
    z+O7IicWR7He7qxYY=; b=e3nGzHgkraiPmBUhp1Fjg4QhPEtvkscZd9ABTR1O70
    MaEpFvjvTcNVroeKZwwm5v2pSVKrhrqHfr2pDUpz0+zn6KmPtvZYm6zydf0rIpGi
    dygvlXyxlRAx/IhrvH9+aAe1vk0bjzmYGR7wFQwRQ1Lf3CRFqUUuj6of9HjhVckr
    5BNcL5Kn0BzwRfpvChoQeFBpjbbwXSTNidSaN+g5MpcrXFH9gGOGYlsyuuNSvMKO
    TXOZRJt05WJH0tjX7nF4BQ/gkpaVo/+FnzLdZ2JascA5iTJHVkZk+hSDfMwl6Htt
    RzVM7iVTiumwf3uSEIIoPn/Gpl/eNmyYD8OJShlRs7fw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbeBINkf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:40:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBINkf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:40:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 4.9 01/92] powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper
Date: Fri,  9 Feb 2018 14:38:30 +0100
Message-Id: <20180209133931.331247603@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit 191eccb1580939fb0d47deb405b82a85b0379070 upstream.

A new hypervisor call has been defined to communicate various
characteristics of the CPU to guests. Add definitions for the hcall
number, flags and a wrapper function.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[Balbir fixed conflicts in backport]
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/hvcall.h         |   17 +++++++++++++++++
 arch/powerpc/include/asm/plpar_wrappers.h |   14 ++++++++++++++
 2 files changed, 31 insertions(+)

--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -240,6 +240,7 @@
 #define H_GET_HCA_INFO          0x1B8
 #define H_GET_PERF_COUNT        0x1BC
 #define H_MANAGE_TRACE          0x1C0
+#define H_GET_CPU_CHARACTERISTICS 0x1C8
 #define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING		0x1D8
@@ -306,6 +307,17 @@
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE	3
 #define H_SET_MODE_RESOURCE_LE			4
 
+/* H_GET_CPU_CHARACTERISTICS return values */
+#define H_CPU_CHAR_SPEC_BAR_ORI31	(1ull << 63) // IBM bit 0
+#define H_CPU_CHAR_BCCTRL_SERIALISED	(1ull << 62) // IBM bit 1
+#define H_CPU_CHAR_L1D_FLUSH_ORI30	(1ull << 61) // IBM bit 2
+#define H_CPU_CHAR_L1D_FLUSH_TRIG2	(1ull << 60) // IBM bit 3
+#define H_CPU_CHAR_L1D_THREAD_PRIV	(1ull << 59) // IBM bit 4
+
+#define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
+#define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
+#define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
+
 #ifndef __ASSEMBLY__
 
 /**
@@ -433,6 +445,11 @@ static inline unsigned long cmo_get_page
 }
 #endif /* CONFIG_PPC_PSERIES */
 
+struct h_cpu_char_result {
+	u64 character;
+	u64 behaviour;
+};
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -340,4 +340,18 @@ static inline long plapr_set_watchpoint0
 	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR, dawr0, dawrx0);
 }
 
+static inline long plpar_get_cpu_characteristics(struct h_cpu_char_result *p)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall(H_GET_CPU_CHARACTERISTICS, retbuf);
+	if (rc == H_SUCCESS) {
+		p->character = retbuf[0];
+		p->behaviour = retbuf[1];
+	}
+
+	return rc;
+}
+
 #endif /* _ASM_POWERPC_PLPAR_WRAPPERS_H */
