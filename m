Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeEPIQv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:16:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEPIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:16:47 -0400
Date: Wed, 16 May 2018 10:16:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Faerber <afaerber@suse.com>
Subject: Re: [PATCH] Makefile: disable PIE before testing asm goto
Message-ID: <20180516081635.GE12198@hirez.programming.kicks-ass.net>
References: <20180516055136.6F4EAA095A@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516055136.6F4EAA095A@unicorn.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 07:51:36AM +0200, Michal Kubecek wrote:
> Since commit e501ce957a78 ("x86: Force asm-goto"), aarch64 build on
> distributions which enable PIE by default (e.g. openSUSE Tumbleweed) does
> not detect support for asm goto correctly. The problem is that ARM specific
> part of scripts/gcc-goto.sh fails with PIE even with recent gcc versions.
> Moving the asm goto detection up in Makefile put it before the place where
> we disable PIE. As a result, kernel is built without jump label support.

Ugh, that's nasty. Thanks for fixing that.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
