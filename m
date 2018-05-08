Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeEHDmI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:42:08 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36458 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbeEHDmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:42:07 -0400
X-Google-Smtp-Source: AB8JxZrkLQwuAT1HPzV62dzvPiRLghy3UkZzveEZT6nTw17BBBHPVryqVQRYYrn9HAVH4Wqwy+AnGw==
Subject: Re: [PATCH] watchdog: mena21_wdt: Fix a possible data race in
 a21_wdt_set_timeout
To: Jia-Ju Bai <baijiaju1990@gmail.com>, morbidrsa@gmail.com,
        wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180508031825.12525-1-baijiaju1990@gmail.com>
 <64e08944-0578-ac4c-8dea-e1e704685e77@roeck-us.net>
 <26fde8a3-fb78-e12f-2f0f-c9b5bb2158e0@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e6a7af86-42e6-83b8-4b3d-4be2812912b5@roeck-us.net>
Date: Mon, 7 May 2018 20:42:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <26fde8a3-fb78-e12f-2f0f-c9b5bb2158e0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 08:32 PM, Jia-Ju Bai wrote:
> 
> 
> On 2018/5/8 11:28, Guenter Roeck wrote:
>> On 05/07/2018 08:18 PM, Jia-Ju Bai wrote:
>>> The write operation to "wdt->timeout" is protected by
>>> the lock on line 118, but the read operation to
>>> this data on line 105 is not protected by the lock.
>>> Thus, there may exist a data race for "wdt->timeout".
>>>
>>> To fix this data race, the read operation to "wdt->timeout"
>>> should be also protected by the lock.
>>>
>>
>> There is no race. There is already a mutex in the watchdog core which serializes
>> calls to the various API functions. It would make more sense to drop drv->lock
>> from the driver.
>>
> 
> Thanks for your reply :)
> Need I submit a patch of dropping all calls to "drv->lock"?
> 

You don't _need_ to, but I would happily give it my Reviewed-by: tag if you do.

Guenter
