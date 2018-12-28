Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220C9217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeL1XeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:34:22 -0500
Received: from muru.com ([72.249.23.125]:59714 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeL1XeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:34:21 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 237E280BF;
        Fri, 28 Dec 2018 23:34:25 +0000 (UTC)
Date:   Fri, 28 Dec 2018 15:34:17 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Johan Hovold <johan@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, omerlle@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181228233417.GD6707@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20181228204614.GA9431@amd>
 <20181228222805.GC6707@atomide.com>
 <20181228232536.GA7355@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228232536.GA7355@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [181228 23:25]:
> So this would be "text mode": AT+CMGF=1. And I'd actually expect
> auto-ack to be the default on ttyUSB4, but in any case this is the
> command that controls it is: AT+CNMI=1,2,2,1,0.

OK thanks. These are not available for /dev/motmdm* files AFAIK.

> So... 57h would be very nice, and even 25h is cool. IIRC original
> motorola firmware does something like 100hours, and cyanogenmod is
> closer to 24h...

Well I got things down to about 55mW during idle but that still needs
more work. So that would be in theory idle battery life of:

(1735mWh * 3.8V) / 55mW = 119.87h (4.99d)

> Note that there's something in the sysfs that allows "precise"
> measurements. Aha, it is "charge_counter" on droid4.
> 
> (I even have some software to do the monitoring and display the
> graphs. unicsy_demo/monitor/batmond).

Oh nice, I'll give that a try.

Regards,

Tony

