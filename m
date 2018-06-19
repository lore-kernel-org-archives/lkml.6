Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2CC5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0658D20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0658D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030470AbeFSU6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:58:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58271 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755470AbeFSU6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:58:13 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVNh2-0003ow-Nz; Tue, 19 Jun 2018 22:57:36 +0200
Date:   Tue, 19 Jun 2018 22:57:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 1/7] x86/tsc: remove tsc_disabled flag
In-Reply-To: <20180619200115.GH2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806192256370.10546@nanos.tec.linutronix.de>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-2-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806191928040.10546@nanos.tec.linutronix.de> <20180619184654.GG2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806192110230.10546@nanos.tec.linutronix.de> <20180619200115.GH2494@hirez.programming.kicks-ass.net>
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

On Tue, 19 Jun 2018, Peter Zijlstra wrote:

> On Tue, Jun 19, 2018 at 09:12:45PM +0200, Thomas Gleixner wrote:
> > On Tue, 19 Jun 2018, Peter Zijlstra wrote:
> > > It does not; there is TSC usage even if you boot with notsc on. See how
> > > it does not clear X86_FEATURE_TSC for instance.
> > 
> > Well, kinda. There is some stuff in the apic calibration which uses TSC
> > independent of tsc_disabled, but that's about it.
> 
> Still, that precludes booting on hardware without TSC, so what's the
> point of having notsc? I'm all for killing the thing.

I'm not arguing against removing it. I just refuse to accept changelogs
which suggest that there is no functional change.

Thanks,

	tglx

