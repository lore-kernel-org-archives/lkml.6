Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeBBK5b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:57:31 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:42466 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBBK5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:57:22 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
 <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
 <8c2fef37-8eb6-38c6-de3d-547edafac8b7@micronovasrl.com>
 <20180202105304.gow2znzgxqmuxgol@flea.lan>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <1b3d96ae-c6e6-4f58-b140-7b1738c12adc@micronovasrl.com>
Date: Fri, 2 Feb 2018 11:57:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202105304.gow2znzgxqmuxgol@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/2018 11:53, Maxime Ripard ha scritto:
> Hi,
> 
> On Thu, Feb 01, 2018 at 05:17:11PM +0100, Giulio Benetti wrote:
>>>>> What kernel version did you use?
>>>>
>>>> Latest mainline.
>>>
>>> I guess this patch could fix it:
>>> http://code.bulix.org/1kitrq-268936?raw
>>
>> This should prevent from modifying parent clock. But my problem was
>> different.
>>
>> On A20, gpu_clk can have different PLL, not I've found out the way
>> to choose right one with assigned-parent-clocks.
>>
>> I have patchset ready for adding A20 mali node, but I need some more
>> time to complete with OPP, then I will submit entire patchset.
>>
>> Now it works correctly, using right pll(dedicated PLL8), setting
>> right frequency.
> 
> The point is that we really don't care about which PLL is actually
> being used, as long as the rate is correct and we don't break anything
> else. If the GPU rate is accessible through one of the other PLL, it
> makes even more sense to not use the GPU PLL and keep it disabled,
> since it will result in some power savings.

Ah! I see the point now, very clever system for power saving.
I'm going to check if it's resolutive,
but it sounds good.

> 
>> Btw, do I need to add a board using it, or can I add only Mali node
>> to sun7i-a20.dtsi(plus other little patches)?
> 
> You can add it to the DTSI without a board using it (and actually,
> nothing should be in the board DTS, everything in the DT for the Mali
> applies to all boards).

Sure. So I would also add the patch you've addressed me:
http://code.bulix.org/1kitrq-268936?raw
as a commit. Can I submit it in patchset to complete the whole job?

> 
> Maxime
> 


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
