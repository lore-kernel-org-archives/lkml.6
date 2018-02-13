Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965737AbeBMUb6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:31:58 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:36901 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965611AbeBMUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:31:57 -0500
Date: Tue, 13 Feb 2018 21:31:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, rostedt@goodmis.org, mingo@redhat.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        broonie@kernel.org
Subject: Re: [PATCH v3] rtc: Add tracepoints for RTC system
Message-ID: <20180213203145.GB30929@piout.net>
References: <f819febcf2104918bfda1eadba021f9cc08ed866.1513221837.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f819febcf2104918bfda1eadba021f9cc08ed866.1513221837.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2017 at 13:31:43 +0800, Baolin Wang wrote:
> It will be more helpful to add some tracepoints to track RTC actions when
> debugging RTC driver. Below sample is that we set/read the RTC time, then
> set 2 alarms, so we can see the trace logs:
> 
> set/read RTC time:
> kworker/0:1-67 [000] 21.814245: rtc_set_time: UTC (1510301580) (0)
> kworker/0:1-67 [000] 21.814312: rtc_read_time: UTC (1510301580) (0)
> 
> set the first alarm timer:
> kworker/0:1-67 [000] 21.829238: rtc_timer_enqueue: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
> kworker/0:1-67 [000] 22.018279: rtc_set_alarm: UTC (1510301700) (0)
> 
> set the second alarm timer:
> kworker/0:1-67 [000] 22.230284: rtc_timer_enqueue: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0
> 
> the first alarm timer was expired:
> kworker/0:1-67 [000] 145.155584: rtc_timer_dequeue: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
> kworker/0:1-67 [000] 145.155593: rtc_timer_fired: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
> kworker/0:1-67 [000] 145.172504: rtc_set_alarm: UTC (1510301820) (0)
> 
> the second alarm timer was expired:
> kworker/0:1-67 [000] 269.102353: rtc_timer_dequeue: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0
> kworker/0:1-67 [000] 269.102360: rtc_timer_fired: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0
> 
> disable alarm irq:
> kworker/0:1-67 [000] 269.102469: rtc_alarm_irq_enable: disable RTC alarm IRQ (0)
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v2:
>  - Only keep time64_t in the buffer.
> 
> Changes since v1:
>  - Use unconditional tracepoints with tracing the failures.
>  - Simplify the rtc_timer_class.
> ---
>  drivers/rtc/interface.c    |   30 +++++++
>  include/trace/events/rtc.h |  206 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 236 insertions(+)
>  create mode 100644 include/trace/events/rtc.h
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
