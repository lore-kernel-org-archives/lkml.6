Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947271AbeCBSZP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:25:15 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42262 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947238AbeCBSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:25:13 -0500
X-Google-Smtp-Source: AG47ELupfLVzoPj1h5hZEGNKKaf4uv1wS5h0DARjkqzUDrFfsIuIuj4rHa5yQlZObHdvkPqmD5egIg==
Subject: Re: [PATCH net 3/4] net: dsa: microchip: Utilize strncpy() for
 ethtool::get_strings
To: David Laight <David.Laight@ACULAB.COM>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180302002529.15226-1-f.fainelli@gmail.com>
 <20180302002529.15226-4-f.fainelli@gmail.com>
 <5dfe389482c54437873d4c0ae29eca8a@AcuMS.aculab.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bd3a6343-1e78-1e5b-3ae2-eec10dcfffcc@gmail.com>
Date: Fri, 2 Mar 2018 10:24:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5dfe389482c54437873d4c0ae29eca8a@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 02:51 AM, David Laight wrote:
> From: Florian Fainelli
>>
>> Do not use memcpy() which is not safe, but instead use strncpy() which
>> will make sure that the string is NUL terminated (in the Linux
>> implementation) if the string is smaller than the length specified. This
>> fixes KASAN out of bounds warnings while fetching port statistics.
> 
> You really ought to use a copy function that will truncate the
> string if it is too long.
> Just assuming the string isn't too long is asking for trouble.
> You might (almost) just use strcpy().
> 
> strlcpy() will probably work best here.

Right, or if we actually do size the statistics string to be
ETH_GSTRING_LEN bytes, memcpy() can be used, provided that the strings
are initialized correctly (which they are).
-- 
Florian
