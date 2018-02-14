Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967353AbeBNLQB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:16:01 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11663 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967252AbeBNLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:15:58 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 14 Feb 2018 03:15:58 -0800
Date: Wed, 14 Feb 2018 13:15:46 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
Message-ID: <20180214111546.GR5850@tbergstrom-lnx.Nvidia.com>
References: <cover.1518452709.git.digetx@gmail.com>
 <148ce8c56ad764fc8133e0d97e43f9639cae15ff.1518452709.git.digetx@gmail.com>
 <20180213103039.GA6764@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180213103039.GA6764@ulmo>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 11:30:39AM +0100, Thierry Reding wrote:
> >  	}
> 
> It's odd that we don't have an MC clock on Tegra2. I wonder if perhaps
> we just never implemented one, or it uses one which is always on by
> default. Cc Peter to see if he knows.

We do, it has DT ID TEGRA20_CLK_MC. However, it looks like the modeling is
incorrect for Tegra20. Unlike on Tegra30 where the MC clock can be either
half or the same as the EMC clock, it is always half the EMC clock on
Tegra20. This happens to work because we likely never change the MC clock
and the non-existing bit just reads as 0, which means half the MC clock.

Peter.
