Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C334EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848302087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTdHA5eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfADFy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:54:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADFy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:54:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x045rjFQ116367;
        Fri, 4 Jan 2019 05:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UDvk/PYOn1HQzMW6Vz5YPwg+wE6thHGEQoQhoUP/IXQ=;
 b=RTdHA5egKcPvzwjJOFGwGxgipVg6zlUqzY5UlHHpV2cpY+nzgT2h4WB1T3lxcJ1nZjef
 Z4y13av7sCXNE2XDfSLRJrPOaJkE0ggGQNtCHdi5x2SRyxCrks8ZWgDBSlp+R/SQPgCU
 EM1LOTtrIasST2t9PA6VOrmMe1IGoWviVFLyspaKhl60WkneKa3ZBSCSBqCx8n6PvEi6
 Xcs1RiJsBIN8EPHl8IdPKGDG9Yf+9RCdN02KV1aHLgwHC/bRJyiAqlMngfot0DKl3AMy
 FWlDY0tiE0vPK1aCTY6L+7WVEQWSbwbUbnJxp3zzBcoNg0jpdqAJrRX0byoEqA5uH5H3 ZA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pp1jrae53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 05:54:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x045sDdF026768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 05:54:13 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x045sAL0027509;
        Fri, 4 Jan 2019 05:54:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 21:54:10 -0800
To:     Ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Subject: Re: [PATCH 0/12] scsi: arcmsr: update for ccb structure address can above 4GB
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1545207461.4457.10.camel@Centos6.3-64>
Date:   Fri, 04 Jan 2019 00:54:06 -0500
In-Reply-To: <1545207461.4457.10.camel@Centos6.3-64> (Ching Huang's message of
        "Wed, 19 Dec 2018 16:17:41 +0800")
Message-ID: <yq11s5t7ytd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ching,

> This patch series are against to mkp's 4.21/scsi-queue.
>
> 1. Rename acb structure member roundup_ccbsize to ioqueue_size
> 2. Rename arcmsr_free_mu to arcmsr_free_io_queue
> 3. Merge arcmsr_alloc_io_queue to arcmsr_alloc_ccb_pool
> 4. Update arcmsr_alloc_ccb_pool for ccb buffer address above 4GB
> 5. Update codes for ACB_ADAPTER_TYPE_A in case of ccb address above 4GB
> 6. Update codes for ACB_ADAPTER_TYPE_B in case of ccb address above 4GB
> 7. Update codes for ACB_ADAPTER_TYPE_C in case of ccb address above 4GB
> 8. Update codes for ACB_ADAPTER_TYPE_D in case of ccb address above 4GB
> 9. Add an option of set dma_mask_64 for ACB_ADAPTER_TYPE_A
> 10.Separate 'set dma mask' as a function
> 11.Fix suspend/resume of ACB_ADAPTER_TYPE_B
> 12.Update driver version to v1.40.00.10-20181217

Applied to 4.22/scsi-queue, thanks!

Your email threading ended up funny. Patchwork treated your submission
as several distinct patch series.

-- 
Martin K. Petersen	Oracle Linux Engineering
