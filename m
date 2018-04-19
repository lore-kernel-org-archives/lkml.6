Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDSO33 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:29:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42995 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbeDSO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:29:27 -0400
X-Google-Smtp-Source: AIpwx4/wP6uB2/JdUUFc39fB6FPAp6aQhLpfkbM9CgRSbGQ3BmW/nJK/FyKHKtOBRNsNbX/mLEwuFg==
Subject: Re: [PATCH 0/2] nvmem: meson-efuse: add write support
To: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180316150113.9779-1-jbrunet@baylibre.com>
 <1524147206.2601.104.camel@baylibre.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <75866a94-c6e4-6537-b7d1-b5cae0519e61@linaro.org>
Date: Thu, 19 Apr 2018 15:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1524147206.2601.104.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/18 15:13, Jerome Brunet wrote:
> On Fri, 2018-03-16 at 16:01 +0100, Jerome Brunet wrote:
>> This changeset adds write support to meson efuse driver.
>> The first patch just changes the way the nvmem data are allocated w/o
>> any functional changes. The second patches actually adds write support.
>>
>> The memory being an OTP, it is safer if it remains read-only by default,
>> which is why I also submitted this DT patch [0].
>>
>> If a user knows what he is doing, it should be easy to remove the
>> read-only property from the board DT. This can be done in u-boot, before
>> starting linux:
>>
>>   > fdt rm /efuse read-only
>>
>> Tested on the gxl libretech-cc
> 
> Hi Srinivas,
> 
> Is this patchset ok with you ? Do you want to me to change something ?
> 
Patches look good to me, Can you rebase them on top of 4.17, I will send 
it to Greg once rc4 is out.

thanks,
srini
> Regards
> Jerome
> 
>>
>> [0]: https://lkml.kernel.org/r/20180316145021.8517-1-jbrunet@baylibre.com
>>
>> Jerome Brunet (2):
>>    nvmem: meson-efuse: remove econfig global
>>    nvmem: meson-efuse: add write support
>>
>>   drivers/nvmem/meson-efuse.c | 37 +++++++++++++++++++++++++++----------
>>   1 file changed, 27 insertions(+), 10 deletions(-)
>>
> 
