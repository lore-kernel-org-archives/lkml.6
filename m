Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F9CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2DF21EB6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 11:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1GUMDAFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2DF21EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeHKOdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 10:33:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36040 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeHKOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 10:33:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7BBx0js150194;
        Sat, 11 Aug 2018 11:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=srk3qFuV9eTsmteVp5jKD92w5Ss91RjH0UavVixKIF0=;
 b=1GUMDAFh1SxB+AnYUrE3oZJFwyOJmXhD0+2Nh8HtFhfI2UuPOrBPpZvoEX+mLVTZkAer
 oD/WohqnSurscisyejhJw1hUZVGM5opIPFGoo6qvPqCmC4pRhWIQEC5bC1vyxm5u67+N
 znuMgnjoPjt0AOS7HpIs91yk/Bfkt1jSTYFFz2ikVfBROPQ06QiXRn2XDJJTchEF/+Wi
 peLPB+MKIQx5q+7OWwLS+YIKb3MCIPH+z9gxCsCGYYOnkbJ8pkyXQEBsqJyYS4OWczgn
 Crs7DvdbVIbwNmcUxp6ZPIByCY6VCTj3PXcsngkNyjd36NolyJaq0HHAxdLGD5q5AzQI IA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ksq7t0hr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Aug 2018 11:59:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7BBx0Sp023349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Aug 2018 11:59:00 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7BBx0w5014705;
        Sat, 11 Aug 2018 11:59:00 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 11 Aug 2018 04:58:59 -0700
Date:   Sat, 11 Aug 2018 14:58:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Or Gerlitz <ogerlitz@mellanox.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1981 same_hw_devs()
 error: uninitialized symbol 'fsystem_guid'.
Message-ID: <20180811115853.jhjniiv6trj7l5si@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8981 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808110135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f313b43be461f157755a57c1156f86abe10588de
commit: 816f670623692b5da2787f278cbfdb331ed29b8a net/mlx5e: Properly check if hairpin is possible between two functions

New smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1981 same_hw_devs() error: uninitialized symbol 'fsystem_guid'.
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1981 same_hw_devs() error: uninitialized symbol 'psystem_guid'.

Old smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:620 mlx5e_hairpin_flow_add() error: uninitialized symbol 'link_speed'.

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=816f670623692b5da2787f278cbfdb331ed29b8a
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 816f670623692b5da2787f278cbfdb331ed29b8a
vim +/fsystem_guid +1981 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c

bdd66ac0 Or Gerlitz 2017-06-11  1969  
5c65c564 Or Gerlitz 2017-11-22  1970  static bool same_hw_devs(struct mlx5e_priv *priv, struct mlx5e_priv *peer_priv)
5c65c564 Or Gerlitz 2017-11-22  1971  {
5c65c564 Or Gerlitz 2017-11-22  1972  	struct mlx5_core_dev *fmdev, *pmdev;
816f6706 Or Gerlitz 2018-08-08  1973  	u64 fsystem_guid, psystem_guid;
5c65c564 Or Gerlitz 2017-11-22  1974  
5c65c564 Or Gerlitz 2017-11-22  1975  	fmdev = priv->mdev;
5c65c564 Or Gerlitz 2017-11-22  1976  	pmdev = peer_priv->mdev;
5c65c564 Or Gerlitz 2017-11-22  1977  
816f6706 Or Gerlitz 2018-08-08  1978  	mlx5_query_nic_vport_system_image_guid(fmdev, &fsystem_guid);
816f6706 Or Gerlitz 2018-08-08  1979  	mlx5_query_nic_vport_system_image_guid(pmdev, &psystem_guid);
5c65c564 Or Gerlitz 2017-11-22  1980  
816f6706 Or Gerlitz 2018-08-08 @1981  	return (fsystem_guid == psystem_guid);
5c65c564 Or Gerlitz 2017-11-22  1982  }
5c65c564 Or Gerlitz 2017-11-22  1983  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
