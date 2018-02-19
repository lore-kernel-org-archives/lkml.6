Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeBSKH5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:07:57 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:57757 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeBSKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:07:55 -0500
Date: Mon, 19 Feb 2018 11:07:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Igor Plyatov <plyatov@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        rtc-linux@googlegroups.com, util-linux@vger.kernel.org
Subject: Re: 500 ms delay in time saved into RTC
Message-ID: <20180219100754.GL14177@piout.net>
References: <30ae185f-28c9-54f1-2884-4ee7801b130e@gmail.com>
 <34f50661-85f5-eb46-3ff7-45f0c2bb5960@prevas.dk>
 <c91e0079-c31f-715d-bb2e-648af34565d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91e0079-c31f-715d-bb2e-648af34565d7@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2018 at 12:16:04 +0300, Igor Plyatov wrote:
> Dear Rasmus,
> 
> thank you very much for explanation!
> 
> I have set "RTC_SET_DELAY_SECS = 0.0" in hwclock.c and got acceptable
> result.
> 
> It wonder why such critical function does not implemented on kernel level in
> RTC driver?
> It is very strange to rely on specific HW in user space SW.
> 

Because of the way the API is designed, handling the MC146818A oddity is
not possible in the driver (i.e. 50% of the time, it will be too late
to handle it).

You can use busybox hwclock which has the x86 insanity commented out:
https://git.busybox.net/busybox/tree/util-linux/hwclock.c


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
