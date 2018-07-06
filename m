Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1ABC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E80622B26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BAUOjIhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E80622B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933016AbeGFV0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:26:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60016 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeGFV0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:26:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w66LOorp158611;
        Fri, 6 Jul 2018 21:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=XjGvH13Tc8zzj5WzO+wuueXfmsCitx7jwRBG3a5dWOc=;
 b=BAUOjIhjhaZouUUcaqep1j2bPW/QO7JX8/i38J+VqNZ+M3h0QH4pF1aS6JGAZBuoVGJd
 nDWEQqjZOVHJTIiR/hQ/UtciSl5u+iNF2P10QsO7/yIf3btO46Jr44sp3C9s6zGMFncD
 2wIHW4Rox0I84EA6stIoybjnioBZ7pXQDe9HtHvWV8IXdundCDxS2PQN9Xz66q7nQzqi
 K3Q2IhtJQVmDlViA8DsIbNBeswyviFxPJ/18WOm1EnxnDrrXeqlZz+S2A+4cL6cv4Gs5
 77SWXEv6kkWoE8yJO1PLwaIpMvPxgUkCvVmEjXPbMFiuNZKlkMtQC9D6YVnK0dJAZIlR 8w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k0dnjk0x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jul 2018 21:25:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w66LPnhB014450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 21:25:49 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w66LPnWZ009435;
        Fri, 6 Jul 2018 21:25:49 GMT
Received: from userv0021.oracle.com (/10.11.23.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Jul 2018 14:25:49 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 3/3] SOC: Driver updates for v4.19
Date:   Fri,  6 Jul 2018 14:25:42 -0700
Message-Id: <1530912342-4641-3-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8946 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=445
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807060241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.19

for you to fetch changes up to 990c10091db318c7eb7e8935c86b6f7c01585015:

  soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused (2018-07-06 09:47:51 -0700)

----------------------------------------------------------------
Keystone SOC driver update for 4.19

 -  Add suspend/resume functionality to TI EMIF SRAM driver
 -  Add wakeup M3 RTC self refresh support
 -  Fix for the PM runtime ifdefs

----------------------------------------------------------------
Arnd Bergmann (1):
      soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused

Dave Gerlach (2):
      memory: ti-emif-sram: Add resume function to recopy sram code
      soc: ti: wkup_m3_ipc: Add wkup_m3_request_wake_src

Keerthy (1):
      soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support

 drivers/memory/ti-emif-pm.c  | 33 +++++++++++++++++++
 drivers/soc/ti/wkup_m3_ipc.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/wkup_m3_ipc.h  |  9 ++++++
 3 files changed, 118 insertions(+)
