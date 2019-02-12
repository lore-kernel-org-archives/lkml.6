Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE5BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F3222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rEmD2/lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfBLVUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:20:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37474 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfBLVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:20:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212212011euoutp0217ee56d14c53314c99810b0dcf8e0bca~Cup57SbNM0893608936euoutp02H
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 21:20:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212212011euoutp0217ee56d14c53314c99810b0dcf8e0bca~Cup57SbNM0893608936euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550006411;
        bh=7TYNu/VzjzCTqtPLAc/2zH4DRP8+M+lHwtfb1YVdlnQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rEmD2/lDYXndQ/bquegCcUVgZSxfHZqfjTZ2wJ3GHU/NL82ang7C2f6kCbM6PIO25
         ZF/j3HbOSUS38X9DTOXMa/iqU6CNQASfS4xuIJFdyKgp9LNK/ZvfZ5VYj0jbeUG9fj
         BIujif82lw3k8Fy1Ue884HjwMjsaPGll5X8FNdmg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212212010eucas1p178e3d6a5b50cf44e9afca173e61d58e0~Cup5CcSb_0849308493eucas1p1J;
        Tue, 12 Feb 2019 21:20:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F4.5E.04806.A88336C5; Tue, 12
        Feb 2019 21:20:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212212009eucas1p261e17551e6e76a73af51fd851d1f7030~Cup4SRRTG2744027440eucas1p22;
        Tue, 12 Feb 2019 21:20:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190212212009eusmtrp12c9639161c8cf27d262d24aefd296efd~Cup4Dj_x10177301773eusmtrp18;
        Tue, 12 Feb 2019 21:20:09 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-1d-5c63388a8906
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.03.04128.988336C5; Tue, 12
        Feb 2019 21:20:09 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190212212008eusmtip2be0bf0b9e9f5b4292c72dc53eea4fa70~Cup3eCXdd2808428084eusmtip2Z;
        Tue, 12 Feb 2019 21:20:08 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <1356584e-1812-6768-72af-931c07d925a8@partner.samsung.com>
Date:   Tue, 12 Feb 2019 22:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212193229.GT117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUYRjG+3ZmdsfNtXG93uyiBUMlNas/horQLiZC8I+IDslWHY882/HI
        MlgT1EQlFVZby4PyWtbWOxGT3PXIRMwE7zxIi8KjXKXUslrHyP9+3/M87/c9L3wkJjUQ9mRI
        RDSriJCHyYRivKFjpdcljfb3OVRQYkNX5+kIWrXYj9ODS58IulTpQPfcnxXR/U2PhbQxow3R
        lW3vRbSx6gOiRxPLhbRhNoWgq5cZD3NGW6BFTL6yD2eKF5cJZmygWchk1mkQY6zZ6y28Kj4R
        wIaFxLIKt5M3xMHFqnkUle1wu/7BOq5E7/akITMSqKPwe/gJlobEpJQqR/CsQkuYDCm1hEDf
        H8gbRgS1c6Xo30Txaq+AN8oQFOkqCP4wh+Dr+BuhKWVFXQRt5ivMxNaUN+inOjemMUotAFVm
        QhoiSSHlCo2aWyZZQp0DZXIObmKccoDpsqaNuA11GQwZ84jPWELXo+mNjBnlDpWvGzavtIOR
        6UIBz/sgqT4f44uOi6Cy8DDPZ2DAOCjk2Qq+dNaJeN4N3TnpOM8c9KRqNjMJkNLVuJk5DobO
        PsJUGaOcQNfkxsuesJD+XWCSgbKAoTlLvoEFZDfkYrwsgdRkKZ92hLr0twKebaFMqxI9RDL1
        lr3UW3ZRb9lF/f/dIoRrkB0bw4UHsdyRCDbOlZOHczERQa7+keE16O/X6l7vXG5ELT/99Igi
        kcxcUt7u5yMl5LFcfLgeAYnJrCWBmL+PVBIgj7/DKiJ9FTFhLKdHu0hcZie5u23ympQKkkez
        oSwbxSr+uQLSzF6JDkxYTbXZ7k94YejIutJ0bGgtVX2WHft8amdjMyR71M6cdlcEbs9+rsly
        +bYy6xh26UKrqyahxDk0V9fgpVibWJrZ4eRRf55Zz9dgH3+MMumTJS3Ow/fybyb9SvKK8R6a
        rKLiWt0SVzN1/qqgvOv17S8XEh18J596mtuOROeig7kynAuWuztjCk7+B4PL9ZBWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7qdFskxBmc+y1psnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8XnDY8ZLW43rmCzOPymndVi41cPBx6P
        NfPWMHrMbrjI4rHw01dWjzvX9rB59G1ZxejxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGl
        hZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbCae8YCyapVmzt/MfSwHhJtouRk0NCwERi
        4a/zTF2MXBxCAksZJTY8mMAKkRCTmLRvOzuELSzx51oXG0TRa0aJa5ueMYIkhAVCJNb0HWAG
        sUUE/CQmNz5lASliFpjFJLGv5yEzRMdPRonfp1YC7eDgYBPQk9ixqhCkgVfATaKhbTILiM0i
        oCrxZPkusKGiAhESH5/uY4KoEZQ4OfMJWA2ngKHE2hPbwGqYBcwk5m1+yAxhi0vcejKfCcKW
        l2jeOpt5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiB8brt
        2M8tOxi73gUfYhTgYFTi4V1xNClGiDWxrLgy9xCjBAezkghvGnNyjBBvSmJlVWpRfnxRaU5q
        8SFGU6DnJjJLiSbnA1NJXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYO
        TqkGxty9F3rmckrY++dUbtLR/CPqt633TUnHzJLYg2F/ipr7ecPbrr88+CJF78sft2dsbyYk
        8qd5OPerHT0n0q/LUO/kIriO+xNznkr4yfzo+S9O+rnzCZ+RmK+ULcf864hzwY0PB/NV1+ud
        dbmxb8f5fa8XedcI/5khL/+nIKzKyqeW0S03cHGtEktxRqKhFnNRcSIALrOgVu0CAAA=
X-CMS-MailID: 20190212212009eucas1p261e17551e6e76a73af51fd851d1f7030
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
        <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
        <20190212193229.GT117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/12/19 8:32 PM, Matthias Kaehlcke wrote:
> Hi,
> 
> On Tue, Feb 12, 2019 at 02:46:24PM +0900, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
>>> This patch set changes workqueue related features in devfreq framework.
>>> First patch switches to delayed work instead of deferred.
>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>
>>> Using deferred work in this context might harm the system performance.
>>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>>> utilization does not have to be connected with a particular CPU.
>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>>> They all are missing opportunity to check the HW state and react when
>>> the deferred work is not fired.
>>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
>>
>> The devfreq framework keeps the balancing between performance
>> and power-consumption. It is wrong to focus on only either
>> performance or power.
>>
>> This cover-letter focus on the only performance without any power-consumption
>> disadvantages. It is easy to raise the performance with short sampling rate
>> with polling modes. To get the performance, it is good as short as possible
>> of period.
>>
>> Sometimes, when cpu is idle, the device might require the busy state.
>> It is very difficult to catch the always right timing between them.
>>
>> Also, this patch cannot prevent the unneeded wakeup from idle state.
>> Apparently, it only focuses on performance without considering
>> the power-consumption disadvantage. In the embedded device,
>> the power-consumption is very important point. We can not ignore
>> the side effect.
>>
>> Always, I hope to improve the devfreq framwork more that older.
>> But, frankly, it is difficult to agree because it only consider
>> the performance without considering the side-effect.
>>
>> The power management framework always have to consider
>> the power-consumption issue. This point is always true.
> 
> I missed the impact of forcing a CPU out of an idle state and/or not
> allowing it to enter a more power efficient state. I agree that this
> should be avoided.
It would be good to have some real world scenarios for comparison:
w/ and w/o this change, i.e. it is 5% or 50% more power used.
I have patches that tries to mitigate wake-ups when there is small
utilization. Let's make it tunable and involve driver developers.
They will decide how much impact on the system power usage they
introduce.
> 
> I wonder if using a power-efficient workqueue could help here:
> 
>    Instead of running work on the local CPU, the workqueue core asks the
>    scheduler to provide the target CPU for the work queued on unbound
>    workqueues (which includes those marked as power-efficient). So they
>    will not get pinned on a single CPU as can happen with regular
>    workqueues.
> 
>    https://lwn.net/Articles/731052/
> 
> 
> Since this series also changes from a custom to system workqueue it
> seems worth to mention that there are power-efficient system workqueues:
> 
> system_power_efficient_wq
> system_freezable_power_efficient_wq
> 
> 
> In case a power-efficient workqueue is suitable in principle there
> would still be a problem though: the feature is currently disabled by
> default, hence devfreq couldn't really rely on it. It is enabled in
> the arm64 defconfig though, so at least devices on this architecture
> would benefit from it. Also power-efficient workqueues might be
> enabled by default in the future as the scheduler becomes more energy
> aware.
Regarding this CPU idle cost worries.
IIRC the new energy model does not even consider idle costs of the CPU.
It would be good to know the measurements, i.e. worst case scenario:
waking up 1 (of 4 or 8) CPU from idle 30 times per second for let's
say 100 us. It is 3 ms / 1000 ms * running energy cost i.e. 250mW.
Thus, 0.75mW.
In my opinion it is not a big cost. In most cases the system is still
doing some other work. It is worth to mention here that on mobiles
when the power button is hit the full suspend is called which freezes
all tasks, devices and power consumption is ~15mW. Thus, the system
suspend is out of scope here.

As I replayed to Chanwoon for the same email: in my opinion current
devfreq is broken.
It was probably developed in times where there was 1 CPU (maybe 2)
and idle state of CPU would be a good hint to not to check devfreq
devices.

Regards,
Lukasz
> 
> Cheers
> 
> Matthias
> 
> 
