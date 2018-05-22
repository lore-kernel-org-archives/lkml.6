Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeEVSLk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:11:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43459 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbeEVSLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:11:38 -0400
Date: Tue, 22 May 2018 20:11:26 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Introduce STM32MP1 RTC
Message-ID: <20180522181126.GL13267@piout.net>
References: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2018 14:04:22+0200, Amelie Delaunay wrote:
> This series introduces STM32MP1 RTC.
> On STM32MP1:
> - two clocks are needed, plck and rtc_ck;
> - to wakeup the system, a wakeup alarm interrupt is needed;
> - some registers or bits have moved, but the operation is the same;
> - the Backup Domain Protection (DBP) is not managed by RTC driver.
> 
> ---
> Changes in v3:
> * Move cleanup changes in a separate patch
> * Replace regs and evts by pointers to ensure no copy is made
> * Set all registers offset as u16 instead of u8 and u16
> * Fix Kbuild smatch warning:
>   drivers/rtc/rtc-stm32.c:827 stm32_rtc_probe()
>   warn: always true condition '(regs.verr != ~0) => (0-u16max != (-1))'
> 
> Changes in v2:
> * One compatible per line in bindings file
> * Remove unnecessary comment under rtc_ck as this clock is required for all
> * Remove interrupts-extended and add stm32mp1 rtc alarm wakeup interrupt in
>   interrupts property description
> 
> Amelie Delaunay (4):
>   rtc: stm32: fix misspelling and misalignment issues
>   rtc: stm32: rework register management to prepare other version of RTC
>   dt-bindings: rtc: update stm32-rtc documentation for stm32mp1 rtc
>   rtc: stm32: add stm32mp1 rtc support
> 
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  27 +-
>  drivers/rtc/rtc-stm32.c                            | 273 ++++++++++++++++-----
>  2 files changed, 229 insertions(+), 71 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
