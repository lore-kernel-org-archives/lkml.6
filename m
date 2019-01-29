Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967EAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711A920989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfA2R1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:27:10 -0500
Received: from muru.com ([72.249.23.125]:36656 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfA2R1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:27:10 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 29F31804F;
        Tue, 29 Jan 2019 17:27:18 +0000 (UTC)
Date:   Tue, 29 Jan 2019 09:27:06 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129172706.GE5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <20190129171844.n6wflw4ehfdy3izs@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129171844.n6wflw4ehfdy3izs@earth.universe>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [190129 17:18]:
> Hi,
> 
> On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:
> > Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> > enabled consumers") started showing new warnings with v5.0-rc cycle:
> > 
> > regulator-dummy: Underflow of regulator enable count
> > 
> > I'm seeing this at least with my pwm-vibra test case:
> > 
> > # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> > pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
> > input: pwm-vibrator as /devices/platform/vibrator/input/input4
> > regulator-dummy: Underflow of regulator enable count
> > Upload rumble effect... id=0
> > regulator-dummy: Underflow of regulator enable count
> > 
> > Are these bogus warnings for dummy regulator or do we have
> > real unpaired regulator calls or somewhere?
> 
> There are real unpaired regulator calls in the pwm-vibrator driver,
> that I did not notice when I wrote the driver :(. Good news is, that
> Paweł Chmiel and Jonathan Bakker are already working on fixing my mess:
> 
> https://lore.kernel.org/patchwork/patch/1032759/

OK good to hear.

> On Droid 4 it's a dummy regulator, since I did not know what
> regulator is being used to supply the vibrator. Probably directly
> from the battery.

Yeah no idea.. Hmm maybe it's actually using the VVIB on the pmic?

Regards,

Tony

