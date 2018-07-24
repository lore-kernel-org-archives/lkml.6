Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C48ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AF220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU4xU+aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AF220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeGXIUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:20:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbeGXIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:20:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so2996107wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pbkoIkGQezSF9zhfJxGFhMVnSmBS6kgzfuasfMyL9O0=;
        b=lU4xU+aOFRfraqlL4hs0VS9Gb7KRLzonVILUYn9AuzR3G/e/ORijrEfGBsJIUEgDAt
         4/nN1OBaI+1qNTQjOQW/Rd8M0NN5Odhjkm5fWlT0KwWdw5NBJdmy35CuEvnRETS1n+3v
         55IM7K5kUtJU9hfyPYjOiYw2duvUrI/0iIJsDYigNyhLiuXdZ/l03nw27+lBOyBqjHh3
         sUVqBHDMdqRaxFa3X2WgLdLriXzfQQpS8f3VAgqYfAWEe1b/AmH6LxhRqgBMOOgbEqE6
         FqaqNvG6s0+PtSzXK9K2/HCt2VDw7eBLrVs47lpdix40F8ZakfNZBjoP24AEiDsXVr5/
         1HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pbkoIkGQezSF9zhfJxGFhMVnSmBS6kgzfuasfMyL9O0=;
        b=D9ArzwGIYTioa5fs20iKXly8lM09TqRHuYFXiSueSCT3aO+H1NqygrDwwoPAGXXZ4R
         GbSZmSI7URDHvW9Hs2xMkz66BS4PvH2S3eRGjkAJjEkD2l9ShiO6sXCRifm6EImvgyDQ
         Ac12KGMTvG8sG1qp4eJBBZV9ROC2lWJ2icgwa5UU+Z1VW45BtYF2gL56YRHfEqJ3wLgI
         62S47McwPJplmz+2bkyIoLcb1DiIEC0Bauvyx6lggue0gM8YeeT+cqGbc67IjvC6m5kf
         aj/w6MR10p5hIOaaxP6hZ7ttaYb3boDSXzS7SDGNepNq/pKmAqS/MfOc8xXV5BsJGYc8
         pxwQ==
X-Gm-Message-State: AOUpUlFI7yahYTff4hhSbISW2w9OCdlmL/GEVRdG+jEJ12sObhHU7g43
        XHO48vO629+azgCTHsuKJWo=
X-Google-Smtp-Source: AAOMgpeKYxPRzrB/Dn6YM1hk9PplJ0LIeh7h6DuU7hWWv+M7yGkjTpNQ//y5M1yhcE0V2UpGWEpMxg==
X-Received: by 2002:adf:8503:: with SMTP id 3-v6mr10780909wrh.100.1532416522067;
        Tue, 24 Jul 2018 00:15:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j11-v6sm10141159wrr.37.2018.07.24.00.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 00:15:21 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:15:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@redhat.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        peterz@infradead.org, tglx@linutronix.de, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv4 01/12] atomic/tty: Fix up atomic abuse in ldsem
Message-ID: <20180724071518.GA7300@gmail.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
 <20180716113017.3909-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716113017.3909-2-mark.rutland@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> working after making the atomic_long interface type safe.
> 
> Needing casts is bad form, which made me look at the code. There are no
> ld_semaphore::count users outside of these functions so there is no
> reason why it can not be an atomic_long_t in the first place, obviating
> the need for this cast.
> 
> That also ensures the loads use atomic_long_read(), which implies (at
> least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> 
> When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> very thin (the only difference is not changing *old on success, which
> most callers don't seem to care about).
> 
> So rework the whole thing to use atomic_long_t and its accessors
> directly.
> 
> While there, fixup all the horrible comment styles.
> 
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
>  include/linux/tty_ldisc.h |  4 +--
>  2 files changed, 37 insertions(+), 49 deletions(-)
> 
> Note: Greg has queued this via the in the tty tree for v4.19, which can be seen at: 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=5fd691afdf929061c391d897fa627822c3b2fd5a

Can this patch be skipped, or do the others depend on it?

Thanks,

	Ingo
