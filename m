Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeBSOCJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:02:09 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55395 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeBSOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:02:07 -0500
X-Google-Smtp-Source: AH8x227SpQiOrY+J3aniVE9OYu4GZhYgQQN+cJHgXZgPoogK/3GUFWbEaunIuU2RRjbI3b3PeSh3ig==
Subject: Re: [PATCH 6/9] ASoC: Intel: sst: Free streams on suspend, re-alloc
 on resume
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-7-hdegoede@redhat.com>
 <CAHp75VfjpRngR9_vE2SrHA_NRZdsap-2bEdRD6OEK63CTPBw2g@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e32ac973-fb6a-37f9-ed65-b6865c13d9dd@redhat.com>
Date: Mon, 19 Feb 2018 15:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfjpRngR9_vE2SrHA_NRZdsap-2bEdRD6OEK63CTPBw2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-02-18 14:51, Andy Shevchenko wrote:
> On Mon, Feb 19, 2018 at 12:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The Bay Trail SST-DSP firmware version looses track of all streams over a
>> suspend/resume, failing any attempts to resume and/or free streams, with
>> a SST_ERR_INVALID_STREAM_ID error.
>>
>> This commit adds support for free-ing the streams on suspend and
>> re-allocating them on resume, fixing suspend/resume issues on devices
>> using this firmware version.
>>
>> This new behavior gets triggered by a new flag in sst_platform_info which
>> only gets set on Bay Trail platforms.
>>
>> This has been tested on the following devices:
>> -Asus T100TA,    Bay Trail    + ALC5642 codec
>> -Ployer MOMO7W,  Bay Trail CR + ALC5652 codec
> 
> 
>>   /* Cherryview (Cherrytrail and Braswell) uses same mrfld dpcm fw as Baytrail,
>> - * so pdata is same as Baytrail.
>> + * so pdata is same as Baytrail, minus the streams_lost_on_suspend quirk.
>>    */
> 
> A nit, perhaps to fix multi line comment style as well?

The is the net/* style of multi-line comments which is used in quite a few
places in the sounds/soc dir. I think both styles are accepted under sound/soc?

Regards,

Hans
