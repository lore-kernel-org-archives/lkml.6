Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7873FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D28F21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3BNieQk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfBRK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:26:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfBRK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:26:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1IANvFf057174;
        Mon, 18 Feb 2019 10:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MdctsrHLwoVfhEFYIwA5HozozuG7ovaT9mVdwrcmTE8=;
 b=3BNieQk1ha6CffGkIjxQQFk2qzT9XgwR/265oTWSdf0pFYzN2lkXcWj0pxPwXk50l24N
 5pLOMvQ73GVVJzaSN2NVEVTvRgnap21zc/Un4mULeJI/P8dk+OpIYOUPcLk9MOB3M95d
 SklDdkre5q2L6JNjuS8Z6ahvpYB/0CQcFkaFDZwUVJ2bhQUzc1ycCniZu/rnJdpvJS/J
 ZDmMuEesUh/eqJQmG34/4PQgA0qsccOoRhme/cWDnEieWslZqtw69EqYJ7AXmnkHB3XS
 zAF7shZUI/O1XBUgdhS0+oBhEQdtFD9fTY4FMklAs8p4ox481n26XXHqzg7fyF1NTdyA ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xtnhf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 10:26:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1IAQ7Po014421
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 10:26:07 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1IAQ66t013344;
        Mon, 18 Feb 2019 10:26:06 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 02:26:05 -0800
Date:   Mon, 18 Feb 2019 13:25:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tariq Toukan <tariqt@mellanox.com>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx4_en: fix spelling mistake: "quiting" ->
 "quitting"
Message-ID: <20190218102557.GC17104@kadam>
References: <20190217230331.18678-1-colin.king@canonical.com>
 <2a1a6636-7795-addb-d7b7-711a23dbafa5@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1a6636-7795-addb-d7b7-711a23dbafa5@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:37:22AM +0000, Tariq Toukan wrote:
> 
> 
> On 2/18/2019 1:03 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a spelling mistake in a en_err error message. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> > index 6b88881b8e35..c1438ae52a11 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> > @@ -3360,7 +3360,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
> >   	dev->addr_len = ETH_ALEN;
> >   	mlx4_en_u64_to_mac(dev->dev_addr, mdev->dev->caps.def_mac[priv->port]);
> >   	if (!is_valid_ether_addr(dev->dev_addr)) {
> > -		en_err(priv, "Port: %d, invalid mac burned: %pM, quiting\n",
> > +		en_err(priv, "Port: %d, invalid mac burned: %pM, quitting\n",
> >   		       priv->port, dev->dev_addr);
> >   		err = -EINVAL;
> >   		goto out;
> > 
> 
> Hi Colin, thanks for your patch.
> 
> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> 
> I would suggest adding a Fixes line, but looking into the history of the 
> typo, it went through many patches that modified this line but preserved 
> the typo.
> Actually, it dates back to the very first commit that introduces mlx4 
> driver:
> 
> Patches history:
> 2b3ddf27f48c net/mlx4_core: Replace VF zero mac with random mac in mlx4_core
> ef96f7d46ad8 net/mlx4_en: Handle unassigned VF MAC address correctly
> 6bbb6d99f3d2 net/mlx4_en: Optimize Rx fast path filter checks
> 453a60827735 mlx4_en: Giving interface name in debug messages
> c27a02cd94d6 mlx4_en: Add driver for Mellanox ConnectX 10GbE NIC
> 
> I'm not sure what the "Fixes:" policy is in these cases.

I wouldn't necessarily put a Fixes tag on this, because does fixing the
spelling really count as a bugfix?  It's borderline whether it's a fix
or a cleanup.

regards,
daan carpenter
