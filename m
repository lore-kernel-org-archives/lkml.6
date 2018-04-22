Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405485-2-5256932788867648964
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
    1524405484; b=kGRwnvcbpoBC3nCT9pDudXnQ6jmdivoDXiY+rPvyZbRN7LQUHm
    RR+FMNEDQwdALJvoUy8OAzs4LJm7En20uA4aLZqWRmPk/rkP5rm4zMU1pdc2XDHD
    18DbIfP1YgYkQeeAlt1gaaSLY6MxQIviHldN9+0dE8Tc07dGz/ZEzXvbsH5juurg
    6VidRNnMS6CcPLQXkARfTeJQIfI7Afso5b1F2/i/AbjvzKSDh0LKFIenanm1N0MD
    x/oH1Cozo1k8vDHFoIfj6dWB9q3aQcSK4EEwYDjHKGINhvoGZgiZ0YstiePfwxM6
    9kvUf24Q2pzXXUIaD1/7vhz+HfBV69zkwcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405484; bh=I7s8WqU8ilWuLlcI3mAh0HFYT/elPv
    hT0LB4Jkv7gyg=; b=wTr0VjCMrpysAoXO9YTnnxkh5W9SrPh9OihLOJGqpVqwAp
    CWy2YfolAmDNogZYcxY4sF8E3GNii7ylBuHttRKCNzvgThQpt0nx2RCFjrKRSHZw
    mwmLGqkVQMEk9t345PTpli3ZjtBZnO1SOUWM0WyF02c3GEb0XgZHqkJ/jb2lFw3O
    lr2ZdofrnGRJPMpWHl6t4jI0d+Uy687sMsSchDqlZrx4j3XkxmRBGmchNGPrI17F
    re0BzoZMUUE8MG+09xDvBDodpI0s+dVu0BoyUkrZ0hmjv3KP3j8kiPReM7qUReDn
    c5HE6DSP/i/swDryT02kfc4um0A4IxqalpynvqGQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfEoqyuYSBQV0SryPwMp093HqB3CVr7khN2wJp5HDaVxWXeCPI19W0lSj8xZr0EIrBsHFm4PMVoKFmYu/LgQYz/LmeisfpfvK620foFWWEe/hHi+HoGGh
    LFB0HBl2zuP1qRmfIcCcDjuJZEy1adzwmMBqI7qwgTt1vp/K1bF6Ivt+S9TTGXjSY68CaJw8xpcZVUAdiWvsftrIwVMKZsi42vimpgy8LRhvlTG1ikfs9Xdg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=ag1SF4gXAAAA:8
    a=oDGFtuMiSMaEt90OD5EA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeDVN6C (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:58:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeDVN56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:57:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aniruddha Banerjee <aniruddhab@nvidia.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.16 080/196] irqchip/gic: Take lock when updating irq type
Date: Sun, 22 Apr 2018 15:51:40 +0200
Message-Id: <20180422135108.454224384@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aniruddha Banerjee <aniruddhab@nvidia.com>

commit aa08192a254d362a4d5317647a81de6996961aef upstream.

Most MMIO GIC register accesses use a 1-hot bit scheme that
avoids requiring any form of locking. This isn't true for the
GICD_ICFGRn registers, which require a RMW sequence.

Unfortunately, we seem to be missing a lock for these particular
accesses, which could result in a race condition if changing the
trigger type on any two interrupts within the same set of 16
interrupts (and thus controlled by the same CFGR register).

Introduce a private lock in the GIC common comde for this
particular case, making it cover both GIC implementations
in one go.

Cc: stable@vger.kernel.org
Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
[maz: updated changelog]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-common.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -21,6 +21,8 @@
 
 #include "irq-gic-common.h"
 
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 static const struct gic_kvm_info *gic_kvm_info;
 
 const struct gic_kvm_info *gic_get_kvm_info(void)
@@ -53,11 +55,13 @@ int gic_configure_irq(unsigned int irq,
 	u32 confoff = (irq / 16) * 4;
 	u32 val, oldval;
 	int ret = 0;
+	unsigned long flags;
 
 	/*
 	 * Read current configuration register, and insert the config
 	 * for "irq", depending on "type".
 	 */
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
@@ -65,8 +69,10 @@ int gic_configure_irq(unsigned int irq,
 		val |= confmask;
 
 	/* If the current configuration is the same, then we are done */
-	if (val == oldval)
+	if (val == oldval) {
+		raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 		return 0;
+	}
 
 	/*
 	 * Write back the new configuration, and possibly re-enable
@@ -84,6 +90,7 @@ int gic_configure_irq(unsigned int irq,
 			pr_warn("GIC: PPI%d is secure or misconfigured\n",
 				irq - 16);
 	}
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	if (sync_access)
 		sync_access();
