Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEOVsi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751149AbeEOVsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:48:37 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b7116836-28e0-f6a5-8791-b62a66774aff@st.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
 <0066b4db-8da6-007d-780d-a8ffc4884ad0@st.com>
 <152548833044.138124.7516235724401510636@swboyd.mtv.corp.google.com>
 <b7116836-28e0-f6a5-8791-b62a66774aff@st.com>
Message-ID: <152642091618.237094.8294094887191293130@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
 default
Date: Tue, 15 May 2018 14:48:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLmkhR029012

Quoting Alexandre Torgue (2018-05-14 05:45:57)
> 
> 
> On 05/05/2018 04:45 AM, Stephen Boyd wrote:
> > Quoting Alexandre Torgue (2018-05-04 00:54:16)
> >> Stephen
> >>
> >> On 05/03/2018 08:40 AM, gabriel.fernandez@st.com wrote:
> >>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> >>>
> >>> Clock driver is mandatory if the machine is selected.
> >>> Then don't use 'bool' and 'depends on' commands, but 'def_bool'
> >>> with the machine(s).
> >>>
> >>> Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")
> >>>
> >>
> >> Sorry to insist but we need it to have STM32 MCUs booting on Kernel v4.17.
> > 
> > Thanks for the bump. I missed this one. Of course, the user can still select
> > the configs now, just it's annoying for upgrade path.
> > 
> >>
> >>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> >>> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> >>> ---
> >>>    drivers/clk/Kconfig | 6 ++----
> >>>    1 file changed, 2 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> >>> index 24a5bc3..721572a 100644
> >>> --- a/drivers/clk/Kconfig
> >>> +++ b/drivers/clk/Kconfig
> >>> @@ -266,15 +266,13 @@ config COMMON_CLK_STM32MP157
> >>>          Support for stm32mp157 SoC family clocks
> >>>    
> >>>    config COMMON_CLK_STM32F
> >>> -     bool "Clock driver for stm32f4 and stm32f7 SoC families"
> >>> -     depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
> >>> +     def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
> > 
> > But the point of the change this patch is fixing was to expose these to
> > the user to turn off they wanted. You'll need to do something like that
> > again here, instead of removing the prompt and replacing it with a
> > def_bool.
> > 
> 
> Sorry I don't understand. Clock driver is mandatory to boot each 
> platform and depends on machine type. Do you see a use case where we 
> could need to disable the clock driver? (it would impose to change 
> devicetree to use fixed clocks and to have a booloader which configures 
> all PLL and clocks).

No. My understanding of the patch that introduced the options was to
allow the user to disable these drivers if they wanted to. I'm just
reiterating the spirit of that patch. That must be wrong?
