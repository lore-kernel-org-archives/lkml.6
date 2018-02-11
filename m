Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323701-2-16723601030049918963
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
    t=1518323700; b=TPYMU1YU8GjS7WjEETHozm7t13YarSlxdyeKULmrszmEdYT
    g16ZlIYydbZF88J9jVvG6BfJKRv4eVodK3E3Ifx49tlApFfI9PEtrgD1oCRh2t2G
    TfBeas6UK22+rQWPuundyIKlr7HUQMvY68NHDyHPHokKz+MhKqC2qWUyvms6fh9y
    4eQdDxODHhlMVyn2R1EjRedoIBx++8JzdkoYuQEoOOBJ2vbONznpZR5D6fwvMXos
    G9Fi52nZKCGqO1SmW6NS3BYur9Utaw97tKvuoSXAppsLVpWHXgX0s9T+suLBIZbv
    GK9vihYxa9z/KdnE7CGGoUF6XYq06r2drBaM7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323700; bh=xrPUOQt3lYYJdYYyo1l
    N+U3smQDejdFy2hYevO4yfNg=; b=Hacpg+tJkOaU8hJOJa1iXaO+rD+AvcHBBvW
    DaYJzFfLyIUxTdoKDEvHi6mgZ7G0Kbz0H8mPniRqk3Sxn42nvXxfSK+Iq1P+L5SE
    CqtSMvpDAgxmcw3Dl1Tmbho8LoYSYoF7IgnZ057hHinz3iwSwx3lkL74K19mDflZ
    meTJ6ChNpdvTdsoSEUg/VrGPehQQ49kJU51wQ28v+HF36/bVVBe4laa4Wzwgq4X4
    wWIB9zIfQckTG5QtY9T1JcJONI5VtVHzr+zcoj6sEONy8Mv8SPD/JqbfTb+VD+P7
    d1y2eMrsYal6gl7C3Fzaf3XxppdjkSmvg4hr6R3G+RB3kuxspbA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbeBKEeT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:34:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41659 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752923AbeBKEeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Ladi Prosek" <lprosek@redhat.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.292935615@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 019/136] KVM: nVMX: set IDTR and GDTR limits when
 loading L1 host state
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ladi Prosek <lprosek@redhat.com>

commit 21f2d551183847bc7fbe8d866151d00cdad18752 upstream.

Intel SDM 27.5.2 Loading Host Segment and Descriptor-Table Registers:

"The GDTR and IDTR limits are each set to FFFFH."

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8695,6 +8695,8 @@ static void load_vmcs12_host_state(struc
 	vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->host_ia32_sysenter_eip);
 	vmcs_writel(GUEST_IDTR_BASE, vmcs12->host_idtr_base);
 	vmcs_writel(GUEST_GDTR_BASE, vmcs12->host_gdtr_base);
+	vmcs_write32(GUEST_IDTR_LIMIT, 0xFFFF);
+	vmcs_write32(GUEST_GDTR_LIMIT, 0xFFFF);
 
 	/* If not VM_EXIT_CLEAR_BNDCFGS, the L2 value propagates to L1.  */
 	if (vmcs12->vm_exit_controls & VM_EXIT_CLEAR_BNDCFGS)
