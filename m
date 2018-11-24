Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98792C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0DF20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0DF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeKXNlT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:41:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:45423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeKXNlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:41:19 -0500
Received: from [192.168.1.153] ([98.118.28.103]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Mbx62-1gAVMO3PSo-00JLW9; Sat, 24
 Nov 2018 03:54:23 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] debugobjects: call debug_objects_mem_init eariler
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <alpine.DEB.2.21.1811232244140.1684@nanos.tec.linutronix.de>
Date:   Fri, 23 Nov 2018 21:54:19 -0500
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EDC1847C-1525-445C-AAFE-F07049C66565@gmx.us>
References: <alpine.DEB.2.21.1811222238270.1665@nanos.tec.linutronix.de>
 <20181123043117.992-1-cai@gmx.us>
 <dfa544fc-18d8-f1bf-fadf-46fdbda8d624@redhat.com>
 <alpine.DEB.2.21.1811232244140.1684@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.101.1)
X-Provags-ID: V03:K1:PZ/0F0wjN6pTDNwn1q1umgu0XVUwbcpTAu1ot28AQB8idd6Ay9I
 KQqwVK4ug5vzfe96sSd1ZN+cDCs54/S/rWtBLDOIRrNVOBfHdLDECE27ckHEwsWSQ4+ajh9
 IMh1wOZkwObM95hmGQs7SeWcxZ6Nh4Qa6gWBdyP+ElEbyKH3C9jpZrxJdQAiGkZ8jeo7rhU
 TxinzY8Gf35ieLqEkzmSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OFv+dldDL0w=:OwnloPHs5nMSgAycyNlkDB
 SSwIqMvXKHKcjce22TYgTIjc4IHwtz/82B+mYWm4qLv41Rq3d45BX5dHgr8uS8AOZxTCfGUtG
 mdlF4cwhJJMlQLrKoLbcGDbEcBg67YJEWCHWEs1pJUb7u0vRLr2KuclhwWslCoErTMN8kgqQS
 vqPtredrjXk/ReswmMSKKpwUt684OugQFY5yeHjsNN1QVIhklf7GjDdrx3m+WXo/6Le26oUi3
 WLa3IIo+RWQ0Hkri2JTBUK5sfbA1/SI7bqUwAiFixC/AQ7sNZVAif5+zDjrCNyxE6HdURI4bU
 V1aOpukELuheoJgwsuGV57YEY75wgduICy5L5N46v+GKYWxl4z1E0b3SnkQhJrC6P0M857koS
 0iFTMlbmvWMQsNTmM69RfP/FhNPOjfJ/i08nIaDRvABLskmo9fV6k7aYma2VdMKdQi6DtGnT0
 2OnM0xwXhifw3OPPA3U5YaaIiIeH6j8OzLUtQUe/5kGH2NlDB/2FbT5NFApnBgIiWrpAzZ8la
 JrGG57N3jwgBvM/WDilkDgqBnKVhhddQyy6Bz5wRFphoZ+qNWmyJQ2ZFyCeoZAWrxPFCphWHR
 5sFb9+BUdMzejty4/dLk3CPChr9nGSOS7bxq7e0OPj/jZzfyWRgaJjqO2DKkVQ08vbuV7xklz
 aBE+6ClRJDG5BGi7DEW7Pf7GCnPZ1y5hcpRNXBP0pZs4Npp9hQMJBRTtKO4d3aKT9Z+s+448R
 3U/gP1ajoEXzei1tqb5rr7AIw1ZbSFmJcmhOzVYDbUbxsDs6ICMwcTe2XMT+NYf/puNQP+o0Y
 EuNCKyBl5aSpnRXUaIGLg2VhToVAbVga4dCVeVm+FKCtXjdvEl1kMVnlX5bUnG0CbluRRkCVe
 ceiXjVxlKWZtV4ggKwGIb1UoyQk2od6fjQuqQU0Ds=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 23, 2018, at 4:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Thu, 22 Nov 2018, Waiman Long wrote:
>> On 11/22/2018 11:31 PM, Qian Cai wrote:
>>> The current value of the early boot static pool size, 1024 is not big
>>> enough for systems with large number of CPUs with timer or/and workqueue
>>> objects selected. As the results, systems have 60+ CPUs with both timer
>>> and workqueue objects enabled could trigger "ODEBUG: Out of memory.
>>> ODEBUG disabled".
>>> 
>>> However, none of the things are actually used or required beofre
> 
> before
> 
>>> debug_objects_mem_init() is invoked.
>>> 
>>> According to tglx,
>>> "the reason why the call is at this place in start_kernel() is
>>> historical. It's because back in the days when debugobjects were added
>>> the memory allocator was enabled way later than today. So we can just
>>> move the debug_objects_mem_init() call right before sched_init()."
>>> 
>>> Afterwards, when calling debug_objects_mem_init(), interrupts have
>>> already been disabled and lockdep_init() will only be called later, so
>>> no need to worry about interrupts in
>>> debug_objects_replace_static_objects().
> 
> Just out of curiosity. How many objects are allocated between early and mem
> init?

64-CPU:   68
160-CPU: 164
256-CPU: 260

INIT_WORK(&p->wq, free_work) is called per CPU:

start_kernel
   vmalloc_init
      __init_work
        __debug_object_init

Once debug_objects_mem_init() is moved just before vmalloc_init(), there
is only 1 object.

ODEBUG: 1 of 1 active objects replace

> 
>>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>>> index 70935ed91125..cc5818ced652 100644
>>> --- a/lib/debugobjects.c
>>> +++ b/lib/debugobjects.c
>>> @@ -1132,13 +1132,6 @@ static int __init debug_objects_replace_static_objects(void)
>>> 		hlist_add_head(&obj->node, &objects);
>>> 	}
>>> 
>>> -	/*
>>> -	 * When debug_objects_mem_init() is called we know that only
>>> -	 * one CPU is up, so disabling interrupts is enough
>>> -	 * protection. This avoids the lockdep hell of lock ordering.
>>> -	 */
>>> -	local_irq_disable();
>> 
>> I think you should have a comment saying that debug_objects_mm_init() is
>> called early with only one CPU up and interrupt disabled. So it is safe
>> to replace static objects without any protection.
> 
> Yes please.
> 
> Thanks,
> 
> 	tglx

