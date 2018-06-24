Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C63C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CB824D63
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CB824D63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeFXAWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 20:22:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44090 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeFXAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 20:22:07 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWsm9-0000Sb-K3; Sun, 24 Jun 2018 02:21:05 +0200
Date:   Sun, 24 Jun 2018 02:21:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
cc:     john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de,
        tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk,
        mark.rutland@arm.com, marc.zyngier@arm.com, broonie@kernel.org,
        paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
        rdunlap@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
        linus.walleij@linaro.org, viresh.kumar@linaro.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, len.brown@intel.com,
        rajvi.jingar@intel.com, alexandre.belloni@bootlin.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 3/8] arm: time: Remove the persistent clock support for
 ARM architecture
In-Reply-To: <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.21.1806240215310.8650@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org> <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Baolin Wang wrote:

> We have introduced the persistent clock framework to support the OS time
> compensating from persistent clock, and we will convert all drivers to
> use common persistent clock framework instead of the persistent clock
> support used only for the ARM architecture. So we can remove these code
> with converting the Omap 32k counter and tegra20 timer.

Why did I look at that in the first place? But as I did, I just have to
say, it's just consistent trainwreck engineering. Remove working code first
and then add new one.

Hell NO! This is not how it works. We add new infrastructure - if required
with some extra temporary helpers - while keeping the existing
functionality intact. Then we convert the users of the old infrastructure
over and when the last user is gone, we remove that including all temporary
helpers.

That's not something fundamentally new. It's documented all over the place.

Thanks,

	tglx
