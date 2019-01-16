Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE42C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96542087E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ld0edM9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfAPFZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:25:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36629 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfAPFZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:25:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so2280769pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H/HALKcacvqDYXk15+v0kxp0lBj9BJAmXZoagms+T7A=;
        b=ld0edM9OOGm+n0suq+USsITO2pV1cvxagw8TDWH+1R42BTWZMUlzvo6GkvIDUIe9cU
         RHk7Rh0yE1uyAifrO7FBqnk0JGoY11XLJOoM353xOjnIDSWBCHfRXTE/D6c+UJfZjgPI
         0ENXKzC3asdIkTSWVWXA71wJaOPjPX6sMdBHpqdVLYAbcgYGvvRBbM5p5AxyiMS6rVNq
         3RFSSJx3RljUjFv18zVmJuQpb+RgGxgFL5IKOm3REi27VshBs/K86+zjIndW3VMB6pfb
         JUT+RC6QmqypWPTrtbr0cplNxeWLaddf487LLVCF/YAUB7VeVWjnricOyl4zq2w2kyPG
         HvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=H/HALKcacvqDYXk15+v0kxp0lBj9BJAmXZoagms+T7A=;
        b=Jo1HDH7ep/dxMcqSOfNeDRYO7Zbo2o0Bk5GHF+oicY6tXVdOjDkRgi76Xlqk4e2vGn
         XNSqQdhy6HA5HQSgBc34wJElKuO938W14kKuCcEPpYaqvvvQnvdrKlxpD1zjzkC4+e2W
         ZKvHhFmv8Xr5CtV+q4JKE1HylBLDBGgZuNqQ3jv0zeM+zocz0J3vOjo5TlJ2m7z9dk0c
         F8/wjZlTnp6SRHhha2b21g6hFK0d4zkkMz1uZbTL6gkjY6/tjxqj6b468Yw+7pFTdI6g
         NNNyUZKvstIDmQIVcCQBBEzJo0vfmZhzYaHHEcajIHdtT1GhFAbwJyZap+6F26FXWFk6
         uS0A==
X-Gm-Message-State: AJcUukcv1QwiGuM9uOpLI+SdIyc3UVtqzSqdGLOPZxKPXYPTb4mtucSZ
        M+AXfYS84SbwgwW2vgsKK3zFxA==
X-Google-Smtp-Source: ALg8bN4uVx6TDRJoMjFYg5t3oSEiRJIzKKRyCL5utcwwI8xVwy5NlRPDTRPsAx94EPURadO99JkTBA==
X-Received: by 2002:a63:7c41:: with SMTP id l1mr7094325pgn.45.1547616340771;
        Tue, 15 Jan 2019 21:25:40 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:f1d4:c2ab:a188:f287? ([2601:646:c200:7429:f1d4:c2ab:a188:f287])
        by smtp.gmail.com with ESMTPSA id q199sm9196537pfc.97.2019.01.15.21.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 21:25:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
Date:   Tue, 15 Jan 2019 21:25:38 -0800
Cc:     Josh Snyder <joshs@netflix.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Dave Chinner <david@fromorbit.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net>
References: <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com> <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm> <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com> <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com> <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com> <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com> <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2019, at 9:00 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Wed, Jan 16, 2019 at 12:42 PM Josh Snyder <joshs@netflix.com> wrote:
>>=20
>> For Netflix, losing accurate information from the mincore syscall would
>> lengthen database cluster maintenance operations from days to months.  We=

>> rely on cross-process mincore to migrate the contents of a page cache fro=
m
>> machine to machine, and across reboots.
>=20
> Ok, this is the kind of feedback we need, and means I guess we can't
> just use the mapping existence for mincore.
>=20
> The two other ways that we considered were:
>=20
> (a) owner of the file gets to know cache information for that file.
>=20
> (b) having the fd opened *writably* gets you cache residency information.
>=20
> Sadly, taking a look at happycache, you open the file read-only, so
> (b) doesn't work.
>=20
> Judging just from the source code, I can't tell how the user ownership
> works. Any input on that?
>=20
> And if you're not the owner of the file, do you have another
> suggestion for that "Yes, I have the right to see what's in-core for
> this file". Because the problem is literally that if it's some random
> read-only system file, the kernel shouldn't leak access patterns to
> it..
>=20
>=20


Something like CAP_DAC_READ_SEARCH might not be crazy.=
