Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324685-2-8115831906599942147
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
    t=1518324685; b=KYcktGnFMA7BmNkAGIfmtZ6xVnoi4PEScrUzrF+o01XlzEr
    M7mVv7sKhqmh0f7hyjoT0IiLKr/4RV2jfKwvG0yiLH2HSWjfweMAT5MfFK1De3zU
    5a2peM2I7Wvrf0x9z+wU0psZrHH1TM6dBas7Uj2Ziv+AtdijQSssCobFeejPy64h
    3ZFF2nn/gA1aILGw2s2dDGnKCTcDNQirpL9rIgaI06lcYjOdsdzEYE6L2mwZXmY8
    nbBQIv6FcK5kU9Pr3KVj3I/qSA6GvbBD92c3rWqiTkV/Z/postBZU5zjNUxiX1a0
    RG61HLRdW3pLeGX/ETCaEufWMiQDLzOxZUikFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324685; bh=adsw6eX3hOWYGVc9LA5
    2esNdMhzTgESIp+rxlKGApeI=; b=E6UwDowmjOspaMoI0n7eMzwK0HxBv9iNIkj
    GVRNMxC4ROUFUQaxvtbwMUlrLDfHx9Rlnx21c5A3SxAAXEkZc0c/fozNdAqJkoqO
    8Hx/EyXCk6bj83KUcsAFvFOv280yy16mGq6oiYSkSN9FExjsmu3xc+THfn5UTcqK
    mfpicR2ilQTHPEiHg9DyvAtVTW0eXPtbua7QkB2mEJGThi7m5YwgDEVxkwtFgu9g
    earm/RQ69PzbBYh7YK2kCysQOyfEjXdnWNxyMabKiKsvNKwISjznhq7VGNRTYYDP
    uzNH/y/gmZZ18qFJxcexHgi14xs47tpFS9h49Zh2hxck1/d/p1Q==
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
        id S1752830AbeBKEuy (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:50:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41781 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752828AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Brian King" <brking@linux.vnet.ibm.com>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        "Andrew Bowers" <andrewx.bowers@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.102901349@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 109/136] i40e: Use smp_rmb rather than
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

commit 52c6912fde0133981ee50ba08808f257829c4c93 upstream.

The original issue being fixed in this patch was seen with the ixgbe
driver, but the same issue exists with i40e as well, as the code is
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
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3047,7 +3047,7 @@ static bool i40e_clean_fdir_tx_irq(struc
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if the descriptor isn't done, no work yet to do */
 		if (!(eop_desc->cmd_type_offset_bsz &
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -657,7 +657,7 @@ static bool i40e_clean_tx_irq(struct i40
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* we have caught up to head, no work left to do */
 		if (tx_head == tx_desc)
