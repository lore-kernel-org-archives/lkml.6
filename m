Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D5C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85D62088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AP1ktJp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85D62088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932528AbeFPILw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 04:11:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932188AbeFPILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 04:11:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5G89FcC131964;
        Sat, 16 Jun 2018 08:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=4Wjp8uT6jXqVz6RBSU2u9+urxE+HlI5VNcS7HcwsyVw=;
 b=AP1ktJp0wLqWB5MeGsorbkelpgl2w2nVApLX38N6BuP7MKqG9pISLoLsYtcmM+VODwQu
 69edNSyOuHzWT8OMTt6yrSQWERA+XlXbK6Pkbcw0XyHTaVKwWrdvKiAsKksgaCW7IzIA
 CXLan3j7Ivz84ZXEdW1xPR5Nag6wUo7tpMgmKYkV7NpJhhzL8ZUOl6e30jYf92lXQ5wE
 kmWN94DeJ7Qqgb4N6+zoj0t24UD3khW8snZlnEaXbNBmUQPInzAG1MN3U8T2Xrg2ZTll
 CFpjH6LgIxZXI+pv1PsDLmJzToFyPTpvSyjMs08CxgvV9hFLBuOT3QIN0yoWHgfflH0Y iQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jmu6xg652-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jun 2018 08:11:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5G8Bgnn030349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jun 2018 08:11:42 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5G8BePs015013;
        Sat, 16 Jun 2018 08:11:41 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 Jun 2018 01:11:40 -0700
Date:   Sat, 16 Jun 2018 11:11:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v4] staging: rtl8192u: add error handling for
 usb_alloc_urb
Message-ID: <20180616081127.oqendremoierdndg@mwanda>
References: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
 <1529114485-60684-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529114485-60684-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=878
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806160102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was actually OK with v1 on the theory that everything else leaked and
so this didn't really introduce anything new... :P

On Sat, Jun 16, 2018 at 10:01:22AM +0800, Zhouyang Jia wrote:
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1639,8 +1639,9 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>  static short rtl8192_usb_initendpoints(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
> +	int i;
>  
> -	priv->rx_urb = kmalloc(sizeof(struct urb *) * (MAX_RX_URB + 1),
> +	priv->rx_urb = kcalloc(MAX_RX_URB + 1, sizeof(struct urb *),
>  			       GFP_KERNEL);
>  	if (!priv->rx_urb)
>  		return -ENOMEM;
> @@ -1649,12 +1650,12 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>  	for (i = 0; i < (MAX_RX_URB + 1); i++) {
>  		priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
>  		if (!priv->rx_urb[i])
> -			return -ENOMEM;
> +			goto out_release_mem;
>  
>  		priv->rx_urb[i]->transfer_buffer =
>  			kmalloc(RX_URB_SIZE, GFP_KERNEL);


You need to free priv->rx_urb[i]->transfer_buffer as well and there are
several other resources which are also not freed.

regards,
dan carpenter

