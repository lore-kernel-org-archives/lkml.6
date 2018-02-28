Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835796-2-1672724613605302824
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
    t=1519835796; b=DoBSRm5S4SXgjsPeq3hu9rxRmwRMGody2UewVpybIQKkkdG
    OViL1uVjOBDrkcba+NIIN6KdcxraajdJKrtQoNBvs9MrEHl3/xR18gxvTwIhAJ8l
    1IMyXldu26O0KKgHx2LQCdqMgfR3EgUbKtwKcL7+0xEgilfABwPd1iwqWnJSUhcx
    zPgmfJsQJBMyIgJihEFmjF/gu+iuDt+EhYapTaQHGj1nbFfM+EB0MXSbfm6ndWl6
    qm+m7wIyglttd1KQyGRQOilXwGKn6yomy4QvP1v2POpkMuGyfVHVmKwsm0V473H/
    wwnV/1ca4m1wBVGRvdH2zgHDMjjrcsaORjdRTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835796; bh=JNtrIQmlBh8k/rLGZRw
    KR7twjrWJji3qSBBxqWOhpkE=; b=Ws+srKngKGA0DyJskUNtmLVCjeD2P+MpVTC
    rjsbh5MgqNFsPwI5TQ+ca+9XZWhIvbCkepyij5inBia1+LYrmSjEEiOnoS2GCxgm
    2cqEwQNrtQaHz4jH9rrtOVlamJxrIi6WD3W2JusVYVnFO9zxlN2nqP9BJuIn0H2j
    XMG3ga2z/SE2Qq8oxQZ47PQGjkeCdj5hnJUOtWgc4sJ1wlg+mC57RS+Q7ykVRBjz
    1mWzWnoZYgIx1x5/QO9o1hCcilcJ605rLseDDUrOIR8T7ClXLuceCFIoEEP8kHXO
    Cl0vCYdaxC/LJmsILaw4Mj7PYQTu8srj1zq9cVqHUsagibazNyQ==
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
        id S934428AbeB1QEt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34846 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932702AbeB1QEs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:48 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andrew Lunn" <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobias Jordan" <Tobias.Jordan@elektrobit.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.807064421@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 066/254] net: mvmdio: disable/unprepare clocks in
 EPROBE_DEFER case
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>

commit 589bf32f09852041fbd3b7ce1a9e703f95c230ba upstream.

add appropriate calls to clk_disable_unprepare() by jumping to out_mdio
in case orion_mdio_probe() returns -EPROBE_DEFER.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3d604da1e954 ("net: mvmdio: get and enable optional clock")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -241,7 +241,8 @@ static int orion_mdio_probe(struct platf
 			dev->regs + MVMDIO_ERR_INT_MASK);
 
 	} else if (dev->err_interrupt == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto out_mdio;
 	}
 
 	mutex_init(&dev->lock);
