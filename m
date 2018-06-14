Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96572C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF45208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PFaCYWZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF45208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936035AbeFNN7A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:59:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755084AbeFNN66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:58:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EDwLku102812;
        Thu, 14 Jun 2018 13:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=XVx2lTVg5HIZrCNiaIAHj9ozZlcBsf6s6saQfFSaxfQ=;
 b=PFaCYWZ49rCXOu2wYKy0OluOCysiVMvTt/TqzpwJLPUsWVVanMa5U1jLvJJrP/lyicwr
 UAehfxeaclH+zKP4kbhJfvYIhcWlZl+5nLfk2u5aBUqUYIVVdMRZVpiOyvnZz8OpoquQ
 ph0a9uUrxgwsa/2ovNxOuscr0knUz/LVZ3dpmgtkw1tXpedHGIxn4fBTHTrMV9Q009Bt
 23eYLwUPzCWk+uLJ9Ptbyzf+oVfKJLvr/L4iQyf0wLzvb+ubUEpdC+Fww5JJ9xOXnKU7
 YdakGnG29/jC5BjrnWUcxhV6+fiqXM4Zj786xw1nR9JiNL/y86c/tHWTjK2zD7h+0h/5 LQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jk0xrd7bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 13:58:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5EDwr3V023615
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 13:58:54 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5EDwrwi026540;
        Thu, 14 Jun 2018 13:58:53 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 06:58:52 -0700
Date:   Thu, 14 Jun 2018 16:58:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gdm724x: add error handling for nlmsg_put
Message-ID: <20180614135845.xzej3zrnhc2bf726@mwanda>
References: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
 <1528975913-51879-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528975913-51879-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 07:31:51PM +0800, Zhouyang Jia wrote:
> When nlmsg_put fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling nlmsg_put.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> v1->v2:
> - Add some cleanup
> ---
>  drivers/staging/gdm724x/netlink_k.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
> index abe2425..16da03b 100644
> --- a/drivers/staging/gdm724x/netlink_k.c
> +++ b/drivers/staging/gdm724x/netlink_k.c
> @@ -119,6 +119,11 @@ int netlink_send(struct sock *sock, int group, u16 type, void *msg, int len)
>  	seq++;
>  
>  	nlh = nlmsg_put(skb, 0, seq, type, len, 0);
> +	if (!nlh) {
> +		kfree_skb(skb);
> +		return -EMSGSIZE;
> +	}

As I mentioned earlier, this patch is not required because the we just
allocated the skb and we know that it is large enough.

regards,
dan carpenter


