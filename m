Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeCZJhy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:37:54 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41186 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeCZJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:37:53 -0400
X-Google-Smtp-Source: AIpwx48e+prV9h/v84AZLo/m6/lAKB7WEbuLF5XvuCMgW0BI5O3mMdDM2MZg5+s4gJp83SqF+ZBHdW4yqlfY3NdAdiE=
MIME-Version: 1.0
In-Reply-To: <b3e9a7ad5dfc4348a8b017110e8ba032@ausx13mpc120.AMER.DELL.COM>
References: <1520333620-22342-1-git-send-email-mario.limonciello@dell.com>
 <1854392.I8WPNng6r5@aspire.rjw.lan> <b3e9a7ad5dfc4348a8b017110e8ba032@ausx13mpc120.AMER.DELL.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Mar 2018 11:37:52 +0200
X-Google-Sender-Auth: VysQfa_0dD6lNgTbaeaglVUFZOw
Message-ID: <CAJZ5v0iwpp5oPGYhrL3X=bMOueByup=UF_ChOTkhjTU5PJc3Cg@mail.gmail.com>
Subject: Re: [PATCH] power/hibernate: Make passing hibernate offsets more friendly
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 9:17 AM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Monday, March 19, 2018 5:11 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: linux-acpi@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH] power/hibernate: Make passing hibernate offsets more friendly
>>
>> On Tuesday, March 6, 2018 11:53:40 AM CET Mario Limonciello wrote:
>> > Currently the only way to specify a hibernate offset for a
>> > swap file is on the kernel command line.
>> >
>> > Add a new /sys/power/disk_offset that lets userspace
>> > specify the offset and disk to use when initiating a hibernate
>> > cycle.
>> >
>> > Also split up the parsing routine to re-use the same code
>> > for the /sys/power/resume and /sys/power/disk_offset parsing.
>> >
>> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>>
>> Well, IMO /sys/power/resume and /sys/power/disk_offset would be confusingly
>> similar after this patch.
>
> Yeah they do function pretty similarly.
>
>>
>> I wonder if adding a resume_offset sysfs attr to simply allow the value of
>> resume offset alone to be passed to the kernel at run time (in addition to
>> the command line) would work?
>>
>> Thanks!
>
> I guess what's your expected flow for how the disk gets selected though?  Should
> the kernel be "guessing" which disk to use?
>
> Or should userspace be setting offset via /sys/power/resume_offset followed by
> disk in /sys/power/resume (which will show an error in syslog about no partition
> found)
>
> If the latter,

Yes, the latter.

> then I'd like to also modify the behavior to downgrade that missing
> hibernate partition to debug instead too.

That's OK.
