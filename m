Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5709CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0744320685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0744320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeKFFIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:08:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeKFFIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:08:39 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lWL8hVrHuikP; Mon,  5 Nov 2018 20:47:22 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD5300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:5300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62A961EC01F6;
        Mon,  5 Nov 2018 20:47:22 +0100 (CET)
Date:   Mon, 5 Nov 2018 20:47:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Olof Johansson <olof@lixom.net>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, manish.narani@xilinx.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
Message-ID: <20181105194721.GB26868@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
 <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Mon, Nov 05, 2018 at 06:51:26AM -0800, Olof Johansson wrote:
> In general, for new functionality where needing both the driver change
> and a DT change to enable it (or a driver change and a config change
> to enable it), we have been merging the changes separately between
> driver trees and arm-soc. I.e. things will be in place, but not
> enabled, until both sides land. Main reason for doing so is to cut
> down on arbitrary dependencies between the trees, since there can
> sometimes end up being a lot of them.

Well, makes sense too and it is the least problematic approach. :-)

> Since DT should strive for being backwards compatible (i.e, a driver
> change shouldn't require a DT change for the kernel to not regress
> functionally), this has been working pretty well.

Ok.

> However, if there's some other reason to share a base between the two
> trees, we can do that. For most cases we've found that it's not needed
> though. So let us know what you prefer here.

No, I just wanted to make sure drivers can still function when they go
to linux-next. But I certainly can get on board with keeping drivers and
DT changes separate as it requires no sync and the short period of time
when they don't load in linux-next, is perfectly ok.

So can I assume you guys are going to pick up:

https://lkml.kernel.org/r/1538667328-9465-7-git-send-email-manish.narani@xilinx.com
https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani@xilinx.com

?

I can then pick up the rest.

And I'll be ignoring DT stuff sent to me from now on and concentrate on
the EDAC drivers, assuming former will go through your tree.

Sounds good?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
