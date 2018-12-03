Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E41AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4395F20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJLBjGxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4395F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLCOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:51:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:51:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3EnDbM041600;
        Mon, 3 Dec 2018 14:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=H3z7hEy8VqHF6brWhtUjNh1isuTV2H8pX5Gx1bozmt0=;
 b=LJLBjGxbpu2aNJvhTCzgrYDBD3RB6eiag3dDuskStoS52ian2fpn/8iVlI8xb3P3tw0B
 PiSpuZoFEgLqJqWExvacAj49QB3fi5iU+f1Kc7KCvAfnOrr5q6SLn+oXDn1EElIiuIMe
 qQH+gWCEL6x8aUdi2V3ENk/fIcuI4XrgiL/1mQyJXHYCvZqF9HglLP15dbdYCOVVr1dQ
 wwUAjut0MCwczDHFqfkoA2UdUOaJLkmg4u05GfivEwRIELo0zYOVCIE0qd/SqVp3TWmE
 IK/bqOBADMc0MqwAWt7JtAH18sglAH+/yX40IRCSUnTL+KkU+Pom+veBzxMdRfonxBud uw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p3hqtpt1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 14:50:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3EoM5X016246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 14:50:22 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB3EoLIe017999;
        Mon, 3 Dec 2018 14:50:21 GMT
Received: from kili.mountain (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 06:50:21 -0800
Date:   Mon, 3 Dec 2018 17:50:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mailbox: ti-msgmgr: Off by one in ti_msgmgr_of_xlate()
Message-ID: <20181203145011.7s3udfz4cug3ph3k@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=543
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The > comparison should be >= or we access one element beyond the end
of the array.

(The inst->qinsts[] array is allocated in the ti_msgmgr_probe() function
and it has ->num_valid_queues elements.)

Fixes: a2b79838b891 ("mailbox: ti-msgmgr: Add support for Secure Proxy")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mailbox/ti-msgmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 713d701b6568..6f6addd51d14 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -547,7 +547,7 @@ static struct mbox_chan *ti_msgmgr_of_xlate(struct mbox_controller *mbox,
 	}
 
 	if (d->is_sproxy) {
-		if (req_pid > d->num_valid_queues)
+		if (req_pid >= d->num_valid_queues)
 			goto err;
 		qinst = &inst->qinsts[req_pid];
 		return qinst->chan;
-- 
2.11.0

