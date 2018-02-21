Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218298-2-13416344842914134360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218291; b=C0RJkADwveQGLaF7ecWJpLnMKwXCiP4we9vpCB2mHbz2g7H
    hcxg/aOW9kWVHCL+S5Lt/x7jTqdUMOdfqiY5khgIo8whjLSdrGzao9+C1cQo3g1+
    85MmD6twdgfBTFXqCJfpwbwkfGJ9+bB0xCm3ZxjZu0HaCBZtTQpn/8pve1v91EDw
    urfHXu9hvc/0HHZnAkdWcx0Uq9hqpmmUG/XDLhDiHOKlH6nORdpdwtUQrYL1K9QO
    MyGPZZ7oChcniisX7SUgYi7KSR4pANYnYu5Xh72bS4tLxKGQfVqm6lMjI3CFXxB7
    CbnvAKqrUawtQIYGAxEYDQSpJtPxW/mxP3Z9GfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218291; bh=YyUjJTKuM6QBbCQ8fFZYlK3Pea
    j7BHpVOTHJLAbuuJg=; b=QJT3sM5XA6XZJFOeQ3dpVZQteRvS6KFGGRlFHX/vXT
    rQfcBjn2b7hz/I1ajrKXXhcVC/i7XAGiT0ihMoBFWMPviUgZurqrsfPAVB+GV7I6
    se9fAcCUp2IHSjBEH2OAmLRDFUDm7cLfrNFYhjCfVSyRH4D/vkIAH4YNuFKxMKFG
    1z+hZxAEW6ztNQsxTgswuTfNo6rt0BlsiqiR2zUcelLiRP4qNSE2zVAbd94dum+I
    gp1oxgpDXlUWuT4SQ9IcoPtNFe9PMIjjI1g0KPTJwcLnGo31R4va7yd3yrf5F7wn
    6YoPmPIw+mdYcF922phRvYCOPQkC6dLt+AhEDcSd6i9A==
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
        id S1754472AbeBUNEq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:04:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbeBUNEn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:04:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Yan <yanaijie@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Ivanov <ivanov.maxim@gmail.com>
Subject: [PATCH 4.14 153/167] scsi: core: check for device state in __scsi_remove_target()
Date: Wed, 21 Feb 2018 13:49:24 +0100
Message-Id: <20180221124533.206424943@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
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

From: Hannes Reinecke <hare@suse.de>

commit 81b6c999897919d5a16fedc018fe375dbab091c5 upstream.

As it turned out device_get() doesn't use kref_get_unless_zero(), so we
will be always getting a device pointer.  Consequently, we need to check
for the device state in __scsi_remove_target() to avoid tripping over
deleted objects.

Fixes: fbce4d97fd43 ("scsi: fixup kernel warning during rmmod()")
Reported-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Max Ivanov <ivanov.maxim@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_sysfs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1383,7 +1383,10 @@ static void __scsi_remove_target(struct
 		 * check.
 		 */
 		if (sdev->channel != starget->channel ||
-		    sdev->id != starget->id ||
+		    sdev->id != starget->id)
+			continue;
+		if (sdev->sdev_state == SDEV_DEL ||
+		    sdev->sdev_state == SDEV_CANCEL ||
 		    !get_device(&sdev->sdev_gendev))
 			continue;
 		spin_unlock_irqrestore(shost->host_lock, flags);
