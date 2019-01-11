Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D91C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC7F2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aAqoAKQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfAKS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:29:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbfAKS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:29:55 -0500
Received: from zn.tnic (p200300EC2BCAC5004D300B3B2C1DD65E.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:4d30:b3b:2c1d:d65e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D89BA1EC00E5;
        Fri, 11 Jan 2019 19:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547231393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M4kvsJBoIpQblbxqqZvWsHsb608huFCWoMTQeIOVn8g=;
        b=aAqoAKQ5VjX+7suC22kWCNvEZ6OA0IGkxczLnh2nNbA4dHd6gSL2S1X0I9yezDTwPjh83s
        fFy5/9S6jXVoqZp7Qnsvumj4UpnbzBDU4TIGf9HbHLSnaZ/QLz3jr7gwHISUYWqJT+TX3I
        8uTyEkXekaochKwbfvh8t9uV+9dd/fI=
Date:   Fri, 11 Jan 2019 19:29:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Message-ID: <20190111182944.GA24304@zn.tnic>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
 <AM6PR0702MB37997C0FA1670DD1AF4C25C7FA8B0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <bba99e8c-5e3e-98a4-d0c9-9734216e66d2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bba99e8c-5e3e-98a4-d0c9-9734216e66d2@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 06:11:04PM +0000, James Morse wrote:
> After I sent this it occurred to me the core can't know about errors in the L3
> cache (if there is one) or the memory-controller. These may have edac/ras
> abilities, but they are selected by the soc integrator, so could be per soc.
> This goes against Boris's no-per-functional-unit edac drivers. If we had to pick
> one out of that set, I think the memory-controller is most useful as DRAM is the
> most likely to be affected by errors.

We have similar "designs" already :)

Memory controller driver drivers/edac/fsl_ddr_edac.c gets linked together with:

mpc85xx_edac_mod-y                      := fsl_ddr_edac.o mpc85xx_edac.o
obj-$(CONFIG_EDAC_MPC85XX)              += mpc85xx_edac_mod.o

layerscape_edac_mod-y                   := fsl_ddr_edac.o layerscape_edac.o
obj-$(CONFIG_EDAC_LAYERSCAPE)           += layerscape_edac_mod.o

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
