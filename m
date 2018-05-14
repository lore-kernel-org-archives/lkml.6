Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeENBzm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 21:55:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45966 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeENBzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 21:55:40 -0400
X-Google-Smtp-Source: AB8JxZqmEOvRAPGc0iDGTjYnGr88duI0LMs33joQeOnOOV9oqpEI1TDzI0RQ/FtOfT60SgfQEcOUaQssuvHLxwY9fAc=
MIME-Version: 1.0
In-Reply-To: <20180510123425.GB5527@lunn.ch>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
 <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
 <20180409123910.GB31060@lunn.ch> <20180409.105039.310935818370762783.davem@davemloft.net>
 <CAFv23Q=QYastpgLxHiwr_PSdoeWfEjiNp6x2F9kM5EYhRee2hA@mail.gmail.com>
 <CAFv23QmkLiuFA6C4YFsO3hoTEE--2bT4H2uxaMqoY30G4_QJGw@mail.gmail.com>
 <CAFv23Qn1-5nHcFsk3egcL+OpKtujv4rkyXxa-Qht4eV4z6cbCA@mail.gmail.com>
 <20180509134543.GF14276@lunn.ch> <CAFv23QkETCHYqpsp_1JR30A1F=x+xCCQQv2RM9VOg24qhQRMOQ@mail.gmail.com>
 <20180510123425.GB5527@lunn.ch>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 14 May 2018 09:55:37 +0800
Message-ID: <CAFv23Qnvg98V_-ZfMkHz1e-SrcmD=Qz2m0FqB59hjHdKT_gpKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] alx: add disable_wol paramenter
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Miller <davem@davemloft.net>, James Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>, rakesh@tuxera.com,
        netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Emily Chien <emily.chien@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'll submit a new patch with some more description of why we
need this feature.
Thanks.

2018-05-10 20:34 GMT+08:00 Andrew Lunn <andrew@lunn.ch>:
> On Thu, May 10, 2018 at 01:58:24PM +0800, AceLan Kao wrote:
>> Hi Andrew,
>>
>> We have some machines using Qualcomm Atheros Killer E2400 Gigabit
>> Ethernet Controller,
>> but none of them has the unintentional wake up issue.
>> We're willing to fix it if we encountered the issue, but before we can
>> do it, we need this feature is supported by the driver.
>>
>> Taking the feature has been removed for 5 years into account, I doubt
>> if we still can reproduce this issue,
>> but again, to verify this issue we need to add back this feature first.
>> Set WoL disabled by default won't introduce any regression but give
>> users and developers a chance to fix it.
>
> The main problem here is the module parameter. That is not going to be
> accepted.
>
> Can you argue the cure is worse than the disease? Is WoL not working
> considered by a lot of people as being a bug? Double wake up is also a
> bug, but not many people care, it does not cause any data corruption,
> etc. So can you argue overall we have a less buggy system, but still
> buggy, if WoL is enabled?
>
> If you can write a convincing Change Message arguing the case, a patch
> simply re-enabling WoL might be accepted.
>
> But you also need to take on the responsibility to help debug the
> failed shutdowns in order to get to the bottom of this problem.
>
>        Andrew
