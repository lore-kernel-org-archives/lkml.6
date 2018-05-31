Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeEaCNX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:13:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47406 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeEaCNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:13:19 -0400
X-Google-Smtp-Source: ADUXVKKrSG5uc6kcODT9ztMLRfg16v6NdZktqInUAnxZc3wB9zdVfeSO05F26a0rc5PCqdbfNcRk9Mqlb86pMSgsc+w=
MIME-Version: 1.0
In-Reply-To: <20180530135859.GB27537@lunn.ch>
References: <20180530021008.15080-1-acelan.kao@canonical.com> <20180530135859.GB27537@lunn.ch>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 31 May 2018 10:13:17 +0800
Message-ID: <CAFv23Qkyp1n3y9PyOcXUBtyk_pTBAWzpwOuQsFMTPqENQLg5JQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "alx: remove WoL support"
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rakesh Pandit <rakesh@tuxera.com>, netdev@vger.kernel.org,
        Emily Chien <emily.chien@canonical.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Stezenbach <js@sig21.net>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

2018-05-30 21:58 GMT+08:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, May 30, 2018 at 10:10:08AM +0800, AceLan Kao wrote:
>> This reverts commit bc2bebe8de8ed4ba6482c9cc370b0dd72ffe8cd2.
>>
>> The WoL feature is a must to pass Energy Star 6.1 and above,
>> the power consumption will be measured during S3 with WoL is enabled.
>>
>> Reverting "alx: remove WoL support", and will try to fix the unintentional
>> wake up issue when WoL is enabled.
>
> Hi AceLan
>
> I find this change log entry rather odd.
>
> If i remember correctly, you first argued that you did not want to
> have to distribute out of tree patches.
Yes, once the secure boot is enabled, no dkms driver would be loaded.

>
> It was suggested that you might be able to justify the revert using
> the argument that the cure is worse than the decease. You ignored
I didn't try to ignore it, maybe I misunderstood what you say. I thought
you do not like the driver parameter, so I only revert back the alx wol
feature.

> that, and when with this Energy Star argument. That got shot down by
> DaveM, and told to actually try to find the problem.
To pass Energy Star is my purpose, I'm sorry to not mention it in the beginning.
We used to using dkms for the measurement, but secure boot is coming,
so we need to make wol feature to be built in the kernel.

And I've written to the device owners for help, but they are not care too much
about the wol feature and are not inconvenient for the testing. So I stuck here
until I saw the user report.

>
> So you then come back and said you think the problem is fixed, but
> don't know exactly what fixed it. So DaveM said try again.
That's another user's report, not me, please refer the link below
https://bugzilla.kernel.org/show_bug.cgi?id=61651#c126

We have no wake up issue and can't reproduce this issue at my side.

>
> Now you are back to Energy Star.
>
> I don't get this. It was the fact you said it was probably fixed that
> made DaveM reconsider. That is the argument you should be using in the
> change log. We want to know what testing you have done. See a
> tested-by: from somebody who had the issue which caused the revert,
> and now says the issue is fixed.
Thanks to remind me and sorry for my ignorance, I never think of adding
tested-by: in the comment, I'll be asking the reporter to provide more info
and put his name in the comment.

Hope my explanation is helpful for the misunderstanding.
And I'll submit another v3 patch once I got the info from reporter.

>
> Ideally we would like to know which change actually fixed the issue,
> so it can be added to stable. But that requires somebody to do a long
> git bisect.
>
>     Andrew
Thanks,

Best regards,
AceLan Kao.
