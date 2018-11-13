Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA35C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31799223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31799223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbeKNDcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:32:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60114 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbeKNDcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:32:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02133EBD;
        Tue, 13 Nov 2018 09:33:07 -0800 (PST)
Received: from e107533-lin (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B83813F5CF;
        Tue, 13 Nov 2018 09:33:06 -0800 (PST)
Date:   Tue, 13 Nov 2018 17:33:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     marc.w.gonzalez@free.fr, arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
Message-ID: <20181113173300.GA8432@e107533-lin>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
 <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
 <20181108093617.GB8433@e107155-lin>
 <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 09:57:27AM +0100, Arnd Bergmann wrote:
> On Thu, Nov 8, 2018 at 10:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
> > > Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> > > dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
> > >
> >
> > Looks good,
> >
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > But I left it intentionally to avoid churn assuming it will go away when
> > ARM SoC team runs savedefconfig and sync the defconfig.
>
> I would never do that, instead I want patches like the one that Marc sent
> in order to make sure we don't accidentally drop anything that is still
> required, e.g. when an option got renamed or gained a dependency.
>
Thanks for the clarification. I must have misunderstood what's done in
Commit c432c0880596 ("arm64: defconfig: renormalize based on recent additions")
I assume it was just the reordering rather than addition/removal of entries.
It's not so clear from the log message.

--
Regards,
Sudeep
