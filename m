Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CACAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2AB208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgGTBLo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2AB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJRQFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:05:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeJRQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:05:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I7wRCZ118137;
        Thu, 18 Oct 2018 08:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=brDzh1fUH/xpsM/gNpjs9sQ9STnUqPcl6UQtgPCmvmc=;
 b=TgGTBLo9GDpsEovVWehxLcIz0SisUigO6kiW7qoLzjLIHXOOyuZldOhpES/LTJMacsE2
 1lv5x7Be3kEdOHZPlcqrKzJJkHgK7wz65YJeekOKE6S8J7XOfxM3gCybQM3mEBLjEaf4
 WfsSNNgb1HjGE4HpIVEKlya+OCm2TgCJ7hVXQrV2bhxDoCGOllxzvW1IOIogyM4tdqRA
 Pn3jI3BsGRHcYeOi5V2PX7A+0gSOqXamdGFHmbyzayXSPwzE+hE2zl4Mu7wtslMWSEze
 BqvQZ0fp38srfdDV+X8BukQhbdkTxJTFaMBC8GYqbWb46AOaudE814FeKJXG9GcP6kiP 0Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brmsff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 08:05:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9I85gbA004594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 08:05:42 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9I85frn009577;
        Thu, 18 Oct 2018 08:05:41 GMT
Received: from kili.mountain (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 01:05:41 -0700
Date:   Thu, 18 Oct 2018 11:05:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mattias Wallin <mattias.wallin@stericsson.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] mfd: ab8500-core: Return zero in
 get_register_interruptible()
Message-ID: <20181018080534.yw2crvhguen5vajg@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed this in review.  The get_register_interruptible() should
return zero on success but it instead returns the value that it read.

I looked at all the places that called this directly and they check for
negatives and treat greater than or equal to zero as success.  This
function is also called as the ->get_register() function pointer.  Some
of the callers of that treat all non-zero returns as errors, so it's
possible that this bug causes some problems in real life.

I could not find any callers that rely on the current behavior, and this
makes the function align with the get_register_interruptible() in
ab3100-core.c.

Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mfd/ab8500-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 30d09d177171..66458a329127 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -252,16 +252,18 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
 	mutex_lock(&ab8500->lock);
 
 	ret = ab8500->read(ab8500, addr);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(ab8500->dev, "failed to read reg %#x: %d\n",
 			addr, ret);
-	else
-		*value = ret;
+		return ret;
+	}
+
+	*value = ret;
 
 	mutex_unlock(&ab8500->lock);
 	dev_vdbg(ab8500->dev, "rd: addr %#x => data %#x\n", addr, ret);
 
-	return ret;
+	return 0;
 }
 
 static int ab8500_get_register(struct device *dev, u8 bank,
-- 
2.11.0

