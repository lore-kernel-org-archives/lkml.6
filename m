Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838947-2-11010355838932286588
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
    t=1519838947; b=FO3KO8aAIbdctNSKXwTGD5qX7IhxNumpklZNqvzV1CdSJRu
    gmMXdBPnYHa++4DDYLiHFM/gtsuCUxsXNl+eiYYJSwq6s9D8bPrKOkzDcb9FeBqe
    YuQhgaB7HSLtyQHXwNs1mQ2Zs78Y9qgDMx1H0DNoUGD2+pMmpdTMoW2/k4E0MBHY
    du8X7BWeQ8yme3/1cMf0jdYECFPmxh7Z1pWMEQsklBDJKtBZrQrgXpceWMF4w+uB
    69V6/MCsbmXCcKd/0km/w7muOx18udxyVi7jLQPpoVZq1E1g4rc4udkcM9vcO/7y
    xwLgQWZDI+96qUJq6f5FA7bwhvRwXdZkqYPG7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838947; bh=Pe63J9NKsOmJVfOK3aw
    +0/H82SLzbjKveU08K4McQhw=; b=bk/Hr3WhgVqhJdsiaZW+7BZLGHYHviwIGBu
    c+XiOGwNSaomXhTfftEkcqj3PdujQLnW/H4V/8WgovGjlWEOUgETA/mY+BShsBCK
    7wJZFKIW624yVYykEEGVcyGXWd9xmwLwOCgyp6GpZyQNO9/uS1CYGXKSRKTX4UNy
    Nsxl1UgcpAadeYDVblyU1hcSLabKhYaKiUTow3/TzY+Eu/yNUxcbMVkA7XeP3Xbk
    W/NLWpM8BKRdNNt777nN2wm+5X+n6h/2+AZrmZqEiqk9xq7vgXB+jC4kJkDDiijq
    EAVQIjdgrK5Wc/P8lODfA55I+DOgYX1Y0W6ijKjQXQdRjOYBAMQ==
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
        id S932118AbeB1R1b (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:27:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33293 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932615AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Aaron Brown" <aaron.f.brown@intel.com>,
        "Benjamin Poirier" <bpoirier@suse.com>,
        "Gabriel C" <nix.or.die@gmail.com>,
        "Christian Hesse" <list@eworm.de>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.791522561@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 077/140] e1000e: Fix e1000_check_for_copper_link_ich8lan
 return value.
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

commit 4110e02eb45ea447ec6f5459c9934de0a273fb91 upstream.

e1000e_check_for_copper_link() and e1000_check_for_copper_link_ich8lan()
are the two functions that may be assigned to mac.ops.check_for_link when
phy.media_type == e1000_media_type_copper. Commit 19110cfbb34d ("e1000e:
Separate signaling for link check/link up") changed the meaning of the
return value of check_for_link for copper media but only adjusted the first
function. This patch adjusts the second function likewise.

Reported-by: Christian Hesse <list@eworm.de>
Reported-by: Gabriel C <nix.or.die@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=198047
Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Christian Hesse <list@eworm.de>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
[bwh: Backported to 3.2: e1000_check_for_copper_link() has a single return
 statement for success and error cases, so set ret_val in the link-up
 case instead of changing that statement.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -657,6 +657,9 @@ out:
  *  Checks to see of the link status of the hardware has changed.  If a
  *  change in link status has been detected, then we read the PHY registers
  *  to get the current speed/duplex if link exists.
+ *
+ *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
+ *  up).
  **/
 static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 {
@@ -672,7 +675,7 @@ static s32 e1000_check_for_copper_link_i
 	 * Change or Rx Sequence Error interrupt.
 	 */
 	if (!mac->get_link_status) {
-		ret_val = 0;
+		ret_val = 1;
 		goto out;
 	}
 
@@ -761,9 +764,12 @@ static s32 e1000_check_for_copper_link_i
 	 * different link partner.
 	 */
 	ret_val = e1000e_config_fc_after_link_up(hw);
-	if (ret_val)
+	if (ret_val) {
 		e_dbg("Error configuring flow control\n");
+		return ret_val;
+	}
 
+	ret_val = 1;
 out:
 	return ret_val;
 }
