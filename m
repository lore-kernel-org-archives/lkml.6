Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89926C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9EA218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EWMYwe0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLZGJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:09:39 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48734 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLZGJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:09:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 855AAC39
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 06:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bBq23uNmtMke for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 00:09:35 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 57CB0BAE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 00:09:35 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id p66so17863812itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Zu3oOlJIreDm2RYh4MGnRpXj5fhkcOJCw3iyQkoPKv8=;
        b=EWMYwe0V+IlrJJjpn//dchM6MyLAp2fM3wIiI8xniaEaRoRzIGDjIpc7yb3H1jCM2c
         xz5dYComLia8VMMKuQYK+pTZhXgASpahze8ULdcKqXwLEzdRulXiQxA2svLDwfR4xo2F
         mQdi8Tl/YakGL6AES/BgwAk5Cozf9faEqzUTzHUwzJDS4PcWQyY0P/6QSSq7NcZ6DWZ+
         s4fveyJrPeF9+yc99qSCWnB0AvsSDcR247jiizFC4hWIe0EaA2ctvSZ0FFopwUQChDAA
         EL2I5maLxvPVK1Hcc40a2/PqfEj1BRWYDxn/Ma4wgXJit3/x4ikw1MuT4zv0c72tY/6q
         mbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zu3oOlJIreDm2RYh4MGnRpXj5fhkcOJCw3iyQkoPKv8=;
        b=mRrJvRkBZ7fitzwnGDN4TNYA3m5/d4+MmkVZPlA2rexvOpi6RU4xQ8VCpUR3dr8Y7g
         R3xr9zxSN0ta5MNbSdKXFTDuS6Bxg3hjhOY0Ae6FFQkf2wliwjhT8M/64yEo0MtPR2n0
         TxK85eBgtDP8rd4cn43Hb/H/MH4akz73MpRWvv3Vsg4zYgaPNRSATvI1DOr7BDSgEqG4
         S8Jwz5Tevsq77LUUQf4pA2vpQb2b+2Ww+Im/RssQDHEZ4k2AWwxZDHSVIkHkZpCoJEQ0
         okPuuaxWI9hELINDRmURC8lmPE+m37aSFk02iQIFflVsKBYNBSn4Eriz4WN1CTKsiK7X
         lLeA==
X-Gm-Message-State: AA+aEWZFUiXlYyiDjnALFDBr1ucf/Xj6UrKH57gJqmZWfMVW2JBFSDvk
        Mgv4+PV5osRZceee6qByoPZXIbkl+clehiyaDazL5YKsJnqbrVIcbzI86mvxvAe1v8GClkDBcMd
        j1Cn5iveae1C9F+P4cGz4jLoKBzaW
X-Received: by 2002:a02:5f49:: with SMTP id r70mr12025825jab.128.1545804574680;
        Tue, 25 Dec 2018 22:09:34 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XglHIjD+rOz6e4wTYYtycyEv9yK2phDa8S7wctm0RpalZ1abceaQ/rOY6BJPQp0sGL2Ag9Ew==
X-Received: by 2002:a02:5f49:: with SMTP id r70mr12025813jab.128.1545804574426;
        Tue, 25 Dec 2018 22:09:34 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id t1sm17291620iol.85.2018.12.25.22.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 22:09:33 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: fix a missing check of genlmsg_put
Date:   Wed, 26 Dec 2018 00:09:04 -0600
Message-Id: <20181226060904.75202-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

genlmsg_put could fail. The fix inserts a check of its return value, and
if it fails, returns -EMSGSIZE.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/tipc/netlink_compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 6376467e78f8..764aa29612ea 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -904,6 +904,8 @@ static int tipc_nl_compat_publ_dump(struct tipc_nl_compat_msg *msg, u32 sock)
 
 	hdr = genlmsg_put(args, 0, 0, &tipc_genl_family, NLM_F_MULTI,
 			  TIPC_NL_PUBL_GET);
+	if (!hdr)
+		return -EMSGSIZE;
 
 	nest = nla_nest_start(args, TIPC_NLA_SOCK);
 	if (!nest) {
-- 
2.17.2 (Apple Git-113)

