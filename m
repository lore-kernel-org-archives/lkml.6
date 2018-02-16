Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758197AbeBPPa7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:30:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54667 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755453AbeBPP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:26:22 -0500
Subject: Re: [PATCH][V2] rtc: tx4939: avoid unintended sign extension on a 24
 bit shift
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180215193614.28684-1-colin.king@canonical.com>
 <20180215204453.GE14177@piout.net> <20180216152440.GH14177@piout.net>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <7ec6aba6-fb27-0982-8874-891528c9535c@canonical.com>
Date: Fri, 16 Feb 2018 15:26:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216152440.GH14177@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/18 15:24, Alexandre Belloni wrote:
> On 15/02/2018 at 21:44:53 +0100, Alexandre Belloni wrote:
>> On 15/02/2018 at 19:36:14 +0000, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The shifting of buf[5] by 24 bits to the left will be promoted to
>>> a 32 bit signed int and then sign-extended to an unsigned long. If
>>> the top bit of buf[5] is set then all then all the upper bits sec
>>> end up as also being set because of the sign-extension. Fix this by
>>> casting buf[5] to an unsigned long before the shift.
>>>
>>
>> The timing of the discovery of this issue is suspicious. I believe it is
>> because I just enabled COMPILE_TEST on that driver and now this gets
>> compiled on a 64bit architecture.
>>
>> Can I ask on which architecture this is an issue? I don't think (and a
>> small test program confirms) x86 does the sign extension because both
>> sec and buf are unsigned.
>>
> 
> Actually, my test program was wrong and you are right.
> Kudos to CoverityScan static analysis for finding it. It's not obvious
for sure

Colin
