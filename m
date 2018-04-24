Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbeDXDpY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:45:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42508 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932780AbeDXDpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:45:22 -0400
X-Google-Smtp-Source: AIpwx4+Tu24nEzJKZiPyqz3AmyKJqEnzBU0D9QT436HTY+Odl+6osa1rWW5avV3Yo91UEWhZuV8jLGN96b3/D5ffZ8M=
MIME-Version: 1.0
In-Reply-To: <CAFv23Q=QYastpgLxHiwr_PSdoeWfEjiNp6x2F9kM5EYhRee2hA@mail.gmail.com>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
 <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
 <20180409123910.GB31060@lunn.ch> <20180409.105039.310935818370762783.davem@davemloft.net>
 <CAFv23Q=QYastpgLxHiwr_PSdoeWfEjiNp6x2F9kM5EYhRee2hA@mail.gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Tue, 24 Apr 2018 11:45:20 +0800
Message-ID: <CAFv23QmkLiuFA6C4YFsO3hoTEE--2bT4H2uxaMqoY30G4_QJGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] alx: add disable_wol paramenter
To: David Miller <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, James Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>, rakesh@tuxera.com,
        netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

May I know the final decision of this patch?
Thanks.

Best regards,
AceLan Kao.

2018-04-10 10:40 GMT+08:00 AceLan Kao <acelan.kao@canonical.com>:
> The problem is I don't have a machine with that wakeup issue, and I
> need WoL feature.
> Instead of spreading "alx with WoL" dkms package everywhere, I would
> like to see it's supported in the driver and is disabled by default.
>
> Moreover, the wakeup issue may come from old Atheros chips, or result
> from buggy BIOS.
> With the WoL has been removed from the driver, no one will report
> issue about that, and we don't have any chance to find a fix for it.
>
> Adding this feature back is not covering a paper on the issue, it
> makes people have a chance to examine this feature.
>
> 2018-04-09 22:50 GMT+08:00 David Miller <davem@davemloft.net>:
>> From: Andrew Lunn <andrew@lunn.ch>
>> Date: Mon, 9 Apr 2018 14:39:10 +0200
>>
>>> On Mon, Apr 09, 2018 at 07:35:14PM +0800, AceLan Kao wrote:
>>>> The WoL feature was reported broken and will lead to
>>>> the system resume immediately after suspending.
>>>> This symptom is not happening on every system, so adding
>>>> disable_wol option and disable WoL by default to prevent the issue from
>>>> happening again.
>>>
>>>>  const char alx_drv_name[] = "alx";
>>>>
>>>> +/* disable WoL by default */
>>>> +bool disable_wol = 1;
>>>> +module_param(disable_wol, bool, 0);
>>>> +MODULE_PARM_DESC(disable_wol, "Disable Wake on Lan feature");
>>>> +
>>>
>>> Hi AceLan
>>>
>>> This seems like you are papering over the cracks. And module
>>> parameters are not liked.
>>>
>>> Please try to find the real problem.
>>
>> Agreed.
