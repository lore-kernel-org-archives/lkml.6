Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933923AbeEIHyC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:54:02 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:40982 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933806AbeEIHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:53:57 -0400
X-Google-Smtp-Source: AB8JxZoG2SuLHOdiKlQZxk7Fa/WXIQW5bGDyV6zzRnbjgkkpJlhuxGmSrujb0/rRYoFfD2PIVrFBBOBcLyb8/QioRJU=
MIME-Version: 1.0
In-Reply-To: <1b7f1bff-b38b-fe10-3e1c-2b465b36f193@gmail.com>
References: <20180508030811.12256-1-baijiaju1990@gmail.com>
 <CAJZ5v0jqW0yuSOSrgy1=dWARPHmaxtG4fvkZj=pX+fPcTTJh1A@mail.gmail.com> <1b7f1bff-b38b-fe10-3e1c-2b465b36f193@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 May 2018 09:53:56 +0200
X-Google-Sender-Auth: x7GfQckR2ytlKk4ewohIFmP_PA0
Message-ID: <CAJZ5v0gT2aHE5xXgCYXD1DRkMFJZeHJSg+zVHnxsJ69-d+qrxQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: scan: Fix a possible data race in acpi_scan_hotplug_enabled
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 5:17 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
>
> On 2018/5/9 4:17, Rafael J. Wysocki wrote:
>>
>> On Tue, May 8, 2018 at 5:08 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>>>
>>> The write operation to "hotplug->enabled" is protected by
>>> the lock on line 1760, but the read operation to
>>> this data on line 1755 is not protected by the lock.
>>> Thus, there may exist a data race for "hotplug->enabled".
>>
>> Either it does exist, or it doesn't.
>>
>> If it exists, it needs to be fixed.  If it doesn't exist, nothing
>> needs to be done.
>>
>> Which is the case?
>
>
> I only read the code and find this possible data race.
> It is not found in real driver execution.
> I am not sure of it, so I use "may" and "possible" here.

It looks like you are not actually sure what you are doing then.
