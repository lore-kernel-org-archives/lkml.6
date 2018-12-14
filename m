Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62447206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbeLNRYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:24:03 -0500
Received: from muru.com ([72.249.23.125]:58430 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeLNRYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:24:03 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0C47C80B6;
        Fri, 14 Dec 2018 17:24:05 +0000 (UTC)
Date:   Fri, 14 Dec 2018 09:23:59 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] phy: ti: usb2: Fix logic on -EPROBE_DEFER
Message-ID: <20181214172359.GV6707@atomide.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
 <1544022206-2300-2-git-send-email-rogerq@ti.com>
 <5C137AE2.4080803@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C137AE2.4080803@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181214 09:42]:
> Kishon,
> 
> On 05/12/18 17:03, Roger Quadros wrote:
> > If clk_get() returns -EPROBE_DEFER then we should just
> > return instead of falling back to old clock name.
> > 
> > Use clk_prepare_enable() and clk_disable_unprepare() instead
> > of splitting up prepare/unprepare from enable/disable.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> I think you should pick this one for -next independently of the rest
> of the series as Tony's ti-sysc patches might cause this issue to trigger
> due to re-ordering of devices.

Yes good idea. FYI, the reason why we can start seeing deferred
probe happen for some new devices with the ti-sysc changes is
because we group the devices by the l4 interconnect and probe
the interconnect instances separately.

Regards,

TOny
