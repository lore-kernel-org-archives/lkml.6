Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F40C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FE320849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iupPx8cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FE320849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeGFVSx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:18:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41930 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932424AbeGFVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:18:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w66LEuuI158510;
        Fri, 6 Jul 2018 21:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XCKPcPQdl1EWw6nNCGAtYFa8UAcaUG+CCUEmToNv964=;
 b=iupPx8cymUkaIdhUZb3QoPVR+HiSREZGbbfkXH31r5ZLOLZyIi/IBCxAJKdrm7WGiwTQ
 bDUbO/YfM24sAw1ksdp4ksdCjfFSHFs0HhEhbScZ13nU6HQisnIV+IpGPNTOJnDaZF5n
 RV+951I0U/6Ux0N+hHQGLirdD+ifailB3JTiYqRDx+LdJZB6V2NhjBvOtGWXpyY/Zjtl
 kWRK5MCbZ0JgEpbmVcvMVkKmTPcacJhrLlaAOnyEnyheZ2W6c9I2vqADXsUWGJ7su1vV
 YoXL7c2cBsNwhCMohTiB0HeO1HOASqU1Kj6TzI2YaMoaiIBadTZfjW8w6/TdtD1yhGC4 iw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k0dntb1f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jul 2018 21:18:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w66LIZ7j032445
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 21:18:35 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w66LIZ5D005683;
        Fri, 6 Jul 2018 21:18:35 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Jul 2018 14:18:35 -0700
Subject: Re:
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org
References: <1530911788-7033-1-git-send-email-santosh.shilimkar@oracle.com>
 <1530911788-7033-3-git-send-email-santosh.shilimkar@oracle.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <08292ecf-ed2e-c60a-a4b6-c69be199345a@oracle.com>
Date:   Fri, 6 Jul 2018 14:18:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1530911788-7033-3-git-send-email-santosh.shilimkar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8946 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=598
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807060239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this.. Will send again with subjects fixed

On 7/6/2018 2:16 PM, Santosh Shilimkar wrote:
> Subject: [GIT PULL 3/3] SOC: Driver updates for v4.19
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>    Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.19
> 
> for you to fetch changes up to 990c10091db318c7eb7e8935c86b6f7c01585015:
> 
>    soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused (2018-07-06 09:47:51 -0700)
> 
> ----------------------------------------------------------------
> Keystone SOC driver update for 4.19
> 
>   -  Add suspend/resume functionality to TI EMIF SRAM driver
>   -  Add wakeup M3 RTC self refresh support
>   -  Fix for the PM runtime ifdefs
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>        soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused
> 
> Dave Gerlach (2):
>        memory: ti-emif-sram: Add resume function to recopy sram code
>        soc: ti: wkup_m3_ipc: Add wkup_m3_request_wake_src
> 
> Keerthy (1):
>        soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support
> 
>   drivers/memory/ti-emif-pm.c  | 33 +++++++++++++++++++
>   drivers/soc/ti/wkup_m3_ipc.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/wkup_m3_ipc.h  |  9 ++++++
>   3 files changed, 118 insertions(+)
> 
