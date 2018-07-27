Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA959C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4898920671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4898920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeG0Gvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:51:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53052 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeG0Gvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:51:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B141620741; Fri, 27 Jul 2018 07:31:37 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7E8692072C;
        Fri, 27 Jul 2018 07:31:37 +0200 (CEST)
Date:   Fri, 27 Jul 2018 07:31:37 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ia64: use asm-generic/io.h
Message-ID: <20180727073137.58668bf2@bbrezillon>
In-Reply-To: <20180711120824.3882108-1-arnd@arndb.de>
References: <20180711120824.3882108-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 11 Jul 2018 14:08:05 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> asm-generic/io.h provides a generic implementation of all I/O accessors,
> which the architectures can override.
> 
> Since ia64 does not provide readsl/writesl etc, any driver using those
> fails to build, and including asm-generic/io.h will provide the
> missing interfaces, as well as any other future interfaces that get
> added there. We need to #define a couple of symbols to themselves
> in the ia64 to ensure that we use the ia64 specific version of those
> rather than the generic one.
> 
> There should be no other effect than adding {read,write}s{b,w,l}()
> as well as {in,out}s{b,w,l}_p(), which were also not provided
> by ia64 but are provided by the generic header for historic reasons.
> 

Kbuild robots reported the same problem on parisc an alpha :-/.

Regards,

Boris
