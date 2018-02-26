Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeBZV3e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:29:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38595 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeBZV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:29:32 -0500
X-Google-Smtp-Source: AG47ELuStGGehXqquVT93TifAEOYfC/lHWMvNf7iaCtAt9Fpo150pvh+7GVWPGNcgo+4NlNmR2Hx0w==
Subject: Re: [RFC PATCH] ARM: configs: sunxi: Set ondemand govenor as default
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, davem@davemloft.net,
        arnd@arndb.de, mchehab@kernel.org, clabbe.montjoie@gmail.com,
        rask@formelder.dk, krzk@kernel.org, sean@mess.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180217142235.28541-1-embed3d@gmail.com>
 <20180219081050.vvfhnbw4foved2fb@flea.lan>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <15992664-76be-2584-0f8d-424eadc23925@gmail.com>
Date: Mon, 26 Feb 2018 22:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219081050.vvfhnbw4foved2fb@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.02.2018 09:10, Maxime Ripard wrote:
> On Sat, Feb 17, 2018 at 03:22:35PM +0100, Philipp Rossak wrote:
>> Right now the performance govenor is the default frequency govenor on
>> sunxi devices. This causes some general problems.
>> When the cpu is idle the cpu runs with its maximum frequency.
>> This causes a higher cpu temperature in the idle state. When the cpu is
>> now under load the cpu gets with that higher idle temperature now faster
>> to its thermal limits.
>> An other big problem of the performace govenor is the missing
>> thermal throttling. Some tests with cpuburn resulted in a system crash
>> when the soc reached its thermal limits since no thermal throttling
>> occurred.
> 
> This won't change anything with cpuburn. While cpuburn will be
> running, ondemand will increase the frequency of the cores to the
> maximum frequency, putting yourself in the exact same situation.
> 
I see here a totally different behavior on the hardware (Bananapi M2, A31s).
First ondemand increases the cpu frequency, when the maximum temperature 
is reached, then it throttles down the cpu step by step to its minimum.
And the cpu doesn't get killed, like with the performance govenor.

I can record some "logs" with RPi-Monitor if this is requiered.

> The only difference is going to be when you're idle or have a rather
> small CPU load. But then, you won't heat much in that case either.
> 
>> With this patch we set the default frequency govenor to ondemand mode
>> and reduce the temperature when the cpu is idle and activate the thermal
>> throtteling.
> 
> This patch doesn't activate the thermal throttling.
> 
> Maxime
> 

Sorry for my late reply!
Philipp
