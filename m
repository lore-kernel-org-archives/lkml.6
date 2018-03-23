Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804838-2-18233513237544485734
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
    t=1521804838; b=htbub8SIdB55CtI/Mzg2R9jlWwSutawKWJZ+SApay0/gUoZ
    047CwgK1eK7EXt9avaT1T8JMtI0L3QDb3Tzl8p28NbPN5+8PFBcjqA6a6PWIXhpG
    0RpUoh4D7jzK8I0BKPADXU+7TGF329Syw0kaHZIeVJGmrF7t3raKweyUCSBcAhTD
    6Mkauk7ho8Ar+GjzIsZsmrstEVyL5mMeAZ4VZJ9ExSXIp/U8lfgZ9TfFvaKlMKGe
    K3JWiy9CJSFFdLY1JGPAHHE/djK5QUH9baY3PVBZQnSWWmPB3oXDJdhiP7MhkhMX
    GFUewqxTEt7bphLm8udlU7vriPFnVHmwQyJsnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804838; bh=/solamJ3C2DLK86rvKoeJYqum0
    a8MDBsZDjVAi7QB6c=; b=JBjdoLDDXnRdO4zRff1DOo3oN49TarQIseplW8Jr2/
    MpsUeVlYbYiI8g6du/v+ym6V7f0Edt0rSa9TuAvMXkx2Mdg5wg1U7mRhdC9wHX1+
    02OuUYPmf7A+lBLO4gzVBvpIhJPr9WREe1UlD8WqLKQGhzqFkjovGqCHUKNzh88J
    LMtjBTE2Rxl+4EsMYZ+LJ6FoRx/UCDHgSImrS5JDHtv6bkTFg+AxYqr4il4p/Oiy
    iu+tWb1VM7gvzeQdIKQ0mWO2di8jKg09WIIgzKGDwDxc4O9NQ6MvRZM4wgXCFnb5
    KbQuqDKyP2ebpcRxIRjnZWV0WwstSnEpgvjkkGXpyixg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755001AbeCWKFb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754935AbeCWKF3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 037/177] irqchip/mips-gic: Separate IPI reservation & usage tracking
Date: Fri, 23 Mar 2018 10:52:45 +0100
Message-Id: <20180323094206.787496927@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>


[ Upstream commit f8dcd9e81797ae24acc44c84f0eb3b9e6cee9791 ]

Since commit 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy
domain") introduced the GIC IPI IRQ domain we have tracked both
reservation of interrupts & their use with a single bitmap - ipi_resrv.
If an interrupt is reserved for use as an IPI but not actually in use
then the appropriate bit is set in ipi_resrv. If an interrupt is either
not reserved for use as an IPI or has been allocated as one then the
appropriate bit is clear in ipi_resrv.

Unfortunately this means that checking whether a bit is set in ipi_resrv
to prevent IPI interrupts being allocated for use with a device is
broken, because if the interrupt has been allocated as an IPI first then
its bit will be clear.

Fix this by separating the tracking of IPI reservation & usage,
introducing a separate ipi_available bitmap for the latter. This means
that ipi_resrv will now always have bits set corresponding to all
interrupts reserved for use as IPIs, whether or not they have been
allocated yet, and therefore that checking it when allocating device
interrupts works as expected.

Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Link: http://lkml.kernel.org/r/1492679256-14513-2-git-send-email-matt.redfearn@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-mips-gic.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -55,6 +55,7 @@ static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
+DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
 
 static void __gic_irq_dispatch(void);
 
@@ -746,17 +747,17 @@ static int gic_irq_domain_alloc(struct i
 
 		return gic_setup_dev_chip(d, virq, spec->hwirq);
 	} else {
-		base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
+		base_hwirq = find_first_bit(ipi_available, gic_shared_intrs);
 		if (base_hwirq == gic_shared_intrs) {
 			return -ENOMEM;
 		}
 
 		/* check that we have enough space */
 		for (i = base_hwirq; i < nr_irqs; i++) {
-			if (!test_bit(i, ipi_resrv))
+			if (!test_bit(i, ipi_available))
 				return -EBUSY;
 		}
-		bitmap_clear(ipi_resrv, base_hwirq, nr_irqs);
+		bitmap_clear(ipi_available, base_hwirq, nr_irqs);
 
 		/* map the hwirq for each cpu consecutively */
 		i = 0;
@@ -787,7 +788,7 @@ static int gic_irq_domain_alloc(struct i
 
 	return 0;
 error:
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 	return ret;
 }
 
@@ -802,7 +803,7 @@ void gic_irq_domain_free(struct irq_doma
 		return;
 
 	base_hwirq = GIC_HWIRQ_TO_SHARED(irqd_to_hwirq(data));
-	bitmap_set(ipi_resrv, base_hwirq, nr_irqs);
+	bitmap_set(ipi_available, base_hwirq, nr_irqs);
 }
 
 int gic_irq_domain_match(struct irq_domain *d, struct device_node *node,
@@ -1066,6 +1067,7 @@ static void __init __gic_init(unsigned l
 			   2 * gic_vpes);
 	}
 
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
 	gic_basic_init();
 }
 
