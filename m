Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324843-2-12622819694714418013
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
    t=1518324842; b=jnEPJvi/VvFOoi4TeXEI/Ya7U8FE2uTtPpIrvdEwdmtso7E
    Z61QXdAEvfFKiMTPfmUb/BUs7x2ztq/apEXukhtucBZRQTjyGCu7CoxMxNlpiAVE
    Po18GkzWrD+6t3rjjx+I0BTpP4EDv7WRGDzZC1YBl9J06036n3T6c9h55YEFiZBi
    AygXpXE7HPi7iomNhuCsYk7G997bg9d57zXPpTI148xN7mWsHqdEYFyUcrREs40g
    3SmN50KMzGUxzAuGje2LaaDwN9F/7UUic778OQrUEA0yQYzfMMjn1STjdIfB/ADR
    dcnCluTp2hotd9TAxREU4VItt0kq5t8fYIadP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324842; bh=N6UcuqPHOCi8sSkFmgR
    i7u5A9KnwYspKS1L3/4RuBIg=; b=OCprnPiThxUree8wUa9DF0xKWn4z9KxQYsI
    KYEgtC8pD32RqwiKLQaqdq2qU9vk8DPDaM/c8o/P8JqBwC9OXWlEfON5lF1uQf9P
    Qu6HL7xMws+t6oXg19WnwSLQdi+DS1vh2ZFS2iub6rKc0JGENSkHSDzkCj3HF39B
    wIOCq5AsoKPwbr2n5lhevEKhL4JsODc4CgkwvVgZXrEKBeYW+pXy9leRgLBbk1p5
    09afhUQ/jIZdX9rAMiXhuC9f5z+vptD/FqNwDzQ+vTDWN6NoktcRHnh+x7nj5Jui
    vNcj5IhA2FZoYnOJNajiY+DtqQL/BHL07FEJbnDwZTpPCSe0ylA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeBKEvh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:51:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41765 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752824AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Andrew Bowers" <andrewx.bowers@intel.com>,
        "Brian King" <brking@linux.vnet.ibm.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.776089863@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 110/136] ixgbevf: Use smp_rmb rather than
 read_barrier_depends
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

From: Brian King <brking@linux.vnet.ibm.com>

commit ae0c585d93dfaf923d2c7eb44b2c3ab92854ea9b upstream.

The original issue being fixed in this patch was seen with the ixgbe
driver, but the same issue exists with ixgbevf as well, as the code is
very similar. read_barrier_depends is not sufficient to ensure
loads following it are not speculatively loaded out of order
by the CPU, which can result in stale data being loaded, causing
potential system crashes.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -249,7 +249,7 @@ static bool ixgbevf_clean_tx_irq(struct
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
