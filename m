Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C829C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D98420824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D98420824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbeKXFQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:16:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbeKXFQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:16:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CBB73618;
        Fri, 23 Nov 2018 10:31:16 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D8823F5CF;
        Fri, 23 Nov 2018 10:31:16 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DBAA21AE1019; Fri, 23 Nov 2018 18:31:32 +0000 (GMT)
Date:   Fri, 23 Nov 2018 18:31:32 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scripts/decodecode: Set ARCH when running natively
 on arm/arm64
Message-ID: <20181123183132.GC21183@arm.com>
References: <20181122121440.74913-1-marc.zyngier@arm.com>
 <20181122121440.74913-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122121440.74913-2-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:14:39PM +0000, Marc Zyngier wrote:
> When running decodecode natively on arm64, ARCH is likely not to be set,
> and we end-up with .4byte instead of .inst when generating the disassembly.
> 
> Similar effects would occur if running natively on a 32bit ARM platform,
> although that's even less popular.
> 
> A simple workaround is to populate ARCH when it is not set and that we're
> running on an arm/arm64 system.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  scripts/decodecode | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
