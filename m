Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17271C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68B1214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfBLMob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:44:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43241 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbfBLMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:44:28 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gtXQF-0006Xj-87; Tue, 12 Feb 2019 13:44:23 +0100
Message-ID: <1549975462.2546.30.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] soc: imx8: Add cpufreq registering and speed
 grading check for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 12 Feb 2019 13:44:22 +0100
In-Reply-To: <1549974071-8284-2-git-send-email-abel.vesa@nxp.com>
References: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
         <1549974071-8284-2-git-send-email-abel.vesa@nxp.com>
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

Hi Abel,

Am Dienstag, den 12.02.2019, 12:21 +0000 schrieb Abel Vesa:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Register cpu-freq platform driver for i.MX8.
> i.MX8MQ has different parts like consumer, industrial and auto etc.,
> different parts have different cpufreq set-points, this patch adds
> fuse check to select correct cpufreq set-points for each part. The
> default dtb has all set-points available, then kernel will check fuse
> to disable those unused set-points, definition as below:
> 
> OCOTP offset 0x440, bit [7:6]
> 
> '00' - Consumer 0C to 95C
> '01' - Ext. Consumer -20C to 105C
> '10' - Industrial -40C to 105C
> '11' - Automotive -40C to 125C

Shouldn't this read 0x440 [9:8] (SPEED_GRADING) instead? According to
the RM those 2 bits directly encode the maximum ARM core frequency, so
we don't need to guess from the target market.

Regards,
Lucas
