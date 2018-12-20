Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C7AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B726218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgQst0l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeLTStr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:49:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42200 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLTStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:49:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so2827546wrx.9;
        Thu, 20 Dec 2018 10:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hfv1b1fuyLl/ox0Hum/uZPqMCgwZnE/AhERr7F4zW7A=;
        b=qgQst0l0uutKUJlzdyrW7WZ/dYkArcrAcjnlTpRCbSL4dnrSDLNnA5Ux70oPX5SFaK
         g41K7Oux6NOt1uNs2Y6PdVkFN7K83rqgLGRmUvIS20Bz2VgOkdJUglXRloFUfMH4hheX
         Gqkz3icynAsRNh3KqIa5v+ySf6nm9C2aV8BJ623d1N4BedgZM4Uubz/xxt1wQYk1YLCh
         i+WG6d+6Ox7Stw461RsHHdcGjkwL/sj69nORIP+vro2i7w4BwMov1mU/kmI1C/YGSial
         90pgt3MrUydBHRoQ/ESMgpH+12XBTS304zvXJUFGkHD6gOXohrT7li3r2AoTyA+YlmX/
         lcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hfv1b1fuyLl/ox0Hum/uZPqMCgwZnE/AhERr7F4zW7A=;
        b=VdJKEUmg3GPVreovodY5zmPsrk2odn4yG8QVcp1W1GBBQdKvDtqUZ3jN9SxaIvf0Kp
         dZl/uF5omB0I1YI1wmypwSFpg10XLqPSNxNjB0sEDYxapmeUfR9lGZ7tLVtwF/yut5nC
         buTswssKg2iqnahmGRRaydEYQbC9Z20Cc46TmSK5lP+fgvLNOHG8ifBpENsCjlVAS7hq
         Z06gDhPScJebDSKQ/Jp09tM68xandy1rTPVIupIhhSh/HFtA8jQOzitTorcZkQaukbmW
         feoeyMqwrQ09UDdpwmySC8dRJpfeUOphccBnbhr/TB+cJ4E/nywFEehJ+yC+PAsqnlIs
         mxnw==
X-Gm-Message-State: AA+aEWah0cR0Qxu8YCkxZqLud9X13avpTIjtGgLJFBO29gjax5rWvGB3
        heymAoPNwqC8AuhEtFXLxxD9Ur8h
X-Google-Smtp-Source: AFSGD/XImlD0fSCuoRJYocmXwxNyikeS9Znn93msfDZBb8kP/qtM8+yjqWTyEfrq6FjkOXFImJk42w==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr24905398wrx.302.1545331784865;
        Thu, 20 Dec 2018 10:49:44 -0800 (PST)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id q185sm11408777wmg.14.2018.12.20.10.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 10:49:43 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:49:41 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andrea.parri@amarulasolutions.com, longman@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 29/72] locking/qspinlock, x86: Provide liveness
 guarantee
Message-ID: <20181220184941.ykfjubbo3nj2mnpm@debian>
References: <20181220085922.332225035@linuxfoundation.org>
 <20181220085923.488666294@linuxfoundation.org>
 <CADVatmPEbBoEeVvAOMkcrsge19ceAkDT5fzEZbMAdTnD5wg6eA@mail.gmail.com>
 <20181220154030.GA9962@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5babtpi2vnasgoql"
Content-Disposition: inline
In-Reply-To: <20181220154030.GA9962@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5babtpi2vnasgoql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 20, 2018 at 04:40:30PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 20, 2018 at 12:14:00PM +0000, Sudip Mukherjee wrote:
> > Hi Greg,
> > 
> > On Thu, Dec 20, 2018 at 9:28 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > commit 7aa54be2976550f17c11a1c3e3630002dea39303 upstream.
> > 
> > Another upstream commit fixes this.
> > b987ffc18fb3 ("x86/qspinlock: Fix compile error")
> 
> Maybe, but that commit doesn't apply to any of these stable trees :(
> 
> Care to provide a backport?

Attached now.

--
Regards
Sudip

--5babtpi2vnasgoql
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-x86-qspinlock-Fix-compile-error.patch"

From 35c4feb16f5204faa40e9b0451cd86549819f375 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 2 Nov 2018 14:26:53 +0100
Subject: [PATCH] x86/qspinlock: Fix compile error

commit b987ffc18fb3b3b76b059aa9e372dbee26f7c4f2 upstream

With a compiler that has asm-goto but not asm-cc-output and
CONFIG_PROFILE_ALL_BRANCHES=y we get a compiler error:

  arch/x86/include/asm/rmwcc.h:23:17: error: jump into statement expression

Fix this by writing the if() as a boolean multiplication instead.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org
Fixes: 7aa54be29765 ("locking/qspinlock, x86: Provide liveness guarantee")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 arch/x86/include/asm/qspinlock.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index f784b95e44df..f0f2dd74b8c9 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -19,10 +19,14 @@ static __always_inline bool __queued_RMW_btsl(struct qspinlock *lock)
 
 static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
 {
-	u32 val = 0;
+	u32 val;
 
-	if (__queued_RMW_btsl(lock))
-		val |= _Q_PENDING_VAL;
+	/*
+	 * We can't use GEN_BINARY_RMWcc() inside an if() stmt because asm goto
+	 * and CONFIG_PROFILE_ALL_BRANCHES=y results in a label inside a
+	 * statement expression, which GCC doesn't like.
+	 */
+	val = __queued_RMW_btsl(lock) * _Q_PENDING_VAL;
 
 	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;
 
-- 
2.11.0


--5babtpi2vnasgoql--
