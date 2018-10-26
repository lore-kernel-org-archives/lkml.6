Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F245ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471E42082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471E42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJ0APX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:15:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45815 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJ0APX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:15:23 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gG4B8-0006VN-8S; Fri, 26 Oct 2018 17:37:38 +0200
Message-ID: <1540568255.2245.11.camel@pengutronix.de>
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Oct 2018 17:37:35 +0200
In-Reply-To: <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
         <20181021205501.23943-2-digetx@gmail.com>
         <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
         <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
         <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
         <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
         <20181024064123.lbpbeervghp35fe7@vireshk-i7>
         <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 26.10.2018, 15:03 +0300 schrieb Dmitry Osipenko:
[...]
> > On the other hand, the tegra20 cpufreq driver is common across a lot of boards.
> > What will happen if the DT for some of the boards isn't correct and missed the
> > necessary regulator node ?
> 
> AFAIK, there is assumption that bootloader should setup regulators in
> a way that kernel could work properly at max clock rates. Otherwise
> things won't work.

This isn't true. The assumption is that the bootloader sets up the
regulators such that stable operation at the CPU speed used by the
bootloader is guaranteed.

Often the bootloader doesn't know about specific SKUs, so drives things
at a rate/voltage that is safe across all SKUs [1], in which case the
bootloader is totally unaware of the voltage needed to run the CPU at
highest possible clock frequency.

Regards,
Lucas

[1] http://git.denx.de/?p=u-boot.git;a=commit;h=2364e151e432b4ccf32dc9e6147121253d4ff86d
