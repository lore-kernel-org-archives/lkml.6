Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9ADC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FBA2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FBA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbeKTEZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:25:28 -0500
Received: from muru.com ([72.249.23.125]:54530 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbeKTEZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:25:28 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 09A698138;
        Mon, 19 Nov 2018 18:00:54 +0000 (UTC)
Date:   Mon, 19 Nov 2018 10:00:50 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: prm44xx: Fix section annotation on
 omap44xx_prm_enable_io_wakeup
Message-ID: <20181119180050.GS53235@atomide.com>
References: <20181018005400.7521-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018005400.7521-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Chancellor <natechancellor@gmail.com> [181017 17:54]:
> When building the kernel with Clang, the following section mismatch
> warning appears:
> 
> WARNING: vmlinux.o(.text+0x38b3c): Section mismatch in reference from
> the function omap44xx_prm_late_init() to the function
> .init.text:omap44xx_prm_enable_io_wakeup()
> The function omap44xx_prm_late_init() references
> the function __init omap44xx_prm_enable_io_wakeup().
> This is often because omap44xx_prm_late_init lacks a __init
> annotation or the annotation of omap44xx_prm_enable_io_wakeup is wrong.
> 
> Remove the __init annotation from omap44xx_prm_enable_io_wakeup so there
> is no more mismatch.

Applying into omap-for-v4.21/soc thanks.

Tony
