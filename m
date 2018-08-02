Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26256C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8988214DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8988214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbeHBMrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:47:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55742 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbeHBMrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:47:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74832ED1;
        Thu,  2 Aug 2018 03:57:03 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46BB93F5D0;
        Thu,  2 Aug 2018 03:57:03 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id BF0061AE30FD; Thu,  2 Aug 2018 11:57:05 +0100 (BST)
Date:   Thu, 2 Aug 2018 11:57:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: fix compiler warning in arm_pmu_device_probe
Message-ID: <20180802105705.GB14312@arm.com>
References: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:45:26AM +1200, Chris Packham wrote:
> GCC warns
> 
>   arm_pmu_platform.c:234:5: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This is because we rely on the for_each_cpu loop in armpmu_request_irqs
> to initialise err. The warning is a little bogus because we know if
> there were 0 CPUs this code would not be running.
> 
> Initialise err to 0 to avoid the warning.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> This has been reported before in https://lkml.org/lkml/2018/3/5/508 I'm not
> sure if it was dismmissed as "meh, gcc is wrong" or if it was just wainting for
> someone with some round tuits.

Which version of GCC are you using? I don't see this warning locally.

Will
