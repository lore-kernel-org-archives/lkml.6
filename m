Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCUBMC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:12:02 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:56311 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCUBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:11:56 -0400
X-Google-Smtp-Source: AIpwx49hujae1BEO1DT3+QiMA0ur1AngmtlUi/xUqBGIe7L5QOOxA7p/9H1epbXNyexbTE1eUS46lQ==
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
From: Woody Suwalski <terraluna977@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com> <20180319092106.GA5683@amd>
 <6e43123a-5227-96c4-a1f5-4416bdb5b0db@gmail.com>
Message-ID: <c7d96582-e2e6-d9c8-1140-3f1dab836132@gmail.com>
Date: Tue, 20 Mar 2018 21:11:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.2
MIME-Version: 1.0
In-Reply-To: <6e43123a-5227-96c4-a1f5-4416bdb5b0db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woody Suwalski wrote:
> Pavel Machek wrote:
>> On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
>>> Pavel Machek wrote:
>>>> Hi!
>>>>
>>>> With recent linux-next, after resume networkmanager often claims that
>>>> "network is disabled". Sometimes suspend/resume clears that.
>>>>
>>>> Any ideas? Does it work for you?
>>>>                                     Pavel
>>> Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
>> Thanks for testing... but yes, 4.16 should be ok. If not fixed,
>> problem will appear in 4.17-rc1.
>>
> Works here OK. Tried ~10 suspends, all restarted OK.
> kernel next-20180320
> nmcli shows that Wifi always connects OK
>
> Woody
>
Contrary, it just happened to me on a 64-bit build 4.16-rc5 on T440.
I think that Dan's suspicion is correct - it is a snafu in the PM: 
trying to hibernate results in a message:
Failed to hibernate system via logind: There's already a shutdown or 
sleep operation in progress.

And ps shows "Ds /lib/systemd/systemd-sleep suspend"...

Woody
