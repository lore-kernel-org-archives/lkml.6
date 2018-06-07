Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nE3qCMhCGVsMAgAAmS7hNA
	; Thu, 07 Jun 2018 14:36:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 50FD9607DC; Thu,  7 Jun 2018 14:36:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E3E98601D2;
	Thu,  7 Jun 2018 14:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3E98601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934124AbeFGOgn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:36:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40419 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933652AbeFGOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:36:41 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zx-4v; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Ew-LZ; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Masatake YAMATO" <yamato@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.96188700@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 351/410] route: remove unsed variable in __mkroute_input
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masatake YAMATO <yamato@redhat.com>

commit cb1c61680d29a054b91a23c7a504cea8a72bdcff upstream.

flags local variable in __mkroute_input is not used as a variable.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/route.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1587,7 +1587,6 @@ static int __mkroute_input(struct sk_buf
 	struct rtable *rth;
 	int err;
 	struct in_device *out_dev;
-	unsigned int flags = 0;
 	bool do_cache;
 	u32 itag = 0;
 
@@ -1660,7 +1659,7 @@ rt_cache:
 	}
 
 	rth->rt_genid = rt_genid_ipv4(dev_net(rth->dst.dev));
-	rth->rt_flags = flags;
+	rth->rt_flags = 0;
 	rth->rt_type = res->type;
 	rth->rt_is_input = 1;
 	rth->rt_iif 	= 0;
