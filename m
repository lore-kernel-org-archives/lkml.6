Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E6AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7052133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbeLQPw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:52:58 -0500
Received: from foss.arm.com ([217.140.101.70]:59174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732831AbeLQPw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:52:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A53A78;
        Mon, 17 Dec 2018 07:52:57 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC7E13F575;
        Mon, 17 Dec 2018 07:52:55 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:52:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sinan Kaya <okaya@kernel.org>, linux-acpi@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 5/6] arm64: select ACPI PCI code only both features
 are enabled
Message-ID: <20181217155252.5ix7m4vz2zeok4xf@mbp>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-6-okaya@kernel.org>
 <2376424.2qzz6yc3ay@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2376424.2qzz6yc3ay@aspire.rjw.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:04:42AM +0100, Rafael J. Wysocki wrote:
> On Saturday, December 15, 2018 2:02:46 AM CET Sinan Kaya wrote:
> > ACPI and PCI are no longer coupled to each other. Specify requirements
> > for both when pulling in code.
> > 
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  arch/arm64/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index ea2ab0330e3a..bcb6262044d8 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -5,7 +5,7 @@ config ARM64
> >  	select ACPI_GTDT if ACPI
> >  	select ACPI_IORT if ACPI
> >  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > -	select ACPI_MCFG if ACPI
> > +	select ACPI_MCFG if (ACPI && PCI)
> >  	select ACPI_SPCR_TABLE if ACPI
> >  	select ACPI_PPTT if ACPI
> >  	select ARCH_CLOCKSOURCE_DATA
> > @@ -163,7 +163,7 @@ config ARM64
> >  	select OF
> >  	select OF_EARLY_FLATTREE
> >  	select OF_RESERVED_MEM
> > -	select PCI_ECAM if ACPI
> > +	select PCI_ECAM if (ACPI && PCI)
> >  	select POWER_RESET
> >  	select POWER_SUPPLY
> >  	select REFCOUNT_FULL
> > 
> 
> I need a maintainer ACK here.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
