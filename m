Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F968C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E19A20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E19A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeLACT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:19:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLACT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:19:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C7F93082E71;
        Fri, 30 Nov 2018 15:10:21 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2E561949B;
        Fri, 30 Nov 2018 15:10:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/hyper-v: define structures from TLFS as packed
In-Reply-To: <20181130142603.GB2358@rkaganb.sw.ru>
References: <20181130121511.12331-1-vkuznets@redhat.com> <20181130131122.GA2358@rkaganb.sw.ru> <87va4ewug9.fsf@vitty.brq.redhat.com> <20181130142603.GB2358@rkaganb.sw.ru>
Date:   Fri, 30 Nov 2018 16:10:17 +0100
Message-ID: <87pnumwqhy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 30 Nov 2018 15:10:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Nov 30, 2018 at 02:44:54PM +0100, Vitaly Kuznetsov wrote:
>
>> I also checked this patch before sending out, WS2016 guest boots without
>> issues. Any particular places you're worried about?
>
> It's Linux guests on Hyper-V that need to be checked.
>

That's exactly what I've tested, Linux guest on Windows Server 2016 with
Hyper-V. (Actually, I checked WS2016 guest on KVM with hv_stimer and
hv_stimer_direct too but afaiu we're not worried about the alignment
requirements there).

-- 
Vitaly
