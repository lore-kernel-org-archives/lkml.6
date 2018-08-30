Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C6B2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kMaSbAaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C6B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeH3SUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:20:24 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40102 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbeH3SUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:20:24 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8788425B755;
        Fri, 31 Aug 2018 00:18:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1535638681; bh=C9N2gVrDgmkdbwxjtGXdw3Ev8fSs0j4JJG3bexWmILQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMaSbAaLfOY1LaTIqV1MgYoVv0NY3xl6Y6FrhaVksYWklcs+TmvONgqkaqJfc0ddq
         c6NAUsJIOdfpKQcPc++dcT+j1J/r9ngemg8txihO3OA4c8D22beLBCk92Fj5MygVVm
         KOOdMiz/6zwVtZZY60071woaBI+8XQJV7wXwjtAk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 806499403D6; Thu, 30 Aug 2018 16:17:59 +0200 (CEST)
Date:   Thu, 30 Aug 2018 16:17:59 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig
 symbol
Message-ID: <20180830141758.2eo2fijrdn2pbovy@verge.net.au>
References: <20180828151011.14065-1-geert+renesas@glider.be>
 <20180828151011.14065-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828151011.14065-3-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:10:11PM +0200, Geert Uytterhoeven wrote:
> The Kconfig symbol for Renesas 64-bit ARM SoCs has always been
> ARCH_RENESAS, with ARCH_SHMOBILE being selected to reuse drivers shared
> with Renesas 32-bit ARM and/or Renesas SuperH SH-Mobile SoCs.
> 
> Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
> 32-bit SoCs.  Now all drivers for Renesas ARM SoCs have gained proper
> ARCH_RENESAS platform dependencies, there is no longer a need to select
> ARCH_SHMOBILE.
> 
> With ARCH_SHMOBILE gone, move the ARCH_RENESAS section up, to restore
> alphabetical sort order.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Geert, applied for v4.20.
