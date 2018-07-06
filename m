Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A8623FFA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WDj0LLwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A8623FFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeGFIjg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:39:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52538 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeGFIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:37:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w668Y4Ck163794;
        Fri, 6 Jul 2018 08:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2017-10-26;
 bh=KWsnD/+nRLAZ13A33OnghMEgjl6DewjiTj1Fkeyy8V0=;
 b=WDj0LLwI0i69a3X4Axm47vJocy0Jq4k3b8DN9kXSn+FfCzDxs4KZX8tCBIZQNAp3DcVW
 iqU/tjeMR6JXsc9QEj7gxx0qP3R9XQkoZYLG+MXCxVW4GtG/559YLnWKMsh3gHC0xFzJ
 oJUzDzASTWWw5qeJUWubXedqZQy60PJGCQ0qDxjO6se5Jn1JsC35Weon6zMWYmMyl59k
 V9BUE3mHsyFmuVdTqMd4ULJTLNrvvyX2FnRFwLnD0//QGokwLMViBsNv3L1VkLegx8k2
 xXBzCBrv8LZt3CD5Qm3+VZKBaWBxIdPrKMtiM7e5HvFk0BpoVNpOIjRnrhTdova2m/Jn gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k0dnjrpda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jul 2018 08:37:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w668bUke022609
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 08:37:30 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w668bUCi009721;
        Fri, 6 Jul 2018 08:37:30 GMT
Received: from kili.mountain (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Jul 2018 01:37:28 -0700
Date:   Fri, 6 Jul 2018 11:37:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: max8997:  clean up a condition in
 max8997_list_voltage()
Message-ID: <20180706083718.n3b7ejg42fknnwb2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8945 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=804
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807060095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code generates a static cehcker warnings because "rid < 0"
is always false:

    drivers/regulator/max8997-regulator.c:169 max8997_list_voltage()
    warn: condition is always false

The problem is that because of type promotion, if "rid" is negative the
comparison against ARRAY_SIZE() is type promoted to size_t and it's
treated as a very high positive value.  I've changed the order of the
checks so now everyone is happy.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index a8ea30ee18a6..029a6ee426ab 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -165,8 +165,7 @@ static int max8997_list_voltage(struct regulator_dev *rdev,
 	int rid = rdev_get_id(rdev);
 	int val;
 
-	if (rid >= ARRAY_SIZE(reg_voltage_map) ||
-			rid < 0)
+	if (rid < 0 || rid >= ARRAY_SIZE(reg_voltage_map))
 		return -EINVAL;
 
 	desc = reg_voltage_map[rid];
