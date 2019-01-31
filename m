Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CBC20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfAaRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:54:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48818 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaRym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:54:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E59DFEBD;
        Thu, 31 Jan 2019 09:54:41 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 806C13F59C;
        Thu, 31 Jan 2019 09:54:39 -0800 (PST)
Date:   Thu, 31 Jan 2019 17:54:36 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Subject: Re: [PATCH v4 08/12] arm64: Advertise mitigation of Spectre-v2, or
 lack thereof
Message-ID: <20190131175436.1c24f7b8@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-9-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
        <20190125180711.1970973-9-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:07:07 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> We currently have a list of CPUs affected by Spectre-v2, for which
> we check that the firmware implements ARCH_WORKAROUND_1. It turns
> out that not all firmwares do implement the required mitigation,
> and that we fail to let the user know about it.
> 
> Instead, let's slightly revamp our checks, and rely on a whitelist
> of cores that are known to be non-vulnerable, and let the user know
> the status of the mitigation in the kernel log.

Yeah, this looks better, I was scratching my head about that
blacklist already.

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> [This makes more sense in front of the sysfs patch]
> [Pick pieces of that patch into this and move it earlier]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

> ---  arch/arm64/kernel/cpu_errata.c | 104 +++++++++++++++++----------------
> 1 file changed, 54 insertions(+), 50 deletions(-)
> 
....
