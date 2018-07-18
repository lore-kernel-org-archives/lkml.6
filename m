Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97592084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vrk6HP3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97592084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbeGRUdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:33:25 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42509 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRUdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:33:25 -0400
Received: by mail-io0-f195.google.com with SMTP id g11-v6so5110624ioq.9;
        Wed, 18 Jul 2018 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jTwVJWmOtG306vPmr/OQPAflF/Q71AHRaadUeFy1eE=;
        b=Vrk6HP3CateMjvCZQwgwFaydOS82hB4Q2YPCfuncFeP2q9/rxRazQx/gyVpH8JihwY
         4OW5begxuaIP78tM/fnuIp7Mbj8z+G/0xy7rL5LXMJIRm/A45JSRS8/2MK9y8M3UuIKk
         obiHOZ25tSJR84tLbECH5SylJH0+HEmFxBplA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jTwVJWmOtG306vPmr/OQPAflF/Q71AHRaadUeFy1eE=;
        b=QEqmMrVzK5LgSY8AKgtA4H6H1cwKjyFkUUEDX/u87DomVL3s2qTXhyfq8dApXtWQpC
         GXpxCDY63NNDG4q2bNnCZK0PuVICR5pCBcAgl1sF56avaG70z3sx+jMScKhs/SGeIPwO
         D7ymAL2nlzJNSLPgChWDY7sHa7HaZsRR1/CreFlzuuV11Ghl61whNdt8cwPcIras6ZCs
         BB8dWO6K/oxJXWl0I2vTV8WDsUUvgVL1HuEy4/GM0tgmkPYiPsavPiRfD+MyBTbHZImZ
         fN1dTsMhTloTkAw/l+IVlDjdp6ozqztYfONUUY0jRbcUW6tpmf9TED+wJNAZIBeckIhv
         ugUQ==
X-Gm-Message-State: AOUpUlH5LgavbVJgDLSQaGRrYeSa+eQghG7XIeWYi9kIfqn74YasBuxa
        2rDsrCGJEHB4OBB7CbC+JmzSFPzLxrCPzC9TJInWQw==
X-Google-Smtp-Source: AA+uWPxsHY0tH40FeMxWaJ6or7iLLo5Ve5C1WUd+NGYVbUWooqqKWUVUsW0uVPJTaqX17/Z23cZPLTGmll6WNYvqZx8=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr6461996iom.238.1531943639459;
 Wed, 18 Jul 2018 12:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk> <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au> <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk> <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk> <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
 <20180718194637.GV30522@ZenIV.linux.org.uk>
In-Reply-To: <20180718194637.GV30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jul 2018 12:53:48 -0700
Message-ID: <CA+55aFydd9ji2eJSNVK7Fjpziehvm6fO3b1eTeUAn0L1tk3GmQ@mail.gmail.com>
Subject: Re: [RFC] call_with_creds()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Huh?  Nevermind ->write(), what about open()?

What about open?

At open time, file->f_cred is the same as current_cred().

So yes, open uses current cred. What's the problem?

Now, if you then use a tasklet or some other thread to do the open,
then obviously that is no longer true. But then the problem is that
you're doing the open() itself in the wrong context, and that has
nothing to do with any general issue, and everything to do with "you
changed to another context without pulling all the context data with
you - you're buggy". Doing some kind of "call_with_creds()" isn't the
solultion - it's just part of the whole thing (what about user
accounting etc? If you switch to another thread to do the work, you
have way more issues than just creds).

              Linus
