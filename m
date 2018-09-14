Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA34ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75BE20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pqaRY+Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75BE20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeINWbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:31:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINWbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:31:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EH8XOg063765;
        Fri, 14 Sep 2018 17:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=AoUpT7MSHDs2976pONNzgVZ0ZTOZNVblMvmKQGgh6vg=;
 b=pqaRY+Qzd2JvOtU/j5clBuoy+TMrGLo26OM7QnUyn/xiMp/Fwjx8+jCMaKT7kcK+YYMh
 g9ipCUNxAXn3BhShdALQLP6Hs5SdlEnTbiSR1DuYet7wKtjUGEn7rTF8LSkoz3iELa8J
 rlsYaimqHA29L5F+A2lRQNa39SSLIREHUgXVtNr42VVCKlzvywmNRWWTsBtZTmwuBjTZ
 +tuaydd3bAv7oB37u7nEKFcmRgPhK5zfeAm4L3v+NNR71n8xu7Z3fqCpdYlzM70GAKQR
 bUZ2z3zQf3xxhSR+JloUhMmNxBmJIYfpD0Ws6JQWi5/H7Zm6qYv/u6wsYPl214WQbdig 1w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mc5uu0aq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 17:15:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EHFoC8029273
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 17:15:50 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EHFnI2009725;
        Fri, 14 Sep 2018 17:15:49 GMT
Received: from [192.168.1.250] (/76.253.0.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 10:15:49 -0700
Subject: Re: [PATCH] net/mlx4_core: print firmware version during driver
 loading
To:     Leon Romanovsky <leon@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, tariqt@mellanox.com,
        davem@davemloft.net
References: <20180914002514.27571-1-qing.huang@oracle.com>
 <20180914044314.GC5257@mtr-leonro.mtl.com>
From:   Qing Huang <qing.huang@oracle.com>
Message-ID: <c580ad9d-b63d-743b-2278-1c4cf3553186@oracle.com>
Date:   Fri, 14 Sep 2018 10:15:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914044314.GC5257@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9016 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FW version is actually a very crucial piece of information and only 
printed once here
when the driver is loaded. People tend to get confused when switching 
multiple FW files
back and forth without running separate utility tools, especially at 
customer sites.
IMHO, this information is very useful and only takes up very little log 
file space. :-)

I was also thinking of doing something slightly differently. Maybe we 
just trim down the
output string, and add something like this?
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -2208,6 +2208,11 @@ static int mlx4_init_fw(struct mlx4_dev *dev)
                         return err;
                 }

+               mlx4_info(dev, "Installed FW version is %d.%d.%03d.\n",
+                         (int) (dev->caps.fw_ver >> 32),
+                         (int) (dev->caps.fw_ver >> 16) & 0xffff,
+                         (int) dev->caps.fw_ver & 0xffff);
+
                 err = mlx4_load_fw(dev);
                 if (err) {
                         mlx4_err(dev, "Failed to start FW, aborting\n");

Thanks,
Qing

On 9/13/2018 9:43 PM, Leon Romanovsky wrote:
> On Thu, Sep 13, 2018 at 05:25:14PM -0700, Qing Huang wrote:
>> When debugging firmware related issues, it's very helpful to have
>        ^^^^^^^^^^ exactly, this is why we set this print as mlx4_dbg and
>        not mlx4_info.
>
>> the installed FW version info in the kernel log when the driver is
>> loaded. It's easier to match error/warning messages with different
>> FW versions in the log other than running a separate tool to get
>> the information back and forth.
>>
>> Signed-off-by: Qing Huang <qing.huang@oracle.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/fw.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
>> index babcfd9..e1c5218 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/fw.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
>> @@ -1686,11 +1686,11 @@ int mlx4_QUERY_FW(struct mlx4_dev *dev)
>>   	MLX4_GET(lg, outbox, QUERY_FW_MAX_CMD_OFFSET);
>>   	cmd->max_cmds = 1 << lg;
>>
>> -	mlx4_dbg(dev, "FW version %d.%d.%03d (cmd intf rev %d), max commands %d\n",
>> -		 (int) (dev->caps.fw_ver >> 32),
>> -		 (int) (dev->caps.fw_ver >> 16) & 0xffff,
>> -		 (int) dev->caps.fw_ver & 0xffff,
>> -		 cmd_if_rev, cmd->max_cmds);
>> +	mlx4_info(dev, "FW version %d.%d.%03d (cmd intf rev %d), max commands %d\n",
>> +		  (int)(dev->caps.fw_ver >> 32),
>> +		  (int)(dev->caps.fw_ver >> 16) & 0xffff,
>> +		  (int)dev->caps.fw_ver & 0xffff,
>> +		  cmd_if_rev, cmd->max_cmds);
>>
>>   	MLX4_GET(fw->catas_offset, outbox, QUERY_FW_ERR_START_OFFSET);
>>   	MLX4_GET(fw->catas_size,   outbox, QUERY_FW_ERR_SIZE_OFFSET);
>> --
>> 2.9.3
>>

