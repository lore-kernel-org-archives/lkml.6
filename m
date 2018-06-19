Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20955C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B552083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AfL+HflU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B552083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966423AbeFSNFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:05:12 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60975 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756580AbeFSNFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:05:10 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3ff9bdf6
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=/dpV64H0S7+KSAH8kCKJK5AI/OM=; b=AfL+Hf
        lUyyvQu9ZZSVvz68haOfZSzNaTebRvF9OWIs8gOGe/vJ8V6taitanZ8QDPiF3S2+
        0ArwUBw6AlEtj+z3zacZ0eFvSwL0LJlN9rCyzzGMvaDxelLzKXuEOLjosvLkDTkn
        yGMvQMSguXcApgX3ncZ2LeBz5fbQf1U54Obex9HxQJd+MbScqAMU3z+F8BG1guL4
        R+LXDuJzq/+3HDUmLxazwg4l9d6ExSJeWWshnxVoYrzOYn/gVlnlqLgUfd0TyJjT
        q1wcme6WF6SnlO44lPelI0RHJABYu8N3KX5P/uKo9y6sbwvNr36Qb3C+yJp9VbBb
        qWjikTepLv9FSvmA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 47cd0029 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 12:59:17 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id c6-v6so18059443oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:05:09 -0700 (PDT)
X-Gm-Message-State: APt69E2vBlXtgUxLeJGVIXZxNUKDQ/AUBWxMN1/XyXy357NXCm+Voggi
        al63cvxfGltOZPbOvzeHLCCisASUjWJJAXf2nfs=
X-Google-Smtp-Source: ADUXVKLVLLODjDbkh6d1d21mCD0+5Vbj4HUui5qeY7zr15VALr2wkEJ8OVhTc8vUhPn32+xX/dbZjCdsnluyTdPg5C8=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr9759002oie.105.1529413508382;
 Tue, 19 Jun 2018 06:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
 <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com> <CACT4Y+YLySJMfG4kCJ2FiPpPtN6sgU6k2FoZUYMFrJGLj+vDjw@mail.gmail.com>
In-Reply-To: <CACT4Y+YLySJMfG4kCJ2FiPpPtN6sgU6k2FoZUYMFrJGLj+vDjw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jun 2018 15:04:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9oeoSbRZyf6qJTg+q-zZanYGu4q=YOZNqCCbRAFu15R9w@mail.gmail.com>
Message-ID: <CAHmME9oeoSbRZyf6qJTg+q-zZanYGu4q=YOZNqCCbRAFu15R9w@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>, aryabinin@virtuozzo.com,
        Alexander Potapenko <glider@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Dimitry,

On Tue, Jun 19, 2018 at 6:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> Your code frees all entries before freeing the cache, right? If you
> add total_entries check before freeing the cache, it does not fire,
> right?

Yes, certainly.

> Are you using SLAB or SLUB? We stress kernel pretty heavily, but with
> SLAB, and I suspect Shakeel may also be using SLAB. So if you are
> using SLUB, there is significant chance that it's a bug in the SLUB
> part of the change.

Nice intuition; I am indeed using SLUB rather than SLAB...

Jason
