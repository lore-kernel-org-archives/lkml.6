Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046F1208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pw/Bpi1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046F1208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeH1Eoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:44:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60980 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeH1Eoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:44:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7S0okHZ006943;
        Tue, 28 Aug 2018 00:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mauTlnwgtjCwY4Ptr0YqQ2RM4R0UAU7c8q6Z9B88W0A=;
 b=pw/Bpi1/UNg/G+4d3Ey/r1d9u5eHEg8I8BkGpOi1OCkvDoFzunSd/p/yB67lyoomw0u6
 cbAgU4sDxB8iXPBII6uP667ZIR0EArN4jW4ZZuIoDrahXDAyu//8RXFgsaK2XmGNzTqy
 PgsuiaGSp21X95UTAq29U8DjvhjEfGZxyJbrVhuWtmRM53I7HTC0mbW/MKp2MtCb4ED4
 pNl+uFMzM850aWZ10DP5/fDBHuzPAQ/nhYP62GBphwWILqVM/4dMvKOnCIR1nhijFCIH
 yWKmXFjgAE9mXgPA7r18X15bGymvyms2BplWgKEvG/x4XCwVm8sY0UPrihkK8yAw83SM kQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2m2y2p8x2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 00:55:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7S0tOP0030327
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 00:55:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7S0tMGm014628;
        Tue, 28 Aug 2018 00:55:23 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 17:55:22 -0700
Subject: Re: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        t-kristo@ti.com, tony@atomide.com, linux-clk@vger.kernel.org
References: <20180828005056.27326-1-nm@ti.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <d2027284-5265-388e-f793-cd048ac8a587@oracle.com>
Date:   Mon, 27 Aug 2018 17:55:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828005056.27326-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=607
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/2018 5:50 PM, Nishanth Menon wrote:
> K3_ARCH uses TISCI for clocks as well. Enable the same
> for the driver support.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Ref: https://patchwork.kernel.org/patch/10447677/
> 
> Since ARCH_K3 only got integrated in v4.19-rc1, rebased to v4.19-rc1 tag..
> 
>   drivers/clk/Makefile         | 1 +
>   drivers/clk/keystone/Kconfig | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
