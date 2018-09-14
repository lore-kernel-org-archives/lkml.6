Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A1FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167CD20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3FxMCqxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167CD20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeINXtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:49:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49618 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeINXtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:49:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EITGEk149253;
        Fri, 14 Sep 2018 18:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ytKQHq8Dx6iYVyVgGWr5nyXdL0umMAPS02a7KuAIros=;
 b=3FxMCqxnWvZ0HjakdzncOEDk5ox4HWqkkfG2KJF4vaiZvDug8YbUD7/CQUKlFJJRuOR1
 IOvQUh2Z7gXt8s3LT7PBOeYPLM/yi69dUW59NMj+P7igO+bceRdpXnm7h5CUJR+NdR7W
 noWqR+rc6/rH873/6FMYcDVzeeKzVYY2CMS3uQ2/WXSfj9u1B83b5TBDwZtax5vmUpf+
 /c+AQAtbiusHPDc3c4DJ0Zv+ICt9k2F4+4zmc31KkPCc6nubIFZ7NlFr/+ZtGNPS2Lzj
 DzdMxKRJLTABtFZPde66Z7VM9+Olrp4VBTF2VZ+06+lQIxHRNhztfsuksocv7TQAMLUJ Qg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5uu0n69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 18:33:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EIXfsj027963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 18:33:41 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EIXeX0020116;
        Fri, 14 Sep 2018 18:33:40 GMT
Received: from [192.168.1.250] (/76.253.0.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 18:33:40 +0000
Subject: Re: [PATCH] net/mlx4_core: print firmware version during driver
 loading
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        tariqt@mellanox.com, davem@davemloft.net
References: <20180914002514.27571-1-qing.huang@oracle.com>
 <20180914044314.GC5257@mtr-leonro.mtl.com>
 <c580ad9d-b63d-743b-2278-1c4cf3553186@oracle.com>
 <20180914181718.GD3811@lunn.ch>
From:   Qing Huang <qing.huang@oracle.com>
Message-ID: <c332f10a-5ad0-53fd-5111-1964443b3092@oracle.com>
Date:   Fri, 14 Sep 2018 11:33:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914181718.GD3811@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9016 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2018 11:17 AM, Andrew Lunn wrote:
> On Fri, Sep 14, 2018 at 10:15:48AM -0700, Qing Huang wrote:
>> The FW version is actually a very crucial piece of information and only
>> printed once here
>> when the driver is loaded. People tend to get confused when switching
>> multiple FW files
>> back and forth without running separate utility tools, especially at
>> customer sites.
>> IMHO, this information is very useful and only takes up very little log file
>> space. :-)
> Why not use ethtool -i ?
>
> $ sudo ethtool -i eth0
> driver: r8169
> version: 2.3LK-NAPI
> firmware-version: rtl8168g-2_0.0.1 02/06/13
>
>      Andrew
Sure. You can also use ibstat or ibv_devinfo tool if they are installed. 
But it's not very
convenient in some cases.

E.g.
A customer upgrades FW on HCAs and encounters issues. During triage, 
it's much easier
to study customer uploaded log files when remotely testing different FW 
files.

Thanks.



