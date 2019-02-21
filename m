Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C610C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C02B2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="stVbGm1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfBUShY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:37:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42076 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:37:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LIXs1X015722;
        Thu, 21 Feb 2019 18:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=1Zkf2SOUloSMzLb2KdIblJ9t0QF8265SuuDCl+i7Mec=;
 b=stVbGm1BAf6m8GHxr0cEmZsMHAo6G70rgtrb8Mi3ht4Dyx1QwxFl9zIThiHWkEuxAHfz
 iKbF4WKcVztIfUpywqGMTBPw9TTPvkbiuaQsxU04G87UIrYd9dDzeAv2ZoiT0XuuTcsj
 dgz8wRbIju8yAK0zW1I7aA25Q30skATUX9gW1knTBig/9iD/lyLlHmS4bLyk5KwMhLpU
 LsJvXpjoiUppoGz7eGc2SEVt/TXfdAMjCurtEKUn4dBlF1EsWkUbMwU8pdf4moOFJIJI
 FWR19x2p0G8zT+w+1rmAcgJr2aa+IFVPpG9UGE+2c+DSJIDPT80bxRR4bUDz5X4wz3Xv 1Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qpb5rsup6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:37:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LIbAoQ002524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:37:10 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1LIb9qx021981;
        Thu, 21 Feb 2019 18:37:09 GMT
Received: from kadam (/197.157.0.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 10:37:09 -0800
Date:   Thu, 21 Feb 2019 21:37:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] test_firmware: remove some dead code
Message-ID: <20190221183700.GA1737@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_fw_config->reqs allocation succeeded so these addresses can't
be NULL.  Also on the second error path, we forgot to set
"rc = -ENOMEM;".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_firmware.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7cab9a9869ac..7222093ee00b 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -631,11 +631,6 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
-		if (!req) {
-			WARN_ON(1);
-			rc = -ENOMEM;
-			goto out_bail;
-		}
 		req->fw = NULL;
 		req->idx = i;
 		req->name = test_fw_config->name;
@@ -737,10 +732,6 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
-		if (!req) {
-			WARN_ON(1);
-			goto out_bail;
-		}
 		req->name = test_fw_config->name;
 		req->fw = NULL;
 		req->idx = i;
-- 
2.17.1

