Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeEaKr6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:47:58 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56151 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbeEaKrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:47:51 -0400
X-Google-Smtp-Source: ADUXVKIPdxlk/ROFFD5FQCezJxG291N9I72xzchh2tmQD0R95Y8uQKNYRpIHQep5vC0S7yBNrguM8/COwpESB5jL+AM=
MIME-Version: 1.0
In-Reply-To: <20180531091410.fl5f42zmyqi6zj5a@vireshk-i7>
References: <20180529100421.31022-1-ulf.hansson@linaro.org> <20180531091410.fl5f42zmyqi6zj5a@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 May 2018 12:47:50 +0200
Message-ID: <CAPDyKFribHht_H+qYRqKRhMT-h-wDqWR+VX2+FrKc9Pb52KcJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PM / Domains: Add support for multi PM domains per device
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 May 2018 at 11:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-05-18, 12:04, Ulf Hansson wrote:
>> Changes in v2:
>>       - Addressed comments from Geert around DT doc.
>>       - Addressed comments from Jon around clarification of how to use this
>>       and changes to returned error codes.
>>       - Fixed build error in case CONFIG_PM was unset.
>>
>> There are devices that are partitioned across multiple PM domains. Currently
>> these can't be supported well by the available PM infrastructures we have in
>> the kernel. This series is an attempt to address this.
>>
>> The interesting parts happens from patch 5 an onwards, including a minor DT
>> update to the existing power-domain bindings, the 4 earlier are just trivial
>> clean-ups of some related code in genpd, which I happened to stumble over.
>>
>> Some additional background:
>>
>> One existing case where devices are partitioned across multiple PM domains, is
>> the Nvida Tegra 124/210 X-USB subsystem. A while ago Jon Hunter (Nvidia) sent a
>> series, trying to address these issues, however this is a new approach, while
>> it re-uses the same concepts from DT point of view.
>>
>> The Tegra 124/210 X-USB subsystem contains of a host controller and a device
>> controller. Each controller have its own independent PM domain, but are being
>> partitioned across another shared PM domain for the USB super-speed logic.
>>
>> Currently to make the drivers work, either the related PM domains needs to stay
>> powered on always or the PM domain topology needs to be in-correctly modelled
>> through sub-domains. In both cases PM domains may be powered on while they
>> don't need to be, so in the end this means - wasting power -.
>>
>> As stated above, this series intends to address these problem from a PM
>> infrastructure point of view. More details are available in each changelog.
>>
>> It should be noted that this series has been tested on HW, however only by using
>> a home-cooked test PM domain driver for genpd and together with a test driver.
>> This allowed me to play with PM domain (genpd), runtime PM and device links.
>>
>> Any further deployment for real use cases are greatly appreciated. I am happy to
>> to help, if needed!
>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

Kind regards
Uffe
