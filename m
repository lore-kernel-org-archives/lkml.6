Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08520C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6221729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OfNw86mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB6221729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbeHNTlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:41:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41944 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbeHNTlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:41:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7EGisPE173781;
        Tue, 14 Aug 2018 16:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7JgAsHMRTzgeSuZQXbPE//RAtV6NDCsfK/otLH1qYZk=;
 b=OfNw86mcqnDbaH2qFqUcCxyKLKfxqT4oiygg/S8KyTGAa8tqxq0t2SO3lBAU3AXXenkw
 5QqZ/9iyZuimj8cGpOPM5uhBb6fOaNcScz0VkNQ/Qd1oxv2XadkCRyvPZI+lrhlreDa6
 QcFIafSqBoLZIeNFfGra7kl1gYhRMpQdnfYH59BMYGOcAEZqNG7i4CoH6QMhXFWu/H9e
 wZ8JLSLboygbkWrk4En3VzJkZN7XzPPYt6kSrbcWDdn/r0kCJgsxgcea1KAvJ7GuQaWH
 +fZB/K82bHqcJVOfoyqa5JhfGoPSRDP9QHphJBw0ayMinsvwL3uTlu26OUsUCTd78kMo lA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ksnad1kr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Aug 2018 16:53:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7EGrFAB015112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Aug 2018 16:53:15 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7EGrDXG028064;
        Tue, 14 Aug 2018 16:53:14 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Aug 2018 09:53:13 -0700
Subject: Re: [PATCH] rds: fix building with IPV6=m
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Greg Thelen <gthelen@google.com>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20180814090752.1681486-1-arnd@arndb.de>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <73b656f7-ce61-b4f7-a76d-cc099bb3820f@oracle.com>
Date:   Tue, 14 Aug 2018 09:53:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814090752.1681486-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=843
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808140172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2018 2:07 AM, Arnd Bergmann wrote:
> When CONFIG_RDS_TCP is built-in and CONFIG_IPV6 is a loadable
> module, we get a link error agains the modular ipv6_chk_addr()
> function:
> 
> net/rds/tcp.o: In function `rds_tcp_laddr_check':
> tcp.c:(.text+0x3b2): undefined reference to `ipv6_chk_addr'
> 
> This adds back a dependency that forces RDS_TCP to also be
> a loadable module when IPV6 is one.
> 
> Fixes: e65d4d96334e ("rds: Remove IPv6 dependency")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   net/rds/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/rds/Kconfig b/net/rds/Kconfig
> index 41f75563b54b..01b3bd6a3708 100644
> --- a/net/rds/Kconfig
> +++ b/net/rds/Kconfig
> @@ -16,6 +16,7 @@ config RDS_RDMA
>   config RDS_TCP
>   	tristate "RDS over TCP"
>   	depends on RDS
> +	depends on IPV6 || !IPV6
>   	---help---
>   	  Allow RDS to use TCP as a transport.
>   	  This transport does not support RDMA operations.
> 
Its weird depends on but probably ok since we get to module
to be enabled with or without IPV6.

Thanks for the patch Arnd !!

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
