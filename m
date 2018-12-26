Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6013C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F621720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbeLZGOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:14:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLZGOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:14:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A68DFA4042;
        Wed, 26 Dec 2018 06:14:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B20606111A;
        Wed, 26 Dec 2018 06:14:44 +0000 (UTC)
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, bhe@redhat.com,
        linux-doc@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org,
        anderson@redhat.com, Kazuhito Hagio <khagio@redhat.com>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com> <20181217130024.GD12165@zn.tnic>
 <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
 <20181226032433.GB13556@dhcp-128-65.nay.redhat.com>
 <20181226033658.GB13822@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <c64a0459-e715-0e10-c674-c50570f32f08@redhat.com>
Date:   Wed, 26 Dec 2018 14:14:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181226033658.GB13822@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 26 Dec 2018 06:14:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年12月26日 11:36, Dave Young 写道:
> On 12/26/18 at 11:24am, Dave Young wrote:
>>>>> +
>>>>> +KERNEL_IMAGE_SIZE
>>>>> +=================
>>>>> +The size of 'KERNEL_IMAGE_SIZE', currently unused.
>>>>
>>>> So remove?
>>>>
>>>
>>> I'm not sure whether it should be removed, so i keep it.
>>
>> Just remove it.  It was added by Baoquan for KASLR issues, later
>> makedumpfile reverted the userspace part and added other implementation.
>>
>> In case old makedumpfile does not support new kernel, it has some kernel
>> versions support list in code, thus no worry about the compatibility
>> issue.
> 
> Ah, it is not unused actually, clone crash tool git:
> $ git grep KERNEL_IMAGE_SIZE
> x86_64.c:               if ((string = pc->read_vmcoreinfo("NUMBER(KERNEL_IMAGE_SIZE)"))) {
> 
> So in the documentation, the use cases of crash tool should also be
> covered.
> 

Sure, maybe only this one was ignored.

I will improve this variable in the documentation.

> Lianbo, it would be good to cc Dave and Kazu for these patches, could
> you cc them in your next post?
> 

Yes, i will add Dave and Kazu, and also resend patch v4.

Thanks.

>>
>> Thanks
>> Dave
> 
> Thanks
> Dave
> 
