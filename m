Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B01C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50E220C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50E220C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbeGKQKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:10:48 -0400
Received: from foss.arm.com ([217.140.101.70]:39444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeGKQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:10:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFEE17A9;
        Wed, 11 Jul 2018 09:05:47 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3156D3F5B1;
        Wed, 11 Jul 2018 09:05:46 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:05:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
Message-ID: <20180711160540.GA12449@e107155-lin>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
 <20180710213557.GC27827@roeck-us.net>
 <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
 <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
 <20180711153015.GA10578@e107155-lin>
 <20180711153950.GA19932@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711153950.GA19932@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:39:50AM -0700, Guenter Roeck wrote:
> On Wed, Jul 11, 2018 at 04:30:16PM +0100, Sudeep Holla wrote:

[...]

> >
> > Typically new properties needs to registered or discussed in dsd@acpica.org
> > Though there's almost no activity on that list for more than a year now.
> > IIRC, the thread[1] gives kind of agreement that was reached after
> > elaborate discussion on _DSD properties.
> >
>
> I think you are saying that there are no real rules or governing body
> for _DSD properties, that _DSD properties are free for all, subject to no
> scrutiny, that a database with assigned _DSD properties does not exist,
> and that therefore there is no means for me to determine if this is an
> approved property.
>

Yes and no. The only intent of the review on dsd@acpica.org to catch
functional/non-compliance issues with the property. The vendor needs to
own it and ensure the support is added in the kernel before shipping it.

> What prevents someone else to use a different property name for the same
> driver and property next week, on a different product using the same
> hardware ?
>

Honestly nothing. But the agreement was vendor needs to proactively get
it reviewed and add the support. The community can reject if it has
functional/compliance issues.

There has been elaborate discussions in the past on this and I provided
the link to the final agreement on that. It's always better to avoid
using them as first option if possible, else get the review/agreement
that it's good to use property.

--
Regards,
Sudeep
