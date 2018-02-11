Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326748-2-17263974633693659140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326747; b=cHsdRE4JKq+fhU3C5hjvoKhTGJdGIfsnabLamRiq+VoGSBy
    S8UQOt/klPzoT6TVoQtZTwDNoOfPdSzWOE6rYUZpezaGzIxzoOYUTN2vnemopZ0i
    /nJ25dY75mw3V6mfWW1tTt/E9F0hdJrqxavsvEvN5wjjrUSBhqeFtPj0dE/KYBM8
    /SJBpynHuxwt8OjauI7NmywsjtqbnR5iHEHioo6IMn9+36WHLRSqmoVKvDR1VCN5
    L2gJrKUzsiz+NdKOJm9FhZ9JmriiUWgFN1QEAB7GuSRY7geip6h9OURYZkxsrP0x
    PGtyZSVc4qgcbTtcRspjHpw9d7ZlgcgHTWhzX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326747; bh=MfAXqVHUTPX1tYagpMu
    9s0XOJfCUwOtDgBrfa27jHOQ=; b=qostTm5BeqYy7F1IZl9TR+KR4AVALFJPZvz
    LcRhPphmozna6qpJshiiY3m3nwlrFRK4cYJ2UClXPfhr/RO6EyZSTBiVkDxhT59r
    YBPCzgtbV8Ouo26YTIvix8xqb0pqAWDSIXWiX+6/5d6jJgGWAIXiNlISok2EjnsP
    6Q43OCKwakAptd/NXy4UrcPNTeOJdqD7xxTwhrWqr9W2adDq29+7zbYox6SG+WAm
    AZrJVzK29dUGxiQ5aKsBYZceYm4K1jqLa2UFTfv4l9y4dChL9iLYdvx3EOI18yMY
    HQM0LHzNwG4PWCR2ZFNwfqMWXqd3ulwbB8f+vnzSKFd/7tXLFYQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeBKFYE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:24:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41326 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752480AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ladi Prosek" <lprosek@redhat.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.421888798@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 08/79] KVM: nVMX: set IDTR and GDTR limits when
 loading L1 host state
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ladi Prosek <lprosek@redhat.com>

commit 21f2d551183847bc7fbe8d866151d00cdad18752 upstream.

Intel SDM 27.5.2 Loading Host Segment and Descriptor-Table Registers:

"The GDTR and IDTR limits are each set to FFFFH."

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7076,6 +7076,8 @@ void load_vmcs12_host_state(struct kvm_v
 	vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->host_ia32_sysenter_eip);
 	vmcs_writel(GUEST_IDTR_BASE, vmcs12->host_idtr_base);
 	vmcs_writel(GUEST_GDTR_BASE, vmcs12->host_gdtr_base);
+	vmcs_write32(GUEST_IDTR_LIMIT, 0xFFFF);
+	vmcs_write32(GUEST_GDTR_LIMIT, 0xFFFF);
 	vmcs_writel(GUEST_TR_BASE, vmcs12->host_tr_base);
 	vmcs_writel(GUEST_GS_BASE, vmcs12->host_gs_base);
 	vmcs_writel(GUEST_FS_BASE, vmcs12->host_fs_base);
