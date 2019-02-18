Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE612081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="10Vi4ixR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbfBRObj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:31:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60436 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387394AbfBRObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:31:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1IEO5Fb053824;
        Mon, 18 Feb 2019 14:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cf6CRf7d2ecUJqXR2V8Upy1NKbRy/xou2lem06sozaI=;
 b=10Vi4ixReGdXDTYiCY1fwPpkSKIEygG6eUOfQQZpGy00VzSzlIBi3K2v17YSEPazSBmf
 oUmRgqNZQmFGU7Xil/H+6sqoRH3078rHieNgMd83ktsPQ/7hhDv7MjCLxIoDluE06ZyE
 cbTyV6SWr5ce4vuPMj2n7F4GZlq/KfdzvVJY+IRCqIINyXZWYJPoCET7jthcSoi6i8Hx
 y3KP0SzHwy/MotkFBjNmvCzxQKzaZr0cFwWsKq0FIkqtkf0hJoOFYl7z0MS3Owr40jOw
 1eh5bYmYKDUxUsv3ZR4YVQjCoerS0RVjpNIAKIis6yuFYRCL7wIdNo+jVifLpLCnSRbf gA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xtpjyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 14:31:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1IEVOvG004865
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 14:31:24 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1IEVNhq013049;
        Mon, 18 Feb 2019 14:31:23 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 06:31:22 -0800
Date:   Mon, 18 Feb 2019 17:31:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: rtl8192e: Remove set but not used
 variables 'broad_addr, stype'
Message-ID: <20190218143114.GD17104@kadam>
References: <20190218123359.83746-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218123359.83746-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:33:59PM +0000, YueHaibing wrote:
> @@ -1747,11 +1747,10 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
>  	header = (struct rtllib_hdr_1addr *)(((u8 *)skb->data) + fwinfo_size);
>  	fc = le16_to_cpu(header->frame_ctl);
>  	type = WLAN_FC_GET_TYPE(fc);
> -	stype = WLAN_FC_GET_STYPE(fc);
>  	pda_addr = header->addr1;
>  
>  	if (is_broadcast_ether_addr(pda_addr))
> -		broad_addr = true;
> +		;
>  	else if (is_multicast_ether_addr(pda_addr))
>  		multi_addr = true;
>  	else
> 

This is ugly.  Please do it like this:


diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c145b689175c..29b53e2246b4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1729,7 +1729,6 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	struct tx_desc *pdesc = NULL;
 	struct rtllib_hdr_1addr *header = NULL;
 	u16 fc = 0, type = 0, stype = 0;
-	bool  multi_addr = false, broad_addr = false, uni_addr = false;
 	u8 *pda_addr = NULL;
 	int   idx;
 	u32 fwinfo_size = 0;
@@ -1751,18 +1750,11 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	pda_addr = header->addr1;
 
 	if (is_broadcast_ether_addr(pda_addr))
-		broad_addr = true;
+		priv->stats.txbytesbroadcast += skb->len - fwinfo_size;
 	else if (is_multicast_ether_addr(pda_addr))
-		multi_addr = true;
-	else
-		uni_addr = true;
-
-	if (uni_addr)
-		priv->stats.txbytesunicast += skb->len - fwinfo_size;
-	else if (multi_addr)
 		priv->stats.txbytesmulticast += skb->len - fwinfo_size;
 	else
-		priv->stats.txbytesbroadcast += skb->len - fwinfo_size;
+		priv->stats.txbytesunicast += skb->len - fwinfo_size;
 
 	spin_lock_irqsave(&priv->irq_th_lock, flags);
 	ring = &priv->tx_ring[tcb_desc->queue_index];
