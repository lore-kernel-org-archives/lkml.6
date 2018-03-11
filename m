Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeCKMnL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 08:43:11 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36598 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbeCKMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 08:43:09 -0400
X-Google-Smtp-Source: AG47ELt8m0PVSJ5tBg1YUfrYKzRr+LYTz9T7Lj8pbCqR/f4dIVukZT/OjfaAiUgg8m6ukBbZJwIFOy+VtujyTjkJrYA=
MIME-Version: 1.0
In-Reply-To: <20180311103423.GA18467@amd>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com>
 <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com>
 <20180303092417.GA30917@amd> <CAJZ5v0iVmE0jwRW1f6hnohSVzKsZbLr0axi+VKoR+FQcHM+_7w@mail.gmail.com>
 <20180303204512.GA9259@amd> <CA+Y=x3k5tsf+oxTo9YQv195XQpEECfqtFcbCoYGkJVCQsbjWpA@mail.gmail.com>
 <20180310131605.GA28296@amd> <CA+Y=x3mwNDNJTt=n-K__wbCb8P+VhgMafRiofc0tnXqdgRk43w@mail.gmail.com>
 <20180311103423.GA18467@amd>
From: Andrew Worsley <amworsley@gmail.com>
Date: Sun, 11 Mar 2018 23:43:08 +1100
Message-ID: <CA+Y=x3kvcPQTX_DuRyCsqQchqDimyKQzjFP3fQFr=NSEwQfv9g@mail.gmail.com>
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 March 2018 at 21:34, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
....
>>
>> Ok - all the test modes work but a full s2ram hangs (never comes back)
>> and obviously the resume full save to disk fails.
>>
>> I attach the following files:
>>
>> echo reboot > /sys/power/disk
>> echo disk > /sys/power/state
>> Then saved dmesg to file  dmesg-reboot-disk-ok.txt
>
> So with "reboot" mode, hibernation works as expected, you just have to
> power down machine manually?

.... Sorry no all the test modes immediately start back with the
restore faultlessly.
There is no time to power off the machine once it is suspended.
 The hibernate command from the other modes fails as before.
I tried running the hibernate command with shutdown and reboot setting
in /sys/power/disk and the power turns off by itself after 10 or so
seconds in all those modes and the subsequent boot up will resume up
to the hang in the usual place:
 do_idle() / cpu_start_entry()/start_secondary()/
secondary_startup_64()   state.


>
>> I tried to add some debug to hibernation_restore() but saw nothing.
>>  Not sure if I doing this correctly but I believe the last know dmesg
>> entry is from swsusp_read() in kernel/power/swap.c
>> but then I should see something in hibernation_restore() but as the
>> console might not work or something I can't be sure....
>>
>> Further directions appreciated
>
> You may want to try without thunderbolt support / talk to thunderbolt
> people:
>
> pciehp seems to have bad problems, too.
>
> I'd suggest debugging with s2ram (as it is less tricky) and removing
> all modules you don't really need.
>
> Good luck,
>                                                                 Pavel
....

  ThanksI tried removing the thunderbolt module - the pciehp doesn't
seem to be loaded or is called something else.
The thunderbolt module sometimes complains loudly when remove but made
no difference.

Thanks for your suggestions I will try the s2ram but it seems to be
stuck badly - no interrupts or messages - black screen so it doesn't
seem so easy to make progress. I am more tempted to add printk()s to
the hibernate but I feat there is a tricky point where it calls
routines to suspend console ....

Funny it hibernates and resumes so well in the 3.16 kernel...

Andrew
