Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeEPH5y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeEPH5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:57:51 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <a49b89ee-2aee-274d-ccc0-3eaf7d9a3755@st.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>
References: <1525329609-7291-1-git-send-email-gabriel.fernandez@st.com>
 <0066b4db-8da6-007d-780d-a8ffc4884ad0@st.com>
 <152548833044.138124.7516235724401510636@swboyd.mtv.corp.google.com>
 <b7116836-28e0-f6a5-8791-b62a66774aff@st.com>
 <152642091618.237094.8294094887191293130@swboyd.mtv.corp.google.com>
 <a49b89ee-2aee-274d-ccc0-3eaf7d9a3755@st.com>
Message-ID: <152645747055.210890.12866212092853247736@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
 default
Date: Wed, 16 May 2018 00:57:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G7vwLC017497

Quoting Alexandre Torgue (2018-05-16 00:34:21)
> >>
> >> Sorry I don't understand. Clock driver is mandatory to boot each
> >> platform and depends on machine type. Do you see a use case where we
> >> could need to disable the clock driver? (it would impose to change
> >> devicetree to use fixed clocks and to have a booloader which configures
> >> all PLL and clocks).
> > 
> > No. My understanding of the patch that introduced the options was to
> > allow the user to disable these drivers if they wanted to. I'm just
> > reiterating the spirit of that patch. That must be wrong?
> > 
> Actually initial patch is a mistake. You can't boot STM32 platform 
> without clock driver. This patch fixes that, and offers the possibility 
> to not build the clock driver of the machine which are not used 
> (currently all machine are selected but to reduce memory footprint you 
> could disable not used machine in defconfig).

Ok I stuck the patch into clk-fixes. Will send off to Linus tomorrow or the
next day.
