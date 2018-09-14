Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F2ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB50B20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nb7Vj1tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB50B20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeIODxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:53:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIODxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:53:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EMUHJ8138712;
        Fri, 14 Sep 2018 22:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2ZXjYW3GOjtFA3njxzSljTGXkQ6wjrfIOYl8jI521SA=;
 b=Nb7Vj1tK8GNxUePJ63uFKSacoc0ZHXlz5AFPn+1+0btEOq5TzviBLg7qEQl3L93kmrrN
 C7xIx86f23rZD93OnNOzqL9DmoppnczuP0s8tloVgF3KSnay91tnuqKsS2C9z6d4xsw9
 NODJHxbrOPYDMZVkNiD9ORf+j34tNX9gvY3B1NnGQHX+ai3KgK8dGMeXlMmq/8tPY/Bo
 Nfgb4pG+GtRlDw/huUfTt43k/Jwbc+t1Gz3mC9UleXWEmqYtkQqL50OCoYwiXI77LPC8
 G+8561dPdjKe2L/O8/8vIvCOOSJ6Wdp/9dSyAXNwlPuHlvqvFG68y5Hwe+hIsjIY9vHZ JQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mc72r9bns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 22:36:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EMam2C016109
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 22:36:48 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8EMalj5024585;
        Fri, 14 Sep 2018 22:36:47 GMT
Received: from [192.168.1.250] (/76.253.0.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 15:36:46 -0700
From:   Qing Huang <qing.huang@oracle.com>
Subject: Re: [PATCH] net/mlx4_core: print firmware version during driver
 loading
To:     David Miller <davem@davemloft.net>
Cc:     andrew@lunn.ch, leon@kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        tariqt@mellanox.com
References: <c580ad9d-b63d-743b-2278-1c4cf3553186@oracle.com>
 <20180914181718.GD3811@lunn.ch>
 <c332f10a-5ad0-53fd-5111-1964443b3092@oracle.com>
 <20180914.141406.2211638662965115243.davem@davemloft.net>
Message-ID: <1d4fe3c6-13aa-12a4-8da4-a83374b89fbf@oracle.com>
Date:   Fri, 14 Sep 2018 15:36:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914.141406.2211638662965115243.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9016 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2018 2:14 PM, David Miller wrote:
> From: Qing Huang<qing.huang@oracle.com>
> Date: Fri, 14 Sep 2018 11:33:40 -0700
>
>> On 9/14/2018 11:17 AM, Andrew Lunn wrote:
>>> On Fri, Sep 14, 2018 at 10:15:48AM -0700, Qing Huang wrote:
>>>> The FW version is actually a very crucial piece of information and
>>>> only
>>>> printed once here
>>>> when the driver is loaded. People tend to get confused when switching
>>>> multiple FW files
>>>> back and forth without running separate utility tools, especially at
>>>> customer sites.
>>>> IMHO, this information is very useful and only takes up very little
>>>> log file
>>>> space. :-)
>>> Why not use ethtool -i ?
>>>
>>> $ sudo ethtool -i eth0
>>> driver: r8169
>>> version: 2.3LK-NAPI
>>> firmware-version: rtl8168g-2_0.0.1 02/06/13
>>>
>>>       Andrew
>> Sure. You can also use ibstat or ibv_devinfo tool if they are
>> installed. But it's not very
>> convenient in some cases.
>>
>> E.g.
>> A customer upgrades FW on HCAs and encounters issues. During triage,
>> it's much easier
>> to study customer uploaded log files when remotely testing different
>> FW files.
> Not a valid argument.  You can print the ethtool output from initramfs
> if necessary for triage.
>
> I still stand by the fact that ethtool is the only fully reliable way
> to obtain this information, the kernel log is not.

This is more for Infiniband mode which depends more on features and 
functionalities
provided in firmware and get much more frequent FW bug fixes than 
typical Ethernet
devices. This is not meant to replace other ways of getting the 
information, more like
an enhancement for checking log history.

This can provide valuable information when tracing through system log 
history to
discover what happened with a specific HCA drv ver and fw ver 
combination in the past.

Regards,
Qing
