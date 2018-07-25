Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3701BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF05620833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emjvDhkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF05620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbeGYXuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:50:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeGYXuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:50:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6PMZ0CG104112;
        Wed, 25 Jul 2018 22:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3DNj1vrNOfG0xX/lgaLGL4wIAE/S7XV/FZ4CuEcrH/M=;
 b=emjvDhkrHy/AvWsmj+1tYHAam+OQ/n7G2ClFuR11ojM8KzdtT3E0nGUuUMGIWiOVO6PA
 1MeWkA4Y1Xxzm/CkkGmixkDUPugdHlUCya0V0Roeii15gO/rPbymLNST1jKaAI2asGju
 Wwz/1U7bCN5iPlJ+grLM8cQ1tzA2hiAZ2tzVxUPV3u9OMapMufgXnItxrTtmVmlblt6w
 +pNALdgnX3bdUmn2oMTdwuSxZ8uOdWdHCWXwjPJvG2CGBfPj/eo5W+FOioyyqlyCc+UF
 kE+kRbgOteD4QLuRL4eVb/T/MRbO2l/XLxBCAgJfpOCK8HADnsvJEHncyOizod0ALIYo JQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kbv8t7g8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 22:36:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6PMaCnZ009538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 22:36:13 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6PMaCZx008901;
        Wed, 25 Jul 2018 22:36:12 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 15:36:12 -0700
Subject: Re: [PATCH] net/rds/Kconfig: RDS should depend on IPV6
To:     Anders Roxell <anders.roxell@linaro.org>, ka-cheong.poon@oracle.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20180725222008.32186-1-anders.roxell@linaro.org>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <cefa5c0b-7935-a6b5-1796-1d5a3da5dd87@oracle.com>
Date:   Wed, 25 Jul 2018 15:36:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725222008.32186-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2018 3:20 PM, Anders Roxell wrote:
> Build error, implicit declaration of function __inet6_ehashfn shows up
> When RDS is enabled but not IPV6.
> net/rds/connection.c: In function ‘rds_conn_bucket’:
> net/rds/connection.c:67:9: error: implicit declaration of function ‘__inet6_ehashfn’; did you mean ‘__inet_ehashfn’? [-Werror=implicit-function-declaration]
>    hash = __inet6_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
>           ^~~~~~~~~~~~~~~
>           __inet_ehashfn
> 
> Current code adds IPV6 as a depends on in config RDS.
> 
> Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to struct in6_addr")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   net/rds/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/rds/Kconfig b/net/rds/Kconfig
> index 41f75563b54b..607128f10bcd 100644
> --- a/net/rds/Kconfig
> +++ b/net/rds/Kconfig
> @@ -1,7 +1,7 @@
>   
>   config RDS
>   	tristate "The RDS Protocol"
> -	depends on INET
> +	depends on INET && CONFIG_IPV6
This should build without CONFIG_IPV6 too.

Hi Ka-cheong,
Can you please loot at it ? I know you modified
lookup function to take always in6_addr now, but
probably hashing with '__inet_ehashfn' should
work too for non IPV6 address(s).

Regards,
Santosh


