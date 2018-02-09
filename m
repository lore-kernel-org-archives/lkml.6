Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518183671-2-1742154658697062304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518183670; b=v38uidM5M7GU7lgi6um9cuSigJRD9OnIAU1kSRhEswQg1YG
    WBdmEE48akx1HMJyZKLgne54k5yjXAZvP5WKpTtf9yCOzafEMCiOU/tHXEx1kLka
    uERO5yAZF3/PxXikEwdlNy2DGU/6lPN5U/VGh9YMkfnmY/2VDYssc8LbIC9ywgCO
    vCTHh46I3fD4yN+6vrl8vcC7KyGF+sKE3PuzFJge6UUAQy2aOu+Pz8WjfR7wi+le
    JlFSXOyH84s02pC4ej/ijKkojgYxvdLm8fl/fv44xyCtToVkA21xDZo9AbrgSeg8
    zyr2w6LK/Vb8ReDPxYjx5CNYvRsyunCX8duijug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518183670; bh=H14H2CubR0bPuBMq72GJ52J+ih
    rYB+OAwW65FO2nkzE=; b=l4iALgJa5gckfwtVRUEuOrHxemPfmF6CxfQ/6znhkl
    Uzet8sQgml+S+0J0T7+uHNaHfeL6OnG++V1iJeDOF2gQC5qcQ+7FgGsoAxVaCgUf
    dmN9bYY9fGdOm9VR4mc+IqaG4V/0k22qFCtUwZAZguLnCXiP9wPIuJ8OwHPYTXxg
    LGXXRrpC3KhlFt/a8XThFPzZo4DTJIzqhhJCeClGSAclM8Gcam3yBKic8jS9S+0Y
    SletjT0hZuOsysM4Ydj6hf4D+a8Q3jAXPPTdwnqjhw0ezYITTsaVdjUmpkDttWu7
    cHgP3FsxGMn6RQPbFjZkQg2qIPoEMtSd4pLFbhr2pgOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBINlG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:41:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeBINlA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:00 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 10/92] powerpc/64s: Wire up cpu_show_meltdown()
Date: Fri,  9 Feb 2018 14:38:39 +0100
Message-Id: <20180209133931.991858082@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit fd6e440f20b1a4304553775fc55938848ff617c9 upstream.

The recent commit 87590ce6e373 ("sysfs/cpu: Add vulnerability folder")
added a generic folder and set of files for reporting information on
CPU vulnerabilities. One of those was for meltdown:

  /sys/devices/system/cpu/vulnerabilities/meltdown

This commit wires up that file for 64-bit Book3S powerpc.

For now we default to "Vulnerable" unless the RFI flush is enabled.
That may not actually be true on all hardware, further patches will
refine the reporting based on the CPU/platform etc. But for now we
default to being pessimists.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Kconfig           |    1 +
 arch/powerpc/kernel/setup_64.c |    8 ++++++++
 2 files changed, 9 insertions(+)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -128,6 +128,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CMOS_UPDATE
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
 	select GENERIC_TIME_VSYSCALL_OLD
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -778,5 +778,13 @@ void __init setup_rfi_flush(enum l1d_flu
 	if (!no_rfi_flush)
 		rfi_flush_enable(enable);
 }
+
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (rfi_flush)
+		return sprintf(buf, "Mitigation: RFI Flush\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #endif
