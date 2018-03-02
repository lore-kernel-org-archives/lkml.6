Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164973AbeCBEVn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:21:43 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37980 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164277AbeCBEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:21:41 -0500
X-Google-Smtp-Source: AG47ELss1EePo3NC4sveQB853OiZV0Ov/BwXtkEbPgTzbd0zjHPtnGOG+EP3ssaZpjEjXwZyeMqyig==
Subject: Re: [PATCH net 4/4] net: dsa: mv88e6xxx: Utilize strncpy() for
 ethtool::get_strings
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180302002529.15226-1-f.fainelli@gmail.com>
 <20180302002529.15226-5-f.fainelli@gmail.com>
 <20180302030804.GB12656@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <64c4ace0-9305-d49f-4ce6-baa08c37336e@gmail.com>
Date: Thu, 1 Mar 2018 20:21:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302030804.GB12656@lunn.ch>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 07:08 PM, Andrew Lunn wrote:
> On Thu, Mar 01, 2018 at 04:25:29PM -0800, Florian Fainelli wrote:
>> Do not use memcpy() which is not safe, but instead use strncpy() which
>> will make sure that the string is NUL terminated (in the Linux
>> implementation) if the string is smaller than the length specified. This
>> fixes KASAN out of bounds warnings while fetching port statistics.
>>
>> Fixes: f5e2ed022dff ("dsa: mv88e6xxx: Add Second back of statistics")
> 
> I'm sure it goes back much further than that.

You are right, it appears that I used the most recent commit that
changed the stats last.

This is not actually needed per-se here because the string is defined to
be ETH_GSTRING_LEN bytes, so unlike b53, we are not copying past the
buffer, in fact only the first patch is really necessary.

Thanks!

> 
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 

-- 
Florian
