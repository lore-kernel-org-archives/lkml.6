Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeDJCkE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:40:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40428 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeDJCkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:40:02 -0400
X-Google-Smtp-Source: AIpwx4/slVL9DgMbRJlvRiqC1yF0j+qr5Z5lYKCi6mDJeycf5bMvQLdjjLrUPtzy0YUnfDm4bE57HKm0BQKbFoszIUU=
MIME-Version: 1.0
In-Reply-To: <20180409.105039.310935818370762783.davem@davemloft.net>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
 <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
 <20180409123910.GB31060@lunn.ch> <20180409.105039.310935818370762783.davem@davemloft.net>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Tue, 10 Apr 2018 10:40:00 +0800
Message-ID: <CAFv23Q=QYastpgLxHiwr_PSdoeWfEjiNp6x2F9kM5EYhRee2hA@mail.gmail.com>
Subject: Re: [PATCH 2/2] alx: add disable_wol paramenter
To: David Miller <davem@davemloft.net>
Cc: andrew@lunn.ch, jcliburn@gmail.com, chris.snook@gmail.com,
        rakesh@tuxera.com, netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is I don't have a machine with that wakeup issue, and I
need WoL feature.
Instead of spreading "alx with WoL" dkms package everywhere, I would
like to see it's supported in the driver and is disabled by default.

Moreover, the wakeup issue may come from old Atheros chips, or result
from buggy BIOS.
With the WoL has been removed from the driver, no one will report
issue about that, and we don't have any chance to find a fix for it.

Adding this feature back is not covering a paper on the issue, it
makes people have a chance to examine this feature.

2018-04-09 22:50 GMT+08:00 David Miller <davem@davemloft.net>:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Mon, 9 Apr 2018 14:39:10 +0200
>
>> On Mon, Apr 09, 2018 at 07:35:14PM +0800, AceLan Kao wrote:
>>> The WoL feature was reported broken and will lead to
>>> the system resume immediately after suspending.
>>> This symptom is not happening on every system, so adding
>>> disable_wol option and disable WoL by default to prevent the issue from
>>> happening again.
>>
>>>  const char alx_drv_name[] = "alx";
>>>
>>> +/* disable WoL by default */
>>> +bool disable_wol = 1;
>>> +module_param(disable_wol, bool, 0);
>>> +MODULE_PARM_DESC(disable_wol, "Disable Wake on Lan feature");
>>> +
>>
>> Hi AceLan
>>
>> This seems like you are papering over the cracks. And module
>> parameters are not liked.
>>
>> Please try to find the real problem.
>
> Agreed.
