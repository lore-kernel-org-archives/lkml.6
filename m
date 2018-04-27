Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758239AbeD0Stm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:49:42 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36919 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757854AbeD0Stj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:49:39 -0400
X-Google-Smtp-Source: AB8JxZqnn5abQNXf/t4RDb57tU4XECAXMZzZx/i3M8kTN7k1qNynpNOZdUIlq53bz08aJoWeBUDkcg==
From: Kevin Hilman <khilman@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
Organization: BayLibre
References: <20180426084437.192394-1-yixun.lan@amlogic.com>
        <1524820841.4026.112.camel@baylibre.com>
        <fbd24a73-6793-76be-3ca5-04cbac5db198@amlogic.com>
        <1524823154.4026.123.camel@baylibre.com>
        <ab754711-f727-133c-7bc3-a9f3243c2278@amlogic.com>
Date: Fri, 27 Apr 2018 11:49:35 -0700
In-Reply-To: <ab754711-f727-133c-7bc3-a9f3243c2278@amlogic.com> (Yixun Lan's
        message of "Fri, 27 Apr 2018 20:33:42 +0800")
Message-ID: <7hsh7g1o3k.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

Yixun Lan <yixun.lan@amlogic.com> writes:

> On 04/27/2018 05:59 PM, Jerome Brunet wrote:

[...]

>> 
>> Looks to be the problem indeed. But it is still an issue with how your patchset
>> in organized.
>> 
>> I can't merge this until Kevin merges the patch above, which he can't merge
>> until there is the clkc_ao support in axg, which is given by this series.
>> 
>> 1# You should remove the axg part of the patch above. Kevin will be able to
>> merge it w/o any dependencies. (BTW, the patch is broken for axg because 1) you
>> did not include the dt-binding header for the clkc_ao in axg and 2) the clkc_ao
>> does not exist at this stage)
>> 2# I can then safely merge this series - w/o breaking gxbb and gxl.
>> 3# Finally you'll have to make a DT change for the axg, enabling the clkc_ao and
>> changes the uart clocks at the same time.
>> 
>
>   I didn't make myself clear in previous email
>
>   I mean, could you merge patch 1-6, just exclude the patch 7
> then kevin can merge the DT part (there are three patches) [1]
> after the DT patches merged, then you can take this patch 7
> This way, it won't break gxl or any other SoCs
>
>   I'm sending patch 7 along with this series, it would be better if I
> give a warning about it.

Your proposal requires extra work from a couple different maintainers to
track all the dependencies, and is very error prone.  Sometimes
maintainers may do this for you if they have time and are feeling
generous, but you will have much more success if you can ease the
process.

Jerome has provided lots of guidance throughout this series and just
above has provided you with a very good proposal above which minimizes
the dependencies, and provides the changes in the right order.

Please follow Jerome's suggestion,

Thanks,

Kevin
