Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17827ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDF42083D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDF42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeGQJLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:11:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54206 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:11:44 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ffLWm-0002rj-J9; Tue, 17 Jul 2018 10:40:12 +0200
Date:   Tue, 17 Jul 2018 10:40:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
cc:     john.stultz@linaro.org, sboyd@kernel.org, arnd@arndb.de,
        broonie@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] time: Introduce one suspend clocksource to compensate
 the suspend time
In-Reply-To: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.21.1807171039220.1740@nanos.tec.linutronix.de>
References: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Baolin Wang wrote:
> On some hardware with multiple clocksources, we have coarse grained
> clocksources that support the CLOCK_SOURCE_SUSPEND_NONSTOP flag, but
> which are less than ideal for timekeeping whereas other clocksources
> can be better candidates but halt on suspend.
> 
> Currently, the timekeeping core only supports timing suspend using
> CLOCK_SOURCE_SUSPEND_NONSTOP clocksources if that clocksource is the
> current clocksource for timekeeping.
> 
> As a result, some architectures try to implement read_persistent_clock64()
> using those non-stop clocksources, but isn't really ideal, which will
> introduce more duplicate code. To fix this, provide logic to allow a
> registered SUSPEND_NONSTOP clocksource, which isn't the current
> clocksource, to be used to calculate the suspend time.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Well done!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
