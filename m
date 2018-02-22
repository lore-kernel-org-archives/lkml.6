Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeBVXsB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:48:01 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:43462 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBVXr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:47:59 -0500
Subject: Re: [PATCH] clk: tegra: fix pllu rate configuration
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
References: <20180222230451.15515-1-marcel@ziswiler.com>
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <98bfea14-de25-e764-94b4-2f0dd687149a@wwwdotorg.org>
Date: Thu, 22 Feb 2018 16:47:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222230451.15515-1-marcel@ziswiler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 04:04 PM, Marcel Ziswiler wrote:
> Turns out latest upstream U-Boot does not configure/enable pllu which
> leaves it at some default rate of 500 kHz:

I assume this is only because U-Boot just happened not to access any USB 
devices. In other words, if you break into the U-Boot boot flow and 
explicitly initialize/access USB, then USB works both in U-Boot and in 
the kernel even without this patch? If that's not the case, it seems 
there's a bug in U-Boot.

Either way, I have no issue with this patch. I just want to make sure 
there weren't other bugs in U-Boot that needed fixing.
