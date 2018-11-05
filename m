Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E530C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD812081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD812081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeKEWkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:40:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbeKEWkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:40:06 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DHAWKaeZmGDH; Mon,  5 Nov 2018 14:20:21 +0100 (CET)
Received: from zn.tnic (p200300EC2BC6CF00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:cf00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 388201EC01A8;
        Mon,  5 Nov 2018 14:20:21 +0100 (CET)
Date:   Mon, 5 Nov 2018 14:20:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Manish Narani <manish.narani@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, amit.kucheria@linaro.org,
        sudeep.holla@arm.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
Message-ID: <20181105132007.GB7937@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:06:11PM +0100, Michal Simek wrote:
> I don't think that driver will be broken. You can build them, use them
> on out of tree HW. And when this patch is merged to mainline it will be
> enabled for xilinx soc.

But if the DT entries are missing, the driver won't load, would it?

> TBH I can't see any reason to do merges but if you want to do that way
> we can also do it.

The reason is because there's a separate DT tree and all those arm
drivers need DT.

I have already acked EDAC patches to go through other trees too, FWIW.
Which is not optimal either if someone sends fixes ontop but I cannot
apply them yet because the dependent patches are in a different tree.

So yes, there are at least two good reasons for merging a shared branch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
