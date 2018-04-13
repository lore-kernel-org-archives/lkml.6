Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754257AbeDMKaJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:30:09 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33898 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753754AbeDMKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:30:07 -0400
X-Google-Smtp-Source: AIpwx4/GsbzHBoqZeTqjhv6vfkKr5fP6mSKFbCrz0qZRFbo6dfDrHbdIgnRzmLvTqwhhodhulSnjYQ==
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <1523436077.16235.5.camel@intel.com> <3546651.LUmDXQgY88@amdc3058>
 <16cbc915-ad89-7bab-c644-8086cfef082f@linaro.org>
 <CGME20180413092901epcas2p43245301152a01c782620f0ab95b2a692@epcas2p4.samsung.com>
 <4212243.RcCUWlsaar@amdc3058>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3b41052a-233d-9992-223a-d16f48295905@linaro.org>
Date: Fri, 13 Apr 2018 12:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4212243.RcCUWlsaar@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2018 11:28, Bartlomiej Zolnierkiewicz wrote:

[ ... ]

>>> It is okay to return 0 because this code-path (the default one) will be
>>> never hit by the driver (probe makes sure of it) - the default case is
>>> here is just to silence compilation errors..
>>
>> The init function is making sure cal_type is one or another. Can you fix
>> it correctly by replacing the 'switch' by a 'if' instead of adding dead
>> branches to please gcc?
>>
>> if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
>> 	return ...;
>> }
>>
>> return ...;
> 
> I'm not the one that added this switch statement (it has been there since
> 2011) and I would be happy to remove it. 

Actually the switch statement was fine until the cleanup.

> However could we please defer
> this to v4.17 and merge the current set of Exynos thermal fixes/cleanups
> (they simplify the driver a lot and make ground for future changes)?

Regarding the latest comment, this can be fixed properly by 'return' (or
whatever you want which does not get around of gcc warnings).

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
