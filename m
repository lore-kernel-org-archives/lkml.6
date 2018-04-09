Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDIHxr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:53:47 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37810 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeDIHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:53:45 -0400
X-Google-Smtp-Source: AIpwx48Cep3Q2n0CWERJimzqkMYL9VvZ5cJAk/xoYPf1hLpyQBgsboiHnVyixpXtmGjmMqBsRCbFUQ==
Date: Mon, 9 Apr 2018 13:23:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] PM / Domain: Add struct device to genpd
Message-ID: <20180409075342.GB7671@vireshk-i7>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
 <a7867661e9bc6f5b1571f60398266ef678ccc1c0.1513926033.git.viresh.kumar@linaro.org>
 <CAPDyKFprVsOd7_nKCXDCxDErh-K+vfaWojqDo0arzt0ZJKCPjQ@mail.gmail.com>
 <20180322095903.h7hgm3xylq3esjyf@vireshk-mac-ubuntu>
 <CAPDyKFqZeOvHy1oY0JnUau17vFTuRBzCjKp+zzpf=tWzAi3cEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqZeOvHy1oY0JnUau17vFTuRBzCjKp+zzpf=tWzAi3cEw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-18, 11:18, Ulf Hansson wrote:
> On 22 March 2018 at 10:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 22-03-18, 10:30, Ulf Hansson wrote:
> >> On 22 December 2017 at 08:26, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> >> > +       ret = device_add(&genpd->dev);
> >>
> >> What's the point of adding the device? Can we skip this step, as I
> >> guess the opp core is only using the device as cookie rather actual
> >> using it? No?
> >
> > We also use it for the OPP debugfs stuff, so that would be required I believe.
> 
> Right, however, isn't that only using the dev_name(dev), which you
> don't need to add the device to make use of.
> 
> Or maybe I missing something around this...

So I tested this bit. The code works fine even if the device isn't added
(registered), but this looks a bit sloppy to attempt.

Please let me know what would you prefer in this case, add the device or not.

-- 
viresh
