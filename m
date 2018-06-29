Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F083C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B19278CD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B19278CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeF2RXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:23:25 -0400
Received: from foss.arm.com ([217.140.101.70]:37516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeF2RXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:23:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4505918A;
        Fri, 29 Jun 2018 10:23:24 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 748C63F5AD;
        Fri, 29 Jun 2018 10:23:22 -0700 (PDT)
Date:   Fri, 29 Jun 2018 18:23:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180629172252.GA6906@e107155-lin>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
 <30d56d70-6043-0ad7-4530-208fab18c8d4@arm.com>
 <20180629170334.3ab7ngru3abxcobf@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629170334.3ab7ngru3abxcobf@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 07:03:34PM +0200, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 11:48:15AM -0500, Jeremy Linton wrote:
[..]

> >
> > If you want a human readable socket identifier that matches something
> > stamped above the socket, that is what SMBIOS is for. Queue discussion about
> > that tables reliability for functional ids. Either way, as the spec is
> > written today (or any ECRs I've seen), your definitely not going to get both
> > nice socket1, socket2, and cpu1, cpu2 out of the same PPTT/ACPIid name-space
> > since the numerical id's conflict.
> >
>
> If we don't expect the ACPI processor ID to be something useful to users,
> then I'll revert back to lobbying for counters, as those arbitrary numbers
> can't be less useful than arbitrary offsets and ACPI IDs, and, IMO, are
> more likely to make users/user apps happy.
>

I agree that ACPI processor ID may not be useful to the users, but providing
some counter based ID which is highly dependent on the ordering the firmware
table which can change between boots is highly inconsistent and unreliable
and in some sense break user ABI. So I still NACK the counter based ID.

--
Regards,
Sudeep
