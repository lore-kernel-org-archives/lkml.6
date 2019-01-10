Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473ABC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EBD214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KxLo6GfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAJBSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:18:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46370 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfAJBSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:18:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id y14so7071079lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82vvuXTKjvPXqY9eZYLT5Juayyl3yZ2lLShppvfB5ig=;
        b=KxLo6GfDAV4uZwzb+AO0y4CW2SQaTeb7bSKg4sPn3tU31Sj3xClf3pkssmSIEVKj4a
         5tF2/WBR0ojdrQFPchyj/usU5H+/Tw49cSOH3RO66Otti6ncYBzubdwbAf5k2zbRCna8
         Ge53H/XsQVHszxlmK6fPk+u/GyLt3eVNUiq+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82vvuXTKjvPXqY9eZYLT5Juayyl3yZ2lLShppvfB5ig=;
        b=kX+c3UnjPnDK3GXFRARDUYPa298UCoxc/eLwI83NKWTjnMeGcyWFYqp2ObvPCH2aqC
         0aMM5GomQ71/Nv865qtSrhPKlWjl8fCp5B0h9fBPuE0lKuUB2tuhNGL8+3dEHZdDENiJ
         iJhg3z1Fnr+MrmAMrbYEz0hOll42kYT8LR1rzbJ/QgXsCwlCVOnosTlTkXlTa2QE93eZ
         YOihP3x2ejwnAcBIPuuY8vB2Y7FFkkM8sO+7k7Q1CDgEo5Tuvcj32pWA6jnW7csbWI2E
         tlloSykrY+g5HVZnwgeT9E85FzScMroHPRgu9pfLL84+ETmxKpi13mUerd6sA7XBNUvv
         EnPw==
X-Gm-Message-State: AJcUukeQXpBuochF56pCslzcOuwpPp+3uwiQ+VsvGTf/Bx2d0uQa16kj
        JVMT5r5yDoFZsjKNkYPCH2TqUm65n0w=
X-Google-Smtp-Source: ALg8bN6/iZhiK9xG2S6VFDhsKQ3MySPrDxsPw6/tdj+/R+sh9PlBenOTAFCvDQc5ut7f09oXyT/aaw==
X-Received: by 2002:a19:f204:: with SMTP id q4mr4910503lfh.133.1547083121234;
        Wed, 09 Jan 2019 17:18:41 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id g17sm15048468lfj.36.2019.01.09.17.18.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 17:18:38 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id t9-v6so8199027ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 17:18:38 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr4534294ljh.59.1547083117840;
 Wed, 09 Jan 2019 17:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard>
In-Reply-To: <20190110004424.GH27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jan 2019 17:18:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
Message-ID: <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
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

On Wed, Jan 9, 2019 at 4:44 PM Dave Chinner <david@fromorbit.com> wrote:
>
> I wouldn't look at ext4 as an example of a reliable, problem free
> direct IO implementation because, historically speaking, it's been a
> series of nasty hacks (*cough* mount -o dioread_nolock *cough*) and
> been far worse than XFS from data integrity, performance and
> reliability perspectives.

That's some big words from somebody who just admitted to much worse hacks.

Seriously. XFS is buggy in this regard, ext4 apparently isn't.

Thinking that it's better to just invalidate the cache  for direct IO
reads is all kinds of odd.

                Linus
