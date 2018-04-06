Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeDFQqZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeDFQqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:46:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB8F217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <57f2182e-09b4-2cab-5602-9d0e029495be@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        David Lechner <david@lechnology.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com>
 <CAMRc=MfQuqTK+mDT0Gawa6J-3d1z6djLutaHREKfVm+3hATEqQ@mail.gmail.com>
 <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com>
 <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com>
 <CAMRc=Mc228JAxxBXcObmokh2h-toojG8OHrmbunm_ORqbGWUnA@mail.gmail.com>
 <69bc0848-0698-b936-96a3-2257a5e27809@ti.com>
 <CAMRc=MenWp=2dtOs1yafnHVkCxfT7SDS0fS2UxUd+U0s_UDwVw@mail.gmail.com>
 <57f2182e-09b4-2cab-5602-9d0e029495be@ti.com>
Message-ID: <152303318048.143116.2883441215887455211@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 12/44] clk: davinci: Add platform information for TI DA850 PSC
Date: Fri, 06 Apr 2018 09:46:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sekhar Nori (2018-04-06 02:37:03)
> 
> Can you please check that and confirm there is no issue with genpd and 
> using CLK_OF_DECLARE() to initialize clocks?
> 
> Unless you report an issue back, or Mike and Stephen have ideas about 
> how to handle the dependency between PSC/PLL derived timer clock 
> initialization and and timer_probe(), I think we need to move back to 
> using CLK_OF_DECLARE(). 

In such a case, please use the hybrid approach where the clks required
for the clockevent and/or clocksource are registered in the early
CLK_OF_DECLARE path but the rest of the clks get registered with a
proper platform device and driver. There are examples of this approach
on other platforms already.
