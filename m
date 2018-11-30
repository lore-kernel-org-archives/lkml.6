Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC398C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2E520863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2E520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLAAsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:48:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLAAsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:48:00 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gSj09-0004FD-Ck; Fri, 30 Nov 2018 14:38:37 +0100
Date:   Fri, 30 Nov 2018 14:38:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Roman Kagan <rkagan@virtuozzo.com>
cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] x86/hyper-v: define structures from TLFS as packed
In-Reply-To: <20181130131122.GA2358@rkaganb.sw.ru>
Message-ID: <alpine.DEB.2.21.1811301438070.17702@nanos.tec.linutronix.de>
References: <20181130121511.12331-1-vkuznets@redhat.com> <20181130131122.GA2358@rkaganb.sw.ru>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Roman Kagan wrote:

> On Fri, Nov 30, 2018 at 01:15:11PM +0100, Vitaly Kuznetsov wrote:
> > Without 'packed' compiler is free to add optimization paddings and re-order
> > structure fields for randomization/optimization. And structures from
> > hyperv-tlfs.h are used for hypervisor-guest communication, we need to
> > ultimately forbid such practices.
> 
> Note that __packed also reduces the structure alignment to 1, which is
> not necessarily what you want.
> 
> E.g. some of these structures are passed by pointer to the hypercall,
> which requires its arguments to be 8byte-aligned.  I'm also not sure
> that passing unaligned argument to [rw]msr is ok, need to double-check.

If you have alignment requirements then you need to express them too.

Thanks,

	tglx
