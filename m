Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2632087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfA2RSx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:18:53 -0500
Received: from muru.com ([72.249.23.125]:36644 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfA2RSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:18:50 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D6600804F;
        Tue, 29 Jan 2019 17:18:57 +0000 (UTC)
Date:   Tue, 29 Jan 2019 09:18:46 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171846.GD5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
 <20190129171151.GC5720@atomide.com>
 <20190129171538.GH10524@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190129171538.GH10524@sirena.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [190129 17:15]:
> On Tue, Jan 29, 2019 at 09:11:51AM -0800, Tony Lindgren wrote:
> 
> > OK. Let's see if Sebastian spots where pwm_vibrator_start()
> > and pwm_vibrator_stop() might get called multiple times
> > or something similar.
> 
> Given that nobody has noticed that the driver stops working entirely
> it's possible that the pattern is something like:
> 
> 
>     pwm_vibrator_start()
>     pwm_vibrator_stop()
>     pwm_vibrator_stop()
>     pwm_vibrator_start()
> 
> so it's a temporary underflow that gets corrected (or it could be that
> not many people are using mainline kernels on these systems).  On your
> system it's the dummy driver but presumably some other users have it
> connected to actual regulators.

Yeah that makes sense.

Regards,

Tony
