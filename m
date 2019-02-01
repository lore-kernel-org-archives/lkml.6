Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F8DC4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E4D218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fX6d3sgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfBASEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:04:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfBASEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:04:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11HwxWt144083;
        Fri, 1 Feb 2019 18:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=drD3YgQGMc9qJL9fvvYzJTyq8vsLPd1gLpS/tANbDzo=;
 b=fX6d3sgHdIYaUkLv0OdxC/+0cnHeGuUkMlKs8+OE1dKz9ztsvqYS6EKq9Mpk0BPs/95c
 FXog4rdFnVlG/WWpS3cMKNwnHOS9E7z3ia11R9oV8kxLEi0B94T5HF1A6oy3WsanuWUP
 qETxYec70IRcC7NatqT+6UZNl9iBATCIdnUB0XMgwzvg1PBqQ9c/wF+sc1b3pOXE/ZLV
 XyPeOM3NbvCNVOEqGoRTdkbrWhxZuF5zHzrzp2k4gjjEh8zX7GTLzpM7f8+ZiaqBhlgF
 qUETUwkF73tew92L+axSyNCUbZ3cTtk+q8BSYe+1N8GzZrFxQaDtJm5FpP8q39Y056x6 Rg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6rr1wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Feb 2019 18:04:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x11I4eXV027485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Feb 2019 18:04:40 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x11I4ceD001522;
        Fri, 1 Feb 2019 18:04:39 GMT
Received: from aserv0021.oracle.com (/10.11.38.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Feb 2019 10:04:38 -0800
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL] soc: ti: couple of non critical fixes for v5.1
Date:   Fri,  1 Feb 2019 10:04:23 -0800
Message-Id: <1549044263-5862-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=608 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.1

for you to fetch changes up to 2b13ef1f4261688c2dc5d67dbee69ed2fdddf53e:

  soc: ti: knav_dma: Use proper enum in pktdma_init_chan (2019-01-30 10:22:17 -0800)

----------------------------------------------------------------
soc: ti: couple of non critical fixes for v5.1

 - Fix the Clang warning for enum in Navigator dma
 - Simplify code in ti_sci with DEFINE_SHOW_ATTRIBUTE macro

----------------------------------------------------------------
Nathan Chancellor (1):
      soc: ti: knav_dma: Use proper enum in pktdma_init_chan

Yangtao Li (1):
      firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE macro

 drivers/firmware/ti_sci.c | 21 ++-------------------
 drivers/soc/ti/knav_dma.c |  2 +-
 2 files changed, 3 insertions(+), 20 deletions(-)
