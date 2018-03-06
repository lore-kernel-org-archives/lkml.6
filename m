Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeCFSWY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:22:24 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50978 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbeCFSWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:22:21 -0500
X-Google-Smtp-Source: AG47ELuBdniaxawERUtiA+3FvdecORwtv9txfjfJ3mTDZS57R96TSqUCslAg3dLXY6D/zG9LjBBB5Q==
Date: Tue, 6 Mar 2018 21:22:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kilobyte@angband.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsprintf: distinguish between (null), (err) and
 (invalid) pointer derefs
Message-ID: <20180306182217.GA3798@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define BAD_PTR_STRING(x) (!(x) ? "(null)" : IS_ERR(x) ? "(err)" : "(invalid)")

This is getting ridiculous.

Instead of simply printing a pointer as %08lx or %016llx, not only glibc
(null) stupidity is propagated but expanded and "improved".

I assure you reading 0000000000000000 is just as obvious as (null) and
reading fffffffffffffffa is just as good as -ENOMEM.

In fact printing with hex is more information. Maybe it is important
that buggy pointer is small value but it's value is lost.

Sure don't dereference a pointer for very small or very erry values
but print it without all the bell and whistles.
