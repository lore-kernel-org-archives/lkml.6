Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeEAOqb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:46:31 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:13782 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754738AbeEAOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:46:29 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v9_00/27]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <1ea1b841-24da-e74a-50a8-98b0793e61a5@ti.com>
Date: Tue, 1 May 2018 20:15:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427001745.4116-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 April 2018 05:47 AM, David Lechner wrote:
> This series converts mach-davinci to use the common clock framework.
> 
> The series works like this, the first 3 patches fix some issues with the clock
> drivers that have already been accepted into the mainline kernel.
> 
> Then, starting with "ARM: davinci: pass clock as parameter to
> davinci_timer_init()", we get the mach code ready for the switch by adding the
> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
> around the legacy clocks so that we can switch easily between the old and the
> new.
> 
> "ARM: davinci: switch to common clock framework" actually flips the switch
> to start using the new clock drivers. Then the next 8 patches remove all
> of the old clock code.
> 
> The final four patches add device tree clock support to the one SoC that
> supports it.
> 
> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
> board file).

I have reviewed this series and looks good to me except some comments I
gave and some issues you have identified yourself in patches 25 and 26.

I think this is a good compromise to achieve platform device based
clocks as far as possible with current kernel framework. I know Bartosz
is working on solving the problem generically and I guess once thats
agreed upon, DaVinci can convert too.

But I think this series has been in the works for far too long and
should be merged (the remoteproc dependencies that Bartosz pointed out
should be resolved too). You can wait for clock maintainers opinion
though before spinning another version.

I have not tested this series yet, will do so soon.

Thanks,
Sekhar

PS: I started giving a Reviewed-by: for the mach-davinci patches before
realizing the futility of doing so and stopped mid-way. They will have
my sign-off anyway once I test and merge them.
