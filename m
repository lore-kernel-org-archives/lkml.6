Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A57C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C802175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6A0dNp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbfBMAN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:13:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfBMAN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CvJls/9WHq/uwdcCcc7/0++kAaQ3Tvmfv+2JesJGOp0=; b=C6A0dNp3ADgT55IKSzIAmX2/L
        o+7Uph0SMZRmVOav7QMIUPHLHEmp3jNeHrlnJZG+ecVd0IXzQkcp4na04WU0uueM0AW2cYs30NGOK
        LubZTVqRL07yeMIXiB4Lw2rQc1o9PH8+7B/yNlGwYlwO2Ao/bfGYJI0XgoPTjpxUPSTd3EW4Uk178
        EQ1BcQ18WHcRr5jcKleDVf6fjnwTuHyC9MXXfONwZ5HZfwTyRYGmIkAtQb3JbNZ69rINrPx4hWBsQ
        PUQCo7CxgJ34VQGaj/Q1aBDUX/YyXvFj9TQMFe1ihjfupN+36tH0b/MTij0MBbKZcKJmwLxNIhtas
        3t2rJodpQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtiBX-0004HW-Mw; Wed, 13 Feb 2019 00:13:56 +0000
Subject: Re: linux-next: Tree for Feb 12 (chrome/wilco_ec/)
To:     Nick Crews <ncrews@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>
References: <20190212175059.1ea4c16c@canb.auug.org.au>
 <94edf49b-6b37-2dac-a2db-ad454b105fd1@infradead.org>
 <CAHX4x87=Myx45wBYtFY=rwz8jVmYY-tYVQjnzod-V8HaWJSy+g@mail.gmail.com>
 <CAHX4x87nRpTR5880y6hc=r7k0OFV9YKate21U=2kkqC-ihdmCQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6913db72-85b3-0b7d-5e38-9cbb6ec4c8c2@infradead.org>
Date:   Tue, 12 Feb 2019 16:13:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAHX4x87nRpTR5880y6hc=r7k0OFV9YKate21U=2kkqC-ihdmCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 3:49 PM, Nick Crews wrote:
> OK, here is the patch to fix this problem. We had the dependency backwards.
> 
> Should I re-send out the entire patch series to the LKML with this fix in it?
> 
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 462eb9dfa4f2..b69561050868 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -95,7 +95,7 @@ config CROS_EC_LPC
>  
>  config CROS_EC_LPC_MEC
>         bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
> -       depends on CROS_EC_LPC || WILCO_EC
> +       depends on CROS_EC_LPC
>         default n
>         help
>           If you say Y here, a variant LPC protocol for the Microchip EC
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index d8e2cddb4712..6ea2d3f64ce5 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -1,6 +1,6 @@
>  config WILCO_EC
>         tristate "ChromeOS Wilco Embedded Controller"
> -       depends on ACPI && X86
> +       depends on ACPI && X86 && CROS_EC_LPC_MEC
>         select CROS_EC_LPC_MEC
>         help
>           If you say Y here, you get support for talking to the ChromeOS
> 
> 

Nick,

Did you test this?

When I apply the patch (by hand, since it was whitespace-mangled/damaged),
I get this:

rdunlap@midway:linux-next-20190212> make ARCH=x86_64 O=X64 oldconfig
make[1]: Entering directory '/home/rdunlap/lnx/next/linux-next-20190212/X64'
  GEN     Makefile
scripts/kconfig/conf  --oldconfig Kconfig
drivers/platform/chrome/Kconfig:84:error: recursive dependency detected!
drivers/platform/chrome/Kconfig:84:	symbol CROS_EC_LPC_MEC is selected by WILCO_EC
drivers/platform/chrome/wilco_ec/Kconfig:1:	symbol WILCO_EC depends on CROS_EC_LPC_MEC
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"




-- 
~Randy
