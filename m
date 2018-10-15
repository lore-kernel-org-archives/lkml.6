Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FECC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4724D208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8TPu7ML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4724D208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJPGhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:37:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48334 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPGhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:37:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9FMmdx2021213;
        Mon, 15 Oct 2018 22:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jy7qEuDRGqGQH+cwmDv61Fp0ms0JdTM5vUaiMs66EJY=;
 b=h8TPu7ML0xPnsZqq9w3w5dlpRS532GImSxjpFOppGC5pzKqJvWspKRnKRgEep29D9VOZ
 ZIbvrHQWprh121y7owCvBQjl4ph5D+DQwvjOtHTSo5L2qU2zjZysoNrctXtBqznsyW+j
 jQkAU2V36DP70JKZRFXaDA9m/ig41xiXC/+K2BDIz4vB+2yW3Ph+bYwd3IwzjrUyADKQ
 QPFzR4zzk+wPmHGEC0pppMosDsQ7i4h0MfL0sNQlxi70fl5VbsYyKsNnmqA9iZBAzjrk
 RD4IynkVISWZ5bQjXGC67DiypGma5RiaLzmnfOetixs4me/fOjBEcvzJcpxvJfT8QKts 6A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39br54g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 22:49:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9FMniuF006752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 22:49:44 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9FMnhRt030396;
        Mon, 15 Oct 2018 22:49:43 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 15:49:43 -0700
Subject: Re: Gang scheduling
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>
References: <44347e72-d595-5c2d-3983-7237526c71c6@oracle.com>
 <c08136ad-3e68-ce1c-af03-b591acc582fc@linux.intel.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <cc445d4f-8532-cd38-08ed-0a70f2cb40a1@oracle.com>
Date:   Mon, 15 Oct 2018 15:49:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c08136ad-3e68-ce1c-af03-b591acc582fc@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 11:01 AM, Tim Chen wrote:
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
>
> Due to the constant change in gang scheduling status of the QEMU thread
> depending on whether vcpu is loaded or unloaded,
> the load balancing part of the code doesn't work very well.
Thanks. Does this mean each vcpu thread need to be affinitized to a cpu?
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
>

Also FYI I get the following error while building sched_1.23-base:

ERROR: "sched_ttwu_pending" [arch/x86/kvm/kvm-intel.ko] undefined!
scripts/Makefile.modpost:92: recipe for target '__modpost' failed

Adding the following fixed it:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 46807dc..302b77d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -21,6 +21,7 @@
  #include <trace/events/sched.h>

  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+EXPORT_SYMBOL_GPL(sched_ttwu_pending);

  #if defined(CONFIG_SCHED_DEBUG) && defined(HAVE_JUMP_LABEL)
  /*
