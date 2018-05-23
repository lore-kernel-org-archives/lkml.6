Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932826AbeEWLvG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:51:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54950 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeEWLvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:51:01 -0400
X-Google-Smtp-Source: ADUXVKK9AiH3jw7gZa8FdbzcJsHMC1PPWSEyJwzkvI2a/Pjo6y8jM/DnbNmZnPh7WDGBJwECn1QC33BjvjNiqpcsUIk=
MIME-Version: 1.0
In-Reply-To: <002d01d3f28b$d3ce3980$7b6aac80$@codeaurora.org>
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org>
 <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
 <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com> <002901d3f286$198878b0$4c996a10$@codeaurora.org>
 <CAKohponbpErCeTYu9iQm_-dupz5SUr+TKsYXzqmmARB-pq95iA@mail.gmail.com>
 <002b01d3f28a$0d033900$2709ab00$@codeaurora.org> <CAKohponruWpcjuSDg-=ZbZ1=qm2iPZs36mfKYJ3nQZREkc3JCw@mail.gmail.com>
 <002d01d3f28b$d3ce3980$7b6aac80$@codeaurora.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 23 May 2018 17:21:00 +0530
Message-ID: <CAKohpo=V_7a3-gDr0qoH=uPnH3+=SNGtgFWPzSU7U61uKqsHyg@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2018 at 17:17,  <ilialin@codeaurora.org> wrote:
> The nvmem will return EPROBE_DEFER, and so will my driver's init. But then no one will call the init again.

So even your driver needs to be registered as a platform driver then
and you can create its device
from the init function, and add a comment on why you create the
platform device in the driver itself.

--
viresh
