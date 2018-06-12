Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4991CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B92208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qqer5SXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B92208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754347AbeFLLzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:55:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44148 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbeFLLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:55:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CBta4l005024;
        Tue, 12 Jun 2018 11:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=ek0FP9VI6tkkK8arwzAAa9x/JrZbx4+YlZ295zXfQjs=;
 b=Qqer5SXz647IPV+wcwZiFql1lPwXn858Ikyf0okY40rz1hgVTfIM41fbvxVFZCpR1wG3
 YKLkYAmevx9Zbchb8NluYFXN/ZFEcqLLQSR6iwqjqsw3DBk4/BWyZ/sOGD45KYTRQh+s
 sAoDtRLO0KnrQL6NwCO6R5KyH4DZi4LAO+o892eA1YpP+pAE40ChBT7Z2RKfkvrIl1tU
 IOtBxxM8JfCEzzH4Ra8Qne4wyZjAVyWrGmJNFaz3/ytDk8UHuUxaNOOUqElxBlVCiGn5
 mR1Vz/7jYC2PUjjWACY1TkrCseKqZagrzZqrg3mRW4GL8rBPvY1t/pXWaHVKmnIWdT+E 7Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jg6b1hnnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:55:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CBtZRc018996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:55:35 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CBtZso030682;
        Tue, 12 Jun 2018 11:55:35 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 04:55:34 -0700
Date:   Tue, 12 Jun 2018 14:55:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: add error handling for nlmsg_put
Message-ID: <20180612115525.yg2mnhlcz6ok3dyo@mwanda>
References: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=847
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:09:24PM +0800, Zhouyang Jia wrote:
> When nlmsg_put fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling nlmsg_put.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/staging/gdm724x/netlink_k.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
> index abe2425..4623140 100644
> --- a/drivers/staging/gdm724x/netlink_k.c
> +++ b/drivers/staging/gdm724x/netlink_k.c
> @@ -119,6 +119,9 @@ int netlink_send(struct sock *sock, int group, u16 type, void *msg, int len)
>  	seq++;
>  
>  	nlh = nlmsg_put(skb, 0, seq, type, len, 0);
> +	if (!nlh)
> +		return -EMSGSIZE;

This can't fail.  We just allocated skb on the line before and we
allocated enough space for "len".  Also if we *did* hit a bug here then
we would need to do some more cleanup instead of a direct return.

regards,
dan carpenter

