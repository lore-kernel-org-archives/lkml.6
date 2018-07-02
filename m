Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEFFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723F925182
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hebjMOzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723F925182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeGBP4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:56:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39322 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeGBP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:56:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62FnJCc072743;
        Mon, 2 Jul 2018 15:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=k3CZv0CyYj5+8n3FTZ6PYfgRMnrX4kUGPOFEYG5dMGg=;
 b=hebjMOzBUcNYa2PbqQ+iWJVjehUIk0y3bIOgI7pcFcw39xjTV0VF0ESejYvtWpIzYYFe
 CIfIU0U9qM92d1CNh7gs6FnJvAC7NDngOZkPa062/KnVcyolvCJ2IavzVv752xVSn9NX
 Gs1RcA2v3BjfUMNv7rEKv9e4fcKj/k6B5Te5B7YcJej/wbvSdkPsx8e0rfuDaFa5zAuQ
 8qcO5UDKEmAjs8VZIwojCUnrEEfR4sbFHbCqxkK9Zd4O36Qx46g4WrOyZnPz/4+QM0X4
 zEGJcmklKDSJtGwVCW78pGavL3cD1T0DoRPhdHezzquJcX8iU4GnS3scRMTgusUw2JhY vQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jx19sn53x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 15:56:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62FuBKP028921
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 15:56:11 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62FuA1g029794;
        Mon, 2 Jul 2018 15:56:10 GMT
Received: from [192.168.100.186] (/92.39.186.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 08:56:10 -0700
Subject: Re: [PATCH] kvmclock: remove redundant variable 'size'
To:     Colin King <colin.king@canonical.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702070623.4769-1-colin.king@canonical.com>
From:   Liam Merwick <liam.merwick@oracle.com>
Message-ID: <36bf55ec-1937-6c3c-49fc-329a1309a815@oracle.com>
Date:   Mon, 2 Jul 2018 16:57:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702070623.4769-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=698
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/18 08:06, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable size is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable ‘size’ set but not used [-Wunused-but-set-variable]
> 

Is it worth adding

Fixes: cc1e24fdb064 ("x86/vdso: Remove pvclock fixmap machinery")

> Signed-off-by: Colin Ian King <colin.king@canonical.com>

either way

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

> ---
>   arch/x86/kernel/kvmclock.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index bf8d1eb7fca3..45c22ce941c1 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -354,13 +354,10 @@ int __init kvm_setup_vsyscall_timeinfo(void)
>   	int cpu;
>   	u8 flags;
>   	struct pvclock_vcpu_time_info *vcpu_time;
> -	unsigned int size;
>   
>   	if (!hv_clock)
>   		return 0;
>   
> -	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
> -
>   	cpu = get_cpu();
>   
>   	vcpu_time = &hv_clock[cpu].pvti;
> 
