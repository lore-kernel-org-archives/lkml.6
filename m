Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971618AbeEXVVf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:21:35 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:38803 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967358AbeEXVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:21:31 -0400
X-Google-Smtp-Source: AB8JxZqDyNp5QxLUZdkKo7kWGGenPvqXeBd36ET9ozWI73HZdC2360tOfGqM4vU42Tn4lYE2HcfJiiCHxq/K2jQMRy4=
MIME-Version: 1.0
In-Reply-To: <96169281-49b2-121f-0b7e-f54aae66db91@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com> <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
 <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com> <51f7de26-579a-8b9e-4e79-f4eee923ab38@codeaurora.org>
 <CAPDyKFo_69kSS6UzdsJeyeiiED=S=chsdkP+R43qMHDEbZ8n_A@mail.gmail.com>
 <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com> <CAPDyKFo8e5FMrxF2ggxVZ+HQjw4s1Wtx-tMf5ka67knJpZMQcA@mail.gmail.com>
 <1687797a-93f1-7e5c-6060-01c12c070964@nvidia.com> <CAPDyKFravSx3h6UnsjNGM2ViZtkxvPMULyVQnoVT9jsEP5az+A@mail.gmail.com>
 <96169281-49b2-121f-0b7e-f54aae66db91@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 May 2018 23:21:30 +0200
Message-ID: <CAPDyKFp3nMoUoM0LfxcSvJKthwrAKK7yCLAkZMGW-oapUsK7GA@mail.gmail.com>
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>>
>>> * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>>> * @dev: Device to attach.
>>> * @index: The index of the PM domain.
>>>
>>> This naming and description is a bit misleading, because really it is not
>>> attaching the device that is passed, but creating a new device to attach
>>> a
>>> PM domain to. So we should consider renaming and changing the description
>>> and indicate that users need to link the device.
>>
>>
>> I picked the name to be consistent with the existing
>> genpd_dev_pm_attach(). Do you have a better suggestion?
>
>
> Well, it appears to get more of a 'get' function and so I don't see why we
> could not have 'genpd_dev_get_by_id()' and then we could have a
> genpd_dev_put() as well (which would call genpd_dev_pm_detach).
>
>> I agree, some details is missing to the description, let me try to
>> improve it. Actually, I was trying to follow existing descriptions
>> from genpd_dev_pm_attach(), so perhaps that also needs a little
>> update.
>>
>> However, do note that, neither genpd_dev_pm_attach() or
>> genpd_dev_pm_attach_by_id() is supposed to be called by drivers, but
>> rather only by the driver core. So description may not be so
>> important.
>>
>> In regards to good descriptions, for sure the API added in patch9,
>> dev_pm_domain_attach_by_id(), needs a good one, as this is what
>> drivers should be using.
>
>
> OK. Same appears to apply here to the description as I mentioned above.
> Still seems to be more of a 'get' than an attach. So I wonder if it should
> be dev_pm_domain_get_by_id() instead?

Regarding "get" vs "attach", I suggest we continue to discuss that in
patch 9. Whatever is decided, $subject patch needs to follow.

>
>>> Finally, how is a PM domain attached via calling
>>> genpd_dev_pm_attach_by_id()
>>> detached?
>>
>>
>> Via the existing genpd_dev_pm_detach(), according to what I have
>> described in the change log. I clarify the description in regards to
>> this as well.
>
>
> OK, so this bit is a to-do as that is not yet exposed AFAICT. I see that you
> said 'although we need to extend it to cover cleanup of the earlier
> registered device, via calling device_unregister().' So if we do this then
> that would be fine.

Let me clarify the changelog. It's not a to-do, as it's already done
as part of $subject patch.

So I guess we are in agreement that we don't need another API to deal
with detach?

Kind regards
Uffe
