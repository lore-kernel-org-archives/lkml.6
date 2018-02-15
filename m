Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720853-2-2426526106578399275
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
    t=1518720852; b=Ve/6C0QGWsTsK+rilnHedSoC5/gA9hXAt9yVMkQpUa97L8S
    1dNr9N6Y0qDflUBYNDGNe4blKMLVVMovsKX/qv9Xd0MNNy653PkO9LaAshfv3alu
    UzoOjXYLQMY9wbxxJI7BwGiuBUjyV9kceukCQYpjrPnbXBs2vue9EZ6qzMheUlDk
    UTRIQTOPFRTn0vQv4KFb1b7irpvUItjdbrTxlwucDg+Y4V0qP7sDKiQVLnnJNhfH
    3ogwllZgDOh/9eNAO7W+uoten8qn6FN28wmeyOo4tX+nh80YqJI8crErgUmadqco
    tHAvliHDntrozLExFgFG5hDWAV696fg/dGE6Wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720852; bh=j/0nwS8WKdilTjcs4+zSWyhKdv
    RnaYL/ArsCbgUoXQ0=; b=WJ8ixMk71SgpiQEAA6YN87MSt72jZb9vALxR8MpFbC
    gQsh1VwilOxnt81R2dAR+h/hSRjSZaw/BsHZuE1N9n8XNJcvFlpSVzaL3wTeUQQx
    e1ksMwEt5fUyZeYFUCWYU+tXSD7STv7AVkev593DGK6I8Efc34QTOYGqAPukTEZT
    vqd4ECBnI2P6ETPReN1kiS85qquDSvcU3oqcKOaUXHr3YSl0c3H/igcWRRzx7xA6
    Qh5NWPqy+ouo9MT66nET95tdlS1eH2NVZPrGgVAmSPiSm/AYgH1mjQ+WISK17nA5
    QYVL1vnilTK/sLEeWRs4hoR8tYN8m5ofae+YUohr1amw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162099AbeBOSx5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:53:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161902AbeBOPUz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 4.4 005/108] powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper
Date: Thu, 15 Feb 2018 16:16:02 +0100
Message-Id: <20180215151223.085452525@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -239,6 +239,7 @@
 #define H_GET_HCA_INFO          0x1B8
 #define H_GET_PERF_COUNT        0x1BC
 #define H_MANAGE_TRACE          0x1C0
+#define H_GET_CPU_CHARACTERISTICS 0x1C8
 #define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING		0x1D8
@@ -285,6 +286,17 @@
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
@@ -423,6 +435,11 @@ extern long pseries_big_endian_exception
 
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
@@ -323,4 +323,18 @@ static inline long plapr_set_watchpoint0
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
