Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F87C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16457206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16457206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeJBSAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:00:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbeJBSAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:00:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9657E7A9;
        Tue,  2 Oct 2018 04:18:05 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 735943F5B7;
        Tue,  2 Oct 2018 04:18:01 -0700 (PDT)
Date:   Tue, 2 Oct 2018 12:17:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Message-ID: <20181002111758.GC1086@e107155-lin>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
 <20180926144830.GB25838@e107155-lin>
 <fa74c24f-1f22-f11f-60fe-5a4489d9c7c2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa74c24f-1f22-f11f-60fe-5a4489d9c7c2@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:49:32PM -0700, Saravana Kannan wrote:
> On 09/26/2018 07:48 AM, Sudeep Holla wrote:
> > On Wed, Sep 26, 2018 at 05:42:15PM +0300, Georgi Djakov wrote:
> > > Hi Rob,
> > > 
> > > Thanks for the comments!
> > > 
> > > On 09/25/2018 09:02 PM, Rob Herring wrote:
> > > > On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
> > > > > This binding is intended to represent the relations between the interconnect
> > > > > controllers (providers) and consumer device nodes. It will allow creating links
> > > > > between consumers and interconnect paths (exposed by interconnect providers).
> > > > As I mentioned in person, I want to see other SoC families using this
> > > > before accepting. They don't have to be ready for upstream, but WIP
> > > > patches or even just a "yes, this works for us and we're going to use
> > > > this binding on X".
> > > Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
> > > currently using this binding, there is ongoing work from at least two
> > > other vendors that would be using this same binding. I will check on
> > > what is their progress so far.
> > > 
> > > > Also, I think the QCom GPU use of this should be fully sorted out. Or
> > > > more generically how this fits into OPP binding which seems to be never
> > > > ending extended...
> > > I see this as a further step. It could be OPP binding which include
> > > bandwidth values or some separate DT property. Jordan has already
> > > proposed something, do you have any initial comments on that?
> > I am curious as how this fits into new systems which have firmware driven
> > CPUFreq and other DVFS. I would like to avoid using this in such systems
> > and leave it upto the firmware to scale the bus/interconnect based on the
> > other components that are connected to it and active.
> > 
> 
> You've made the same point multiple times across different patch sets. Not
> all FW can do arbitrary functions. A lot of them are very limited in their
> capabilities. So, as much as you and I would like to let the FW do the work,
> it's not always possible. So, in those cases, we do need to have support for
> the kernel scaling the interconnects correctly. Hopefully this clears up
> your questions about FW capabilities.

Yes, I do understand I have made the same point multiple time and it's
intentional. We need to get the fragmented f/w support story fixed.
Different ARM vendors are doing different things in f/w and ARM sees the
same fragmentation story as before. We have come up with new specification
and my annoying multiple emails are just to constantly remind the same.

I do understand we have existing implementations to consider, but fixing
the functionality in arbitrary way is not a good design and it better
to get them fixed for future.

--
Regards,
Sudeep
