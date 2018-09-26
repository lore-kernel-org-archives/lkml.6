Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F57220843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F57220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeIZVBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:01:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47922 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeIZVBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:01:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE98A18A;
        Wed, 26 Sep 2018 07:48:36 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C0733F5BD;
        Wed, 26 Sep 2018 07:48:32 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:48:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Message-ID: <20180926144830.GB25838@e107155-lin>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:42:15PM +0300, Georgi Djakov wrote:
> Hi Rob,
> 
> Thanks for the comments!
> 
> On 09/25/2018 09:02 PM, Rob Herring wrote:
> > On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
> >> This binding is intended to represent the relations between the interconnect
> >> controllers (providers) and consumer device nodes. It will allow creating links
> >> between consumers and interconnect paths (exposed by interconnect providers).
> > 
> > As I mentioned in person, I want to see other SoC families using this 
> > before accepting. They don't have to be ready for upstream, but WIP 
> > patches or even just a "yes, this works for us and we're going to use 
> > this binding on X".
> 
> Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
> currently using this binding, there is ongoing work from at least two
> other vendors that would be using this same binding. I will check on
> what is their progress so far.
> 
> > Also, I think the QCom GPU use of this should be fully sorted out. Or 
> > more generically how this fits into OPP binding which seems to be never 
> > ending extended...
> 
> I see this as a further step. It could be OPP binding which include
> bandwidth values or some separate DT property. Jordan has already
> proposed something, do you have any initial comments on that?

I am curious as how this fits into new systems which have firmware driven
CPUFreq and other DVFS. I would like to avoid using this in such systems
and leave it upto the firmware to scale the bus/interconnect based on the
other components that are connected to it and active.

--
Regards,
Sudeep
