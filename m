Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC9BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9732146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KaAhDXQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfAKHIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:08:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37379 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfAKHI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:08:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so10094906lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 23:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APfuF3eni2ygNP5lvzz/+mFQk3/YqgPBk1fCHYe99PQ=;
        b=KaAhDXQQhxGTkyOQB6Zh58GYoR47yKzSYXFs3Y79Su2l+DQ8IGmpxW63UNcyPJHGvv
         wQSnFdupBpBf5kL/saiWXY7SVolfqC+pL7zukscGHF4TCC1oK0Iksd3zAdJbCDOUP4Iz
         vb6CbuwOenMcanKm1zjhmiiAMFArdcfsSSBsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APfuF3eni2ygNP5lvzz/+mFQk3/YqgPBk1fCHYe99PQ=;
        b=ltXUmsUMqIvHs7is++B1Jf5poGlydv63GaO8E0QhDdk7gnAeM1wknKx8i8BGQAoNT+
         DVNhfGzkbn7/rev94eHKKokQliyq3FoJIIGFP15lmsIOzMpfb5HGpO9gq57fntZtBtPZ
         hDCufTdN4uVYt1vkmdhzqC/5Eq85TGJwf1qKs4YHuUVHNRANEmu5IpAU84aQEyPnATd4
         xmqedMgAEmteVrNXI1WhX69U6s6kahyHXWjXS46Uxfgj1ySdSyeZK2oov0RIYOhFbHY2
         9Lcf5PjJkA9aAcSx23pSsbXQV6AkcuV5ewzNmnWT6BnVG0CxGGE55dS+jhBPi939eGZY
         XG0Q==
X-Gm-Message-State: AJcUukfKXAFBTx9DVBEVi+FJuVnLRVnDQaXvtUJ7UD4uf0ifPBQrasHB
        lCW1cx5yQEYG9JO+R6iLZ/TePnS+st4=
X-Google-Smtp-Source: ALg8bN5qLCMXCI0JRyfNEctuups7PSCfPBX9SiXnketNhD563m4p8fTa5rtDHNT2Wcd5zmUXrjS+pw==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr7918182lfe.63.1547190505956;
        Thu, 10 Jan 2019 23:08:25 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g12-v6sm15328335lja.74.2019.01.10.23.08.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 23:08:24 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id n18so10088869lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 23:08:24 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr7920507lfc.124.1547190503820;
 Thu, 10 Jan 2019 23:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111020340.GM27534@dastard> <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
 <20190111040434.GN27534@dastard>
In-Reply-To: <20190111040434.GN27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 23:08:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-kegfnPC_dmw0A72Sdk4B9tvce-cOR=jEfHDU1-4Eew@mail.gmail.com>
Message-ID: <CAHk-=wh-kegfnPC_dmw0A72Sdk4B9tvce-cOR=jEfHDU1-4Eew@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 8:04 PM Dave Chinner <david@fromorbit.com> wrote:
>
> So it will only read the single page we tried to access and won't
> perturb the rest of the message encoded into subsequent pages in
> file.

Dave, you're being intentionally obtuse, aren't you?

It's only that single page that *matters*. That's the page that the
probe reveals the status of - but it's also the page that the probe
then *changes* the status of.

See?

Think of it as "the act of measurement changes that which is
measured". And that makes the measurement pointless.

              Linus
