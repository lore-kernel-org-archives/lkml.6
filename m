Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0892C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972E220864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJdLgQXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972E220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbeKVSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:23:16 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52915 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbeKVSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:23:15 -0500
Received: by mail-wm1-f53.google.com with SMTP id r11-v6so7855359wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6yY/lCtm4vceGoXi6Z7QaJMba46cENnJPnOY7yEo+Mo=;
        b=FJdLgQXI1PkNb71euVGHhXwNwZzSqg4unyb2S5WDnA1m1J2IzjdgcMghLgTepofW19
         4DxpXDM3fJyBmfY+J3FmtpG/gE10EG2+v+7TWjeVJiLSQL4T+PGPs+LuGtjeAWJo34nk
         pNWz1aI313uCdRzxPxy+7ofvF8GkN9cJUkaf8R37bevYBgtEYH0hx43gb/q6wK9p0Ibv
         X+idb+0LWVP5lprPPiJ/mHgZOeOFcYGyQkHpMlrgEAV6GA5Wd4M5vx1c7nqsC1KgGzKf
         Qv3QBzz70x8dU4atbUz7JHWa2YS/qFAqDZFRxlWe1EY9v/sW/IjaMkP1g9xxHiIQcpOv
         unrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6yY/lCtm4vceGoXi6Z7QaJMba46cENnJPnOY7yEo+Mo=;
        b=tNIfBZL5tk3zyDagLe1NYCDUc5y8mEXzGwCstDbi9RO2ovZSJgvRlEix6GdXgf4jFm
         uTzixz90oSqTyKo1j2SeLIfWUBKPhu6PIIF8AMcyvP5S5ZSLXsKojUEHsvx5jal/Gt4N
         ofnQxthKl8BsrDIl8aGXygrxEu+sPPyW9Pe0osKqbGH67SJSv+WGMLQnidsiJSrrQUxG
         KWmTeLKJbjeG213bYeGtE81oGgWbZtmVuRTq4fD345CYNdW8wJlOf8rqLrkVJNiBqnEa
         Hg8fcevEa8NTeXYpYSdLaFZcHHkooHKqT2L4hHBv5+xVf/R9gbKXjZyHQiSPNcFHjCLp
         dCGQ==
X-Gm-Message-State: AGRZ1gIHOq2zBIF5qS32MSB9OcaujbZQDMsGCqMKYvpI3wjoQbhW63PB
        ZpQdfeI7mogrMG5V+cSv6EE=
X-Google-Smtp-Source: AJdET5ch8gdvQvw4kBjOkt16vJ8ZCCWAnadpmg6ri+Vrgj92QTeCYTvwE7UBM2SMu9dcKd8Ln8prxw==
X-Received: by 2002:a1c:b58b:: with SMTP id e133mr8844086wmf.0.1542872699910;
        Wed, 21 Nov 2018 23:44:59 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r76-v6sm3705038wmb.21.2018.11.21.23.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:44:59 -0800 (PST)
Date:   Thu, 22 Nov 2018 08:44:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 18/24] x86/speculation: Avoid __switch_to_xtra() calls
Message-ID: <20181122074456.GF41788@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.041653473@linutronix.de>
 <73b835e8-618f-1cd7-09e3-99b1bc4ca2c2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b835e8-618f-1cd7-09e3-99b1bc4ca2c2@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On 11/21/2018 12:14 PM, Thomas Gleixner wrote:
> 
> > +	 * Avoid __switch_to_xtra() invocation when conditional stpib is
> 
> s/stpib/stibp

and:

  s/stibp/STIBP

to make it consistent throughout the patchset.

Thanks,

	Ingo
