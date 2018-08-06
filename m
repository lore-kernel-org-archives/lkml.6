Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E91FC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE550219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5Rz6FvJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE550219CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHFFtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:49:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43610 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeHFFtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:49:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w763d3lE151374;
        Mon, 6 Aug 2018 03:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cf5A+/lqNJ859neGA4N5TvbcK1iFkfpElMi8IY4I39c=;
 b=5Rz6FvJScucgzsCjzewd1wCtCyyMnbKyWQRoxk8tbjNlcpcjD7D6dPUGpp91aG4xoHCB
 U3u/Qwlcsk95lUsPUiw7C1e/odXnTQ4QEKUEPmXxfOglgjMIKHelC1sObiPWczJxFKyK
 MtdEk80OJSjE2Or0G1Hos1cWQBHSaTQajT3MaopFdDczdg+aCQPcrM3ELyh1bzaDL63y
 lHbT8y9OgfdIbyf8vRgo0hDNgaPhbqxr44oQ8EE/XnQOcld5LJJr6RpJ5stVl2GxXFgz
 wW5LEuXWOXnY27P1uciEADLVLQzXAeaproDXZXCMCLKoU6QLRTH10Hvel24Pc4FnRi7b Ag== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kn3jsu2h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Aug 2018 03:41:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w763fxkX018479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Aug 2018 03:41:59 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w763fxmY028275;
        Mon, 6 Aug 2018 03:41:59 GMT
Received: from santoshs-mbp.lan (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Aug 2018 20:41:58 -0700
Subject: Re: [PATCH] RDS is not Radio Data System
To:     Pavel Machek <pavel@ucw.cz>
References: <20180805065920.GA8968@amd>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Cc:     ka-cheong.poon@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Message-ID: <fe3aa742-581c-0acc-be47-23bb00614138@oracle.com>
Date:   Sun, 5 Aug 2018 20:41:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805065920.GA8968@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8976 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808060040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/18 11:59 PM, Pavel Machek wrote:
> Hi!
> 
> Getting prompt "The RDS Protocol" (RDS) is not too helpful, and it is
> easily confused with Radio Data System (which we may want to support
> in kernel, too).
>
Fair enough. Prompt change is fine Pavel.

> I wonder if option should be named NET_RDS, instead?
> 
> And this sounds like a good idea:
> 
> (Plus, we normally have "module will be called foobar" and if unsure
> say X. What happened to those?)
>
Module name is there for a while so please use different one if you
have a conflict with it.

> diff --git a/net/rds/Kconfig b/net/rds/Kconfig
> index 41f7556..2738f14 100644
> --- a/net/rds/Kconfig
> +++ b/net/rds/Kconfig
> @@ -1,6 +1,6 @@
>   
>   config RDS
> -	tristate "The RDS Protocol"
> +	tristate "The Reliable Datagram Sockets (RDS) Protocol"
>   	depends on INET
>   	---help---
>   	  The RDS (Reliable Datagram Sockets) protocol provides reliable,
> 
Please git format this patch with your SOB and send it to netdev.
Feel free to add my ack with it.

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
