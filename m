Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324640-2-8806914200568855944
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
    t=1518324639; b=tLmaD16q9EYNFGuyP12/wOkgsAa6SvMUoUNBAbOaepkd0C0
    5YRNyKS/1O7q1BZLx8sRUShjJ6CEc5MhfRtajjPOIOiw46Tj6jG+eIFnlYtqMRJC
    ZMgH/v561G9Nr1hKrDopGgfru2X37wFkelQsnVdksManLfBoStTT+eO7mfzo0Lvv
    vobmrhsO4FszaKp3VGbbfO/HXohY/2J9MIklajhAYqXR+DQ3uwtd49nuwnETbZr1
    +5rk8CpgOAUEbJDqovVcgUa1u5mAmhKObhcIPty7ZN/ZZilOJeP+KcChrptMAY+e
    nWt2VA5n8K64D9avz6DqEGIGE5e4g07FQbQx8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324639; bh=sEBZQ2++5l8jGkfr/4R
    F/hHhbDvHQkzQ1HyqMjNXMW8=; b=gJGBhU/+HdxT/uJKIxPuVHSY77Kq8cLTsPN
    iyDeEf7Hc/Q2keW3Ii2LYL3xLIhbDMrwi7snODXPKS6XR9DzeJqcg8hUQUXD5rk9
    eDt6mguiN86i/BM5lndCT16XDXC3ztKFeA1frZ3kq/hsx2yhLNYAQXv6HJu5FgUR
    7dEuv8temezioFNATbkLTHKsasVCWqpG2yOXFSYsqYSUMPAhukn/05rsa+6p3t91
    CLY8ysW0GsxzeafiYeNdnrxw958DQEmX05cSFDuSOfRL2vIg3vxJ7vph138Rnpl4
    lYkH4eoVW6idTqW88r9FXr0csax3ieVUVYrUm8bJQG0RemItNQA==
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
        id S1753169AbeBKEtn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:49:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41790 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752831AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Brian King" <brking@linux.vnet.ibm.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Andrew Bowers" <andrewx.bowers@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.683489827@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 108/136] ixgbe: Fix skb list corruption on Power systems
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

commit 0a9a17e3bb4564caf4bfe2a6783ae1287667d188 upstream.

This patch fixes an issue seen on Power systems with ixgbe which results
in skb list corruption and an eventual kernel oops. The following is what
was observed:

CPU 1                                   CPU2
============================            ============================
1: ixgbe_xmit_frame_ring                ixgbe_clean_tx_irq
2:  first->skb = skb                     eop_desc = tx_buffer->next_to_watch
3:  ixgbe_tx_map                         read_barrier_depends()
4:   wmb                                 check adapter written status bit
5:   first->next_to_watch = tx_desc      napi_consume_skb(tx_buffer->skb ..);
6:   writel(i, tx_ring->tail);

The read_barrier_depends is insufficient to ensure that tx_buffer->skb does not
get loaded prior to tx_buffer->next_to_watch, which then results in loading
a stale skb pointer. This patch replaces the read_barrier_depends with
smp_rmb to ensure loads are ordered with respect to the load of
tx_buffer->next_to_watch.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1086,7 +1086,7 @@ static bool ixgbe_clean_tx_irq(struct ix
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
