Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5611CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F3F2232D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K2mrC1he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAEURc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:17:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45505 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfAEURc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:17:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so27601947lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRF36iWgYXCowecQCa4ahsuhW8PKhuB6aSQnN1znDbc=;
        b=K2mrC1helUL4L325HY2NrT1I4s0DGh5TZeQoHqBCb4EiGtuS6OMSSMFj/IXj91AApP
         0WIe+9z7ZKrZaj/QnItuCV8+QYEkOSxpr6DSt8xIIp314eWRJzAXpHNi0YCE6TpH5LnR
         EZ7lEPWEqoE21UAsTku9cUmNgSynPP2Ll+JaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRF36iWgYXCowecQCa4ahsuhW8PKhuB6aSQnN1znDbc=;
        b=I9hVwZfyhmlHANKBKGfn1XLhtPIV6XyKlSO+YfcaDMf3S/4gC5AnlUJL27P5TY1c5z
         vhXtaJ7Z9+tL59xMUdoftaEmhYmlBOekMqDRJmYDk0/5Xls/XuE9pCmQGkr6iFcrI852
         uJzNq9zk9ixLSMG3z//qJ0oydpASShFzXIYqUSYNgRmAz3nZRlLuslGwVxplWK4ZFcif
         GOH/Mlgiz2GtNTwvpo3DwLmU8LkN0xXS8RB7pS3pRt9wmbtFKqNaaVM8P2b31kYQ1P9a
         qChP/Hrob4heqJghF+pqY2JYg1AlBTZWCAQrheDk4B2kyWgdwAf+K4lvRdrvn242IySi
         5jcg==
X-Gm-Message-State: AA+aEWZdAAmD0mFDEApZB7bQLeGWE8GQS8ZEEVlkeMOS7fcVGp/49h8D
        w99py36ESDyvboGYxbnA39+5bt+YsZk=
X-Google-Smtp-Source: AFSGD/XDM3JtT26d+mQpTr+WW9lJvb47B9yNhHy3ee2qu1WkAKcyASNkyCrui0F90IPlbrecK/hw5g==
X-Received: by 2002:a19:7352:: with SMTP id o79mr30110747lfc.104.1546719449733;
        Sat, 05 Jan 2019 12:17:29 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id j9sm68291lfk.74.2019.01.05.12.17.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 12:17:28 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id t18-v6so35098443ljd.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 12:17:28 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr10266322ljh.59.1546719448269;
 Sat, 05 Jan 2019 12:17:28 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com> <nycvar.YFH.7.76.1901052108390.16954@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1901052108390.16954@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 12:17:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGmE4QVr6NbgHnrVGVENfM3s1y6GNbsfh8PcOg=6bpqw@mail.gmail.com>
Message-ID: <CAHk-=whGmE4QVr6NbgHnrVGVENfM3s1y6GNbsfh8PcOg=6bpqw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Crossed emails ]

On Sat, Jan 5, 2019 at 12:12 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> I am still not completely sure what to return in such cases though; we can
> either blatantly lie and always pretend that the pages are resident

That's what my untested patch did. Or maybe just claim they are all
not present?

And again, that patch was entirely untested, so it may be garbage and
have some fundamental problem. I also don't know exactly what rule
might make most sense, but "you can write to the file" certainly to me
implies that you also could know what parts of it are in-core.

Who actually _uses_ mincore()? That's probably the best guide to what
we should do. Maybe they open the file read-only even if they are the
owner, and we really should look at file ownership instead.

I tried to make that "can_do_mincore()" function easy to understand
and easy to just modify to some sane state.

Again, my patch is meant as a "perhaps something like this?" rather
than some "this is _exactly_ how it must be done". Take the patch as a
quick suggestion, not some final answer.

              Linus
