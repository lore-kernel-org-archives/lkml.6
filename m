Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91F2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6605020835
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZMkjK7om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6605020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeH2PEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:04:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2PEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:04:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TB4LYr193074;
        Wed, 29 Aug 2018 11:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3qzgHUcozG7fwDGcplunc95cPwl7r/MPZwNStqtgWvE=;
 b=ZMkjK7omdUk+7hqzAkFeUrwTgGC37AyXHg34ToZLXn8pVy20i1tMpyu2aRcXj2nAsOgm
 aWrl5trBzk55V9ruEwYXX9m42Omz3UUkDpWZZ9FKMzz0NpV8y8GFu7P0NignYWfoKHrW
 VE8g/vrWoWH9fhdL0bNHbi5QzT4royJe1TGon/Zzng+7IMtCKPbde1h7KN1Eh5XuTPWq
 7kxTwc1O9tAj1kcWQA3JKVUDoaqsfp5yi/j5Dkhi3xnrUTi5hBxuwezBhwf5zuJ5znxS
 2jZn07RSX8qrkpzfV4vyJ8+Ygg4s677SwmKqfXj0rxkLkT24D+jQLI88znkhw2Jypdhd jQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2m2yrq905s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 11:07:52 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7TB7pNY017742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 11:07:51 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7TB7mcO001394;
        Wed, 29 Aug 2018 11:07:48 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 04:07:48 -0700
Date:   Wed, 29 Aug 2018 14:07:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        devel@driverdev.osuosl.org, andrew@lunn.ch, horia.geanta@nxp.com,
        madalin.bucur@nxp.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ioana.ciornei@nxp.com,
        laurentiu.tudor@nxp.com
Subject: Re: [PATCH net-next v2 0/2] dpaa2-eth: Move DPAA2 Ethernet driver
Message-ID: <20180829110739.3xzbdtelwjlhun2v@mwanda>
References: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=822
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few static checker warnings for the driver but only the
first one looks like a possibly real bug.

drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c:1116 dpaa2_eth_stop() error: uninitialized symbol 'dpni_enabled'.
drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c:1671 set_fq_affinity() warn: 'xps_mask' puts 1024 bytes on stack
drivers/staging/fsl-dpaa2/ethsw/ethsw.c:742 port_vlans_add() error: uninitialized symbol 'err'.
drivers/staging/fsl-dpaa2/ethsw/ethsw.c:886 port_vlans_del() error: uninitialized symbol 'err'.

regards,
dan carpenter

