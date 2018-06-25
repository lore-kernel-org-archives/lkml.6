Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FBBC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD26256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD26256E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754834AbeFYQTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:19:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeFYQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:19:32 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXUCW-0003Nr-8I; Mon, 25 Jun 2018 18:18:48 +0200
Date:   Mon, 25 Jun 2018 18:18:47 +0200 (CEST)
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
Subject: Re: [PATCH 1/8] time: Add persistent clock support
In-Reply-To: <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806251815320.1821@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org> <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org> <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> The clocksource core already has all the registration/unregistration
> functionality plus an interface to reconfigure the frequency, so
> clocksources can come and go and be reconfigured and all of this just
> works.

Just for completeness sake.

If this extra suspend clocksource is not needed, i.e. because the system is
not suspended, then it does not need to be enabled. clocksources already
have an enable/disable callback exactly for that purpose. So instead of
having the clocks running during normal system operation the thing can be
OFF and save power and only be switched to ON when it is actually needed,
i.e. when going into suspend.

Thanks,

	tglx
