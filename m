Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526308553; cv=none;
        d=google.com; s=arc-20160816;
        b=BI5Ahfol0EBuxoVT32NKMUD/e1ld8d82MUUtdSM07ZovrJuSyd9BlpGh9ooquOgy+r
         fuvNtkiQDAWLxwM9M0oeooTUKirqN/U6ktaK4UWcs9E/7XoTLY98mV3p7URb3D5Mxzfo
         MVO6pJk+s6xI66vKUJpWIcZ+CucCT3ObwO3WIdQz2bjXQERgOXBH/BNgKlvILNVNFrK3
         O48oGkSH1XhVQ9cNH11/GahHoZKH57E39mQBbWTh/22EV51CyO/FIr959exe0P8h76XT
         jPFa9dXRzYqg3xOjd0WkCDmfmBj6YhuxKYivxf3c7d6EhB6f6jNSFF8asPvX2iXFv9N/
         vKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zLI6CkfNIwXpOre0tjLJaG68qltRG/XfRp47Oq3uJpA=;
        b=o6WblcBgqNiuJqCLgkBhaiu+ywveeSe91yawJgA1LM/vJo9pjvg1MSP0vrSrdZ6mWB
         zvyC+hxBRF39Lr+DISOatr6sV1+6MRVairwQMZ+PoeRY394S9/1nrJx/KNz7Pa8VBhaE
         5Ph07o3/DlmHJiiHsVWO/cfvL8ANfpiivBpWxAq4vLzJbf+jR8mZkNhxSxz7mIKfayIH
         w/pMLFkehzIu/ugDs0RmBr3KWuMUD0XscfitOQ+DO5UZEJXNkXucX+BYBUic+s/L93Q6
         erqQ77ncyuLnQllpdIeu7kWC0qUWjOpl8MU1JOQk98IEVvzI81lMt45DRnwfrvgq5065
         O9eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jQ0JJQ5V;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jQ0JJQ5V;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpY2vVsHVJdWJuraZZ/YpwVlmOVWCgz6nBYpTk/+TiqUwXECURFh8MqgIwIv/4Vagh7OAUtjavMruBTEHmgTBI=
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcTQX82UdcBROBc18C-M0_3bOnStLqJzUzRDqHC33m-1g@mail.gmail.com>
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
 <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
 <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com> <CAPDyKFoQFxHqupyqH3JsriUDdJHpUDecD37OqOSKn-sT26gEiA@mail.gmail.com>
 <CAJKOXPcTQX82UdcBROBc18C-M0_3bOnStLqJzUzRDqHC33m-1g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 May 2018 16:35:52 +0200
Message-ID: <CAPDyKFqdp=pL6HB_wYUofNX=ueF=pkMQ4+ptS8okpFxg7pvV9w@mail.gmail.com>
Subject: Re: [FAIL bisect] Sound card probe error
To: Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600450517864551424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 May 2018 at 14:43, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, May 14, 2018 at 2:30 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 14 May 2018 at 14:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>>> Hi,
>>>
>>> On 05/14/2018 12:17 PM, Krzysztof Kozlowski wrote:
>>>
>>>> Bisected to:
>>>> 8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
>>>> commit 8c123c14bbba4add148536b6d47a9226deda2f7a
>>>> Author: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Date:   Thu Apr 26 10:53:06 2018 +0200
>>>>
>>>>     driver core: Respect all error codes from dev_pm_domain_attach()
>>>>
>>>>     The limitation of being able to check only for -EPROBE_DEFER from
>>>>     dev_pm_domain_attach() has been removed. Hence let's respect all error
>>>>     codes and bail out accordingly.
>>>>
>>>>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The DRM driver creates the HDMI codec but its registration fails, due
>>> to some missing clocks. The clock are missing because the exynos5-subcmu
>>> driver probing fails.
>>>
>>> [    0.678578] exynos5-subcmu: probe of GSC failed with error -17
>>> [    0.679250] exynos5-subcmu: probe of MFC failed with error -17
>>> [    0.679992] exynos5-subcmu: probe of DISP failed with error -17
>>>
>>> The exynos5-subcmu driver before registering platform device makes
>>> of_genpd_add_device() call, so in platform_drv_probe() dev_pm_domain_attach()
>>> call will fail, as dev->pm_domain is already set. Previously the error
>>> was masked by code removed in the above commit and platform_drv_probe()
>>> was could complete successfully.
>>
>> Thanks for providing this information!
>>
>> I was about to tell that I overlooked the fact that there is more than
>> one way to assign PM domain pointers to devices. To fix the problem,
>> dev_pm_domain_attach() should return 0, not -EEXIST when it finds and
>> existing PM domain pointer.
>>
>> Does the below patch fix the problem?
>>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Date: Mon, 14 May 2018 14:26:16 +0200
>> Subject: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM domain
>>  exists
>>
>> As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
>> to devices, clearly we must allow a device to have the pointer already
>> being assigned. For this reason, return 0 instead of -EEXIST.
>>
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> Yes, this fixes the issue.
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the confirmation!

I am going to re-post the patch to include linux-pm, then let's see
how Rafael wants to handle it.

Kind regards
Uffe
