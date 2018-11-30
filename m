Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E16320868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E16320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeK3X7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:59:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeK3X7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:59:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7F8316974D;
        Fri, 30 Nov 2018 12:49:56 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42A661054FD4;
        Fri, 30 Nov 2018 12:49:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] x86/hyper-v: define structures from TLFS as packed
In-Reply-To: <alpine.DEB.2.21.1811301320410.17702@nanos.tec.linutronix.de>
References: <20181130121511.12331-1-vkuznets@redhat.com> <alpine.DEB.2.21.1811301320410.17702@nanos.tec.linutronix.de>
Date:   Fri, 30 Nov 2018 13:49:52 +0100
Message-ID: <87y39awwzz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 30 Nov 2018 12:49:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, 30 Nov 2018, Vitaly Kuznetsov wrote:
>
>> Subject: x86/hyper-v: define structures from TLFS as packed
>
> Please start the first word after the prefix colon with an uppercase
> letter. Also structures from TLFS doesn't make sense to me. Something like
> this:
>
> Subject: x86/hyper-v: Mark TLFS structures packed
>
>> Without 'packed' compiler is free to add optimization paddings and re-order
>> structure fields for randomization/optimization. And structures from
>
> s/And/As/ ?
>
>> hyperv-tlfs.h are used for hypervisor-guest communication, we need to
>> ultimately forbid such practices.
>
> That whole paragraph reads a bit strange. Something like:
>
>   The TLFS structures are used for hypervisor-guest communication and must
>   exactly meet the specification.
>
>   Compilers can add alignment padding to structures or reorder struct
>   members for randomization and optimization, which would break the
>   hypervisor ABI.
>
>   Mark the structures as packed to prevent this.
>
> Hmm?

Sure, will do v2!

>
>> Suggested-by: Nadav Amit <nadav.amit@gmail.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Other than that: Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

-- 
Vitaly
