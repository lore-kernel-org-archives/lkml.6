Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C357C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42B620866
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="KlUT9ZNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42B620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504385AbeKWXfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:35:40 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50407 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbeKWXfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:35:40 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 92FE125B75B;
        Fri, 23 Nov 2018 23:51:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1542977493; bh=1ucZT+m4auXenlmy2yvmZeNN0L4Rjc3FVpE5ueC1OBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlUT9ZNAhs3gww2czt5za0yFYGkwu06DCTwrQAVRR9KGmrnnoNvOGvJ+i8TLShmTm
         v5PXJhlFzGYNyvBNeMIeFC4L2RFHxEKK2PwJWuY0HhTQSDBje3j664ikz2Qh+3PW6j
         mA8FzwpxabnKCgm/l+Ch05eU5YV034s1psA8810o=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 2A36F9403E4; Fri, 23 Nov 2018 13:51:32 +0100 (CET)
Date:   Fri, 23 Nov 2018 13:51:32 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] ARM64: dts: renesas: Add all CPUs in cooling maps
Message-ID: <20181123125131.fxrslxz4wvphpe5o@verge.net.au>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <f2116377ab65e4b3ece39c32f54ac3eec2fb7d8c.1542362530.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2116377ab65e4b3ece39c32f54ac3eec2fb7d8c.1542362530.git.viresh.kumar@linaro.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 03:34:31PM +0530, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, applied for v4.21.
