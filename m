Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8335C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8000420892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+2e1Hwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8000420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeKIHzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:55:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33032 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKIHzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:55:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so15403437lfc.0;
        Thu, 08 Nov 2018 14:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YPui7bcJGXbVMZjpaWkPM+7iS/isIkfIFDRG+aAA/sY=;
        b=L+2e1HwnelIeCLf8YzR75sIlsMp6aDkUsow1WS24ztc+/xlPqY1pNtdv2GgLst46YE
         IfPV6PWAJqngNTttkcJGI3qWVsZStyf2B2yKLGo3cgm5cU0ZU4F34KyMAqTWlfz178Lh
         0JwUMnYUQGPOYfhjH30/gQ04YlnmpRux38XyI3AK0Oe9ZRGBlNs1nGLezBJ+Z/Bnhroj
         5JpRPxGfDqmCksHcBCZRGI/aeP9f3cOEFjpw9dZW8rB/W+9L8ddu9+mBngD9aO3bqa8A
         siv4cFwuuCt0/I8eTkyKVHp4u9rfoSM0F+jHB3SO1ryWvgja6tm3wkgTfS+QNe+afOwV
         O3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YPui7bcJGXbVMZjpaWkPM+7iS/isIkfIFDRG+aAA/sY=;
        b=SfnhxbKe0RsY70BROKKaTHZ4Z6Jo7yb7DxImjUb4008qRN/72SJpnHffaiBBmbK7sE
         YcG/YgZcTK0QeIQiVQlEpSbDahvxG52uvjYpRMF59PzbE6f1n/dVn1kEwIV+hldmI+BP
         cqTaZ6b1Y2IFdjR5BvJhD9RPPVnjbXpushX8sAYZCk1txCgVSg4a0b4OZBSxSgmehZip
         93+1aX/1/J2BjkmHNQ9pqRmMUoAXR9vv+DMFAu7EPWLTKtmOII3ZmAbxxyLrzoIUk3sS
         10lcmxxApsEldBDKPC8EmYkBwrOoBh04yw8kU/9yhgBGnFXG4ucCVzB+K31XwxQjTS0C
         StLQ==
X-Gm-Message-State: AGRZ1gIa0OH6ODmO8sgFMzxV94e3q46KoHQZi0Zv7EgX1SJICs3Xnw53
        0qzxBLNgZOT34jIOp9sRW4o=
X-Google-Smtp-Source: AJdET5c/zU6vFpkfJ6VNVJEQRIbTrJqvofOalaadjpux9J1BDj2wfghV+IKlHYErE3ZeTDizOQBn5w==
X-Received: by 2002:a19:702:: with SMTP id 2mr3805648lfh.144.1541715486117;
        Thu, 08 Nov 2018 14:18:06 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id u21-v6sm876886lju.46.2018.11.08.14.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 14:18:05 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id A06BF4607EF; Fri,  9 Nov 2018 01:18:04 +0300 (MSK)
Date:   Fri, 9 Nov 2018 01:18:04 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
Message-ID: <20181108221804.GE13195@uranus.lan>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <CALCETrVAe8R=crVHoD5QmbN-gAW+V-Rwkwe4kQP7V7zQm9TM=Q@mail.gmail.com>
 <4295b8f786c10c469870a6d9725749ce75dcdaa2.camel@intel.com>
 <CALCETrUKzXYzRrWRdi8Z7AdAF0uZW5Gs7J4s=55dszoyzc29rw@mail.gmail.com>
 <20181108213126.GD13195@uranus.lan>
 <CALCETrXNt6nEMu9bbK7GizoeC+rphi8ZK0dDsHiVgOCQj1eQEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXNt6nEMu9bbK7GizoeC+rphi8ZK0dDsHiVgOCQj1eQEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 02:01:42PM -0800, Andy Lutomirski wrote:
> > >
> > > They both seem like bugs, perhaps.  As I understand it, __packed
> > > removes padding, but it also forces the compiler to expect the fields
> > > to be unaligned even if they are actually aligned.
> >
> > How is that? Andy, mind to point where you get that this
> > attribute forces compiler to make such assumption?
> 
> It's from memory.  But gcc seems to agree with me I compiled this:
> 

Indeed, thanks!
