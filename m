Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeEUDOG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 23:14:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35022 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeEUDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 23:14:03 -0400
X-Google-Smtp-Source: AB8JxZqKMOEGhIFfxx1+G7aauQh6+hNhimg57C63sTpty5IE9uzFdqKurcUmu4LSTOJzWdfFVs1xQNKncdQbv0Q2okU=
MIME-Version: 1.0
In-Reply-To: <20180514.093504.1396660355199793729.davem@davemloft.net>
References: <20180514032839.32079-1-acelan.kao@canonical.com> <20180514.093504.1396660355199793729.davem@davemloft.net>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 21 May 2018 11:14:00 +0800
Message-ID: <CAFv23Q=RGo5Tw4sL5GiYM69xeGUPReiBE290rnzCvOPezQinCg@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "alx: remove WoL support"
To: David Miller <davem@davemloft.net>
Cc: James Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>, rakesh@tuxera.com,
        netdev@vger.kernel.org, Emily Chien <emily.chien@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

We are willing to fix the issue, but we don't have a machine to reproduce it,
and the WoL feature has been removed 5 years ago, it's hard to find
those buggy machines.

WoL is a feature that is only used by a very small group of people,
and the wake up issue
looks like only happens on some platforms. Which means only small part
of the group of people are affected.
So, it's not a serious issue worth to remove it from alx driver.

As the commit describes, WoL is required to pass E-Start 6.1, and
taking secure boot into account,
we can't keep distributing "alx driver with WoL" dkms package, so we
really need this feature to be built in the kernel.

There are some solutions to fix it.
1. Add WoL feature back, and we will try our best to fix the wake up
issue if we encounter it or users report it.
2. Add WoL feature back and add an driver option to disable it by
default, so that it won't create any regression and user can enable it
by kernel cmdline.
3. Add WoL feature back and create a white list in the driver, we'll
add those platforms we tested to the list.
4. or create a blacklist to list machines which are reported buggy.
Could you let me know which solution is more feasible for you?
Thanks.

Best regards,
AceLan Kao.

2018-05-14 21:35 GMT+08:00 David Miller <davem@davemloft.net>:
> From: AceLan Kao <acelan.kao@canonical.com>
> Date: Mon, 14 May 2018 11:28:39 +0800
>
>> This reverts commit bc2bebe8de8ed4ba6482c9cc370b0dd72ffe8cd2.
>>
>> The WoL feature is a must to pass Energy Star 6.1 and above,
>> the power consumption will be measured during S3 with WoL is enabled.
>>
>> Reverting "alx: remove WoL support", and will try to fix the unintentional
>> wake up issue when WoL is enabled.
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=61651
>>
>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>
> First, we must fix the problem that caused WoL to be disabled.
>
> Then, and only then, can you re-enable it.
>
> Thank you.
