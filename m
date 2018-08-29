Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1A0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD32087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAD32087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeH2EYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:24:38 -0400
Received: from baldur.buserror.net ([165.227.176.147]:38984 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2EYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:24:37 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2018 00:24:37 EDT
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fuoLB-00073O-3U; Tue, 28 Aug 2018 19:28:09 -0500
Message-ID: <1dd3074eabb496155c4d1abb83c82c52529a656a.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Rob Herring <robh+dt@kernel.org>, vabhav.sharma@nxp.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel-owner@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sriram Dash <sriram.dash@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Udit Kumar <udit.kumar@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>, V.Sethi@nxp.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Tue, 28 Aug 2018 19:28:06 -0500
In-Reply-To: <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
         <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
         <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: robh+dt@kernel.org, vabhav.sharma@nxp.com, mark.rutland@arm.com, kstewart@linuxfoundation.org, linux-kernel-owner@vger.kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com, will.deacon@arm.com, yamada.masahiro@socionext.com, sriram.dash@nxp.com, linux-clk@vger.kernel.org, udit.kumar@nxp.com, linux@armlinux.org.uk, catalin.marinas@arm.com, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, V.Sethi@nxp.com, linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, priyanka.jain@nxp.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 15:45 -0500, Rob Herring wrote:
> On Mon, Aug 20, 2018 at 1:52 PM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
> > +/ {
> > +       model = "NXP Layerscape LX2160ARDB";
> > +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> > +
> > +       aliases {
> > +               crypto = &crypto;
> 
> Drop this. Aliases should be numbered, and this is not a standard
> alias name either.

Is this a new rule?  In any case, U-Boot looks for a "crypto" alias.

-Scott

