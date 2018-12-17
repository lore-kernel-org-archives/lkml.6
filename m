Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38010C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7A620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbeLQKFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:05:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43856 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeLQKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:05:09 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id dbdcdb4cfb7b4916; Mon, 17 Dec 2018 11:05:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 5/6] arm64: select ACPI PCI code only both features are enabled
Date:   Mon, 17 Dec 2018 11:04:42 +0100
Message-ID: <2376424.2qzz6yc3ay@aspire.rjw.lan>
In-Reply-To: <20181215010247.26101-6-okaya@kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org> <20181215010247.26101-6-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 15, 2018 2:02:46 AM CET Sinan Kaya wrote:
> ACPI and PCI are no longer coupled to each other. Specify requirements
> for both when pulling in code.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  arch/arm64/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ea2ab0330e3a..bcb6262044d8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -5,7 +5,7 @@ config ARM64
>  	select ACPI_GTDT if ACPI
>  	select ACPI_IORT if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> -	select ACPI_MCFG if ACPI
> +	select ACPI_MCFG if (ACPI && PCI)
>  	select ACPI_SPCR_TABLE if ACPI
>  	select ACPI_PPTT if ACPI
>  	select ARCH_CLOCKSOURCE_DATA
> @@ -163,7 +163,7 @@ config ARM64
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_RESERVED_MEM
> -	select PCI_ECAM if ACPI
> +	select PCI_ECAM if (ACPI && PCI)
>  	select POWER_RESET
>  	select POWER_SUPPLY
>  	select REFCOUNT_FULL
> 

I need a maintainer ACK here.


