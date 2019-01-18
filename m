Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB28AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856652086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="a2pmFH2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfARO2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:28:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfARO2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:28:39 -0500
Received: from zn.tnic (p200300EC2BCB1B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C69761EC0573;
        Fri, 18 Jan 2019 15:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547821717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gbHNbKy+Xhm8EHzQUm+KhOvq1C3SEcIFrwN7KVnE3ck=;
        b=a2pmFH2c3OjQOEYgn1JYHJVyPQB6XpnE8P1QtoMAmHEp+Mc9yr/dKt5MW4WCSmmUZg1D2u
        trLHdxQ1UYKMgxhYqZ8BeIPCB+Y9V7wfurI4O+j1ffWv7+GEd9yNHNeLZfkVGj1HAC1Iyi
        oPSadCexi6CUmL8yFep/dCfUoMTvfpg=
Date:   Fri, 18 Jan 2019 15:28:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Stefan Schaeckeler <schaecsn@gmx.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: Re: [PATCH v2 0/2] Add support for the Aspeed AST2500 SoC EDAC driver
Message-ID: <20190118142831.GD622@zn.tnic>
References: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 08:38:15AM -0800, Stefan Schaeckeler wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for the Aspeed AST2500 SoC EDAC driver.
> 
> Changes since v1:
> - Addressed all cosmetic issues
> - Fixed (un-)recoverable address calculation in reg58 and reg5c
> - Removed status field from the example device tree binding
> - Added little more text to Kconfig
> 
> 
> Stefan M Schaeckeler (2):
>   EDAC: Add Aspeed AST2500 EDAC driver
>   dt-bindings: edac: Aspeed AST2500
> 
>  .../bindings/edac/aspeed-sdram-edac.txt       |  25 ++
>  MAINTAINERS                                   |   6 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |   7 +
>  drivers/edac/Kconfig                          |   8 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/aspeed_edac.c                    | 421 ++++++++++++++++++
>  6 files changed, 468 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
>  create mode 100644 drivers/edac/aspeed_edac.c
> 
> -- 

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
