Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeBRM6M (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 07:58:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55639 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeBRM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 07:58:11 -0500
X-Google-Smtp-Source: AH8x225D0fUlG7kTvzVnpB2gumiNEpIsHusoYG9bOoEZSC5Ucbe5ILVDSeYfGAVuBH82eo1do6gzDQ==
Date: Sun, 18 Feb 2018 13:58:04 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/9] lib/test_printf: Mark big constant with ULL
Message-ID: <20180218125802.lu5abzydm2hwxj5p@ltop.local>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:07:03PM +0200, Andy Shevchenko wrote:
> Sparse complains that constant is so bit for unsigned long on 64-bit
> architecture.
> 
> lib/test_printf.c:217:54: warning: constant 0xffff0123456789ab is so big it is unsigned long
> lib/test_printf.c:246:54: warning: constant 0xffff0123456789ab is so big it is unsigned long
> 
> To satisfy everyone, mark the constant with ULL.

It should be 'UL' not 'ULL' since for architectures a pointer and
a unsigned long have the ame size while on 32bit archs, long long
are (or may?) 64bit.

-- Luc Van Oostenryck
