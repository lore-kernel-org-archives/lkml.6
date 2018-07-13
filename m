Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45705ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D912084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D912084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeGMXIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:08:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeGMXIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:08:35 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fe6uZ-0002HM-I3; Sat, 14 Jul 2018 00:51:40 +0200
Date:   Sat, 14 Jul 2018 00:51:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, jgross@suse.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [patch 0/7] x86/kvmclock: Remove memblock dependency and further
 cleanups
In-Reply-To: <CAGM2reaKmu=h8QosuoJvJzzdTy2QfGRp9YxaKK-9UzpsfL-MoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807140049200.2644@nanos.tec.linutronix.de>
References: <20180706161307.733337643@linutronix.de> <CAGM2reaKmu=h8QosuoJvJzzdTy2QfGRp9YxaKK-9UzpsfL-MoQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Pavel Tatashin wrote:

> > So this still will have some overhead when kvmclock is not in use, but
> > bringing it down to zero would be a massive trainwreck and even more
> > indirections.
> 
> Hi Thomas,
> 
> In my opinion, having kvmclock page in  __initdata for boot cpu, and
> setup it in init_hypervisor_platform(). Later, switch to memblock
> allocated memory in x86_init.hyper.guest_late_init() for all CPUs
> would not be too bad, and might be even use fewer lines of code. In
> addition, it won't have any overhead when kvm is not used.

Why memblock? This can be switched when the allocator is up and
running. And you can use the per cpu allocator for that.

I'm not having cycles at the moment to look at that, so feel free to pick
the series up and enhance it.

Thanks,

	tglx
