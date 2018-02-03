Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeBCLJz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:09:55 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54625 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750921AbeBCLJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:09:47 -0500
Subject: Re: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13
 9360 and TUXEDO Book 1406
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        it+linux-input@molgen.mpg.de
References: <5a74e1a7-2083-c6b2-f51a-f44908ac8bc4@molgen.mpg.de>
 <20180130175017.72inurhk5l7tcvae@dtor-ws>
 <20180130180736.ehucqywbz7zdl4v7@dtor-ws>
 <a7c19320-4942-e41d-5323-0ac3693e7012@molgen.mpg.de>
From: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>
Message-ID: <5d6a4804-d4d1-df4f-6b63-43ac6b00af96@molgen.mpg.de>
Date: Sat, 3 Feb 2018 12:09:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a7c19320-4942-e41d-5323-0ac3693e7012@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dmitry,


Am 30.01.2018 um 19:39 schrieb Paul Menzel:

> On 01/30/18 19:07, Dmitry Torokhov wrote:
>> On Tue, Jan 30, 2018 at 09:52:45AM -0800, Dmitry Torokhov wrote:

>>> On Tue, Jan 30, 2018 at 06:36:34PM +0100, Paul Menzel wrote:

>>>> I do not know, when it started, but with Linux 4.14-rc8 and 4.15,
>>>> benchmarking suspend and resume time with `sleepgraph.py` [1][2], 
>>>> there is a
>>>> regression, that i8042 AUX port [serio1] suspend takes a second on 
>>>> Dell XPS
>>>> 13 9360 and TUXEDO Book 1406.
>>>
>>> It would be really helpful to know when the regression started.
>>
>> So the reason it takes longer is because the touchpad does not want to
>> talk to us for some reason and we wait until commands time out:
>>
>> [   94.591636] calling  serio1+ @ 2299, parent: i8042
>> [   94.794292] psmouse serio1: Failed to disable mouse on isa0060/serio1
>> [   95.593303] call serio1+ returned 0 after 974280 usecs
>>
>> but it is not clear why it happens, I do not think we changed anything
>> in that path for a while, so it might be some other change affecting
>> things indirectly. I'm afraid you'll have to narrow the scope, and
>> ideally bisect.
> 
> Thank you for looking into this. Just to note, that it worked with Linux 
> 4.14.1 from Ubuntu 17.10, so it’s probably something in 4.15. Bisecting 
> will take a bit, as the FTRACE stuff broke in Linux 4.15-rc1 and was 
> only fixed in 4.15-rc9. Hopefully, it’s just one commit I need to 
> backport. I’ll get back to you hopefully at the end of the week.

Unfortunately, I am unable to reproduce it currently. Also not with the 
original Linux kernel versions I tried. I’ll report back, when I see it 
the next time.


Kind regards,

Paul
