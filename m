Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeEIDRu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:17:50 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:42122 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933543AbeEIDRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:17:48 -0400
X-Google-Smtp-Source: AB8JxZrbkdjF+VknO5UKj5yODQaeg+VfBHUT9ZTwa5LnTEv5bk+R58CIkIJxmepRQWE8b6vt2cotjw==
Subject: Re: [PATCH] acpi: scan: Fix a possible data race in
 acpi_scan_hotplug_enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180508030811.12256-1-baijiaju1990@gmail.com>
 <CAJZ5v0jqW0yuSOSrgy1=dWARPHmaxtG4fvkZj=pX+fPcTTJh1A@mail.gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <1b7f1bff-b38b-fe10-3e1c-2b465b36f193@gmail.com>
Date: Wed, 9 May 2018 11:17:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jqW0yuSOSrgy1=dWARPHmaxtG4fvkZj=pX+fPcTTJh1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/9 4:17, Rafael J. Wysocki wrote:
> On Tue, May 8, 2018 at 5:08 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> The write operation to "hotplug->enabled" is protected by
>> the lock on line 1760, but the read operation to
>> this data on line 1755 is not protected by the lock.
>> Thus, there may exist a data race for "hotplug->enabled".
> Either it does exist, or it doesn't.
>
> If it exists, it needs to be fixed.  If it doesn't exist, nothing
> needs to be done.
>
> Which is the case?

I only read the code and find this possible data race.
It is not found in real driver execution.
I am not sure of it, so I use "may" and "possible" here.


Best wishes,
Jia-Ju Bai
