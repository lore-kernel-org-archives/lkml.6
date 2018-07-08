Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5053C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A69A2089F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A69A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932958AbeGHLoK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:44:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51112 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932839AbeGHLoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:44:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C91B3237DF;
        Sun,  8 Jul 2018 07:44:04 -0400 (EDT)
Date:   Sun, 8 Jul 2018 21:45:21 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
In-Reply-To: <CAMuHMdWzO1jzd=8SN5G_eoFObEAJR4-5u7JDExMefR__30QauA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807082133130.49@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de> <alpine.LNX.2.21.1806221455570.14@nippy.intranet> <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
 <CAMuHMdWzO1jzd=8SN5G_eoFObEAJR4-5u7JDExMefR__30QauA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2018, Geert Uytterhoeven wrote:

> On Fri, Jun 22, 2018 at 10:55 AM Arnd Bergmann <arnd@arndb.de> wrote:

> > I don't think anyone so far had a strong preference here, so I went 
> > with what Mathieu suggested and kept the original Mac behavior, but 
> > added the WARN_ON().
> 
> So, is this safe to apply?
> Especially in light of the warnings seen by Meelis with the PPC version.
> 

You mean, "can we apply this and avoid warning splats?"

Meelis's result says, "no".

I forget what date the RTC gets set to when the PMU/Cuda is reset but I 
suspect that timezone arithmetic in either MacOS or Linux could cause it 
to end up in 1969.

So I'd prefer to see the WARN_ON() removed.

-- 
