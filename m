Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9296BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C7520652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfAPV4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:56:20 -0500
Received: from ms.lwn.net ([45.79.88.28]:52604 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfAPV4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:56:20 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4AB3A2DD;
        Wed, 16 Jan 2019 21:56:19 +0000 (UTC)
Date:   Wed, 16 Jan 2019 14:56:18 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 0/2] LICENSES: Fix fallout from recent SPDX conversions
Message-ID: <20190116145618.6b8e8a81@lwn.net>
In-Reply-To: <20190116102651.489113812@linutronix.de>
References: <20190116102651.489113812@linutronix.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 11:26:51 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Recent SPDX conversions introduced new wreckage:
> 
>  arch/sh/lib/ashiftrt.S: 1:42 Invalid Exception ID: GCC-exception-2.0
>  ...
>  arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt: 1:38 Invalid token: "
>  ,,,
> 
> The first group is due to using an exception identifier without adding the
> exception text to the LICENSES directory.
> 
> The second one is due to the magic conment format in the SuperH bootcode
> files.
> 
> At least the first one could have been caught by checkpatch.pl:
> 
> WARNING: 'SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0' is not supported in LICENSES/...
> #38: FILE: arch/sh/lib/ashiftrt.S:1:
> +/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
> 
> ....
> 
> The following series addresses both issues.

I've applied both to the docs tree, thanks.

jon
