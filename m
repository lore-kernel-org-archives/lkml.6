Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425874AbeCBJn3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:43:29 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37339 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424874AbeCBJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:42:41 -0500
X-Google-Smtp-Source: AG47ELvXdRJe2dwSTn44R9d27qnNjt/FAKYOadx5gBhaFhr6KPAEe9VA1NGwwNy1/FiVbmF+wKaTzrPfo484eUsJhnM=
MIME-Version: 1.0
In-Reply-To: <ad15f3beb9f44c77b79f3038cb75b69c@ausx13mpc124.AMER.DELL.COM>
References: <1519839829-2191-1-git-send-email-mario.limonciello@dell.com>
 <CAHp75VcdsALCUBNoO4BoOj0rHuxurhr6B3GL2i7D79BxRL77kQ@mail.gmail.com> <ad15f3beb9f44c77b79f3038cb75b69c@ausx13mpc124.AMER.DELL.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Mar 2018 10:42:40 +0100
X-Google-Sender-Auth: fcyR7PjylfTv_HxSmqN4oIB4As0
Message-ID: <CAJZ5v0jGr0VP9bNXprvyHfLvvvEgva6S9rAZM8EZEpGw=0PG+g@mail.gmail.com>
Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 9:05 PM,  <Mario.Limonciello@dell.com> wrote:
>
>
>> -----Original Message-----
>> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> Sent: Wednesday, February 28, 2018 12:11 PM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: Rafael J . Wysocki <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-
>> acpi@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
>> Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
>>
>> On Wed, Feb 28, 2018 at 7:43 PM, Mario Limonciello
>> <mario.limonciello@dell.com> wrote:
>> > Currently the only way to specify a hibernate offset for a swap
>> > file is on the kernel command line.
>> >
>> > This makes some changes to improve:
>> > 1) Add a new /sys/power/disk_offset that lets userspace specify
>> > the offset and disk to use when initiating a hibernate cycle.
>> >
>> > 2) Adjust /sys/power/resume interpretation to also read in an
>> > offset.
>>
>> Read is okay per se (not consistent though), showing is not.
>> It might break an ABI.
>
> Right this is part of why I was proposing making a new attribute.
>
> The current RFC implementation I sent keeps the read output the
> same for /sys/power/resume.

You also need to retain the write behavior of it.

A new attribute is fine if it helps, but the behavior of the existing
one cannot change (both sides).
