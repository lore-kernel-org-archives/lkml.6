Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeDVMTV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 08:19:21 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:52899 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeDVMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 08:19:18 -0400
X-Google-Smtp-Source: AIpwx4+J+A5L0wInqe8chlTXETlAeLZXcpudg/4Ak0kHHL1pJZ9JMgq/+Vyal//HDWw3UjU+oW1haA==
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com> <20180319092106.GA5683@amd>
 <6e43123a-5227-96c4-a1f5-4416bdb5b0db@gmail.com>
 <c7d96582-e2e6-d9c8-1140-3f1dab836132@gmail.com> <20180415161551.GF10802@amd>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <01331018-8c62-30b2-673c-11b0bcd38c0e@gmail.com>
Date: Sun, 22 Apr 2018 08:19:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.2
MIME-Version: 1.0
In-Reply-To: <20180415161551.GF10802@amd>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Tue 2018-03-20 21:11:54, Woody Suwalski wrote:
>> Woody Suwalski wrote:
>>> Pavel Machek wrote:
>>>> On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
>>>>> Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>> With recent linux-next, after resume networkmanager often claims that
>>>>>> "network is disabled". Sometimes suspend/resume clears that.
>>>>>>
>>>>>> Any ideas? Does it work for you?
>>>>>>                                      Pavel
>>>>> Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
>>>> Thanks for testing... but yes, 4.16 should be ok. If not fixed,
>>>> problem will appear in 4.17-rc1.
>>>>
>>> Works here OK. Tried ~10 suspends, all restarted OK.
>>> kernel next-20180320
>>> nmcli shows that Wifi always connects OK
>>>
>>> Woody
>>>
>> Contrary, it just happened to me on a 64-bit build 4.16-rc5 on T440.
>> I think that Dan's suspicion is correct - it is a snafu in the PM: trying to
>> hibernate results in a message:
>> Failed to hibernate system via logind: There's already a shutdown or sleep
>> operation in progress.
>>
>> And ps shows "Ds /lib/systemd/systemd-sleep suspend"...
> Problem now seems to be in the mainline.
>
> But no, I don't see systemd-sleep in my process list :-(.
>
> I guess you can't reproduce it easily? I tried bisecting, but while it
> happens often enough to make v4.17 hard to use, it does not permit
> reliable bisect.
>
> These should be bad according to my notes
>
> b04240a33b99b32cf6fbdf5c943c04e505a0cb07
>   ed80dc19e4dd395c951f745acd1484d61c4cfb20
>   52113a0d3889d6e2738cf09bf79bc9cac7b5e1c6
>   4fc97ef94bbfa185d16b3e44199b7559d0668747
>   14ebdb2c814f508936fe178a2abc906a16a3ab48
>   639adbeef5ae1bb8eeebbb0cde0b885397bde192
>
> bisection claimed
>
> c16add24522547bf52c189b3c0d1ab6f5c2b4375
>
> is first bad commit, but I'm not sure if I trust that.
> 									Pavel
It has not happen on any of my systems in the last month. Good, but bad 
for getting more info :-(

Woody
