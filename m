Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324810-2-3660125610265803663
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
    t=1518324810; b=oNBCuuD7zjy/XwRMjePitJb3ZPkHAnLJFNJ81fncQrqW8jj
    cu2rEcgJLe8W6VTmIxIxfm84p8fJmZfC6+Pg0dOe87KA3X3ZnSRkCTdptPDVw87S
    LCyBkLWgHNvA4MT9RFDBcelQl6fVnn9LKRaBt2AwKqbtkwxomMnJ0oKrziyBR6Qq
    Ie9VeYdeA0fElu1wdcq4V/FxbBvogoRbfkZOW6yyiG8JuN/ZNehLI63Vy0mwG4gE
    3f5hnVI4whUqN7dkVT5qxzo4w0w9am6uUbfpvU60sI1V23+Iz3rPVwCZKFHGttBk
    QvnfRk7z3DT3tQHUytniPNERpO8kfkSgepgXQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324810; bh=h5is5BPkXxxsJ88pIpD
    dPh5qe0kNyMVrmD7z6YRIY9o=; b=c18TwIQUlowzrc5VGCKo/iyaf0kah0da+3j
    8awcM5kCFhxKgmZc3OHKNQn5FZEwi++STBbwpWb+KE+VUCCJJkH/95SXmVdTToYN
    FxENS4mkY7Mj9mL68bu9AZNa8IAY5LwAOeaybgQAIbZX8JXGvCtBppRpmvtni3tC
    SxzYVfQ3XfNz6a0smRK8+H2zsxLfNZW8NB0koXzCZHE9CbrrI7ksOwlKLdxAhebd
    l2444UwHmr24QxFA9SUYz4/VK9B/0DQw0/yohgi9fa0ZUEl+Cpv6kbw4jglkBxff
    LF1NyV3UclEZr/GFXaZtwkdIiBQ9uBN+xPo+XXnGLVnQCJ9S5xQ==
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
        id S1753610AbeBKEvn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:51:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41754 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752817AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        "Brian King" <brking@linux.vnet.ibm.com>,
        "Aaron Brown" <aaron.f.brown@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.655142759@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 111/136] igbvf: Use smp_rmb rather than
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

commit 1e1f9ca546556e508d021545861f6b5fc75a95fe upstream.

The original issue being fixed in this patch was seen with the ixgbe
driver, but the same issue exists with igbvf as well, as the code is
very similar. read_barrier_depends is not sufficient to ensure
loads following it are not speculatively loaded out of order
by the CPU, which can result in stale data being loaded, causing
potential system crashes.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -808,7 +808,7 @@ static bool igbvf_clean_tx_irq(struct ig
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(E1000_TXD_STAT_DD)))
