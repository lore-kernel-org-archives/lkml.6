Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57642C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DC120895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tirokkTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DC120895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJMR7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:59:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50048 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeJMR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:59:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9DAKVZQ015244;
        Sat, 13 Oct 2018 10:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=+rZkSVUgEaGyjCLKqYVzb+D1TcVxq0X8nw8IHxDeaAk=;
 b=tirokkTGghJ0j2+c9tjgE+OaGQLuBOq1Dmnhq1mZ5/vNe6hVTXqSR54TqPLqM6B2zB15
 sYaWtBA5ESaUb3uYYAIuQY1aZRreTm+zz0pX4fEtsDLjlhPB72VVVRkjRTcv9Duxarfz
 2kmonny/B0cCpAxkzSZSS0SGb4MLwQI6ihIaM2RL5D4nOek1VEaZIzgxC4wtw4bLn086
 oog5ZH5NbI365EPX5Ups5r0BY/ZMWqlgIoyKkENEogSX4mtDhAnP0iOoYMLPP/qaP8HR
 KJL32qLfbmTsnPogiSsr9emhL9KfJJdpnMfZa0XKKV5OvyZsHoDTeYNiCRe6MK9iF5kd OQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n39bqs3eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Oct 2018 10:22:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9DAMThZ000843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Oct 2018 10:22:30 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9DAMSD8000455;
        Sat, 13 Oct 2018 10:22:29 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Oct 2018 10:22:28 +0000
Date:   Sat, 13 Oct 2018 13:22:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tony Prisk <linux@prisktech.co.nz>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] clocksource/timer-vt8500: remove duplicate function name
Message-ID: <20181013102222.GC16086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9044 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810130099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We print the function name twice in a row in the error message so I've
removed one.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
index e0f7489cfc8e..c3aff1a8f7d5 100644
--- a/drivers/clocksource/timer-vt8500.c
+++ b/drivers/clocksource/timer-vt8500.c
@@ -145,7 +145,7 @@ static int __init vt8500_timer_init(struct device_node *np)
 
 	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
 	if (ret) {
-		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
+		pr_err("%s: clocksource_register failed for %s\n",
 		       __func__, clocksource.name);
 		return ret;
 	}
