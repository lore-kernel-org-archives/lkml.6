Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD62C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A408D2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A408D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeK0M12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:27:28 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:3375 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0M12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:27:28 -0500
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 3BA5560B67;
        Tue, 27 Nov 2018 01:31:21 +0000 (UTC)
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 2CEAF59;
        Tue, 27 Nov 2018 01:31:19 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id EA62C49;
        Tue, 27 Nov 2018 01:31:17 +0000 (UTC)
Date:   Mon, 26 Nov 2018 18:31:17 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Tao Ren <taoren@fb.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Message-ID: <20181127013117.GB11080@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20181115234413.27009-1-taoren@fb.com>
 <20181116001938.GA16009@roeck-us.net>
 <9a43bb84-f476-d6c8-886a-2120312ee8e7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a43bb84-f476-d6c8-886a-2120312ee8e7@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:37:28AM +0000, Tao Ren wrote:
> On 11/15/18 4:19 PM, Guenter Roeck wrote:
> > NACK. This message is displayed if/when the watchdog application
> > exits without stopping the watchdog and/or without closing properly.
> > This _is_ critical since it will reboot the system after the next
> > timeout period.
> > 
> > If userspace triggers this message on purpose (eg by the mentioned
> > script, which does not exit properly), userspace is at fault,
> > not the kernel.
> > 
> > Guenter
> 
> Thank you for the quick response, Guenter. I see the log each time when I reboot my system, and when I searched the message in google, I also found posts asking why the message is printed at reboot, and that's why I feel it's confusing.
> 
> Anyways, please ignore the patch since it's necessary.

Tao,

If you're on a system running systemd, the default behavior is to
enable the watchdog during shutdown.  This guards against shutdown hanging.
So this message will be routinely printed out during orderly shutdown.


See file: /etc/systemd/system.conf
----------------------------------
...
# Entries in this file show the compile time defaults.
...

#ShutdownWatchdogSec=10min




-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
