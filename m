Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeBUU3Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:29:16 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:46691 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:29:14 -0500
X-Google-Smtp-Source: AH8x226x1o+bZXGauSfVgYW55YSNpSl2mBt176tKeqvaji6hHlr2VKUOJPrJoebYv8GSci9hFJWfqw==
Date: Wed, 21 Feb 2018 23:29:11 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        avagin@virtuozzo.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] proc: fix /proc/*/map_files lookup some more
Message-ID: <20180221202911.GC2092@uranus.lan>
References: <20180221184411.GA25924@avx2>
 <20180221185143.GJ30522@ZenIV.linux.org.uk>
 <20180221195340.GA28911@avx2>
 <20180221120403.504b7f1c814618bac39bb78b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221120403.504b7f1c814618bac39bb78b@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:04:03PM -0800, Andrew Morton wrote:
> 
> I don't know this code and I'm all confused.
> 
> - why is the code designed to accept addresses of "0"?

It was never designed to accept addresses of 0, it is rather
a side effect of using sscanf in first place.

The address priting is done via

	len = snprintf(buf, sizeof(buf), "%lx-%lx", p->start, p->end);

> - how do we know that the first digit of a VMA address will never be 0?

It should not be, due to snprintf above.
---

Thanks a lot, Alexey!

Reviewed-by: Cyrill Gorcunov <gorcunov@openvz.org>
