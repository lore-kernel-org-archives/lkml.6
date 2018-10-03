Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A76DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8722089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8722089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJCQVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:21:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeJCQVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24CEA18A;
        Wed,  3 Oct 2018 02:33:57 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1179E3F5B7;
        Wed,  3 Oct 2018 02:33:52 -0700 (PDT)
Date:   Wed, 3 Oct 2018 10:33:46 +0100
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
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Message-ID: <20181003093346.GA12570@e107155-lin>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
 <20180926144830.GB25838@e107155-lin>
 <fa74c24f-1f22-f11f-60fe-5a4489d9c7c2@codeaurora.org>
 <20181002111758.GC1086@e107155-lin>
 <c17450ce-fc25-e792-b91b-51106f032542@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c17450ce-fc25-e792-b91b-51106f032542@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:56:56AM -0700, Saravana Kannan wrote:
> 
> On 10/02/2018 04:17 AM, Sudeep Holla wrote:

[...]

> > Yes, I do understand I have made the same point multiple time and it's
> > intentional. We need to get the fragmented f/w support story fixed.
> > Different ARM vendors are doing different things in f/w and ARM sees the
> > same fragmentation story as before. We have come up with new specification
> > and my annoying multiple emails are just to constantly remind the same.
> > 
> > I do understand we have existing implementations to consider, but fixing
> > the functionality in arbitrary way is not a good design and it better
> > to get them fixed for future.
> 
> I believe the fragmentation you are referring to is  in the
> interface/communication protocol. I see the benefit of standardizing that as
> long as the standard actually turns out to be good. But that's completely
> separate from what the FW can/can't do. Asking to standardize what the FW
> can/can't do doesn't seem realistic as each chip vendor will have different
> priorities - power, performance, cost, chip area, etc. It's the conflation
> of these separate topics that doesn't help IMHO.

I agree on interface/communication protocol fragmentation and firmware
can implement whatever the vendor wish. What I was also referring was
the mix-n-match approach which should be avoided.

e.g. Device A and B's PM is managed completely by firmware using OSPM hints
Suppose Device X's PM is dependent on Device A and B, in which case it's
simpler and cleaner to leave Device X PM to firmware. Reading the state
of A and B and using that as hint for X is just overhead which firmware
can manage better. That was my main concern here: A=CPU and B=some other
device and X is inter-connect to which A and B are connected.

If CPU OPPs are obtained from f/w and this inter-connect from DT, mapping
then is a mess and that's what I was concerned. I am sorry if that's not
the scenario here, I may have mistaken then.

--
Regards,
Sudeep
