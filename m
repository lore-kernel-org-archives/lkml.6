Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D669DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA8E218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns64+bku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfBZXRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:17:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34710 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfBZXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:17:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id a16so12331156edn.1;
        Tue, 26 Feb 2019 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F/ZWUspDnO9H+N1b+3KaSbEisQ9DROKLGDc6Wk9zF/Q=;
        b=Ns64+bkuLm12DoKtMqYvm9spiyuFy91esqRW620Tr8a7c6yO/zBoKktXkM25pJWO7N
         KYZHrHySgbKp0ukEqgvOhVKztZuddf20j5XWcS8omSkG42v0aRxVNYrlBxPtJ5MKsME7
         ICL0xa9DMOfylbdIxpEwAZmOFNWw8UhcTBw6asiXQj4RekvDc6+JweuyVSjAgI3eHELu
         vrpNWsBvdmFuFoBrNOxVtfbPgEBXp3J4Y4DdxNVAhdJW9HKxxO6kJVWQ6cQR3MOt6yFp
         sJZMlrFYPfy5nxUdukFrBbjcMPSYdZIfmqc7x6DDDKYm9VEv7xqnU2PBR6i514uULX4k
         dhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F/ZWUspDnO9H+N1b+3KaSbEisQ9DROKLGDc6Wk9zF/Q=;
        b=PInyJwQ3bxoIhfe6qFrVbVSVhuzdQVNxRMZDpbXkTKEebgurTmJumQhrEb/oWjqxVP
         bTOnbTH3yNvwQWcBxETP2IeoCODFdPSsycThk/kPg8IJ+ezriGbaOLu4JgDNYjj7jRmW
         5+bW/asmJQ4AWWxsoVMe91LxyEaQujMYOBV9oit2RO3m5UF1ivb6S0OwSlz70pTfKz+d
         5xmoZMz9+qICnRl4WfXxTps7H+L2p1HGpa42zMQvxnC7www6T/dvxmmjbWqEVmy0BDDB
         Y1SZjsGX9KbdErHqBAbj3waXdSbOFLBN1VM4n2lRaAv0MCZxf7dYz9Uex5jVcjpS2dWw
         66Ow==
X-Gm-Message-State: AHQUAuZbox7xhCX0UPBwsCUwTYZ+9PDratzLpN+Y3I2J9OAiShLcKNW8
        MVVSaKC0E7Y4FQn7jcTv/Rw=
X-Google-Smtp-Source: AHgI3IY1BbDU8p0Py+W8Y6W1UeY89PQP3LwkVqNuoCAqT9ACsIxnL06lQwM6hryAvvVGWelTdqrUAA==
X-Received: by 2002:a50:ca41:: with SMTP id e1mr3769377edi.73.1551223071600;
        Tue, 26 Feb 2019 15:17:51 -0800 (PST)
Received: from ltop.local ([2a02:a03f:4034:3c00:69ad:1253:f4b5:5458])
        by smtp.gmail.com with ESMTPSA id fy6sm2459233ejb.52.2019.02.26.15.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 15:17:50 -0800 (PST)
Date:   Wed, 27 Feb 2019 00:17:49 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Message-ID: <20190226231747.z3lc6yr6xmrw5q2z@ltop.local>
References: <cover.1550839937.git.andreyknvl@google.com>
 <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
 <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 06:18:25PM +0100, Andrey Konovalov wrote:
> On Fri, Feb 22, 2019 at 11:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > > The following testing approaches has been taken to find potential issues
> > > with user pointer untagging:
> > >
> > > 1. Static testing (with sparse [3] and separately with a custom static
> > >    analyzer based on Clang) to track casts of __user pointers to integer
> > >    types to find places where untagging needs to be done.
> >
> > First of all, it's really cool that you took this approach.  Sounds like
> > there was a lot of systematic work to fix up the sites in the existing
> > codebase.
> >
> > But, isn't this a _bit_ fragile going forward?  Folks can't just "make
> > sparse" to find issues with missing untags.
> 
> Yes, this static approach can only be used as a hint to find some
> places where untagging is needed, but certainly not all.
> 
> > This seems like something
> > where we would ideally add an __tagged annotation (or something) to the
> > source tree and then have sparse rules that can look for missed untags.
> 
> This has been suggested before, search for __untagged here [1].
> However there are many places in the kernel where a __user pointer is
> casted into unsigned long and passed further. I'm not sure if it's
> possible apply a __tagged/__untagged kind of attribute to non-pointer
> types, is it?
> 
> [1] https://patchwork.kernel.org/patch/10581535/

It's something that should need to be added to sparse since it's
different from what sparse already have (the existing __bitwise and
concept of address-space doesn't seem to do the job here).

-- Luc Van Oostenryck
