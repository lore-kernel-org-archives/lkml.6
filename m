Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBCDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1AD2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vM5U66kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1AD2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbeIUQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:28:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50672 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeIUQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:28:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8LAdgbt085730;
        Fri, 21 Sep 2018 10:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=yywmGyJZCmjFMbqU6wFiXfF8xbFENHtIXjLxjwSCU8A=;
 b=vM5U66kX3mcmNj75sNY0/K3RzMDgpJU4cUCn1QPBGHJPhaGiHgB4nVE7xcAOiMTsUqsT
 S7KhWVDFvrJx2ADsE4+0Yus7HiKlaIfnQ9pLizfcPTvdExeb1wFr6iHzlUOixNjcf/5c
 zqOBN4yK6CErWnBL8oEEEKh81s7dzJLT2Kx4lwOa0eueSEVta4/9IudqNCj83N84yysY
 L7ohaN1kEjRLI3pe6dI5ApY+fbZzzvIuFOburaxgQlcB3BJHJd3cdUnT6r3CL8TaoDH+
 LyQ7J3Z50OUObI0OkFOhDU7XqRx+k88lCUlJEcO8BEESYh1cb4vnIH24FwWZBcceA4ei 9w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mmkm22cuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 10:39:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8LAdfCo030757
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 10:39:41 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8LAde11026297;
        Fri, 21 Sep 2018 10:39:40 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Sep 2018 03:39:40 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 0/2] net: if_arp: use define instead of hard-coded value
Date:   Fri, 21 Sep 2018 12:39:28 +0200
Message-Id: <20180921103930.1420679-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=503
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct arpreq contains the name of the device. All other places in the
kernel, the define IFNAMSIZ is used to designate its size. But in
if_arp.h, a literal constant is used.

As it could be good reasons to use constants instead of the defines in
include files under uapi, it seems to be OK to use the define here,
without opening a can of worms in user-land.

This because if_arp.h includes netdevice.h, which also uses
IFNAMSIZ. For the distros I have checked, this also holds true for the
use-land side.

The series also fixes some incorrect indents.

Håkon Bugge (2):
  net: if_arp: Fix incorrect indents
  net: if_arp: use define instead of hard-coded value

 include/uapi/linux/if_arp.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--
2.14.3

