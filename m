Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9EFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9F820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9F820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJZB7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:59:52 -0400
Received: from muru.com ([72.249.23.125]:52896 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbeJZB7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:59:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A52468027;
        Thu, 25 Oct 2018 17:26:07 +0000 (UTC)
Date:   Thu, 25 Oct 2018 10:26:01 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Regression: OOPs on boot due to "wlcore: Add support for
 optional wakeirq"
Message-ID: <20181025172601.GA31348@atomide.com>
References: <CALAqxLVOEVP2g6tPc1RF8mEgfffwWVHSuwrvv_a+oB2d0Jp8rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLVOEVP2g6tPc1RF8mEgfffwWVHSuwrvv_a+oB2d0Jp8rg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Stultz <john.stultz@linaro.org> [181025 17:04]:
> Hey Tony,
>   In testing linus/master on my hikey board, I'm hitting the following
> OOPS on bootup:
> 
> [    1.870279] Unable to handle kernel read from unreadable memory at
...
> [    1.870485]  wl1271_probe+0x210/0x350
> [    1.870491]  sdio_bus_probe+0x100/0x128
...
> I've bisected it down to 3c83dd577c7f ("wlcore: Add support for
> optional wakeirq").
> 
> It seems since we don't have a wakeirq value in the dts, the wakeirq
> value in wl1271_probe() is zero, which then causes trouble in
> irqd_get_trigger_type(irq_get_irq_data(wakeirq)).
> 
> Should we check wakeirq before we set the second elements of res[]?

Oh sorry about that, yeah I'll take a look and post a patch ASAP.
Hmm for me value 0 there causes no errors looks like.

Regards,

Tony
