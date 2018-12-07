Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA82C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052DE2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052DE2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLGROv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:14:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeLGROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:14:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D03715AB;
        Fri,  7 Dec 2018 09:14:50 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D7933F5AF;
        Fri,  7 Dec 2018 09:14:45 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:14:40 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after
 cmd_db API change
Message-ID: <20181207171437.qmtacurmqg53zzkl@queper01-lin>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-9-georgi.djakov@linaro.org>
 <20181207162733.pdd62qvqzd6xk4nr@queper01-lin>
 <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 Dec 2018 at 18:47:22 (+0200), Georgi Djakov wrote:
> Hi Quentin,
> 
> On 12/7/18 18:27, Quentin Perret wrote:
> > Hi Georgi,
> > 
> > On Friday 07 Dec 2018 at 17:29:17 (+0200), Georgi Djakov wrote:
> >> Recently the cmd_db_read_aux_data() function was changed to avoid using
> >> memcpy and return a pointer instead. Update the code to the new API and
> >> fix the build failure.
> >>
> >> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
> > 
> > IIUC this file is introduced by patch 5. Should the fix be squashed
> > into patch 5 directly ? Just to keep things bisectable.
> 
> The reason why i have split it as a separate change is because as a
> separate change it would be easier to review & test for the people who
> are already familiar with the rest of the series.
> 
> Another minor reason is that a separate patch will also make the life a
> bit easier for some people who are back-porting this to kernels using
> the older version of the cmd_db API.
> 
> The commit that changed the cmd_db API is not yet in mainline, but in
> linux-next. I am not sure what is preferred in this case?

Not sure either but I guess that will depend who gets merged first ...
If that's the cmd_db change, then you'll need to squash your fix in
patch 5. If your series goes first, then the fix needs to be applied to
the cmb_db change.

I personally don't mind either way as long as we don't break bisection :-)

Thanks,
Quentin
