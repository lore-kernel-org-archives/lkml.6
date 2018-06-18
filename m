Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F275C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCF9208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NcnACHza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCF9208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935141AbeFRMFU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:05:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36960 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934786AbeFRMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:05:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5IC3p7e176900;
        Mon, 18 Jun 2018 12:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=IthjKZJKYvkZUJCypEdwOCg9FA5GKBu+XQRCN4uPUA4=;
 b=NcnACHzaIFTu4NtUVhvlZMybwyDiwmjSZ6lgbu7jBfMQ2y9o8gLQIhEiwWW1i3wHEIYV
 rmK4sY4RtBbZdzEnu96zU9opLYYu9b08mCUCcDpD/kyynhE7B2a53eqVVqLfX8tDa65/
 b1Dm+SaWaz3f90twEuToEikzQn8Qj7BC3c/rGhvQngDNldY2qNSd724ZUS4MUYJrWr3s
 +KiGaLWH6S0pLsb4tUZViczczb46A1c5SJPFlew8xa9IH73OnztPCky87C4Su/QORsTz
 m0PP4fuJSwPKKpCyeER2eTsUxIXAuHnM6wJfab7kNLcc3cJE4hkBHcFexnyAj/bloIR1 uw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2mbw0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 12:05:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5IC4xCu012418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 12:04:59 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5IC4xwd005627;
        Mon, 18 Jun 2018 12:04:59 GMT
Received: from liran-pc.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 05:04:58 -0700
From:   Liran Alon <liran.alon@oracle.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     idan.brown@oracle.com, Liran Alon <liran.alon@oracle.com>
Subject: [PATCH] net: net_failover: fix typo in net_failover_slave_register()
Date:   Mon, 18 Jun 2018 15:04:05 +0300
Message-Id: <1529323445-23777-1-git-send-email-liran.alon@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8927 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=465
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806180146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync both unicast and multicast lists instead of unicast twice.

Fixes: cfc80d9a116 ("net: Introduce net_failover driver")
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 drivers/net/net_failover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 83f7420ddea5..4f390fa557e4 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -527,7 +527,7 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 
 	netif_addr_lock_bh(failover_dev);
 	dev_uc_sync_multiple(slave_dev, failover_dev);
-	dev_uc_sync_multiple(slave_dev, failover_dev);
+	dev_mc_sync_multiple(slave_dev, failover_dev);
 	netif_addr_unlock_bh(failover_dev);
 
 	err = vlan_vids_add_by_dev(slave_dev, failover_dev);
-- 
1.9.1

