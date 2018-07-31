Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22EBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B986208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qE1onPXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B986208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeGaCqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:46:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbeGaCqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qbGs4h/GgGklAXQBai4VPsqaU5ZT/KchQuqvzxesQ2I=; b=qE1onPXb4N0gulcpheDsUwJlOU
        FJ8D9a3Z++u2vahBkSlXLwM4unIqsEkjXjlmGle61yKz/S8dUT2QJo2QS5cMLikF0D+tAcoFmg3nE
        T5Zs7GxawrXzDWu4vzUlmw7sXdh1YjyA+wvXOOviTk/oYz1A8oQtZlLlmXbdTSQf8b5ocaBhTeRBd
        iRR08xBdP9YAfD+yBNlf12vLQ8/Flso4olRQqharMXAHq9su+r+9Bw8gRxPwsrdmn7FJZaPiTRI13
        BGHLsYqIUm50vfM4fLbEc8btN5BbaJe96l2WDYbEZ7j7NLO4nt0wRl+wq+PwbECRyWU7xoU00HlYE
        ++EN6CAg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkJ9b-0002OT-5u; Tue, 31 Jul 2018 01:08:47 +0000
Subject: Re: [PATCH 0/6] rapidio: move Kconfig menu definition to subsystem
To:     Alexei Colin <acolin@isi.edu>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Matt Porter <mporter@kernel.crashing.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180730225035.28365-1-acolin@isi.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <db90c65d-b6da-1f57-43c6-e105fc6f1704@infradead.org>
Date:   Mon, 30 Jul 2018 18:08:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 03:50 PM, Alexei Colin wrote:
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfig files. This set of
> patches does two things:
> 
> 1. Move the Kconfig menu definition into the RapidIO subsystem and
> remove the duplicate definitions from arch Kconfig files.
> 
> 2. Enable RapidIO Kconfig menu entry for arm and arm64 architectures,
> where it was not enabled before. I tested that subsystem and drivers
> build successfully for both architectures, and tested that the modules
> load on a custom arm64 Qemu model.
> 
> For all architectures, RapidIO menu should be offered when either:
> (1) The platform has a PCI bus (which host a RapidIO module on the bus).
> (2) The platform has a RapidIO IP block (connected to a system bus, e.g.
> AXI on ARM). In this case, 'select HAS_RAPIDIO' should be added to the
> 'config ARCH_*' menu entry for the SoCs that offer the IP block.
> 
> Prior to this patchset, different architectures used different criteria:
> * powerpc: (1) and (2)
> * mips: (1) and (2) after recent commit into next that added (2):
>   https://www.linux-mips.org/archives/linux-mips/2018-07/msg00596.html
>   fc5d988878942e9b42a4de5204bdd452f3f1ce47
>   491ec1553e0075f345fbe476a93775eabcbc40b6
> * x86: (1)
> * arm,arm64: none (RapidIO menus never offered)
> 
> Responses to feedback from prior submission (thanks for the reviews!):
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593347.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593349.html
> 
> Changelog:
>   * Moved Kconfig entry into RapidIO subsystem instead of duplicating
> 
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.
> 
> We appreciate the suggestion for also selecting the RapdiIO subsystem for
> compilation with COMPILE_TEST, but hope to address it in a separate
> patchset, localized to the subsystem, since it will need to change
> depends on all drivers, not just on the top level, and since this
> patch now spans multiple architectures.
> 
> 
> Alexei Colin (6):
>   rapidio: define top Kconfig menu in driver subtree
>   x86: factor out RapidIO Kconfig menu
>   powerpc: factor out RapidIO Kconfig menu entry
>   mips: factor out RapidIO Kconfig entry
>   arm: enable RapidIO menu in Kconfig
>   arm64: enable RapidIO menu in Kconfig
> 
>  arch/arm/Kconfig        |  2 ++
>  arch/arm64/Kconfig      |  2 ++
>  arch/mips/Kconfig       | 11 -----------
>  arch/powerpc/Kconfig    | 13 +------------
>  arch/x86/Kconfig        |  8 --------
>  drivers/rapidio/Kconfig | 15 +++++++++++++++
>  6 files changed, 20 insertions(+), 31 deletions(-)
> 

LGTM.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # for the series

thanks,
-- 
~Randy
