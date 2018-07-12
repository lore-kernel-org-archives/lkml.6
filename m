Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833C12087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUzV9DKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833C12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbeGLVq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:46:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733006AbeGLVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:46:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so23112179wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cTslhsETMjX1ESqbiCMq81CGPYp6Hr9Em6mJe/4gu8=;
        b=hUzV9DKK8oEhU8apJEghdXfuHq+7ObHjv4IjS+itdlGXrzpy6puXwImPsa+m2uiiLY
         sFos3f6SQ8HhmGq0lUq5mSJxXzwy6746jIEhe2YYdNLISQSDfC0FLl3P9NCPRCJVJP4/
         jDhgf4Fo/yyV2pm9wwprcP5Z+mXrbGtO9zHPng2KjnPthIDGfQwhJXnd+vEgRHEwAJ2O
         l3qVzjSu6nYuV0D90wgDW7BqUnkzOKNwYWfbkyrinulP5/CVIsT1YXhlEWbpdacU+MH5
         27tvpEXTaSX2UCoLkBEJPGnxCpVRFDeRhx73XOwCTB4TdeYFthJslvnaGpU1NV7Wekca
         9N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cTslhsETMjX1ESqbiCMq81CGPYp6Hr9Em6mJe/4gu8=;
        b=l8MvbAH/WfOlAoHnG4lu71Y5ulsBTE8L/A9FXyLbAj/02LQZ2ujerKY68R4D8R6dzD
         BIRf5F0knp+92xK+8N6bZWRAPHmVWEMkb5l8QvVyEpHii2SktTRtXxNuMEHV9TLDrVG0
         TmrRPmdUbDUm5GfVA+F6y+uAVYTbR/pd3w/Ur3x05yTN5bqNh97jMWi2vNIifYVjSdw7
         wFIxiIl/psugmTa2wmUxCLVTrYwcPiotxbZrCgXYMI4N6PnkL21TDglhlvH2z1JitBz4
         47GDe/bP4tF7KDPVzJ0ixJM3/9KZ++qsINhOxlock+EY7EGabTW5usDKeg1P89fHMrLa
         uhAQ==
X-Gm-Message-State: AOUpUlHaFZ319d8E1zqZ40RgykSEazfxFQm0kqAD1iBhipM3pmgbOXbr
        xDlJWFvS1NbMPSx8wuj5cNM=
X-Google-Smtp-Source: AAOMgpcgst4QBdAKNxOiwuegdlsl2oNw5vUhgkYo5Zj2/99K2G8n8aoKk0gTRsestMsraTHDefg9yA==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr3055080wrd.187.1531431300930;
        Thu, 12 Jul 2018 14:35:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l10-v6sm47057088wrv.23.2018.07.12.14.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 14:35:00 -0700 (PDT)
Date:   Thu, 12 Jul 2018 23:34:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv2] refcount: always allow checked forms
Message-ID: <20180712213458.GA14004@gmail.com>
References: <20180711093607.1644-1-mark.rutland@arm.com>
 <20180712170124.GD26935@arm.com>
 <CAGXu5j+hfVmB_+wPn=-hx3w+sNoKQBRLAbf2M0WrNY3Y+tYCQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+hfVmB_+wPn=-hx3w+sNoKQBRLAbf2M0WrNY3Y+tYCQQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Thu, Jul 12, 2018 at 10:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jul 11, 2018 at 10:36:07AM +0100, Mark Rutland wrote:
> >> In many cases, it would be useful to be able to use the full
> >> sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
> >> this would help to avoid duplicate warnings where callers try to
> >> sanity-check refcount manipulation.
> >>
> >> This patch refactors things such that the full refcount helpers were
> >> always built, as refcount_${op}_checked(), such that they can be used
> >> regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
> >> wants a checked refcount to opt-in, avoiding the need to duplicate the
> >> logic for warnings.
> >>
> >> There should be no functional change as a result of this patch.
> >>
> >> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> >> Acked-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: David Sterba <dsterba@suse.com>
> >> Cc: Boqun Feng <boqun.feng@gmail.com>
> >> Cc: Ingo Molnar <mingo@kernel.org>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  include/linux/refcount.h | 27 +++++++++++++++++-------
> >>  lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
> >>  2 files changed, 45 insertions(+), 35 deletions(-)
> >
> > Looks good to me:
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Peter, Ingo, can this go via the atomics tree? That's been the
> traditional location for the refcount patches.

Sure, will have a look tomorrow!

	Ingo
