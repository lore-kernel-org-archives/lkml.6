Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85035C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CD625038
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CD625038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936839AbeF2P4G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:56:06 -0400
Received: from foss.arm.com ([217.140.101.70]:36420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936157AbeF2P4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:56:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 267D218A;
        Fri, 29 Jun 2018 08:56:01 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AADD3F5C0;
        Fri, 29 Jun 2018 08:55:59 -0700 (PDT)
Date:   Fri, 29 Jun 2018 16:55:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, ard.biesheuvel@linaro.org,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180629155556.GD16282@e107155-lin>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:46:08PM +0200, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:

[..]

> > 
> > How is that different from OS generated one from user's perspective ?
> > Vendors might assign sockets UID and he may help them to replace one.
> > Having some generated counter based id is not helpful.
> 
> I agree with this. It's a good argument for maintaining a mapping of
> package-id to id-physically-printed-on-a-package somewhere. To avoid
> maintaining a mapping it could just be stored directly in
> cpu_topology[cpu].package_id, but then how can we tell the difference
> between a valid printed-on-package-id and an ACPI offset? We'd still
> have to maintain additional state to determine if it's valid or not,
> so we could just maintain a mapping instead.
> 

x86 may have a architectural way to obtain it and hence they don't need
to rely on PPTT. But for ARM, we need to rely on PPTT for it and if
vendors/users need accurate information, it has to come from PPTT and
any other place is never going to be consistent and hence unusable.
So, even though specification doesn't mandate, I think OS should as it's
the only robust way. We can get the firmware fixed/updated if random
unique number hurts. Firmware is not upgradeable is no longer a valid
argument.

-- 
Regards,
Sudeep
