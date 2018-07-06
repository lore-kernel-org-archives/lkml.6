Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F46EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F6B22B26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8GFLfEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F6B22B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933043AbeGFV0b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:26:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60028 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeGFV0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:26:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w66LPLqE159009;
        Fri, 6 Jul 2018 21:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=VdjmzySpct2F+3jS4NJNBlqEgQc523idvViW8PqWa44=;
 b=Z8GFLfExdRic+CMaQNrg5nalhPGkpGItd+YgfoCs1ZCEjmedEWYi4CmJ0Hf2BjXK2O/v
 jjP2JdPyGBcUB2ih2GaBhVdK3B/y2odL2xinf0LVTYFsTTIxoEzd5+3VkXLJEDB/IB+k
 Orb/BFX/XXvcbdedRAKcTwD5gcs9Cdoja16nOiTD9WP4cO8keIrxVGmxTMDmFc2r/XwZ
 nMd2Qup4sGuFvAjZGZWr/yoMnBxVPXx7reViVD09RwNd6YTdtc0nZTVrJnSguiJtsaDx
 70RJLd0QLVAGUfXjYQDq8BZSxS02DtrIWzVAoQy9EbRnb+Rtchyyfve+07y7xdrui77x iQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k0dnjk0x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jul 2018 21:25:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w66LPn27023127
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 21:25:49 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w66LPnUA009432;
        Fri, 6 Jul 2018 21:25:49 GMT
Received: from userv0021.oracle.com (/10.11.23.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Jul 2018 14:25:49 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 2/3] ARM: Keystone config update for v4.19
Date:   Fri,  6 Jul 2018 14:25:41 -0700
Message-Id: <1530912342-4641-2-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8946 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807060241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.19

for you to fetch changes up to 60e9343b355118e903a155135f0511918d69e3ac:

  ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP (2018-06-29 15:57:53 -0700)

----------------------------------------------------------------
ARM: Keystone config updates for 4.19

 - Enable MMC support
 - Enable Micrel and DP83867 phys

----------------------------------------------------------------
Kishon Vijay Abraham I (1):
      ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP

Murali Karicheri (1):
      ARM: keystone: k2g: enable micrel and dp83867 phys

 arch/arm/configs/keystone_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
