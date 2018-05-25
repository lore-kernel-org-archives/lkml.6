Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeEYMeG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:34:06 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35841 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeEYMeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:34:04 -0400
X-Google-Smtp-Source: AB8JxZoK6YUGK6vroSjyeVpY8QBsx7ZfOtNuB7/sRLdYj/zRSCiiGnI7JMSac6fFKNrNaQ4erol7L3oFRUjPAEFbMuE=
MIME-Version: 1.0
In-Reply-To: <b3a94d63-678c-eab6-47a8-43eca95da979@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-10-git-send-email-ulf.hansson@linaro.org>
 <1c21d18e-954a-f3a8-9817-0117b7cb7e4f@nvidia.com> <CAPDyKFozm88OM8cDFXXwvgdMirrt2=HhZtBdyhNjo2bgjHV2Mg@mail.gmail.com>
 <2c63af8c-4745-a751-8d3d-f7122e921e6f@nvidia.com> <CAPDyKFrTtvhxOhf9BPY1=cJ9VQyx9D=P3O0vCV+WXSVR82FozQ@mail.gmail.com>
 <b3a94d63-678c-eab6-47a8-43eca95da979@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 May 2018 14:34:02 +0200
Message-ID: <CAPDyKFphA8iEpRv2RipqDygt6i4W7VOE65JWCxOH=R_xzLCJzg@mail.gmail.com>
Subject: Re: [PATCH 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2018 at 13:07, Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 25/05/18 11:45, Ulf Hansson wrote:
>
> ...
>
>>> Right, but this case still seems like an error. My understanding is that
>>> only drivers will use this API directly and it will not be used by the
>>> device driver core (unlike dev_pm_domain_attach), so if anyone calls this
>>> attempting to attach another PM domain when one is already attached, they
>>> are doing something wrong.
>>
>>
>> [...]
>>
>> You may be right!
>>
>> What I was thinking of is whether multiple PM domains may be optional
>> in some cases, but instead a PM domain have already been attached by
>> dev_pm_domain_attach(), prior the driver starts to probe.
>>
>> Then, assuming we return an error for this case, that means the caller
>> then need to check the dev->pm_domain pointer, prior calling
>> dev_pm_domain_attach_by_id(). Wouldn't it? Perhaps that is more clear
>> though?
>
>
> IMO the driver should know whether is needs multiple power-domains or not
> and if it needs multiple then it should just call
> dev_pm_domain_attach_by_id() N times without needing to checking
> dev->pm_domain first. If it fails then either the PM domain core did
> something wrong or power-domains are missing from DT, but either way there
> is an error, so let it fail.

Right, sounds reasonable!

Kind regards
Uffe
