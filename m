Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525CDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198A520879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198A520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbeLNJv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:51:58 -0500
Received: from foss.arm.com ([217.140.101.70]:47918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeLNJv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:51:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4095380D;
        Fri, 14 Dec 2018 01:51:57 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 111AE3F614;
        Fri, 14 Dec 2018 01:51:57 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 2F47B1AE0DFC; Fri, 14 Dec 2018 09:51:56 +0000 (GMT)
Date:   Fri, 14 Dec 2018 09:51:56 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: replace arm64-obj-* in Makefile with obj-*
Message-ID: <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
References: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Fri, Dec 14, 2018 at 01:01:52PM +0900, Masahiro Yamada wrote:
> Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
> same.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)

I'm fine with this patch, but I think I'd prefer to apply it at -rc1 so
we don't end up with lots of silly conflicts in the Makefile for any new
files added during the merge window.

Is that ok with you?

Will
