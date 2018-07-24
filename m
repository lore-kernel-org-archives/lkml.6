Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964FB205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L14K6aLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964FB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbeGXMTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:19:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbeGXMTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:19:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so3753875wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqI1Hv96+jL7MQ+RddRuzNVcFPgmH0HdtwTqlDynhws=;
        b=L14K6aLZyvqiwtQ4qWyV48oo3yN7CwP8ptKLhNDzYBVPp8QJZjIBXhPWI4CTsa/nVB
         c0D7c41ZUNqDFAH+kdxtHjkIpPOxogAmEibT0BUoHnVGwn1bGg6VQ/8JwmhazPA7N5Yr
         63QR/JDHsVFlJ1zFO92z5Z+I6WTEflAmuMEAdAb+FHtad813oE6BY3TnwtC++1zcfz4X
         0SzzMk7a3ovQZZMXi2oLR+/+cPp2c7IV6yXfEMGSKHkezQxLgoIv9uTz6/KadcoUlxr5
         ak5O6FPIj74cZUUac4ur8hIJhJhZMHvNuvU4GXq0vhi3wWXJgeEnEWWJQOZZPk/ul5Hw
         ARCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqI1Hv96+jL7MQ+RddRuzNVcFPgmH0HdtwTqlDynhws=;
        b=c1dz3ylYNtrdpa/CupNgypMX5U7aUMXUOYxNmrSA8CCW5Bcndx7sp2Iwfbzxn4Jff4
         iRhis7/XxTODAuMc4rmPMlEdHWpgSi8r+k0AOpzbW4wpVynZFdIxp0SfTNfhm/qUW+sm
         I1BUDOECB39G6uncNOf6/uFU+8jq+bc6l8yjFgCXYiaZjYScZRrufmvXkvFzK11Y9Aoi
         4SMjmfzGPfjflVSeAs5P1irbDvpck/CmmSXmGgaFEg28YUx7SnV5iqI1O6XjBhsaVt7+
         422Z8J/DjfmGQAru1O0vI/v2xQdcRiSniSO4WwJwtlwogm+9IZMCdiFVRpg9qzwZwo3s
         iLRg==
X-Gm-Message-State: AOUpUlE2g7TD8+SIE5+grRuWDwj3+ee/2evZtum2BAM0hGJ8sZ/Udml4
        JTNiRZAvGoWl6nRmAk9Mluw=
X-Google-Smtp-Source: AAOMgpfOjwncL4CRdBk4EQmAbCNzs6K0Y9gp9dSrhKRRyYSTZFnFjaCw8KqyoLDi9ld5+nIcO/BBzg==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr11243035wrv.102.1532430796693;
        Tue, 24 Jul 2018 04:13:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v1-v6sm30789288wrs.34.2018.07.24.04.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 04:13:15 -0700 (PDT)
Date:   Tue, 24 Jul 2018 13:13:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
Message-ID: <20180724111313.GA14212@gmail.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
 <20180724071518.GA7300@gmail.com>
 <20180724092036.GN2494@hirez.programming.kicks-ass.net>
 <20180724092324.vnfowffsla4kja5c@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724092324.vnfowffsla4kja5c@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Jul 24, 2018 at 11:20:36AM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 24, 2018 at 09:15:18AM +0200, Ingo Molnar wrote:
> > > 
> > > * Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > > 
> > > > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> > > > working after making the atomic_long interface type safe.
> > > > 
> > > > Needing casts is bad form, which made me look at the code. There are no
> > > > ld_semaphore::count users outside of these functions so there is no
> > > > reason why it can not be an atomic_long_t in the first place, obviating
> > > > the need for this cast.
> > > > 
> > > > That also ensures the loads use atomic_long_read(), which implies (at
> > > > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> > > > 
> > > > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> > > > very thin (the only difference is not changing *old on success, which
> > > > most callers don't seem to care about).
> > > > 
> > > > So rework the whole thing to use atomic_long_t and its accessors
> > > > directly.
> > > > 
> > > > While there, fixup all the horrible comment styles.
> > > > 
> > > > Cc: Peter Hurley <peter@hurleysoftware.com>
> > > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > ---
> > > >  drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
> > > >  include/linux/tty_ldisc.h |  4 +--
> > > >  2 files changed, 37 insertions(+), 49 deletions(-)
> > > > 
> > > > Note: Greg has queued this via the in the tty tree for v4.19, which can be seen at: 
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=5fd691afdf929061c391d897fa627822c3b2fd5a
> > > 
> > > Can this patch be skipped, or do the others depend on it?
> > 
> > IIRC it depends on it, without this patch you get build issues due to
> > atomic_long_cmpxchg() getting picky about it's arguments (type safety
> > improved).
> 
> Yup. Without this patch, there will be a build regression at patch 9,
> when we move to generated atomic_long_*() wrappers.

Ok, then these bits will have to wait until Greg's tree goes upstream
in about two weeks.

Which patches can I apply as a preparatory step?

Thanks,

	Ingo
