Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EEEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB4325603
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB4325603
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbeFYIko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:40:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeFYIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:40:41 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXN37-0004jz-TD; Mon, 25 Jun 2018 10:40:38 +0200
Date:   Mon, 25 Jun 2018 10:40:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: Build/qemu test results for v4.18-rc2
In-Reply-To: <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806251040060.8650@nanos.tec.linutronix.de>
References: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net> <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com>
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

On Mon, 25 Jun 2018, Linus Torvalds wrote:
> On Mon, Jun 25, 2018 at 12:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 134 pass: 113 fail: 21
> > Failed builds:
> >         i386:allyesconfig
> >         i386:allmodconfig
> 
> These seem to be due to the trial code to embed user modules in the
> netfilter modules to use bpf  to do netfilter (aka bpfilter). Right
> now that doesn't cross-compile right.
> 
> I'm hoping the networking people get their trial balloon to work
> right, but if worst comes to worst, it will just be disabled for 4.18.
> 
> In the meantime, I'm hoping it doesn't hold back any *other* testing.
> I'm assuming the allyes/modconfig build failures don't actually matter
> for the boot testing etc.
> 
> The mips problems I have no idea about.

Fix is in the mips tree already.
