Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D88C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B732081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B732081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeLEOWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:22:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24339 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:22:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7B59653C4;
        Wed,  5 Dec 2018 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 870C06014F;
        Wed,  5 Dec 2018 14:21:49 +0000 (UTC)
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205101653.GA6940@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <72c311b4-1946-0bcf-54d9-9fcd7f6e630c@redhat.com>
Date:   Wed, 5 Dec 2018 22:21:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205101653.GA6940@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 05 Dec 2018 14:22:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年12月05日 18:16, Dave Young 写道:
>>>> +init_uts_ns
>>>> +===========
>>>> +This is the UTS namespace, which is used to isolate two specific elements
>>>> +of the system that relate to the uname system call. The UTS namespace is
>>>> +named after the data structure used to store information returned by the
>>>> +uname system call.
>>>
>>> Those non-obvious exports should also have a short explanation why
>>> they're part of VMCOREINFO.
>>>
>>>> +
>>>> +node_online_map
>>>> +===============
>>>> +It is a macro definition, actually it is an arrary node_states[N_ONLINE],
>>>> +and it represents the set of online node in a system, one bit position
>>>> +per node number.
>>>
>>> Ditto.
>>>
>>> So yeah, people can find out what those things are but I think it is
>>> more important to state here *why* they're part of VMCOREINFO and how
>>> they're used and why they're exported.
>>>
>>
>> This is a good question.
>>
>> For these two *why*, it should be easy to understand. Because user-space tools
>> need to know basic information, such as the symbol values, field offset, structure
>> size, etc. Otherwise, these tools won't know how to analyze the memory of the crash
>> kernel.
>>
>> For the second question 'how they are used', we can get the answer from user-space
>> tools, such as makedumpfile, crash tools. Therefore, it may not need to explain any
>> more in kernel document. On the other hand, if we must put these contents into kernel
>> document, i have to say, that would be a hard task.
> 
> It should be a good chance to learn how makedumpfile works :),  Maybe it is
> hard to get *all* of them, but it would be good to dig and find the
> thing you can find then explain it.  And leave those *unknown* part as
> FIXME or TODO, people can add description later. 
> 

Thank you, Dave.

It looks like a good idea.


Regards,
Lianbo

> Added Kazu in cc as well..
> > Thanks
> Dave
> 
