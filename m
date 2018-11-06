Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4693EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE112081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE112081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbeKFX05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:26:57 -0500
Received: from foss.arm.com ([217.140.101.70]:34126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730421AbeKFX05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:26:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2EE280D;
        Tue,  6 Nov 2018 06:01:34 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DB393F5BD;
        Tue,  6 Nov 2018 06:01:33 -0800 (PST)
Date:   Tue, 6 Nov 2018 14:01:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        matthew.brown.dev@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lib/raid6: Fix arm64 test build
Message-ID: <20181106140130.GC71046@arrakis.emea.arm.com>
References: <20181106001441.42934-1-jeremy.linton@arm.com>
 <CAKv+Gu_i_Oaee_JTEuVd+yVsSzj-_ULUKp_NmMGT3Xh+oQBZKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_i_Oaee_JTEuVd+yVsSzj-_ULUKp_NmMGT3Xh+oQBZKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 09:16:04AM +0100, Ard Biesheuvel wrote:
> (+ Catalin, Will)
> 
> On 6 November 2018 at 01:14, Jeremy Linton <jeremy.linton@arm.com> wrote:
> > The lib/raid6/test fails to build the neon objects
> > on arm64 because the correct machine type is 'aarch64'.
> >
> > Once this is correctly enabled, the neon recovery objects
> > need to be added to the build.
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I can pick this up for 4.20-rc2 (I can't find a maintainers entry for
this Makefile).

-- 
Catalin
