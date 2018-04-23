Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDWEXz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 00:23:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42494 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDWEXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 00:23:52 -0400
X-Google-Smtp-Source: AIpwx49UKj0IQEU/MYQ0nXxPzzEwQHV9Xm7w1SPi5D6h5dKodQEXt1ThJ3wLs/hSBIXhjJL3XFPCzw==
Date: Mon, 23 Apr 2018 09:53:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Markus Mayer <code@mmayer.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
Message-ID: <20180423042343.GB2989@vireshk-i7>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-3-code@mmayer.net>
 <20180419041632.GF24576@vireshk-i7>
 <74b70865-dfa9-25c8-20f8-3d2f722b9b2d@arm.com>
 <20180420044259.GA2873@vireshk-i7>
 <d09b1f87-d467-72d0-cb5d-fd747c7e30c8@arm.com>
 <20180420093548.GA2989@vireshk-i7>
 <52044000-513b-b5a1-27db-fb7fdb5ee04f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52044000-513b-b5a1-27db-fb7fdb5ee04f@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-18, 09:50, Florian Fainelli wrote:
> On 04/20/2018 02:35 AM, Viresh Kumar wrote:
> > On 20-04-18, 10:15, Sudeep Holla wrote:
> >> It still doesn't give the flexibility to switch between the two
> >> implementations boot time based on some firmware config(e.g. DT status
> >> property).
> > 
> > I agree, but it didn't look like they need flexibility :)
> > 
> > Lets see how the intend to use it. If they are *always* going to use SCPI if
> > that is available, then it should be solved at Kconfig level only. Else they
> > shouldn't put such code in the driver to quit early.
> 
> We have both drivers (brcmstb-avs-cpufreq and scmi-cpufreq) enabled in
> our kernel configuration, however, depending on the firmware version, we
> may have a number of combinations:
> 
> - arm,scmi DT node is present and enabled (status = okay) as well as
> brcmstb-avs-cpufreq being present and enabled
> - arm,scmi DT node is present but disabled (status = disabled) and
> brcmstb-avs-cpufreq is being present and enabled

In this case the Kconfig thing I have been talking about doesn't apply anymore.

-- 
viresh
