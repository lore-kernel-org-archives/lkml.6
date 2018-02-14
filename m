Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032949AbeBNQuQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:50:16 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:60081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032744AbeBNQuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:50:14 -0500
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Phil Elwell <phil@raspberrypi.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
Date: Wed, 14 Feb 2018 17:49:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214165827.386b9bb1@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-Provags-ID: V03:K0:1SNnkUfpNy8gwEkul6piSPrwR/y/AhX/jwLNNnDhzXqGDbSKZPP
 BJckO18oQwNr5vRoybcgdQCcLz0xtUHawvZdIiCPjfW6MtpIYVWktvX/skRPLCqUeWJnx9R
 oTX/KnOMfoBG9TTCQjkpGKpQMGqUr5bSXImUhuo82/kOXCFXdk/pcPJRYEyzfpHs2XZg3/c
 QoQ8zKJbj6WcZbdxytH6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iCL04rxiy80=:0cKaYax9pSqcoOHFCFtjNh
 KKJbDTlGumCuTnAl50A+MEAvuPOTP2R47QDPORRwom3s3wf5rgef7ReD09OsD/x2L9rvzHEdg
 IoYZlxR87KY6jDz+fwIvBsal77hx+YaF7qgv2hfMxJc1wP4w55PduIoZv4BM9h0D+b0T6DbS8
 kFg1k5BWejGGWUPFF1z4cuHD5FXbRvZxp5h0BkQfztlmAYwNoqN46ao863AN3+j5RaBD1or2U
 5GxCNAh3THGcVkTM/WD1OyViFYFd3MQK5lQ+ZnCphOpxsvZluFLJxh63h09wOWg14xHZpPJj1
 Jd3IRUTIHp39pNa1n52eL5NSviPQgCUZyA/fc5z8pFjYwkAmtYXVpYZPNiNUl1rDTJkevHvXF
 0hoIWgkhj3zLoBoxpubpJC0TCv/aEzONQH+yH1/fzxS8SHlcSXbeU/5jzxlXeEKI+JKun6+np
 7Fs4qqtzNM4Gm47nzliX+cirOLv71uL7SLEOhWaM1dqNHH7sTZ9qcBCLgboyhy2jMNqOOGW8b
 ysGPAW5QoYyr6oMFap+R0u9boAuXt2UZFJeint0zdH+tML6B/fHVrnwQSkViU7KMHjzqv2uC/
 bZZoVt4dbBDI1kt7mu1K4bx5x7L5ZMHwwoOsnqQTd/TfAtvXGELALMJc6dmXA13IvRFomXV4I
 nE2s5E4msTzX0Y3gK8p9JQL3Hkun7Ylovzy/pEEBooL75htfGi8okndVRC7QXGIvD0kB2nd9Y
 t7NMZnH++jVm7993qz7fB42syZ2BaARqT7IUd2ZXvgNAH8FxqtmNUwqLPCo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

[add Phil]

Am 14.02.2018 um 17:13 schrieb Michal Suchánek:
> On Wed, 14 Feb 2018 16:36:49 +0100
> Michal Suchánek <msuchanek@suse.de> wrote:
>
>> On Wed, 14 Feb 2018 15:58:31 +0100
>> Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>
>>> Hi Michal,
>>>
>>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:  
>>>> The bcm2835 mmc host tends to lock up for unknown reason so reset
>>>> it on timeout. The upper mmc block layer tries retransimitting
>>>> with single blocks which tends to work out after a long wait.
>>>>
>>>> This is better than giving up and leaving the machine broken for
>>>> no obvious reason.    
>>> could you please provide more information about this issue (affected
>>> hardware, kernel config, version, dmesg, reproducible scenario)?
>>>   
> It tends to reproduce when upgrading a few packages with zypper and
> otherwise at random during system operation. It seems that for my card
> it worsens with age to some degree so perhaps it depends on the
> fragmentation of the internal card flash.
>
> Attaching dmesg and kernel config.

do you noticed this issue before 4.15-rc4?

Could you please test with 4.15 final again?

What kind of SD card (name) triggers the issue?

Thanks Stefan

>
> Thanks
>
> Michal
