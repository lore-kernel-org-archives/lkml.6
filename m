Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeAaMFl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:05:41 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:53816 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeAaMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:05:39 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
Date: Wed, 31 Jan 2018 13:05:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 31/01/2018 09:43, Maxime Ripard ha scritto:
> Hi,
> 
> On Wed, Jan 31, 2018 at 12:23:59AM +0100, Giulio Benetti wrote:
>> When mali.ko is inserted, it set default clocks and call all parent
>> clocks to stay into range, causing pll-video0 to change and
>> subsequently to change dclk to wrong frequencies.
> 
> This is what you should fix.

Ok, so it must be patch title(shrinked of course), right?

> 
>> "gpu" clock has lot of parent plls inside driver, but on sun7i
>> pll8-gpu does not depend on pll-video0, pll-ve, pll-video1.
>>
>> It only depends on 24Mhz main clock.
> 
> I don't really know why you are mentionning that. The GPU clock has
> all the parents described in the driver. And the parents' parents are
> irrelevant to this particular issue.
> 
>> Remove all pll parents from gpu_parents_sun7i except "pll-gpu".
> 
> However, this is not a proper fix for your issue.

Yes, you're right, now I understand.

It is more complex than I thought.
I need to dig more and study better A20 CCU.

So this patch can be dropped.

> 
> What kernel version did you use?

Latest mainline.

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
