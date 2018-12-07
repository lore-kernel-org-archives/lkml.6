Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C7C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4CE2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4CE2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLGQxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:53:40 -0500
Received: from muru.com ([72.249.23.125]:56734 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLGQxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:53:40 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8753980C0;
        Fri,  7 Dec 2018 16:53:42 +0000 (UTC)
Date:   Fri, 7 Dec 2018 08:53:36 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix audio permanently muted
Message-ID: <20181207165336.GP6707@atomide.com>
References: <20181123111945.6016-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123111945.6016-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [181123 03:18]:
> Since commit 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused
> GPIOs"), on-board audio has appeared muted.  Believed to be unused GPIO
> pin "hookflash1", apparently set high regardless of the corresponding
> bit of "latch2" port attempted to be set low during .init_machine(),
> has been identified as the reason.
> 
> According to Amstrad E3 wiki, the purpose of the pin hasn't been
> clearly identified.  Original Amstrad software used to produce a high
> pulse on it when the phone was taken off hook or recall was pressed.
> With the current finding, we can assume the pin provides a kind of
> audio mute function.
> 
> Proper resolution of the issue should be done in two steps:
> - resolution of an issue with the pin state not reflecting the value
>   the corresponding bit of the port was attempted to be initialized
>   with,
> - extension of on-board audio driver with a new control.
> 
> For now, rename the pin to "audio_mute" to reflect its function and,
> as a quick fix, hogg it as output low so on-board audio can produce
> audible sound again.
> 
> Fixes: 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused GPIOs")
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Adding into omap-for-v4.20/fixes thanks.

Tony
