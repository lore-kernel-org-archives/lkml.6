Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8076CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3922B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeKAX0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:26:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57096 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeKAX0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:26:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BDE7A78;
        Thu,  1 Nov 2018 07:22:52 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1E63F5D3;
        Thu,  1 Nov 2018 07:22:50 -0700 (PDT)
Date:   Thu, 1 Nov 2018 14:22:47 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, rafael.j.wysocki@intel.com,
        takahiro.akashi@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        ahs3@redhat.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
Message-ID: <20181101142247.GB27913@e107155-lin>
References: <20181012192937.3819951-1-jeremy.linton@arm.com>
 <20181101113136.GA6608@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101113136.GA6608@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:31:36AM +0000, Lorenzo Pieralisi wrote:
> On Fri, Oct 12, 2018 at 02:29:37PM -0500, Jeremy Linton wrote:
> > The BAD_MADT_GICC_ENTRY check is a little too strict because
> > it rejects MADT entries that don't match the currently known
> > lengths. We should remove this restriction to avoid problems
> > if the table length changes. Future code which might depend on
> > additional fields should be written to validate those fields
> > before using them, rather than trying to globally check
> > known MADT version lengths.
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  arch/arm64/include/asm/acpi.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Hi Jeremy,
>
> I assume there is no [PATCH 1/2] (to make sure I have not missed
> anything).
>

IIRC, it's a patch fixing module device table entry for SPE. They are
independent, just happened to be put out together.

--
Regards,
Sudeep
