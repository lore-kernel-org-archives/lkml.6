Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524840429-2-13736585389854977384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840429; b=ArXv1QMGfgiJVDsiMK6tqlbbVA8r1PzPtUngeVJyfXVLmVmmzJ
    lMRxhWoYUa1ZAr/ZtVLN1zKWA8aJbGQ0CUOPYC8hhig/rP3JiHEcGzNwv0N7lQ/K
    8exEJjvdGhb83789DIkdH3dA2k2Ogr6UiMMNNCqBjaklTdg/XNlEYCZBIFYKpKIE
    h5dm5OHmDeJ0+ly6CiKqozkfdwmkY7czT6WbD8j/RmfyLNND8O2NIvKVI3crxZyC
    22xGIJNOSmsEQO247+jHR8vhYmmUaNqsv+j38zSMuLdgEVaTBG28xl52l5NQnAhg
    PTxCb9xmVMVcLZXEnzVRHCOAfxbFMYmnCv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840429; bh=zNR1Q2KZrav4FhphmC/Cz0uuCPWVNO
    14juWWPAKittQ=; b=LQC2E4i81BDtPedono0I7S9ZEM/Q5o//NwTkdIPymEpYBk
    IXlrTOuHfUcM72w4PRbsKlVt+lX2G4X3tSfI0aC0LMaSgst8QILIDFU5JL8RIlfD
    nJWzSfuQu9DPaPN64A2ACu8Fl96TpIi1dlCdr+BsGtDNxO3/22Btdr25ejrnmOvm
    +yPX9IG9lpSvfBWDWfuhEUYnw4xdwCz4C5zEok2Vd73jik+6U0UY4KO7n1+3mgnD
    YQEsPr0Hj5XdERsUy0f7GQZ3+P6sYu1D5xePwAUiTpt8JaMrJmEi9Q2wtjZQ2BOA
    zg1uOZ+rn985Zq+8KG3DzUVlWmpHhkdYClEQRxlw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAyrwxK0/yd9yGLYMECUbhBc4Kmh2zHzNOg+7KAkzRmoc6pW6LTUmNgDJD6jbWVcHr+nxZj+vx8sNISebFMoQliPL93P0CVU2PflyO1X+1paF8n4PDW3
    EHWelsFA3wfZKc27s1MG244M4uAcM8P6VRywRR2lkJyILeuQIzZpN35OWO0nGOfqTcTU/ra0jvXAjwSZAeOw1lnMyeK+WSTeQg30AuRws//ZqMp6Vd1hIWzI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=pBOFz4KDIYXk_25JnuYA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbeD0OHy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934379AbeD0OHx (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7944B21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 4.14 51/80] KVM: s390: force bp isolation for VSIE
Date: Fri, 27 Apr 2018 15:58:44 +0200
Message-Id: <20180427135735.535700520@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit f315104ad8b0c32be13eac628569ae707c332cb5 ]

If the guest runs with bp isolation when doing a SIE instruction,
we must also run the nested guest with bp isolation when emulating
that SIE instruction.
This is done by activating BPBC in the lpar, which acts as an override
for lower level guests.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/vsie.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -831,6 +831,7 @@ static int do_vsie_run(struct kvm_vcpu *
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	int guest_bp_isolation;
 	int rc;
 
 	handle_last_fault(vcpu, vsie_page);
@@ -841,6 +842,20 @@ static int do_vsie_run(struct kvm_vcpu *
 		s390_handle_mcck();
 
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
+
+	/* save current guest state of bp isolation override */
+	guest_bp_isolation = test_thread_flag(TIF_ISOLATE_BP_GUEST);
+
+	/*
+	 * The guest is running with BPBC, so we have to force it on for our
+	 * nested guest. This is done by enabling BPBC globally, so the BPBC
+	 * control in the SCB (which the nested guest can modify) is simply
+	 * ignored.
+	 */
+	if (test_kvm_facility(vcpu->kvm, 82) &&
+	    vcpu->arch.sie_block->fpf & FPF_BPBC)
+		set_thread_flag(TIF_ISOLATE_BP_GUEST);
+
 	local_irq_disable();
 	guest_enter_irqoff();
 	local_irq_enable();
@@ -850,6 +865,11 @@ static int do_vsie_run(struct kvm_vcpu *
 	local_irq_disable();
 	guest_exit_irqoff();
 	local_irq_enable();
+
+	/* restore guest state for bp isolation override */
+	if (!guest_bp_isolation)
+		clear_thread_flag(TIF_ISOLATE_BP_GUEST);
+
 	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	if (rc == -EINTR) {
