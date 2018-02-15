Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720318-2-15527304916148253566
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
    t=1518720318; b=ln37H8LAJe20vXiAT4VJIWBiWWoAYpqdo3otvcVpvVYscQm
    u0OqILH6IDYUNg1gwmVBf9dBBx12Tou0lImAabsSfCo/5mOBS60b4fSRClHcrhnC
    vT0RQ0aJVByH+9Wn20sqWYKtyV5PuHP7EoqymmnQpipE6xir811WLLcCxDEI/k5E
    L3erzMw7YORd90Xr1C0CSz/ryhRtRfoCiQP9dKNraADTlw3HgGQ4jEO633z5ZqHt
    V/hlOoCLm306EELeL05wB7E15u7XHkDL0GumTdoofDaMJ/WFEYJAmpHbJeRKhecd
    Re82NMZ0JBTC5C28e8nLpYKLvWNGsy2HR0uTDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720318; bh=+D+nFBs5mqCloKGpRyvshbKfVd
    tMukO/MUEjoUWy6C0=; b=Sja6vsCWEXmH2Kjd0JJw+0FQmb5rNWzAoMvkxYFCxe
    Td/PJ/7vVeztCinGQNb4VQ3aHGq1mDafarXkbwquKb74iiDZpkvmtAYtIQGSwqZ8
    inmpGbUs0RzYyakUJObZvzVVUFPk3YfN4Ajx//n7GMfqACc6vUXVHC6vuR32lDD+
    +fpK4njhBZB+9rIyaLeq+jG9b279BOUJLj/wpoHdLvC6NsP0OEFx+iqtrGREK56E
    8NU0hWQ3mWFIRZyduqOj5Mv3ptk5Soi96pN7EtVMRiX/kRUNL8uX7wxTycLOd1+M
    /jWMfivm6ehIti01savneTNpa9de+EDi4oLhDOHivBhQ==
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
        id S1162580AbeBOSpB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:45:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162500AbeBOPW6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 015/108] powerpc/64s: Wire up cpu_show_meltdown()
Date: Thu, 15 Feb 2018 16:16:12 +0100
Message-Id: <20180215151224.669637675@linuxfoundation.org>
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
@@ -136,6 +136,7 @@ config PPC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_TIME_VSYSCALL_OLD
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -934,5 +934,13 @@ void __init setup_rfi_flush(enum l1d_flu
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
