Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF6C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944C72070C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oFL/GTEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAEQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:18:20 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:54186 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfAEQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:18:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0AF47D57
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 16:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cVBQqiZiEPKP for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 10:18:18 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id D084BD24
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 10:18:18 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id 128so4025610itw.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 08:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EdwU4yU1+pAyGU+TkYjcCsYXH7yf/ra9OzPs4lLX0H8=;
        b=oFL/GTEuZ6hVcoboa8+2JvSIkWpK4m6Tyt4S2CiULpVFVe82HC5BV+ncWGr19+JWpI
         1ET+9uCioZGmGpeXeaRhgQSvTKX05a3EQmTlpKDYq+bc1leA/2jzMY4BzEX4YCCIWsXH
         YDur6sr8uU1LaKIEhd8bEsxAU8lsv/anDy1ACBXG2v7FoajQ9vYPkoaQX8cFDzz8bqW8
         5DDMhd895chG9Qr1Ej5JknOxTiivW9YbKkLMHJsDrf8VVBwarCaegEHX7zOA8/B6rej3
         f5bF19ePKYjDTNC+ntkzZvF6un8wSlu+RhQ1HbccWH1g6rXh5mOlrVDB8gFE4GEPCqOZ
         oLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EdwU4yU1+pAyGU+TkYjcCsYXH7yf/ra9OzPs4lLX0H8=;
        b=QEfuZSyOjuwAyMiSMH6cqgWRm6vYXUIbGH2/lCYkB6e7aTVy4ww+RCq6Vejo38Vx7d
         y/zCXsiPeBhtXc+rnmv75kKYTyf1tk+A/33ZkVgNQZGBP3KVayiWGceSPEd/q50hSGB4
         hDYOoqAAFfh5pgNMgauhOorQzNPapNOCqCFej0TAP9rdIPbkPD4HNx2eXhQvNCEtCZKE
         ZjU7CP1CIa2wN2bYEkxt1mGn5Q7qp9Srs1vdMVbLsV6Z4KTzM7Td3oMS9qYL3ZtIdzv5
         XxtVrHB0KNmL+Fp9zW//FM0kOwgS+1A54Iy01eDhXsQUothe81Nwa12alAr8IR9M5f3s
         0XNQ==
X-Gm-Message-State: AJcUukecrJXjspLwSrrE9YNzlIoc8nE5VXomfz4isXracjr5uI+Bq+J6
        8iA9MawrslSrNet5paVr9MhTOHDWk3F+w//ufnH55VdHeLCQTjt7efGNwXI32g88PfWFm1ZTV+T
        gjf86fMWy1Ia8PVow5xdKRl8UkR4M
X-Received: by 2002:a5e:d503:: with SMTP id e3mr26452370iom.291.1546705098416;
        Sat, 05 Jan 2019 08:18:18 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7i0cmdF7jyKGNQRFI+4ADpWxtHT5m6Ol3cQJ/oY44LWoQ3qcqnz/6oXunmasEBtRrc0dtERg==
X-Received: by 2002:a5e:d503:: with SMTP id e3mr26452360iom.291.1546705098167;
        Sat, 05 Jan 2019 08:18:18 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m11sm2171199itb.24.2019.01.05.08.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 08:18:17 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [V2] infiniband: fix a missing check of nla_put
Date:   Sat,  5 Jan 2019 10:18:07 -0600
Message-Id: <20190105161808.3496-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_put() may fail. The fix adds a check for its return value, and
returns -EMSGSIZE if it fails, post canceling netlink msg.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/infiniband/core/addr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 0dce94e3c495..e847b34bacd1 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -178,7 +178,10 @@ static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
 	/* Construct the family header first */
 	header = skb_put(skb, NLMSG_ALIGN(sizeof(*header)));
 	header->ifindex = dev_addr->bound_dev_if;
-	nla_put(skb, attrtype, size, daddr);
+	if (nla_put(skb, attrtype, size, daddr)) {
+		nlmsg_cancel(skb, nlh);
+		return -EMSGSIZE;
+	}
 
 	/* Repair the nlmsg header length */
 	nlmsg_end(skb, nlh);
-- 
2.17.1

