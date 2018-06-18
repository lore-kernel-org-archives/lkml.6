Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B18EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12076208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12076208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbeFRG6d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:58:33 -0400
Received: from muru.com ([72.249.23.125]:47618 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755055AbeFRG6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:58:31 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 90B4C8081;
        Mon, 18 Jun 2018 07:01:11 +0000 (UTC)
Date:   Sun, 17 Jun 2018 23:58:27 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Charge counter on droid 4
Message-ID: <20180618065827.GN112168@atomide.com>
References: <20180615080014.GA29192@amd>
 <20180615083156.GA32102@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180615083156.GA32102@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180615 08:34]:
> On Fri 2018-06-15 10:00:14, Pavel Machek wrote:
> > Hi!
> > 
> > Droid 4 has non-removable battery, yet the charge counter is reset to
> > near zero on each boot of linux.

Not sure if we actively do anything to reset it. I'm guessing
it's the Motorola bootloader that resets everything on boot.

> > Unfortunately, that makes charge counter pretty much useless on d4, as
> > the "battery full" and "battery empty" limits will be different during
> > each boot.

From what I've seen also the stock kernel starts only with
voltage based estimate initially after a reboot?

> Hmm, and could we refrain from providing "power" values?
> 
> I was thinking great, we have hardware that does proper power
> measuerement for us. No.... it is driver providing synthetic
> values. As userland has enough information to do that itself, I
> believe we should not do this in kernel.

Hmm I don't follow you, why would we want to remove these as
they implement a standard sysfs interface?

I use the sysfs interface all the time to monitor the power
consumption and the output seems to match what I was seeing
with my power supply.

Note that we also have the IIO raw data also available if that
might help.

Regards,

Tony
