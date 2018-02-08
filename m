Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBHKF1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:05:27 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17728 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBHKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:05:24 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Feb 2018 02:06:06 -0800
Subject: Re: [PATCH v3 01/11] regulator: core: add API to get voltage
 constraints
To: Mark Brown <broonie@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-2-git-send-email-pdeschrijver@nvidia.com>
 <20180206163544.GI5681@sirena.org.uk>
 <20180207084744.GG7031@tbergstrom-lnx.Nvidia.com>
 <20180207104351.GA6003@sirena.org.uk>
 <20180207123750.GA5850@tbergstrom-lnx.Nvidia.com>
 <20180207141846.GC6003@sirena.org.uk>
 <20180207143213.GB5850@tbergstrom-lnx.Nvidia.com>
 <20180207150155.GD6003@sirena.org.uk>
 <20180207152045.GC5850@tbergstrom-lnx.Nvidia.com>
 <20180207153711.GE6003@sirena.org.uk>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
From: Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <86cd40ac-d255-f4b9-87cb-0cd34efba7d8@nvidia.com>
Date: Thu, 8 Feb 2018 15:34:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180207153711.GE6003@sirena.org.uk>
X-Originating-IP: [10.19.64.176]
X-ClientProxiedBy: DRBGMAIL104.nvidia.com (10.18.16.23) To
 bgmail102.nvidia.com (10.25.59.11)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 07 February 2018 09:07 PM, Mark Brown wrote:
> On Wed, Feb 07, 2018 at 05:20:45PM +0200, Peter De Schrijver wrote:
>> On Wed, Feb 07, 2018 at 03:01:55PM +0000, Mark Brown wrote:
>>> I can't really tell what you're saying here.  If the driver needs to
>>> know if it can set the a given voltage there's already an API for doing
>>> that as I said.  If you're trying to convey this minimum and maximum
>>> voltage via the constraints that sounds like an abuse of the constraints.
>> No, what I want is the voltage which the regulator will output for a given
>> regulator_set_voltage request taking constraints, regulator step etc into
>> account.
> Knowing the range of the constaints is going to tell you nothing useful
> about that, it has zero information on steps or anything.  The way to
> find out what voltages can be set is to enumerate the voltages that can
> be set through the existing API and then if you want to set a specific
> voltage that you've confirmed is available you can set exactly that
> voltage via the normal voltage setting interface, no need to provide a
> range.

Hi,
I added this API in downstream for the purpose of finding whether rail 
output can be changed or not(fixed) based on constraints.
If min and max is same then it can not change. I used this information 
to set the pad voltage of SOC automatically.

I dont know other usage when I added this API. May be Peter is needed here.
