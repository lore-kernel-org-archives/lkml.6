Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360A3218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfAaN5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:57:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44516 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfAaN5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:57:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8B1BA78;
        Thu, 31 Jan 2019 05:57:47 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EAAA3F589;
        Thu, 31 Jan 2019 05:57:46 -0800 (PST)
Date:   Thu, 31 Jan 2019 13:57:44 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peng Donglin <dolinux.peng@gmail.com>
Subject: Re: [PATCH 1/4] arm64: dump: no need to check return value of
 debugfs_create functions
Message-ID: <20190131135744.GB21965@fuggles.cambridge.arm.com>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-2-gregkh@linuxfoundation.org>
 <20190130182102.GK18558@fuggles.cambridge.arm.com>
 <20190130193348.GC20667@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130193348.GC20667@kroah.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:33:48PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 30, 2019 at 06:21:02PM +0000, Will Deacon wrote:
> > Hi Greg,
> > 
> > On Tue, Jan 22, 2019 at 03:41:11PM +0100, Greg Kroah-Hartman wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > > 
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Peng Donglin <dolinux.peng@gmail.com>
> > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  arch/arm64/include/asm/ptdump.h | 9 +++------
> > >  arch/arm64/mm/dump.c            | 4 ++--
> > >  arch/arm64/mm/ptdump_debugfs.c  | 7 ++-----
> > >  3 files changed, 7 insertions(+), 13 deletions(-)
> > 
> > Are you taking this via your tree, or would you like us to queue it in
> > arm64?
> 
> What ever is easiest for you is fine with me, I can handle it either
> way, just let me know.

It's easy enough for us to merge the arm64 bits, so we'll pick that up for
5.1.

Cheers,

Will
