Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B160FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F82146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704F82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbeKTEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:25:02 -0500
Received: from muru.com ([72.249.23.125]:54510 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbeKTEZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:25:01 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 78EA380B6;
        Mon, 19 Nov 2018 18:00:28 +0000 (UTC)
Date:   Mon, 19 Nov 2018 10:00:24 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix some section annotations
Message-ID: <20181119180024.GR53235@atomide.com>
References: <20181018005207.7201-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018005207.7201-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Chancellor <natechancellor@gmail.com> [181017 17:52]:
> When building the kernel with Clang, the following section mismatch
> warnings appears:
> 
> WARNING: vmlinux.o(.text+0x2d398): Section mismatch in reference from
> the function _setup() to the function .init.text:_setup_iclk_autoidle()
> The function _setup() references
> the function __init _setup_iclk_autoidle().
> This is often because _setup lacks a __init
> annotation or the annotation of _setup_iclk_autoidle is wrong.
...

Applying into omap-for-v4.21/soc thanks.

Tony
