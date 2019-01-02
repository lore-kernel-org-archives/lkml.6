Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C426C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E8F218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YH8FObRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfABBRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:17:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56198 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfABBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:17:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0218u2f194857;
        Wed, 2 Jan 2019 01:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DOEFMh2Em9wTUlaM+xAb4z+7QOtFFUelr7kMXpNVW5Y=;
 b=YH8FObRpxHDPnFatzl6VA+CUkkW4V/9oxOHr0JATbjzGvy7/8916bnslAarcBu7Dgucs
 f+JKO8T3vdxDTsqzsofpJPISJhrrQQf80JZsJrSHUbG6R+IcXX0c12rKGomQnJDRPGi8
 lqC420st/BdgTygJZT/vHc6R8282a7keqc0wEwGaWVK1KQONOCX3caBLp6F77XS6x10H
 hEWFGHH5asNvWFLcevSjINhoQlBzz+KaZIoDjCqMN60ZdI3vamzr6ekem3h4cTy9Pl6o
 Whz70obaVZUX/cBfVdOZkek3g9Os0OO/sS7uR9YQGUF4HqDYqMzNo+IMokk5YtSW3HD2 sA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pp1jr006t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 01:17:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x021H8i7014968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 01:17:08 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x021H6sq004834;
        Wed, 2 Jan 2019 01:17:06 GMT
Received: from [10.191.15.253] (/10.191.15.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jan 2019 17:17:06 -0800
Subject: Re: [PATCH] x86/retpoline: change RETPOLINE into CONFIG_RETPOLINE
To:     Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        stable@vger.kernel.org
References: <20181231234253.2724-1-namit@vmware.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <f09d61a6-21ff-1557-d3f7-209944a4308d@oracle.com>
Date:   Wed, 2 Jan 2019 09:17:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181231234253.2724-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/1 7:42, Nadav Amit wrote:
> A recent enhancement intentionally fails the kernel build if the
> compiler does not support retpolines and CONFIG_RETPOLINE is set.
>
> However, the patch that introduced it did not change RETPOLINE macro
> references into CONFIG_RETPOLINE ones. As a result, indirect branches
> that are used by init functions are not kept (i.e., they use
> retpolines), and modules that do not use retpolines are marked as
> retpoline-safe.
>
> Fix it be changing RETPOLINE into CONFIG_RETPOLINE.
>
> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   arch/x86/kernel/cpu/bugs.c   | 2 +-
>   include/linux/compiler-gcc.h | 2 +-
>   include/linux/module.h       | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 8654b8b0c848..1de0f4170178 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -215,7 +215,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
>   static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
>   	SPECTRE_V2_USER_NONE;
>   
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>   static bool spectre_v2_bad_module;
>   
>   bool retpoline_module_ok(bool has_retpoline)
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 2010493e1040..977ddf2774f9 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -68,7 +68,7 @@
>    */
>   #define uninitialized_var(x) x = x
>   
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>   #define __noretpoline __attribute__((__indirect_branch__("keep")))
>   #endif
>   
> diff --git a/include/linux/module.h b/include/linux/module.h
> index fce6b4335e36..0c575f51fe57 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -817,7 +817,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
>   static inline void module_bug_cleanup(struct module *mod) {}
>   #endif	/* CONFIG_GENERIC_BUG */
>   
> -#ifdef RETPOLINE
> +#ifdef CONFIG_RETPOLINE
>   extern bool retpoline_module_ok(bool has_retpoline);
>   #else
>   static inline bool retpoline_module_ok(bool has_retpoline)

Someone sent a similar patch last month, see below link,  you missed the 
change in scripts/mod/modpost.c

https://lkml.org/lkml/2018/12/10/540

But you patch description is more clear.

-- 
Thanks
Zhenzhong

