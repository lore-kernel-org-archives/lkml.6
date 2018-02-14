Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031675AbeBNPmW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:42:22 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:39910 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031611AbeBNPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:42:20 -0500
X-Google-Smtp-Source: AH8x225lz8zv3DEZqOlLoTUX58oQuEPCgSrfIxZSVj7sXCOcpHBUGDdPWOm2lH9wdHg20Gid/NISQw==
Subject: Re: [PATCH v2 1/2] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518452709.git.digetx@gmail.com>
 <148ce8c56ad764fc8133e0d97e43f9639cae15ff.1518452709.git.digetx@gmail.com>
 <20180213103039.GA6764@ulmo>
 <20180214111546.GR5850@tbergstrom-lnx.Nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ea94ef04-2eda-51c8-b485-e8c8063f2598@gmail.com>
Date: Wed, 14 Feb 2018 18:42:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180214111546.GR5850@tbergstrom-lnx.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 14:15, Peter De Schrijver wrote:
> On Tue, Feb 13, 2018 at 11:30:39AM +0100, Thierry Reding wrote:
>>>  	}
>>
>> It's odd that we don't have an MC clock on Tegra2. I wonder if perhaps
>> we just never implemented one, or it uses one which is always on by
>> default. Cc Peter to see if he knows.
> 
> We do, it has DT ID TEGRA20_CLK_MC. However, it looks like the modeling is
> incorrect for Tegra20. Unlike on Tegra30 where the MC clock can be either
> half or the same as the EMC clock, it is always half the EMC clock on
> Tegra20. This happens to work because we likely never change the MC clock
> and the non-existing bit just reads as 0, which means half the MC clock.

Yes, and also that clock isn't specified in DT for MC. So probably we would have
to use clk_get_sys even if it was implemented correctly.
