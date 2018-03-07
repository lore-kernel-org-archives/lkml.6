Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520452144-2-13947150591623315399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452143; b=WhnDAA8NjSPlfQHRU9dU4p8kLi3f/k886xBKT/imF+Sw9ex
    TysdPUZUCY0EAH+mUHYMoYYyZbXegbLK/0wSiVj4sTY56oD2uliEV1VhU+FZE47v
    I4tSV+vISKpc4fzG67nSzsHTrMGsuhWX6KSrv7RXbxPTljCWLYzUOwn2vB3cVxrD
    0hKpkdQSPk76zs38rGQdZt8M+nNiYMJlf4sAqIp/nwsVxHgBOzZfaW9+4WkNfxD0
    GWJ4lP7ZjA+cDOOfa3GbRmyY4GgEQSW5GNwvT6H7kDUPvGN5vI7Iuvh55cD+CE4t
    PxnEln0XfhYXTOMHpMmLt0R0r2ntrdxJncI7yNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452143; bh=P5mS3l/Z1dXm5+gkr+57UlS5lb
    imt4Eks3NS/Z0lPnY=; b=a8K0765pY04mw0AGiThmgwxTYrpaJYP3466rsfB0Ha
    kLCRHiTzclS5vFDxrgQIQsyGKHqR4ne7xYXPO3tz6kbdMYaNEbm65dWkHg6W7p0P
    DLq8Wjcbqrk0mNn0Y+NZ8TIVbL20gWtbmEIvJi5fxVx2qmMnGdqrBdJxj++np4UP
    6pcuoUwpQzBy+8P9kc8dRTLTXDI76M9F9VlozoPJyEJWqR3EyePl6E0DZ071/Tqv
    sU+82hNHvyZOdKQqLNUVB/2jbIYB2tO+TI7/iNoIfvpSMKFiWlYRkwJ1hTxSY9xP
    N5A8UcPuQ4ItxKq+qRLf/dtP1PWThudcrcaBUheH4B6Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965975AbeCGTsi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:48:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965954AbeCGTsh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:48:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.14 089/110] KVM: s390: consider epoch index on TOD clock syncs
Date: Wed,  7 Mar 2018 11:39:12 -0800
Message-Id: <20180307191051.269268206@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: David Hildenbrand <david@redhat.com>

commit 1575767ef3cf5326701d2ae3075b7732cbc855e4 upstream.

For now, we don't take care of over/underflows. Especially underflows
are critical:

Assume the epoch is currently 0 and we get a sync request for delta=1,
meaning the TOD is moved forward by 1 and we have to fix it up by
subtracting 1 from the epoch. Right now, this will leave the epoch
index untouched, resulting in epoch=-1, epoch_idx=0, which is wrong.

We have to take care of over and underflows, also for the VSIE case. So
let's factor out calculation into a separate function.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180207114647.6220-5-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[use u8 for idx]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |   32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -169,6 +169,28 @@ int kvm_arch_hardware_enable(void)
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 			      unsigned long end);
 
+static void kvm_clock_sync_scb(struct kvm_s390_sie_block *scb, u64 delta)
+{
+	u8 delta_idx = 0;
+
+	/*
+	 * The TOD jumps by delta, we have to compensate this by adding
+	 * -delta to the epoch.
+	 */
+	delta = -delta;
+
+	/* sign-extension - we're adding to signed values below */
+	if ((s64)delta < 0)
+		delta_idx = -1;
+
+	scb->epoch += delta;
+	if (scb->ecd & ECD_MEF) {
+		scb->epdx += delta_idx;
+		if (scb->epoch < delta)
+			scb->epdx += 1;
+	}
+}
+
 /*
  * This callback is executed during stop_machine(). All CPUs are therefore
  * temporarily stopped. In order not to change guest behavior, we have to
@@ -184,13 +206,17 @@ static int kvm_clock_sync(struct notifie
 	unsigned long long *delta = v;
 
 	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm->arch.epoch -= *delta;
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			vcpu->arch.sie_block->epoch -= *delta;
+			kvm_clock_sync_scb(vcpu->arch.sie_block, *delta);
+			if (i == 0) {
+				kvm->arch.epoch = vcpu->arch.sie_block->epoch;
+				kvm->arch.epdx = vcpu->arch.sie_block->epdx;
+			}
 			if (vcpu->arch.cputm_enabled)
 				vcpu->arch.cputm_start += *delta;
 			if (vcpu->arch.vsie_block)
-				vcpu->arch.vsie_block->epoch -= *delta;
+				kvm_clock_sync_scb(vcpu->arch.vsie_block,
+						   *delta);
 		}
 	}
 	return NOTIFY_OK;
