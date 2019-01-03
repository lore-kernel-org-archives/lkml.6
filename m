Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599AC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A307921479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbkliaUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfACCIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:08:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60714 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfACCIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:08:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0324GvC083917;
        Thu, 3 Jan 2019 02:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LQOY38Ihd6qPrMXS7Kg6EK0CT6lRvuyFcgzLpHM3JJI=;
 b=VbkliaUSRpofcJhNaF9MXWy/m+TDU7t2LEtX/3+dEyko2BNzpwHH9XL5LzFW/UgB2xH8
 LFgKTv/7X6b2t50sU+xch2c/aE589f2l3nUYV9ao8ORghbd753eLlmJMusImTU88p+h0
 T5EehWEu0m44fOgDdzZJvQIcG2XHPWzFSlOpBU1rrpiRugwGtd5vdcqExYwlhgsCKraQ
 McxDVctaEF5PluqAvvbrEHw0a4teqEWlP2yQHqZNB5QFrqZu9Io50TFo4eIocsVfGz8i
 HPqVvvwEKXjFJv4fkPi8TnOguvaIHaGxR2Ztm2tS+KC4mIEYK3W9/D6iPjErAod3qqpL 5w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pp1jr4srk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jan 2019 02:07:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0327NDK003348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jan 2019 02:07:23 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0327N0d032650;
        Thu, 3 Jan 2019 02:07:23 GMT
Received: from [10.191.16.61] (/10.191.16.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 18:07:23 -0800
Subject: Re: [PATCH] x86/retpoline: change RETPOLINE into CONFIG_RETPOLINE
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20181231234253.2724-1-namit@vmware.com>
 <f09d61a6-21ff-1557-d3f7-209944a4308d@oracle.com>
 <DE796CE1-11EB-42B7-904E-A20CA9AC3699@vmware.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <34e5c301-e67a-3688-18ee-d64b608d5cd2@oracle.com>
Date:   Thu, 3 Jan 2019 10:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <DE796CE1-11EB-42B7-904E-A20CA9AC3699@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9124 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901030016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/3 1:23, Nadav Amit wrote:
>> On Jan 1, 2019, at 5:17 PM, Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
>>
>>
>> On 2019/1/1 7:42, Nadav Amit wrote:
>>> A recent enhancement intentionally fails the kernel build if the
>>> compiler does not support retpolines and CONFIG_RETPOLINE is set.
>>>
>>> However, the patch that introduced it did not change RETPOLINE macro
>>> references into CONFIG_RETPOLINE ones. As a result, indirect branches
>>> that are used by init functions are not kept (i.e., they use
>>> retpolines), and modules that do not use retpolines are marked as
>>> retpoline-safe.
>>>
>>> Fix it be changing RETPOLINE into CONFIG_RETPOLINE.
>>>
>>> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>> ---
>>>   arch/x86/kernel/cpu/bugs.c   | 2 +-
>>>   include/linux/compiler-gcc.h | 2 +-
>>>   include/linux/module.h       | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>>> index 8654b8b0c848..1de0f4170178 100644
>>> --- a/arch/x86/kernel/cpu/bugs.c
>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>> @@ -215,7 +215,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
>>>   static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
>>>   	SPECTRE_V2_USER_NONE;
>>>   -#ifdef RETPOLINE
>>> +#ifdef CONFIG_RETPOLINE
>>>   static bool spectre_v2_bad_module;
>>>     bool retpoline_module_ok(bool has_retpoline)
>>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>>> index 2010493e1040..977ddf2774f9 100644
>>> --- a/include/linux/compiler-gcc.h
>>> +++ b/include/linux/compiler-gcc.h
>>> @@ -68,7 +68,7 @@
>>>    */
>>>   #define uninitialized_var(x) x = x
>>>   -#ifdef RETPOLINE
>>> +#ifdef CONFIG_RETPOLINE
>>>   #define __noretpoline __attribute__((__indirect_branch__("keep")))
>>>   #endif
>>>   diff --git a/include/linux/module.h b/include/linux/module.h
>>> index fce6b4335e36..0c575f51fe57 100644
>>> --- a/include/linux/module.h
>>> +++ b/include/linux/module.h
>>> @@ -817,7 +817,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
>>>   static inline void module_bug_cleanup(struct module *mod) {}
>>>   #endif	/* CONFIG_GENERIC_BUG */
>>>   -#ifdef RETPOLINE
>>> +#ifdef CONFIG_RETPOLINE
>>>   extern bool retpoline_module_ok(bool has_retpoline);
>>>   #else
>>>   static inline bool retpoline_module_ok(bool has_retpoline)
>> Someone sent a similar patch last month, see below link,  you missed the change in scripts/mod/modpost.c
> Indeed. I missed this patch since it wasn’t on tip (and Google wasn’t
> helpful either).
>
> I wonder why it has still not been applied.


See https://lkml.org/lkml/2018/12/21/244

-- 
Thanks
Zhenzhong

