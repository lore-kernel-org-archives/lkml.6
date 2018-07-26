Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D55C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8DD20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hyhZUEko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8DD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeGZGR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:17:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43082 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeGZGR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:17:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6Q4xUAo076744;
        Thu, 26 Jul 2018 05:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ecV5xDrBV8I7ZM/qGn8B0cprbMZROoQfZVzeyEgwm1o=;
 b=hyhZUEkoNHnf6qoVQZpiI4H9oFSk6lHi6aMplnfeZEgZbuuc8evoWudwLJSC1bO8ie4k
 q97UevA7D/NQh6SrYpXG7YA2C3Ynf2k0IzwgMCruV1FSjPFhsSLLTt50SqfcrY9YdaWO
 FWC7H5cmo/kckvL6etlZM1QuFOptdet7Un6RSAH1+L/It1qGCXiLJydZd5uKoRwXTsxH
 ll/GxRMZ54KkMNuoajLPFKJkSa5UnsuSauYOud8mtEINF52TwZjwfWlxTZsuKILDxxae
 oICKdbTOO5kHwv1yKJlcjIo4XIMPLQzE77VXOlz2zKo8N3xZVWa3TTh3YRm/LeTBqP6E gw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kbtbd1fff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 05:02:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6Q52Nuc013555
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 05:02:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6Q52Ntm019167;
        Thu, 26 Jul 2018 05:02:23 GMT
Received: from santoshs-mbp.lan (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 22:02:22 -0700
Subject: Re: [PATCH] net/rds/Kconfig: RDS should depend on IPV6
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20180725222008.32186-1-anders.roxell@linaro.org>
 <cefa5c0b-7935-a6b5-1796-1d5a3da5dd87@oracle.com>
 <3e4b4c29-40f8-211b-62e3-c9411b2c0013@oracle.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <62dc735a-19ca-13ca-bd7e-3b591ffc132e@oracle.com>
Date:   Wed, 25 Jul 2018 22:02:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3e4b4c29-40f8-211b-62e3-c9411b2c0013@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/18 9:56 PM, Ka-Cheong Poon wrote:
> On 07/26/2018 06:36 AM, Santosh Shilimkar wrote:
>> On 7/25/2018 3:20 PM, Anders Roxell wrote:
>>> Build error, implicit declaration of function __inet6_ehashfn shows up
>>> When RDS is enabled but not IPV6.
>>> net/rds/connection.c: In function ‘rds_conn_bucket’:
>>> net/rds/connection.c:67:9: error: implicit declaration of function 
>>> ‘__inet6_ehashfn’; did you mean ‘__inet_ehashfn’? 
>>> [-Werror=implicit-function-declaration]
>>>    hash = __inet6_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
>>>           ^~~~~~~~~~~~~~~
>>>           __inet_ehashfn
>>>
>>> Current code adds IPV6 as a depends on in config RDS.
>>>
>>> Fixes: eee2fa6ab322 ("rds: Changing IP address internal 
>>> representation to struct in6_addr")
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> --- >>>   net/rds/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/rds/Kconfig b/net/rds/Kconfig
>>> index 41f75563b54b..607128f10bcd 100644
>>> --- a/net/rds/Kconfig
>>> +++ b/net/rds/Kconfig
>>> @@ -1,7 +1,7 @@
>>>   config RDS
>>>       tristate "The RDS Protocol"
>>> -    depends on INET
>>> +    depends on INET && CONFIG_IPV6
>> This should build without CONFIG_IPV6 too.
>>
>> Hi Ka-cheong,
>> Can you please loot at it ? I know you modified
>> lookup function to take always in6_addr now, but
>> probably hashing with '__inet_ehashfn' should
>> work too for non IPV6 address(s).
> 
> 
> I guess for now, let's add this dependency first.  I
> will do a follow up patch to remove this dependency.
> 
Sounds good to me.

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

