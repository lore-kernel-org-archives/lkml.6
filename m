Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1731CC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7E82190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FM515L3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbfBMDAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:00:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36792 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390243AbfBMC77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:59:59 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D2xUtB048656;
        Wed, 13 Feb 2019 02:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DGeFANtyGzc66dMUkUoBWt6GC+vzVlM18gqe6DtGsQI=;
 b=FM515L3tyhnJmzHA30kgGawGvnFOBRpGiHLHB71TPiBuIA1IuK+6NvVTh8ugLnLCJnH6
 zIy4csHfPu8nAHDFCFuJuDc66bO93VDNjaZol/MqOYy7j1xWcu4Vhw82o5Ittc4pA4ic
 qyxlNPDvikEHoZWbtGXeYSOO5NZ8lTQQlwlxTmhNQL8gL0w8+Zl9NpvO3EQKE7xQfkdb
 a8KdCraQlBcrWjtF3/ywZR7xGg1eQqgOeiLT9Okb7DW44O1iMu3rFVLUdBQwjvREXW9G
 7UrLEE+choabhHuUYNlSlY45fYJiEwzlQKRfevsEnNoXyeSE0YPVRwhAsJTLh6vEWGbK Ig== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qhre5ffg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 02:59:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D2xktf005096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 02:59:46 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D2xksu022427;
        Wed, 13 Feb 2019 02:59:46 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 18:59:45 -0800
Subject: Re: Gang scheduling
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>
References: <44347e72-d595-5c2d-3983-7237526c71c6@oracle.com>
 <c08136ad-3e68-ce1c-af03-b591acc582fc@linux.intel.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <890bd498-93b2-5d9d-8066-21278540727f@oracle.com>
Date:   Tue, 12 Feb 2019 18:57:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c08136ad-3e68-ce1c-af03-b591acc582fc@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On 10/12/18 11:01 AM, Tim Chen wrote:
> On 10/10/2018 05:09 PM, Subhra Mazumdar wrote:
>> Hi,
>>
>> I was following the Coscheduling patch discussion on lkml and Peter mentioned he had a patch series. I found the following on github.
>>
>> https://github.com/pdxChen/gang/commits/sched_1.23-loadbal
>>
>> I would like to test this with KVMs. Are the commits from 38d5acb to f019876 sufficient? Also is there any documentaion on how to use it (any knobs I need to turn on for gang scheduling to happen?) or is it enabled by default for KVMs?
>>
>> Thanks,
>> Subhra
>>
> I would suggest you try
> https://github.com/pdxChen/gang/tree/sched_1.23-base
> without the load balancing part of gang scheduling.
> It is enabled by default for KVMs.
I applied the following 3 patches on 4.19 and tried to install a KVM (with
virt-install). But the kernel hangs with following error:

kernel:watchdog: BUG: soft lockup - CPU#21 stuck for 23s! [kworker/21:1:573]

kvm,sched: Track VCPU threads
x86/kvm,sched: Add fast path for reschedule interrupt
sched: Optimize scheduler_ipi()

The track VCPU patch seems to be the culprit.

Thanks,
Subhra
>
> Due to the constant change in gang scheduling status of the QEMU thread
> depending on whether vcpu is loaded or unloaded,
> the load balancing part of the code doesn't work very well.
>
> The current version of the code need to be optimized further.  Right now
> the QEMU thread constantly does vcpu load and unload during VM enter and exit.
> We gang schedule only after vcpu load and register the thread to be gang
> scheduled.  When we do vcpu unload, the thread is removed from the set
> to be gang scheduled.  Each time there's a synchronization with the
> sibling thread that's expensive.
>
> However, for QEMU, there's a one to one correspondence between the QEMU
> thread and vcpu.  So we don't have to change the gang scheduling status
> for such thread to avoid the church and sync with the sibling. That should
> be helpful for VM with lots of I/O causing constant VM exits.  We're
> still working on this optimization.  And the load balancing should be
> better after this change.
>
> Tim
