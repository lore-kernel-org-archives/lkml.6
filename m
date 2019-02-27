Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19657C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7720217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="da0cKwWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfB0TpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:45:20 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37888 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbfB0TpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:45:20 -0500
Received: by mail-vk1-f193.google.com with SMTP id x140so4149918vke.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/I963yzAOICZO0m49NrabGWLqzNwIfBiMpnSzlw1yY=;
        b=da0cKwWX8l7yd2DZHszZmYocwlUEn3Kx4H9UjfO4IOVU2w2q3cuX8KglUdeRluO+Q8
         1+pyrpwq3OhnVsk8dYXueikskWJVapM22r+65sWBZIFEEfyY6dF82iDOmQuLxj6vdsrK
         TRokUsOGB2GkdzB3NF2vC7lZ1Xn0D4uCdyJ78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/I963yzAOICZO0m49NrabGWLqzNwIfBiMpnSzlw1yY=;
        b=FrOHFhRnrAPjjeI2YE1OMG4XO4rHzHkc9TDNIwBA5X7LZvql1uy8B1e1Mv0qnr1ngq
         KkCkKmJNeN4p2xxr3d+BAegt9uJzFqJPz2SJxvgF0AV5HPG7x7iYmFXzbF+ogl40artg
         rjDgTb7ktb7GzzIKm/SI5UrUfkoZWScBlEyMC6NOGSpu8MLthNlGR4S8RJfucED8FOi7
         leTNFEZHdIuNLTPL1hXkqYh3ZGkup00HYdintFf6rTbxpGmKkIwZpvHLs24Kyb4ePXVg
         WQWXrsjNJVrG3WOIECUjDseL1F1Z/YqEdOQrfcNo0rXChlAG4WfSQwIsokEFRZbEoi2N
         x2Xw==
X-Gm-Message-State: AHQUAuY0J9fSyn0+OnMg78VfSRNUj4Gf1gonbUK8/zM8Drrnk4xGoxda
        LK4ZJN4NsSBQIXAMKKAz8u3he0gKKPM=
X-Google-Smtp-Source: AHgI3IYF1xyHl+4qitb9veW7FBOPk95uygTzwfbRkghZ4wmPbGMZj2hk6uQcAj/nu1Cz9aCxwVAkrw==
X-Received: by 2002:a1f:d9c5:: with SMTP id q188mr1648498vkg.28.1551296717465;
        Wed, 27 Feb 2019 11:45:17 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id c6sm14188022vkf.45.2019.02.27.11.45.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:45:15 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id j7so1751116uak.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:45:15 -0800 (PST)
X-Received: by 2002:a67:89c9:: with SMTP id l192mr2730926vsd.188.1551296715168;
 Wed, 27 Feb 2019 11:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226233647.28547-1-keescook@chromium.org> <20190226233647.28547-2-keescook@chromium.org>
 <20190227104407.GA18804@openwall.com>
In-Reply-To: <20190227104407.GA18804@openwall.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Feb 2019 11:45:03 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+vBURRz2aUafmOY9nJ56Sr-YonvhE8OGJ+6QkOQe5ePQ@mail.gmail.com>
Message-ID: <CAGXu5j+vBURRz2aUafmOY9nJ56Sr-YonvhE8OGJ+6QkOQe5ePQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/asm: Pin sensitive CR0 bits
To:     Solar Designer <solar@openwall.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 2:44 AM Solar Designer <solar@openwall.com> wrote:
>
> On Tue, Feb 26, 2019 at 03:36:45PM -0800, Kees Cook wrote:
> >  static inline void native_write_cr0(unsigned long val)
> >  {
> > -     asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
> > +     bool warn = false;
> > +
> > +again:
> > +     val |= X86_CR0_WP;
> > +     /*
> > +      * In order to have the compiler not optimize away the check
> > +      * in the WARN_ONCE(), mark "val" as being also an output ("+r")
>
> This comment is now slightly out of date: the check is no longer "in the
> WARN_ONCE()".  Ditto about the comment for CR4.

Ah yes, good point. I will adjust and send a v2 series.

>
> > +      * by this asm() block so it will perform an explicit check, as
> > +      * if it were "volatile".
> > +      */
> > +     asm volatile("mov %0,%%cr0": "+r" (val) : "m" (__force_order) : );
> > +     /*
> > +      * If the MOV above was used directly as a ROP gadget we can
> > +      * notice the lack of pinned bits in "val" and start the function
> > +      * from the beginning to gain the WP bit for sure. And do it
> > +      * without first taking the exception for a WARN().
> > +      */
> > +     if ((val & X86_CR0_WP) != X86_CR0_WP) {
> > +             warn = true;
> > +             goto again;
> > +     }
> > +     WARN_ONCE(warn, "Attempt to unpin X86_CR0_WP, cr0 bypass attack?!\n");
> >  }
>
> Alexander

-- 
Kees Cook
