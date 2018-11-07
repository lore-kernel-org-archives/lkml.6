Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09798C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F2720883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F2720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeKHHfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:35:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbeKHHfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:35:33 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xE2SdQlviqk3; Wed,  7 Nov 2018 23:03:11 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 647BB1EC0291;
        Wed,  7 Nov 2018 23:03:11 +0100 (CET)
Date:   Wed, 7 Nov 2018 23:03:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, skx: Better fix for randconfig builds
Message-ID: <20181107220305.GI14169@zn.tnic>
References: <20181102153232.1450251-1-arnd@arndb.de>
 <20181102161013.GG14602@zn.tnic>
 <20181102173959.GA27709@agluck-desk>
 <20181102234255.GE26770@zn.tnic>
 <CAK8P3a2yE8FGvpN0P8hXnyCpS4h-ZOHeYhSCjE+Ov=7s1TB=5g@mail.gmail.com>
 <20181106143253.GH13712@zn.tnic>
 <20181106183914.GA26731@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106183914.GA26731@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:39:15AM -0800, Luck, Tony wrote:
> On Tue, Nov 06, 2018 at 03:32:53PM +0100, Borislav Petkov wrote:
> > On Tue, Nov 06, 2018 at 02:44:42PM +0100, Arnd Bergmann wrote:
> > > No, it was unintentional, the 'if ACPI' can be dropped when we add
> > > 'depends on ACPI'.
> > 
> > So I have one fix already which takes care of non-sensical configs. If
> > you or Tony wanna make it prettier, feel free to test it thoroughly and
> > send me a patch ontop of
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next
> > 
> 
> 
> It was previously noted that Kconfig complained about unmet
> dependencies when trying to configure skx_edac together with
> CONFIG_ACPI=n. First fix for this checked for ACPI when doing
> 
> 	select ACPI_ADXL
> 
> but this required stub functions for the case where ACPI wasn't
> selected. It also allowed building a driver that didn't actually
> work for a system that has non-volatile DIMMs.
> 
> Arnd Bergmann pointed out that the right fix is to make EDAC_SKX
> "depend on ACPI".
> 
> Fixes: a324e9396ca3 ("EDAC, skx: Fix randconfig builds")
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/Kconfig | 4 ++--
>  include/linux/adxl.h | 5 -----
>  2 files changed, 2 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
