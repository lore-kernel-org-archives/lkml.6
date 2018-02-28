Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519838836-2-13689354079186192695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838836; b=dWQu3yez0xUUqy/ayIDKgp1u5BZBc6vo9294EPAnItfEwBi
    AGodIKdSN7LWeO2DpO1QXR16G7TWK1aq0TGxz81KAylp5ULntJoXl02LePhyqcT6
    sjZNSPL3SdhwXGibIwwKTGiDQ8nmUwitta2E/NP7mWNyT7+hneh+Ct3ZosMgiqe8
    7bJwU4GwgQMX0t0xc5d23f9dKhPVyQWKlzGaiKMceW+n7zmXnhNf7qtTQCZOwGGJ
    CDXk/ttw81IwGe2LWFad3J8jvn235XYW4OP01qBp52yGbkSjhtu5o/8sgwiXKp3O
    Dal8L4Hvqwpc6dmbGC3ziqY7IbYKWOrVxtCNkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838836; bh=CLwGaDJCg8J3g2FRmRT
    Nt+q/7H3e5wx6uzE+WqoQgxM=; b=ExVYXccj3PP2oKErL7Jblf/BTea4AoaRqYd
    64Irf8s3iF1SCoGG7CoAO8gd9qrm3o/A0sqKN+i6KP6GNVdT3HKNN/Y1uLUmkvoh
    +yubvjcvqsX35ka1p9yLf7ldn/m0qvb7ZrjMbb99OnAwZcIRBSif45gsBkxihy/f
    Z6xOBFoNwVLYeaANDlyV609iRYOBD8lx84Dy266kOd5nJmyaN4oKilN2Hg+JELM4
    cEQJIXlgXLKW4w3q/coBNj6rrTlCocT+LpXf2UcXOpdycFiAwFHfhcVXHWL9p8Pr
    f5QkrGvuXrEX4BspQTzWCYKLgmw83YC8jisE8wvdmQ8g6dJw6Mw==
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
        id S932400AbeB1RZJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:25:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33296 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932611AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Aaron Brown" <aaron.f.brown@intel.com>,
        "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Benjamin Poirier" <bpoirier@suse.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.711091898@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 076/140] e1000e: Separate signaling for link check/link up
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Poirier <bpoirier@suse.com>

commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013 upstream.

Lennart reported the following race condition:

\ e1000_watchdog_task
    \ e1000e_has_link
        \ hw->mac.ops.check_for_link() === e1000e_check_for_copper_link
            /* link is up */
            mac->get_link_status = false;

                            /* interrupt */
                            \ e1000_msix_other
                                hw->mac.get_link_status = true;

        link_active = !hw->mac.get_link_status
        /* link_active is false, wrongly */

This problem arises because the single flag get_link_status is used to
signal two different states: link status needs checking and link status is
down.

Avoid the problem by using the return value of .check_for_link to signal
the link status to e1000e_has_link().

Reported-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/e1000e/lib.c    | 11 ++++++++---
 drivers/net/ethernet/intel/e1000e/netdev.c |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/lib.c
+++ b/drivers/net/ethernet/intel/e1000e/lib.c
@@ -435,6 +435,9 @@ void e1000e_clear_hw_cntrs_base(struct e
  *  Checks to see of the link status of the hardware has changed.  If a
  *  change in link status has been detected, then we read the PHY registers
  *  to get the current speed/duplex if link exists.
+ *
+ *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
+ *  up).
  **/
 s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 {
@@ -449,7 +452,7 @@ s32 e1000e_check_for_copper_link(struct
 	 * Change or Rx Sequence Error interrupt.
 	 */
 	if (!mac->get_link_status)
-		return 0;
+		return 1;
 
 	/*
 	 * First we want to see if the MII Status Register reports
@@ -494,10 +497,12 @@ s32 e1000e_check_for_copper_link(struct
 	 * different link partner.
 	 */
 	ret_val = e1000e_config_fc_after_link_up(hw);
-	if (ret_val)
+	if (ret_val) {
 		e_dbg("Error configuring flow control\n");
+		return ret_val;
+	}
 
-	return ret_val;
+	return 1;
 }
 
 /**
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4222,7 +4222,7 @@ static bool e1000e_has_link(struct e1000
 	case e1000_media_type_copper:
 		if (hw->mac.get_link_status) {
 			ret_val = hw->mac.ops.check_for_link(hw);
-			link_active = !hw->mac.get_link_status;
+			link_active = ret_val > 0;
 		} else {
 			link_active = 1;
 		}
