Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722692081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajJJpcqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfBUSko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:40:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUSkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:40:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LIY1js015825;
        Thu, 21 Feb 2019 18:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=8xGBbFGBQ5w4REzMMHT+9jWRuxT92qV2u4BTJcrv9Ug=;
 b=ajJJpcqzQaoHcDP5mq8z+AP4u9M3Ax+3OauO35FmSqK2KuoucGoHjlLfF3Wc1FndpOC2
 ukrmTbFJUKyo4L0z300eDpH9rU6TAcuU098VUS4c0YTDV0HKo07iN+RlprIFCcmDhUFg
 TCmrLWR7WWFM4tJNEAFbZGmYVQacpwGwwecpZfBS5hc2VEAgodaqwWeKposxJ7qPqDwV
 Nk60sjK4c+yOs6y/4nHEeEkAWxEzHXuhaTpwogfwyYEQxmwPIumWA68FA/slIrCN/QGS
 wYjFXT7W5PAQqGdR7trJhEn3by5h1lrEplOWpmzsDwbYn9DGBuIJYZdILwgapAgMgJts Kg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5rsv8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:40:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LIeZDU017828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 18:40:35 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LIeZQi031910;
        Thu, 21 Feb 2019 18:40:35 GMT
Received: from kadam (/197.157.0.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 10:40:24 -0800
Date:   Thu, 21 Feb 2019 21:38:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] test_firmware: silence underflow warning in
 test_dev_config_update_u8()
Message-ID: <20190221183826.GA30993@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221183700.GA1737@kadam>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We put an upper bound on "new" but we don't check for negatives. In
this case the underflow doesn't matter very much, but we may as well
make the static checker happy.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_firmware.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7222093ee00b..5911b0f1a715 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -326,15 +326,12 @@ static ssize_t test_dev_config_show_int(char *buf, int cfg)
 static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	int ret;
-	long new;
+	u8 new;
 
-	ret = kstrtol(buf, 10, &new);
+	ret = kstrtou8(buf, 10, &new);
 	if (ret)
 		return ret;
 
-	if (new > U8_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_fw_mutex);
 	*(u8 *)cfg = new;
 	mutex_unlock(&test_fw_mutex);
-- 
2.17.1

