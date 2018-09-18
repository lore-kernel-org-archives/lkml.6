Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75264C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF43214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q5k+1wNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF43214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeIRUOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:14:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38216 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbeIRUOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:14:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8IEcxcp102797;
        Tue, 18 Sep 2018 14:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 to : cc : references : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1KIeoKu9ybrqIIMrjycedX2teX+RJUv97CeHXqXcspw=;
 b=Q5k+1wNJ1LAUV3hYz59IRuobmcnY4Z3k3mYBs6Ml3ymQivRQPXzkzK8nc0msjDs0t9ej
 u9WJDYywUdrMMfSAP7gGi9Sfat3Z2jd1Shg856x33P7LGCes3BPzLUDxGAuWqzsWkPuN
 fg2nOZFiGPCriPrOqpGca9XFhZeEb22QYIBQLiM67UPlaAfsrCgLU5+l9Npbnyj0CIIW
 PiPU8ASCRiuX7gcR5u6/FA06gJZG5B43/jVrVygEJ4BQ6t3oyFNeTcgmUybqvIWiS0p6
 NQDmr6EKUQEvu3uzkl6IvUBeivnyVF/QpeCa26KomcIiCvI2E6esKHqcI/Q44L+zGThs QA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mgtqqvwj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 14:40:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8IEenKt018147
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 14:40:49 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8IEemg6019530;
        Tue, 18 Sep 2018 14:40:48 GMT
Received: from [10.191.5.20] (/10.191.5.20)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Sep 2018 07:40:48 -0700
Reply-To: zhenzhong.duan@oracle.com
Subject: Re: [PATCH] x86/speculation: Use AMD specific retpoline for inline
 asm on AMD
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, dwmw@amazon.co.uk,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        bp@suse.de, hpa@zytor.com, dhaval.giani@oracle.com
References: <87411705-893f-46d3-b899-b09ed9fa8d1b@default>
 <20180918095015.GE19234@hirez.programming.kicks-ass.net>
 <3fcc1453-1618-9a79-71c9-5eede0023775@oracle.com>
 <20180918105939.GK24106@hirez.programming.kicks-ass.net>
 <1c6ca05f-094e-03e9-b21a-866aaf80cebb@oracle.com>
 <20180918130058.GM24106@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle
Message-ID: <9074a680-ad3d-e222-5b19-eb13fd1d4e28@oracle.com>
Date:   Tue, 18 Sep 2018 22:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918130058.GM24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 21:00, Peter Zijlstra wrote:
> On Tue, Sep 18, 2018 at 08:04:44PM +0800, Zhenzhong Duan wrote:
>> On 2018/9/18 18:59, Peter Zijlstra wrote:
>>> On Tue, Sep 18, 2018 at 06:31:07PM +0800, Zhenzhong Duan wrote:
>>>> On 2018/9/18 17:50, Peter Zijlstra wrote:
>>>>> On Mon, Sep 17, 2018 at 10:17:30PM -0700, Zhenzhong Duan wrote:
>>>>>> -#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
>>>>>> +#elif defined(CONFIG_RETPOLINE)
>>>>> This doesn't make any sense..
>>>> This change is used for x86_64 to have minimal Retpoline support when
>>>> CONFIG_RETPOLINE is defined but RETPOLINE isn't defined, or I missed
>>>> something?
>>> No it doesn't.
>>>
>>> #if defined(X86_64) && defined(RETPOLINE)
>>>
>>>    /* x86_64 retpoline goes here */
>>>
>>> #elif defined(RETPOLINE)
>>>
>>>    /* !x86_64 retpoline goes here */
>>>
>>> #else
>>>
>>>    /* !retpoline goes here
>>>
>>> #endif
>> Sorry, but I am confused.
>> So where is 'if defined(x86_64) && !defined(RETPOLINE) &&
>> defined(CONFIG_RETPOLINE)' go?
> Argh, CONFIG_RETPOLINE vs RETPOLINE :/
> 
> The thing is, the one you modify has a comment on that explains why it
> is i386 only. CET and retpolines don't like one another much.
> 
> And the x86_64 version uses %V which requires new GCC.
> 
> So I'm all for fixing the RETPOLINE_AMD thing, but at this point nobody
> should use the minimal stuff, that's just delusional.
> 

Clear, thanks for your explanation.

Zhenzhong
