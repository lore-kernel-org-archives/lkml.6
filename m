Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BECC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A1B2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A1B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbeKQMlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:41:55 -0500
Received: from foss.arm.com ([217.140.101.70]:35010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbeKQMlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:41:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BD0A78;
        Fri, 16 Nov 2018 18:27:00 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12883F5A0;
        Fri, 16 Nov 2018 18:26:59 -0800 (PST)
Date:   Sat, 17 Nov 2018 02:26:57 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
Message-ID: <20181117022656.GB2470@brain-police>
References: <20181117015456.101222-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117015456.101222-1-olof@lixom.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Fri, Nov 16, 2018 at 05:54:56PM -0800, Olof Johansson wrote:
> Makes sparse happy. Before:
> 
> arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm64/include/asm/sysreg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The warning is bogus imo, but since it's harmless to fix it then we can do
that. However, you've been beaten by:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/613179.html

Will
