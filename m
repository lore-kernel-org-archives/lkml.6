Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD345C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7666207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBGJNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:13:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfBGJNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:13:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5E40C065F63;
        Thu,  7 Feb 2019 09:13:49 +0000 (UTC)
Received: from [10.40.204.71] (ovpn-204-71.brq.redhat.com [10.40.204.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 315F96155B;
        Thu,  7 Feb 2019 09:13:47 +0000 (UTC)
Subject: Re: [PATCH v2] powerpc/mm: move a KERN_WARNING message to pr_debug()
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>
References: <20190205202133.5048-1-lvivier@redhat.com>
 <8736p0kyiy.fsf@concordia.ellerman.id.au>
From:   Laurent Vivier <lvivier@redhat.com>
Message-ID: <866a19ec-93b2-de04-d8a3-11858fcaacea@redhat.com>
Date:   Thu, 7 Feb 2019 10:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8736p0kyiy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Feb 2019 09:13:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2019 05:33, Michael Ellerman wrote:
> Hi Laurent,
> 
> I'm not sure I'm convinced about this one. It seems like we're just
> throwing away the warning because it's annoying.
> 
> Laurent Vivier <lvivier@redhat.com> writes:
>> resize_hpt_for_hotplug() reports a warning when it cannot
>> increase the hash page table ("Unable to resize hash page
>> table to target order") but this is not blocking and
>> can make user thinks something has not worked properly.
> 
> Something did not work properly, the resize didn't work properly. Right?
> 
>> As we move the message to the debug area, report again the
>> ENODEV error.
>>
>> If the operation cannot be done the real error message
>> will be reported by arch_add_memory() if create_section_mapping()
>> fails.
> 
> Can you explain that more. Isn't the fact that the resize failed "the
> real error message"?

In arch_add_memory(), after calling resize_hpt_for_hotplug() it calls
create_section_mapping() and if create_section_mapping() fails we will
have the error message "Unable to create mapping for hot added memory"
and the real exit (EFAULT).

> 
>> Fixes: 7339390d772dd
>>        powerpc/pseries: Don't give a warning when HPT resizing isn't available
> 
> This should all be on one line, and formatted as:
> 
> Fixes: 7339390d772d ("powerpc/pseries: Don't give a warning when HPT resizing isn't available")
> 
> See Documentation/process/submitting-patches.rst for more info and how
> to configure git to do it automatically for you.

Thank you, I didn't know the format was documented.

Thanks,
Laurent

