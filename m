Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeCFO4F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:56:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38578 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932448AbeCFO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:56:04 -0500
Date: Tue, 6 Mar 2018 15:56:02 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, zyw@rock-chips.com,
        briannorris@google.com, dianders@google.com, jwerner@chromium.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [RESEND PATCH v3] rtc: cros-ec: return -ETIME when refused to
 set alarms in the past
Message-ID: <20180306145602.GA3035@piout.net>
References: <20180227025003.8823-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227025003.8823-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2018 at 10:50:03 +0800, Jeffy Chen wrote:
> Since accessing a Chrome OS EC based rtc is a slow operation, there is a
> race window where if the alarm is set for the next second and the second
> ticks over right before calculating the alarm offset.
> 
> In this case the current driver is setting a 0-second alarm, which would
> be considered as disabling alarms by the EC(EC_RTC_ALARM_CLEAR).
> 
> This breaks, e.g., hwclock which relies on RTC_UIE_ON ->
> rtc_update_irq_enable(), which sets a 1-second alarm and expects it to
> fire an interrupt.
> 
> So return -ETIME when the alarm is in the past, follow __rtc_set_alarm().
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> Fix alarm time comparing.
> 
> Changes in v2:
> Rewrite commit message as Brian suggested.
> Check alarm time only when that alarm is enabled.
> 
>  drivers/rtc/rtc-cros-ec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
