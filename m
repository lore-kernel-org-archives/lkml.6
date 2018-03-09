Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbeCIRdJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeCIRdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:33:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6B7205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Dmitry Osipenko <digetx@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180308144437.GJ3529@ulmo>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <699ce67980d71fd315085ea9785ee6213e0772cb.1515589507.git.digetx@gmail.com>
 <cbf3e9ff-f7e1-32c2-546d-85fd198c2a3b@gmail.com>
 <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com> <20180308144437.GJ3529@ulmo>
Message-ID: <152061678678.13890.15810434310624804730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/3] clk: tegra: Mark HCLK, SCLK and EMC as critical
Date: Fri, 09 Mar 2018 09:33:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thierry Reding (2018-03-08 06:44:37)
> On Thu, Mar 01, 2018 at 04:33:29PM +0300, Dmitry Osipenko wrote:
> > On 15.01.2018 13:56, Dmitry Osipenko wrote:
> > > On 10.01.2018 16:59, Dmitry Osipenko wrote:
> > >> Machine dies if HCLK, SCLK or EMC is disabled. Hence mark these clocks
> > >> as critical.
> > >>
> > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > >> ---
> > >>
> > >> Change log:
> > >> v2:     Fixed accidentally missed marking EMC as critical on Tegra30 and
> > >>         Tegra124. Switched to a use of common EMC gate definition on Tegra20
> > >>         and Tegra30.
> > >>
> > >> v3:     Dropped marking PLL_P outputs as critical, because seems they are
> > >>         not so critical. Although, I still haven't got a definitive answer
> > >>         about what exact HW functions are affected by the fixed-clocks.
> > >>         Anyway it should be cleaner to correct the actual drivers.
> > > 
> > > Stephen / Michael, would it be possible to schedule these patches for 4.16? My
> > > T20 and T30 devices aren't working without the 'critical clocks' patch. Things
> > > happen to work with the opensource u-boot, but not with the proprietary
> > > bootloader. It's probably not a big deal that out-of-tree devices are broken,
> > > although would be nice to have one problem less.
> > 
> > Guys, is there anything I could do to get these patches in linux-next?
> 
> I've picked these up into the for-4.17/clk branch in the Tegra tree. I
> already have that branch for the MBIST patches which are a dependency
> for the for-4.17/soc branch.
> 
> Stephen, Mike, let me know if you have any objections to carrying these
> in the Tegra tree.
> 

Are you going to send us a PR at some point?
