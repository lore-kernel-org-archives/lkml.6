Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C817721477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C817721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeHXVoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:44:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35830 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeHXVoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:44:16 -0400
Received: from p57b77786.dip0.t-ipconnect.de ([87.183.119.134] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ftGVS-0004z9-T2; Fri, 24 Aug 2018 20:08:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Olof Johansson <olof@lixom.net>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
Subject: Re: [PATCH v2 0/4] iommu/rockchip: Runtime PM fixes
Date:   Fri, 24 Aug 2018 20:08:22 +0200
Message-ID: <13492452.cxnNOAAFxb@phil>
In-Reply-To: <20180824155059.qskwdxmc6ws3hwtv@localhost>
References: <20180824150637.15316-1-marc.zyngier@arm.com> <20180824155059.qskwdxmc6ws3hwtv@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. August 2018, 17:50:59 CEST schrieb Olof Johansson:
> On Fri, Aug 24, 2018 at 04:06:33PM +0100, Marc Zyngier wrote:
> > This small series addresses a couple of runtime PM issues I've spotted
> > while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
> > specifically doing kexec.
> > 
> > In order to avoid making a complete mess of the IOMMU code, Heiko has
> > requested that all RK platforms would select CONFIG_PM, which
> > simplifies a lot of things. I've kept 32 and 64bit patches separate,
> > but feel free to squash them into on if that's more convenient.
> > 
> > Note that even with these patches, kexec is still fairly broken on
> > rk3399, as the VOP is never turned off (see [1] for a fix).
> > 
> > [1] https://www.spinics.net/lists/arm-kernel/msg670229.html
> > 
> > * From v1:
> >   - Collected RBs from Heiko
> >   - Added two patches forcing CONFIG_PM on all Rockchip platforms at
> >     Heiko's request, following the example set by Tegra platforms.
> 
> Thanks, applied to our next/late branch which I plan to send in tomorrow.

that was a quick turn around :-) .
Thanks for picking the series.

Heiko


