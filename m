Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44634C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BE621529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BE621529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeHXS67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:58:59 -0400
Received: from foss.arm.com ([217.140.101.70]:60536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeHXS66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:58:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E90EAED1;
        Fri, 24 Aug 2018 08:23:49 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA76B3F5BC;
        Fri, 24 Aug 2018 08:23:48 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:23:46 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] kmemleak: Always register debugfs file
Message-ID: <20180824152345.hebdwpatberaah3a@armageddon.cambridge.arm.com>
References: <20180824131220.19176-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824131220.19176-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:12:20PM +0200, Vincent Whitchurch wrote:
> If kmemleak built in to the kernel, but is disabled by default, the
> debugfs file is never registered.  Because of this, it is not possible
> to find out if the kernel is built with kmemleak support by checking for
> the presence of this file.  To allow this, always register the file.
> 
> After this patch, if the file doesn't exist, kmemleak is not available
> in the kernel.  If writing "scan" or any other value than "clear" to
> this file results in EBUSY, then kmemleak is available but is disabled
> by default and can be activated via the kernel command line.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

I think that's also consistent with a late disabling of kmemleak when
the debugfs entry sticks around.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
