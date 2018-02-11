Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326353-2-13736013314750832231
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326353; b=pASrSpgpIUIHiehNOlCcm1zb0EDTtkImxBxTAZJtSTbLxqU
    tstP9qfdgTsbczX1UKVLtVoukQZ5lAIq158Y2vbNXWUp3Hu8sqvVaUHXm4RaWtf0
    vdcJ7ggkNjNlrCiNgfOvtahsvWZLnX8KxHX6MzR3ICwRbNcWxQhJa67AFco0a12A
    pHgx60lCLqhXdqSWH+4pp3+rEZLnHqaUQRLsR/uzAX1kIGl1oKduNOvhsnVH0our
    QGVUuSLeSN5Fyd1OVpSOx5mEgQ3tkVJVLuJMgTrx67GNQDhn1Lp1mdzIvpmnhmo+
    r8+PyRkYot2F8rra8fVDOcEAiv4fHMMjdJ6JPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326353; bh=vt1TXnGfGxadeRqp7Nu
    GIgVpkAKKp8ZmOE+j+jGbLqc=; b=R+cc5TPGKw8id32i/g8P3emtHXwupUWjN4D
    OLzAoN3Aj6cCZZZSvuRKZr+CKlH+WnPy+3+mVrHXcHH0bxQOij6CAtSSwP0ZhDLe
    6JZc/B8Y4IPupemuZHyNIqpe3x2VE6l49ipKzR13NaNsBBmQZTcVsnPGyQKHUs+P
    2Az/v6b8VJ5Nw+kI6RCs4IkgnJpYkZg6B7ulfOjgZFlOHmA4rN8xjXZtEsJJDhgW
    x+KO+MxbfbxTGsQcm3eqWMQFQu+A+bPqfmOEt1R/MGgg+ES9YID1Syqhyra7m6ZW
    TZKulzmrFuQCvEsMvLnpS0sCdLj0ZkloZZg18HuAdiNngVKxnaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeBKFSa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754070AbeBKFSY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.927046@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 056/136] powerpc/pseries/vio: Dispose of virq mapping
 on vdevice unregister
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

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

commit b8f89fea599d91e674497aad572613eb63181f31 upstream.

When a vdevice is DLPAR removed from the system the vio subsystem
doesn't bother unmapping the virq from the irq_domain. As a result we
have a virq mapped to a hardware irq that is no longer valid for the
irq_domain. A side effect is that we are left with /proc/irq/<irq#>
affinity entries, and attempts to modify the smp_affinity of the irq
will fail.

In the following observed example the kernel log is spammed by
ics_rtas_set_affinity errors after the removal of a VSCSI adapter.
This is a result of irqbalance trying to adjust the affinity every 10
seconds.

  rpadlpar_io: slot U8408.E8E.10A7ACV-V5-C25 removed
  ics_rtas_set_affinity: ibm,set-xive irq=655385 returns -3
  ics_rtas_set_affinity: ibm,set-xive irq=655385 returns -3

This patch fixes the issue by calling irq_dispose_mapping() on the
virq of the viodev on unregister.

Fixes: f2ab6219969f ("powerpc/pseries: Add PFO support to the VIO bus")
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/vio.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1572,6 +1572,8 @@ static struct device_attribute vio_dev_a
 void vio_unregister_device(struct vio_dev *viodev)
 {
 	device_unregister(&viodev->dev);
+	if (viodev->family == VDEVICE)
+		irq_dispose_mapping(viodev->irq);
 }
 EXPORT_SYMBOL(vio_unregister_device);
 
