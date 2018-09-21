Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD28ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4631921571
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afmvqcmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4631921571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391191AbeIVAHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:07:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58438 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:07:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8LIEMCO051784;
        Fri, 21 Sep 2018 18:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cUkl5zzTIALdM2WId67uYl/Swk2vIOaiXXsrKRXmU/M=;
 b=afmvqcmccf9QE0B3VqZ7BwsQu2nh2U2N+ZlVr+/qpztpqH6JIl/YE65ReL+fbaX4cocI
 Vp5mIzGmmGTcGWmFcn3bMTBQ3NqDhMWIit48y0CLCuqiHLvvwbKfDPtFzBZhShuRxs7W
 ILKo01tAyZaLK06AcMbdLr02jZsDcx44g9nWBNmcKTZp6D7gfFOjHg0/yBvmP7Qk4SAe
 mqOTvoug9Gcun7Y4acF3qseMQaulyc4JLycyQzWDu3egI9r79JvkhBSY7HNFu3dSppWt
 FOxpoVL9jekNehluOYCvDeeU4PnAOXMAdfoZpGKHulfM3y/SjcjtFX2hxSOaPeMPdFqx 1w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mmkm24r6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 18:17:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8LIHWAk013603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 18:17:32 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8LIHVmP009684;
        Fri, 21 Sep 2018 18:17:31 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Sep 2018 11:17:31 -0700
Subject: Re: [PATCH] RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for
 rds_ib_stats
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180921180451.18711-1-natechancellor@gmail.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <b7e183c1-294e-a98d-8d96-b7c7fcc358c2@oracle.com>
Date:   Fri, 21 Sep 2018 11:17:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921180451.18711-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9023 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2018 11:04 AM, Nathan Chancellor wrote:
> Clang warns when two declarations' section attributes don't match.
> 
> net/rds/ib_stats.c:40:1: warning: section does not match previous
> declaration [-Wsection]
> DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);
> ^
> ./include/linux/percpu-defs.h:142:2: note: expanded from macro
> 'DEFINE_PER_CPU_SHARED_ALIGNED'
>          DEFINE_PER_CPU_SECTION(type, name,
> PER_CPU_SHARED_ALIGNED_SECTION) \
>          ^
> ./include/linux/percpu-defs.h:93:9: note: expanded from macro
> 'DEFINE_PER_CPU_SECTION'
>          extern __PCPU_ATTRS(sec) __typeof__(type) name;
> \
>                 ^
> ./include/linux/percpu-defs.h:49:26: note: expanded from macro
> '__PCPU_ATTRS'
>          __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))
> \
>                                  ^
> net/rds/ib.h:446:1: note: previous attribute is here
> DECLARE_PER_CPU(struct rds_ib_statistics, rds_ib_stats);
> ^
> ./include/linux/percpu-defs.h:111:2: note: expanded from macro
> 'DECLARE_PER_CPU'
>          DECLARE_PER_CPU_SECTION(type, name, "")
>          ^
> ./include/linux/percpu-defs.h:87:9: note: expanded from macro
> 'DECLARE_PER_CPU_SECTION'
>          extern __PCPU_ATTRS(sec) __typeof__(type) name
>                 ^
> ./include/linux/percpu-defs.h:49:26: note: expanded from macro
> '__PCPU_ATTRS'
>          __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))
> \
>                                  ^
> 1 warning generated.
> 
> The initial definition was added in commit ec16227e1414 ("RDS/IB:
> Infiniband transport") and the cache aligned definition was added in
> commit e6babe4cc4ce ("RDS/IB: Stats and sysctls") right after. The
> definition probably should have been updated in net/rds/ib.h, which is
> what this patch does.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/114
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
Looks fine. Thanks !!

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
