Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE9C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0541C21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGahK594"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392001AbeLUVRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:17:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36009 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388463AbeLUVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:17:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so4850025lfg.3;
        Fri, 21 Dec 2018 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nw6acrcLU19Xw4fdc5+xJxz54d3g4VoJ0jU4KWrfj3c=;
        b=AGahK594YjAUkXRnXRBBtoKpmGll80LGkMJ0kZBqIanHTV6LDZb3hfH/K2wQrCo2dH
         JxsDmdm0ltK9Jv+y4mDSw4tPtOiBTl0nTrcKfQAB6b7C4QiMs0+rz8ymDpZN6ipXKwL6
         jbGQpQGfrIYLQPYHjHvOC2vnIIA7ITzu5oLNT2J7j3OhZC/SiZrToeWr4J40DJGYg6Yy
         0tU3CPKCLsKNEZg3chO52UIDarV51GgkmJbDMxzcS+cRC+G746vtc7LoVWdaVfQjiHP7
         f+PwvQBvQb7kih3n/rvcVtIbWU7UBeEeWxpHJE0iXenXm8xAQDafXiKQYOAsBcvXc4Rp
         eWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nw6acrcLU19Xw4fdc5+xJxz54d3g4VoJ0jU4KWrfj3c=;
        b=cLyE9/NzNk6Q1uLq0otzqMypAKihGpUBgFgdDBwYWyRdLMF0bFXnWU53/tsQ+yfjgQ
         jXzf3az4Fxe0S9W9pcr3uLTbHkMKHi7h39E5DsVnyuD+OxHTS/FuGYJGuraTkJWU5K7T
         HrZlNYbhlSbxRd35NjattFNdNWckdNiVDshqs+Wtr+OuR7MhRqh4XC4/3+gwMeJ8xSFX
         egwxGPUpiLgvjyGIjxT1W5jzgrQq0zXV+I0Yki4uxqzIY5HURibEhh7EE+Qh4KtQFaY9
         +fVt/3qzDr8HEfM/imVmUTXPkxZEhW2LUkWz7Cdf30uSQueykMp9dhyugihytWxgoWoN
         ovLg==
X-Gm-Message-State: AA+aEWaGc/MmP43hsL6jT/WJ0pircZIJKXO3olugo6QK+pL/w+I95eID
        6FLU9isGIlBetA6uRGfBFu0=
X-Google-Smtp-Source: AFSGD/WcJhnykNupqVa5TdIns8nUNKv+NqRWKvwbWzQ+qmGBpRZXhnl5GH/5uBu8VpBAmYjuwziAjQ==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr2227221lfb.121.1545427062174;
        Fri, 21 Dec 2018 13:17:42 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id s20sm4963537lfb.51.2018.12.21.13.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 13:17:40 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id EE823460769; Sat, 22 Dec 2018 00:17:39 +0300 (MSK)
Date:   Sat, 22 Dec 2018 00:17:39 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] x86_64: memset_user()
Message-ID: <20181221211739.GD8441@uranus>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-2-igor.stoppa@huawei.com>
 <20181221182515.GF10600@bombadil.infradead.org>
 <20181221200546.GA8441@uranus>
 <20181221202946.GJ10600@bombadil.infradead.org>
 <20181221204616.GC8441@uranus>
 <20181221210721.GK10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221210721.GK10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 01:07:21PM -0800, Matthew Wilcox wrote:
> On Fri, Dec 21, 2018 at 11:46:16PM +0300, Cyrill Gorcunov wrote:
> > Cast to unsigned char is needed in any case. And as far as I remember
> > we've been using this multiplication trick for a really long time
> > in x86 land. I'm out of sources right now but it should be somewhere
> > in assembly libs.
> 
> x86 isn't the only CPU.  Some CPUs have slow multiplies but fast shifts.

This is x86-64 patch, not some generic code.

> Also loading 0x0101010101010101 into a register may be inefficient on
> some CPUs.

It is pretty efficient on x86-64. Moreover the self dependents as
a |= a << b is a source for data hazards inside cpu engine. Anyway
i'm not going to insist, just wanted to remind about such trick.
Up to you what to choose.
