Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9B1C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB23A2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB23A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJFThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:37:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeJFThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:37:54 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8lnB-00016a-Eo; Sat, 06 Oct 2018 14:34:45 +0200
Date:   Sat, 6 Oct 2018 14:34:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 13/13] clocksource/drivers/dw_apb: Add reset control
In-Reply-To: <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <alpine.DEB.2.21.1810061433170.5454@nanos.tec.linutronix.de>
References: <20181005143253.GE1881@mai> <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org> <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org>
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

On Fri, 5 Oct 2018, Daniel Lezcano wrote:

> From: Dinh Nguyen <dinguyen@kernel.org>
> 
> Add code to retrieve the reset property from the dw-apb timers and if
> the property is available, the safe operation is to assert the timer
> into reset, and followed by a deassert of the timer reset (brings the
> timer out of reset).
> 
> This patch is needed for systems where the bootloader has left the timer
> not used in reset.
> 
>  - Trivial conflict with commit a74bd1ad7a:
>     "Convert to using %pOFn instead of device_node.name"
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Ingo just noticed, that this SOB chain is wrong. How is Marek involved
here? Can you please fix that up and send me another pull request?

Thanks,

	tglx


