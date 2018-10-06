Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE1C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B769C21486
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B769C21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJGAL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:11:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJGAL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:11:26 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8q2v-0007jI-BW; Sat, 06 Oct 2018 19:07:17 +0200
Date:   Sat, 6 Oct 2018 19:07:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 13/13] clocksource/drivers/dw_apb: Add reset control
In-Reply-To: <5ebc1d90-2067-8cb5-0c93-1c9f0677abc5@linaro.org>
Message-ID: <alpine.DEB.2.21.1810061907030.5454@nanos.tec.linutronix.de>
References: <20181005143253.GE1881@mai> <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org> <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.21.1810061433170.5454@nanos.tec.linutronix.de>
 <5ebc1d90-2067-8cb5-0c93-1c9f0677abc5@linaro.org>
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

On Sat, 6 Oct 2018, Daniel Lezcano wrote:

> On 06/10/2018 14:34, Thomas Gleixner wrote:
> > On Fri, 5 Oct 2018, Daniel Lezcano wrote:
> > 
> >> From: Dinh Nguyen <dinguyen@kernel.org>
> >>
> >> Add code to retrieve the reset property from the dw-apb timers and if
> >> the property is available, the safe operation is to assert the timer
> >> into reset, and followed by a deassert of the timer reset (brings the
> >> timer out of reset).
> >>
> >> This patch is needed for systems where the bootloader has left the timer
> >> not used in reset.
> >>
> >>  - Trivial conflict with commit a74bd1ad7a:
> >>     "Convert to using %pOFn instead of device_node.name"
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> > 
> > Ingo just noticed, that this SOB chain is wrong. How is Marek involved
> > here? Can you please fix that up and send me another pull request?
> 
> Thomas,
> 
> I will fix it as soon as possible but I would like to give the
> opportunity to Dinh to explain why he sent the patch with Marek's SOB.
> 
> Dinh ?

No rush.
