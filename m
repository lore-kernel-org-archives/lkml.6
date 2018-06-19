Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F3C5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251992075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="4fRLkKJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251992075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030443AbeFSUpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:45:34 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:55111 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755280AbeFSUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T7Br3Nsi+YA2MsCtxMDdZFtb6GqTx/7CqWb7BX+W4qk=; b=4fRLkKJcNzPsyISg0swI/VqrGV
        icCBWYySmrln4ucxzapgOauQ5PToAEj6r2h/5Fv6zIz9AUXy/nz9B6b9bFy38t7Df+Ls4Z5qduoyo
        H+hJCf4Es3C7iW5xRKShWJKDOoehcDGnYmjfnBtMAXCH4rj9Vm5CFYNDCF0CRh4d2jY1jOyyXAX6i
        6OOj34UxSt37Dx9N6+IAqH7lpAqMtnkCgY/R2hoeMWmPj0IfdB9Xo4g8XVikSCIwrEiszaMZH6KET
        /gYl5xyDxCTs9Elp1rNeR/2aZyNPpuXsCVvSgT3ZBg7Nh1DqxsO+2Yl33NM7HHyi35kBwtt4oBLxt
        LKyfdMJA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46254 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fVNVM-00AtGK-BP; Tue, 19 Jun 2018 20:45:32 +0000
Date:   Tue, 19 Jun 2018 13:45:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Make badr macro compatible with newer GAS versions
Message-ID: <20180619204531.GB28370@roeck-us.net>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
 <20180619203223.GA28370@roeck-us.net>
 <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:34:38PM +0200, Ard Biesheuvel wrote:
> On 19 June 2018 at 22:32, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
> >> Work around the mindless and backward incompatible change in GAS that
> >> prevents us from using a simple addition to set the Thumb bit in local
> >> symbol references taken using 'adr' instructions (#2)
> >>
> >> As a preparatory step, remove badr occurrences in ARM code sequences
> >> contained in Thumb2 kernels.
> >>
> >> Ard Biesheuvel (2):
> >>   ARM: avoid badr macro for switching to Thumb-2 mode
> >>   ARM: assembler: prevent ADR from setting the Thumb bit twice
> >>
> >
> > This doesn't work for images built with a toolchain based on gcc 7.3.0
> > and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
> > binutils 2.30.
> >
> 
> Sigh.
> 
> So does it fail? Or is the resulting binary broken?

Hard to say. It crashes early in boot, even before earlycon can say
anything.

Qemu exec trace, broken:

race 0: 0x7fffcf92c0c0 [00000000/00000008/0x11080001]
Trace 0: 0x7fffcf92c300 [00000000/21008000/0x11080001] stext
Trace 0: 0x7fffcf92c480 [00000000/210099ce/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c480 [210099ce] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c780 [210099ea] index 0 -> 0x7fffcf92c8c0 [210099dc]
Trace 0: 0x7fffcf92c8c0 [00000000/210099dc/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 0 -> 0x7fffcf92ca80 [210099f6]
Trace 0: 0x7fffcf92ca80 [00000000/210099f6/0x11080001] __lookup_processor_type
Trace 0: 0x7fffcf92cb80 [00000000/2100800c/0x11080001] stext
Linking TBs 0x7fffcf92cb80 [2100800c] index 1 -> 0x7fffcf92cc80 [21008014]
Trace 0: 0x7fffcf92cc80 [00000000/21008014/0x11080001] stext
Trace 0: 0x7fffcf92cdc0 [00000000/2120477e/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d400 [00000000/212047bc/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d500 [00000000/212047be/0x11280000] __v7m_setup
                                           ^^^^^^^^^^
Trace 0: 0x7fffcf92d600 [00000000/2100b830/0x11280001] __invalid_entry
Trace 0: 0x7fffcf92d880 [00000000/2100b842/0x11280001] __invalid_entry
Trace 0: 0x7fffcf92e100 [00000000/21025780/0x11280001] printk
Trace 0: 0x7fffcf92e640 [00000000/21025a7c/0x11280001] vprintk_func

Qemu exec trace, ok:

Trace 0: 0x7fffcf92c0c0 [00000000/00000008/0x11080001]
Trace 0: 0x7fffcf92c300 [00000000/21008000/0x11080001] stext
Trace 0: 0x7fffcf92c480 [00000000/210099ce/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c480 [210099ce] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c780 [210099ea] index 0 -> 0x7fffcf92c8c0 [210099dc]
Trace 0: 0x7fffcf92c8c0 [00000000/210099dc/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 1 -> 0x7fffcf92c780 [210099ea]
Trace 0: 0x7fffcf92c780 [00000000/210099ea/0x11080001] __lookup_processor_type
Linking TBs 0x7fffcf92c8c0 [210099dc] index 0 -> 0x7fffcf92ca80 [210099f6]
Trace 0: 0x7fffcf92ca80 [00000000/210099f6/0x11080001] __lookup_processor_type
Trace 0: 0x7fffcf92cb80 [00000000/2100800c/0x11080001] stext
Linking TBs 0x7fffcf92cb80 [2100800c] index 1 -> 0x7fffcf92cc80 [21008014]
Trace 0: 0x7fffcf92cc80 [00000000/21008014/0x11080001] stext
Trace 0: 0x7fffcf92cdc0 [00000000/2120477e/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d400 [00000000/212047bc/0x11080001] __v7m_setup
Trace 0: 0x7fffcf92d500 [00000000/212047be/0x11280001] __v7m_setup
Trace 0: 0x7fffcf92d600 [00000000/212047c0/0x11280001] __v7m_setup
Trace 0: 0x7fffcf92d900 [00000000/212047d2/0x11280001] __v7m_setup
Linking TBs 0x7fffcf92d900 [212047d2] index 1 -> 0x7fffcf92dcc0 [212047e0]
Trace 0: 0x7fffcf92dcc0 [00000000/212047e0/0x11280001] __v7m_setup
Trace 0: 0x7fffcf92e0c0 [00000000/21008020/0x11280001] stext
Trace 0: 0x7fffcf92e200 [00000000/210099c8/0x11280001] __after_proc_init

Guenter
