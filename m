Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21B4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFA520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeLMSBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:01:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39562 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeLMSBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:01:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 677B8A78;
        Thu, 13 Dec 2018 10:01:17 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3610C3F575;
        Thu, 13 Dec 2018 10:01:17 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 07AD51AE0838; Thu, 13 Dec 2018 18:01:40 +0000 (GMT)
Date:   Thu, 13 Dec 2018 18:01:40 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/13] ARMv8.3 pointer authentication userspace support
Message-ID: <20181213180140.GA18185@edgewater-inn.cambridge.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181212193544.GB22013@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212193544.GB22013@edgewater-inn.cambridge.arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 07:35:44PM +0000, Will Deacon wrote:
> On Fri, Dec 07, 2018 at 06:39:18PM +0000, Kristina Martsenko wrote:
> > This series adds support for the ARMv8.3 pointer authentication extension,
> > enabling userspace return address protection with GCC 7 and above.
> 
> I've pushed this out to for-next/ptr-auth with the following changes:
> 
>   * Rebased onto for-next/core
>   * Dropped the GET/SET ptrace requests for now, due to fragile regset usage
>   * Moved the user key state from thread_info to thread_struct
>   * Removed use of VA_BITS for the PAC mask (doesn't work with 52-bit user VAs)
>   * Added a patch to use _BITUL for the bit definitions in sysreg.h
>   * Tidied up the HWCAP generation [need to run this past Suzuki]
>   * Reduced the number of CPU caps from 6 to 4 [also need to run past Suzuki]
>   * Added Reviewed-by tags
> 
> I've not merged it into for-next/core yet, because it could use some testing
> and review first.

This is now in for-next/core, so I've removed the for-next/ptr-auth staging
branch.

Will
