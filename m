Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C09C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4061220815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfACKld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:41:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbfACKlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:41:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DB4F80D;
        Thu,  3 Jan 2019 02:41:32 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 276323F5D4;
        Thu,  3 Jan 2019 02:41:30 -0800 (PST)
Date:   Thu, 3 Jan 2019 10:41:27 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, nm@ti.com,
        sboyd@kernel.org, Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Douglas Raillard <Douglas.Raillard@arm.com>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Message-ID: <20190103104127.GB23511@e107155-lin>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
 <20190103103318.GA23511@e107155-lin>
 <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 04:08:29PM +0530, Viresh Kumar wrote:
> On 03-01-19, 10:33, Sudeep Holla wrote:
> > As you already state the checks are unnecessary, if we drop them we don't need
> > to add any firmware specific callbacks. I am thinking if it makes sense to
> > add a generic helper function to remove the OPPs from a device. If we have
> > that any driver needing that can use it. The main reason I think helper is
> > useful is that we need exactly same fix for SCMI driver too.
> >
> > Thoughts ?
>
> Okay, will do that and fix both the drivers as well.
>

Thanks, happy to test here.

--
Regards,
Sudeep
