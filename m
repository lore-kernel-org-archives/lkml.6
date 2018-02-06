Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeBFEAb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:00:31 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46749 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFEA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:00:27 -0500
X-Google-Smtp-Source: AH8x227NHIsWKne/jqvYuOAogew/4ZEyXe72Wpy1mf0FOkobhHMW4MOkihQAiqWkNsq8zNqStZbkptiqdOsUBiq7Vws=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0HBYckf4eQUONg6yzai3emGYODAu6mTFpY+s6RUJ2NbA@mail.gmail.com>
References: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
 <CAK8P3a0HBYckf4eQUONg6yzai3emGYODAu6mTFpY+s6RUJ2NbA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 6 Feb 2018 12:00:26 +0800
Message-ID: <CAMz4kuLPsF-aeK9uEeeBd1irz0CPVGhR=wYEtkYM1-3Ktzb1Dg@mail.gmail.com>
Subject: Re: [RESEND PATCH] rtc: Fix overflow when converting time64_t to rtc_time
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 26 January 2018 at 17:24, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jan 26, 2018 at 6:06 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> If we convert one large time values to rtc_time, in the original formula
>> 'days * 86400' can be overflowed in 'unsigned int' type to make the formula
>> get one incorrect remain seconds value. Thus we can use div_s64_rem()
>> function to avoid this situation.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Could you apply this patch? Since it was pending for a while and it is
a bug fix. Thanks.

-- 
Baolin.wang
Best Regards
