Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35117214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S25Z8OJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfAIS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:26:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45944 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfAIS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:26:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so7315242ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYHo4BDWkQuib5zX71OSEA0OVBabwksHuuT/CZTIf4w=;
        b=S25Z8OJ1pX0QKsZYg/M0fXk3w3bXm7xAcOnQjDOREYBiQR8iMYf6faROB/7DN+39Fr
         CCHlM8Jo6MDQYsdV25OSIoh3iQT+GmLbIADo8OGLR2nu4DxhnWCrlN2q9+chgfDv5I+K
         CRUqm5AcGPUNJI+0aaNtaQLg9O32BM1sMYLWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYHo4BDWkQuib5zX71OSEA0OVBabwksHuuT/CZTIf4w=;
        b=rQj6zhPULgepBJxdL54vQuWlmi2VxW1fkzUShpxzvmKt4vAqt6AHSBTqFXg7f9qmsl
         dUVC1ktTN2DNP52w9pfRLXk5R3m534f59skIxoPCPJJvkaoChkYSDRbb5M38uIX2xDtW
         NNzoESBqjl3rndsre6rVKa6U8TYfMBwhatMXqKJSvH7U24HRHISxPMlLgkOWGmm0p2G0
         SZ1Hd1uW0sydK4dt0rKXHXNI9IJEFXGs2yIWHEBfZFsBDGIiOzh1rBasp0tXp+X/wzJN
         J2VJHqZa/aVGuLdJiGvHEm0CGhiGZahriX+jfqFSSOHDw3hyoehkA2CpViPH2N4S2X2i
         fMjA==
X-Gm-Message-State: AJcUukdMm3GrFpyQ6gAVXufoDe2C70ou9FOibFZR3h7GCZM0O8snu59J
        hsZxfjMC0O3Pg7OL14CcV1ow7pzO36PDsQ==
X-Google-Smtp-Source: ALg8bN4qR6M9McF+PiRySfHNjRN/2gZZabLlKkbdQ5lXEO+YZ0Vji3j5Re4fNR3X0wE7mfnGCuSkaQ==
X-Received: by 2002:a2e:2246:: with SMTP id i67-v6mr3601516lji.154.1547058362048;
        Wed, 09 Jan 2019 10:26:02 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b20sm13607666lfj.61.2019.01.09.10.26.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 10:26:00 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id p6so6402284lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:26:00 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr3883924lfj.138.1547058359888;
 Wed, 09 Jan 2019 10:25:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
 <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard>
In-Reply-To: <20190109043906.GF27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jan 2019 10:25:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
Message-ID: <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
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

On Tue, Jan 8, 2019 at 8:39 PM Dave Chinner <david@fromorbit.com> wrote:
>
> FWIW, I just realised that the easiest, most reliable way to
> invalidate the page cache over a file range is simply to do a
> O_DIRECT read on it.

If that's the case, that's actually an O_DIRECT bug.

It should only invalidate the caches on write.

On reads, it wants to either _flush_ any direct caches before the
read, or just take the data from the caches. At no point is
"invalidate" a valid model.

Of course, I'm not in the least bit shocked if O_DIRECT is buggy like
this. But looking at least at the ext4 routine, the read just does

        ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,

and I don't see any invalidation.

Having read access to a file absolutely should *not* mean that you can
flush caches on it. That's a write op.

Any filesystem that invalidates the caches on read is utterly buggy.

Can you actually point to such a thing? Let's get that fixed, because
it's completely wrong regardless of this whole mincore issue.

               Linus
