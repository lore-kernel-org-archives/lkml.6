Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340EA20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cM5SKOpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340EA20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeIYB4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:56:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45596 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeIYB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:56:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8OJmfCM014742;
        Mon, 24 Sep 2018 19:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=KHl+mvPqO+yDcs7njhxv8AUGS1cM0lgnjgIYATjPu9w=;
 b=cM5SKOpRUAaiQuISntcFIBYLTTM+2aMLiRZwCN5e510DIkjNPCJnfAaYUV89lr26hIao
 7yDFJMV5Eg28LZmhO5rMf37Kx9w+AHgnD6p3TQDpCCfIyr4p/+D1URbr5G4zbXj9Qfap
 soJ7vc+ypoFEnwvRr6XLwO2RseaG+jRujP6o7TE7YR+3NK8bMCOIokovcgZWuYKroAh8
 bOqPBOjS7cHbsNiC81wDRH8c1Eg90wdmHoFyh8mkx0fl98WfTrAExqgpERs2trhhzOO6
 Gj5QVSeHd3jaI9vr76lgYGMNJcF1JHQ7FwtkoEsSFnSlySKIAbcEkUkWQOFmSWwFGDr9 ag== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mnd5t81ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 19:51:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8OJpafq028897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 19:51:37 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8OJpZwH024535;
        Mon, 24 Sep 2018 19:51:36 GMT
Received: from userv0022.oracle.com (/10.11.38.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 12:51:35 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT_PULL] SOC: driver updates for v4.20
Date:   Mon, 24 Sep 2018 12:51:02 -0700
Message-Id: <1537818662-6307-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9026 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=814
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_4.20

for you to fetch changes up to 7bcfe20d0d8b647879629798fa57e39905d6cded:

  soc: ti: fix spelling mistake "instace" -> "instance" (2018-09-24 12:43:21 -0700)

----------------------------------------------------------------
soc: driver soc update for v4.20

  - Enable host-id as an optional dt property
  - Fix minor typo in knav driver

----------------------------------------------------------------
Colin King (1):
      soc: ti: fix spelling mistake "instace" -> "instance"

Nishanth Menon (2):
      Documentation: dt: keystone: ti-sci: Add optional host-id parameter
      firmware: ti_sci: Provide host-id as an optional dt parameter

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
 drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
 drivers/soc/ti/knav_dma.c                          |  4 ++--
 drivers/soc/ti/knav_qmss.h                         |  6 +++---
 4 files changed, 29 insertions(+), 9 deletions(-)
