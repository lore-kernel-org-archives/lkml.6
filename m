Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411258-2-8028011102842835845
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
    t=1519411258; b=YAxjo2zfZ+BLjv1PNkOudV1alioWdu/rjbNCpZWvHarYbLs
    BVkui5qh8U/YhpHpfOs+WQjCcy3XYAFBQyhHsQCL4mJQmSA0XvvE0dPC+pSxBzJi
    vU40/zMgHwpoGBTVLrWpqVrTQnEdQ10fWw3FqNm/V79ul+2GWKXQ+TZFocPNWkS5
    3XzJIbAdXEFUlxllg7Mli9kJb6//5/8xHlu4GKUXS/pBNY1HBcnmsKY2LNyNddYU
    Sn3Pi9yWoRgNZHJFc/PKGv7wdc04vTaMSUTL1B44LvhupD6sYFarK32HtzFvlvGs
    KNUIsvHFE1f4+zq8JEAkr2Kqk2YwYqMQyWmjhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411258; bh=WLm5Lx2sZFpvq+iRYx1sUHc8dm
    3id/i9EEIZ2GFNBnI=; b=U/Rb8UjmxGDEEw4McnJRppf7KZ2ZTiQljfroLQCqMt
    OBYTERofO2gqjCz8HFfz2LrYtbT9oKhg0YD6FD0vJZDXmN5yDzdkchjtKiQ+IKhl
    Bu6HXNpWNohDthwakys7W2es0/a8izsCk2AR3JbWsOKxKwQmwq+CIZgZ0GiiMpai
    2d2C7DEQnKjYmB7FhhpC2OCas/0waffx1/gGf7pPxexhCUFJ2fwR4Yyz/3EXteeu
    lCclceGpOMSfNLlnn7WFyZJm0c5NyiLBDmPxnrCl/aCaiS401Qhg/oY/yBduwydH
    IA477WCIeCY4vhAybi9aWewPjSEQbSeH362N0fjOaDiA==
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
        id S932685AbeBWSkt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:40:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932672AbeBWSks (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:40:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4.4 155/193] ncr5380: shut up gcc indentation warning
Date: Fri, 23 Feb 2018 19:26:28 +0100
Message-Id: <20180223170350.209664414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

gcc-6 and higher warn about the way some loops are written in
the ncr5380 driver:

drivers/scsi/g_NCR5380.c: In function 'generic_NCR5380_pread':
drivers/scsi/g_NCR5380.c:541:3: error: this 'while' clause does not guard... [-Werror=misleading-indentation]
   while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
   ^~~~~
drivers/scsi/g_NCR5380.c:544:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'while'

This was addressed in mainline kernels as part of a rework on commit
12150797d064 ("ncr5380: Use runtime register mapping"). We don't
want the entire patch backported to stable kernels, but we can
backport one hunk to get rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/g_NCR5380.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -538,7 +538,10 @@ static inline int NCR5380_pread(struct S
 			printk(KERN_ERR "53C400r: Got 53C80_IRQ start=%d, blocks=%d\n", start, blocks);
 			return -1;
 		}
-		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
+		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY)
+		{
+			// FIXME - no timeout
+		}
 
 #ifndef SCSI_G_NCR5380_MEM
 		{
