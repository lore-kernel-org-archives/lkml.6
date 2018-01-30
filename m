Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeA3TLD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:11:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40050 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeA3TLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:11:01 -0500
X-Google-Smtp-Source: AH8x225A4UibOs3JVufSAJQedWyVK8RA+wNqO5iRaD/+f6j2tEZwlG07v31pzxq8uCCb6bOLzpIA6A==
Message-ID: <1517339457.3153.9.camel@baylibre.com>
Subject: Re: [PATCH v2 0/9] clk: meson: pll fixes
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 30 Jan 2018 20:10:57 +0100
In-Reply-To: <20180119155529.11532-1-jbrunet@baylibre.com>
References: <20180119155529.11532-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-01-19 at 16:55 +0100, Jerome Brunet wrote:
> This changeset is a collection of fixes and clean-up around the pll clock
> provider. This has been triggered by the discussion around the ethernet
> clock on the axg [0].
> 
> On the axg the rate reported by the fixed_pll is off by 8Mhz, which leads
> the internal mux of the ethernet driver to pick an mpll2 instead of the
> fdiv4.
> 
> With this series applied, the fixed_pll of the axg now reports
> 1999998046 Hz, which is coherent with measurements (~2GHz)
> 
> While debugging this, we uncovered quite a mess around the hdmi_pll
> of the gxbb and gxl family. This is also fixed by this series.
> 
> Last, the parameters table provided to the read-only sys_plls have
> been removed, saving a bit of memory
> 
> There is still work to be done on this clock provider. Someday,
> I hope to see the parameter tables go away completely. This pll
> is just a (quite complex) fractional divider, we sould be able to
> figure something out at runtime.
> 
> Changes since v1: [1]
> * fix several typos in the comments
> * fix arm32 u64 math in patch 3 (Thanks a lot Martin!!)
> 
> [0]: https://lkml.kernel.org/r/1516095424.2608.36.camel@baylibre.com
> [1]: https://lkml.kernel.org/r/20180118184532.6856-1-jbrunet@baylibre.com

Series applied clk-meson next/drivers
