Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECA4208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f68hEzuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECA4208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeHZU4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 16:56:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38952 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 16:56:18 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so10978126iok.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2YfVEj9XYV2l91tIeJEWqD50Xw1aO1Sruasgvf3dck=;
        b=f68hEzuk6rLR83YCmK0UMP9z5y3/nTpH/zq5GHiav11WOJtjCAi9T7eBK1WZx979Jt
         jbinRCmbLpFxTcKP1mhXuwQqZctkhNv5L9gz5E/RJ73DSTVMpFbQJxdx/H8el7+Kb4y2
         hdz48ftu5AMWqrPNd1KaNhuyvCzyNKWWFNHoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2YfVEj9XYV2l91tIeJEWqD50Xw1aO1Sruasgvf3dck=;
        b=fktZ5ATaiu5HUN592kSmF4umTsrP6WTOWp7LeTy47XynzM8ppij1CemtIqA0JFp2eZ
         rO094Tx43mObUT8oRNwtqPLb9FU8rBgopfkFYWE3sCfFwaZlvABxUmUhPLi2ls6BJ/sa
         Qff6Igd84P6z+JhgNHm5H83l0O195AHoguky2vem77vG39zeeJUQa1D404rgQvnTeGwH
         KkWI9QZFDdvJ7Z8acWrQJ8nzS77Rd7zKFbjRKJKyCg8Hcug4rHCA8fB4HciOEeMK11VW
         JnO0EHWTh7mpsmWNUTjILIHhHtl8YZqCmPnSAm1nS2VUIBpjff9Da5mG3tqwxJGsmWaX
         ZTRA==
X-Gm-Message-State: APzg51DcWwSzWJOe0U5MW/yUOIe4JJ2PqMuuZxkUHg23/8a0yhI7Awuq
        Fz3qpR+5BdGVdfh/rns5RgeAtFXVK4wcztbe5U0=
X-Google-Smtp-Source: ANB0VdacSncNMEPkD8UFvWzi5g/hG1TLvv9FOJR4bLwsako5iBIXbUAPLqDoDPlw1d3C5ADyHavQMBJhiMELtWCHB74=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr8268830ioh.203.1535303590809;
 Sun, 26 Aug 2018 10:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de>
 <153527451524.1785.7684129956167424331.tglx@nanos.tec.linutronix.de>
In-Reply-To: <153527451524.1785.7684129956167424331.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Aug 2018 10:13:00 -0700
Message-ID: <CA+55aFwBRzrWDsyzQLLurET_cfD4JNRPddNmFnJJodtLdLpL4w@mail.gmail.com>
Subject: Re: [GIT pull] timer updates for 4.19
To:     Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 2:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> New defines for the compat time* types so they can be shared between 32bit
> and 64bit builds. Not used yet, but merging them now allows the actual
> conversions to be merged through different maintainer trees without
> dependencies

So I pulled this, then looked at it a bit more, and went "that's stupid".

Why introduce a completely useless new name for something we already have?

Why can't the 32-bit code just use the "compat" names instead? Even
for 32-bit systems, it's about compatibility with the old world order.

So what's the advantage of calling it "old" over just calling it "compat"?

I do not for a *second* believe that "compat" is somehow confusing to
32-bit architectures. They all have the new 64-bit time code already,
it's not like there is any confusion what-so-ever about what is going
on here.

The fact is, those 32-bit interfaces are FOR COMPATIBILITY with old
binaries. What the hell is confusing about that? No, the real
confusion would be to have yet another name for the same thing for no
good reason.

So I unpulled this. Somebody needs to convince me that this makes
sense, and no, "it's confusing" is not a convincing argument.

            Linus
