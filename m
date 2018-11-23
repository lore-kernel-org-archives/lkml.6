Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683FD20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dnD0S6Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683FD20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408311AbeKWR6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:58:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbeKWR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:58:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAN79UmK186783;
        Fri, 23 Nov 2018 07:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=6oChp6IlwFJRiE/pNceTCbO15V6573NX8MJlwLtAlIc=;
 b=dnD0S6PzOl7CKJ6tPpNdF4J6vySfpCK71nrcskre2Vm+XKLYXW8Jz0lBZGh0vp4frQoB
 NvobmUPtgMcGX0r+YGNDIgdFFEHPkXJhQLsg25jf/cKXSfp3/XAg5bc+OWiib9qcPZ0p
 Gn/VSuwleMd4W71UtOfZgAbzdGiOHv/64mhqXfaI7P1qjwDaKfZFEzOvCdqBaX/uem6V
 KlFNgTjdJ+aLPXj0RFHlTqIa+jopqBqamwPYyvTuNQkK+3bykhmh0mxXYThHldSiOwc/
 Ioo9F6Mq4vpXggNzcQQ0gFa060zjKfeGh57uIjoL99+hLkoZODCzDSUJ+OF2GmeZfyh2 Bw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ntbmr1b32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 07:15:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAN7FCKH030433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 07:15:12 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAN7FBH5007936;
        Fri, 23 Nov 2018 07:15:12 GMT
Received: from kili.mountain (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Nov 2018 23:15:11 -0800
Date:   Fri, 23 Nov 2018 10:15:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] ic3: master: off by one in mode_show()
Message-ID: <20181123071505.ahhh7xqvt4eb7tt2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9085 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=790
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811230057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be >= ARRAY_SIZE() to avoid reading one element beyond the
end of the array.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index bda4b9613e53..c39f89d2deba 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -475,7 +475,7 @@ static ssize_t mode_show(struct device *dev,
 
 	i3c_bus_normaluse_lock(i3cbus);
 	if (i3cbus->mode < 0 ||
-	    i3cbus->mode > ARRAY_SIZE(i3c_bus_mode_strings) ||
+	    i3cbus->mode >= ARRAY_SIZE(i3c_bus_mode_strings) ||
 	    !i3c_bus_mode_strings[i3cbus->mode])
 		ret = sprintf(buf, "unknown\n");
 	else
-- 
2.11.0

