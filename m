Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8376EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489222086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489222086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbeKFT2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:28:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38396 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387505AbeKFT2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:28:06 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HNLWVHdkT9cl; Tue,  6 Nov 2018 11:03:37 +0100 (CET)
Received: from zn.tnic (p200300EC2BD1C800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:c800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C53591EC032D;
        Tue,  6 Nov 2018 11:03:36 +0100 (CET)
Date:   Tue, 6 Nov 2018 11:03:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        mchehab@kernel.org, amit.kucheria@linaro.org, sudeep.holla@arm.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
Message-ID: <20181106100329.GC13712@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:36:55AM +0530, Manish Narani wrote:
> Change in v10:
> 	- Moved the checking for ce_cnt and ue_cnt before the readl() call
> 	- Aligned arguments on the opening brace in setup_irq()
> 
> Manish Narani (6):
>   edac: synopsys: Add error handling for NULL in probe()
>   dt: bindings: Document ZynqMP DDRC in Synopsys documentation
>   edac: synopsys: Add macro defines for ZynqMP DDRC
>   edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
>   arm64: zynqmp: Add DDRC node
>   edac: synopsys: Add Error Injection support for ZynqMP DDRC
> 
>  .../bindings/memory-controllers/synopsys.txt       |  27 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
>  drivers/edac/Kconfig                               |   2 +-
>  drivers/edac/synopsys_edac.c                       | 911 ++++++++++++++++++++-
>  4 files changed, 918 insertions(+), 29 deletions(-)

Ok, patches pushed here:

(minus https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani@xilinx.com)

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-for-4.21-synps

Please run this on the hw before I queue it for linux-next.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
