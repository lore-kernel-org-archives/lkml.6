Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034517AbeBPOw0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:52:26 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33190 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033381AbeBPOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:52:23 -0500
X-Google-Smtp-Source: AH8x224BVfT95g/IWK20AvMKyTR6JGYP/F07Da7/j8g0bXPtAaNVp7Gb/G0OlBhqHmJbHdWcIBVtwk3OhlsYtF1fuaQ=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gowD179tVaAc_8Wy-pV=mAwsO1egs0DfCnA-eEWayJdw@mail.gmail.com>
References: <20180209161456.18951-1-tony@atomide.com> <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
 <CAJZ5v0gRtkBf7uu4C_k7ivNGo=JM0bB1PAdr_6Nbbs39OPevHw@mail.gmail.com>
 <CAHp75VcVNDV9FmPFTBHsJRoiHtOviwC68Wk+aCqhqteZw41ZzQ@mail.gmail.com> <CAJZ5v0gowD179tVaAc_8Wy-pV=mAwsO1egs0DfCnA-eEWayJdw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 16:52:22 +0200
Message-ID: <CAHp75VdxsDiwi8uux3Q4vYhEO1P3w0sePVBcm38RvimKez8XAg@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:54 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Feb 16, 2018 at 11:39 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Feb 16, 2018 at 11:14 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Wed, Feb 14, 2018 at 12:23 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:

>>> IMO it is somewhat excessive to put the entire sprintf() under a raw
>>> spinlock and it's not even necessary.
>>
>> It's a copy'n'paste of from the rest of functions there.
>
> Fair enough. :-)

>>> The value can change any time after you've dropped the lock and in
>>> particular before the function returns, so why bother with locking?
>>> desc will not go away from under you at that point anyway.
>>
>> IIRC descriptor's content might be changed, or descriptor itself might
>> be gone (potential crash).
>
> No, desc cannot go away at this point AFAICS due to the kernfs
> refcounting.  And the lock is *inside* of the desc object anyway, so
> it doesn't help really against that.

Oh, indeed.

> The contents may change, but so what?
>
> Effectively, you read an int and reading an int is atomic.  It may
> change after that, but the lock doesn't prevent it from changing.  It
> only prevents the change from being applied to it before you drop the
> lock, but why do you care?

So, with explanations above, perhaps we can produce the patch to
remove those locks from the rest?

-- 
With Best Regards,
Andy Shevchenko
