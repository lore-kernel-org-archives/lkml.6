Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D703ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C51E21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C51E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeINSTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:19:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49755 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:19:51 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0nmm-0006HI-G9; Fri, 14 Sep 2018 15:05:24 +0200
Date:   Fri, 14 Sep 2018 15:05:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
In-Reply-To: <2f723b28-8f81-4b02-861c-42f756a8825a@redhat.com>
Message-ID: <alpine.DEB.2.21.1809141459530.10480@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <2f723b28-8f81-4b02-861c-42f756a8825a@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018, Florian Weimer wrote:

> On 09/14/2018 02:50 PM, Thomas Gleixner wrote:
> > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> > implementation, which extended the clockid switch case and added yet
> > another slightly different copy of the same code.
> > 
> > Especially the extended switch case is problematic as the compiler tends to
> > generate a jump table which then requires to use retpolines.
> 
> Does vDSO code really have to use retpolines?  It's in userspace, after all.

Unless you have IBRS/STIPB enabled, you need user space ratpoutine as well.

Thanks,

	tglx
