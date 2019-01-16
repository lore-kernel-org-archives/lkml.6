Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E06CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402642082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="JkA9zzHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfAPAmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:42:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41737 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfAPAmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:42:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so4059003edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=message-id:date:from:in-reply-to:references:to:cc:subject;
        bh=4QK0fcL3IswM3mZdm/QqWZe5ovNHXs5WUgtTQ4HPZfc=;
        b=JkA9zzHilq/qF7HAk3+PdQLQLF8nB4EQNxCc7nUyuyAKWg3Y1bwPrf8+Ip8YZeoaOc
         13/pnmaw352+8xhoj3sWpUlcoclQ01YoxeDs6jYdVx6LCsdGvzHyuH/x4m30osWPGNfo
         kG3vJuDNAPm1Q5QL32HtXUzKW+kRHtkmaVqjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:in-reply-to:references:to
         :cc:subject;
        bh=4QK0fcL3IswM3mZdm/QqWZe5ovNHXs5WUgtTQ4HPZfc=;
        b=KksqPAe547fj6HmxVNTHS5JhL0jw7XL8UFzjrerZQkIyxq0PNQgC4ZZfYcS6FQdUak
         8jcC48um2Q0TKHMi3WS4J+q7gLobdhDjU2GgfWtVVQM3zUrUwDBvPP8L0Y4Wm3TQ1h+C
         d3VZX3iO1DFVh7b4qZSVYXkR6/zHf3v++e6EDl+pXnj91hEaSuiA6y7V1618ojp1DUTl
         KShpUK0pEgJp7KWAPAsPjaYFE6+aIoOsqexWl6Ff6MSe3UtPfpNTOLmYoOsAexlB15wm
         Vm7agocgeicSn3W8jPWsh58CniAFzsh8qpiHhJlTr3GlhYcMZnuTxov7vG/8aRXMDsvX
         pb9A==
X-Gm-Message-State: AJcUukfyEMVisdSEqJ74NbbR3REXNZJfyfnhxQ5kqe3tmRv0vebt31S1
        mWP+zVDbYWyDhrNRvg0qAd4kOQ==
X-Google-Smtp-Source: ALg8bN5t94pVyEUZJ0/UrQSFUMayx9CmuwarLeSFfFOOAhxCORGYMKkNnVbad3ei9VgsxMM+dpGr7A==
X-Received: by 2002:a17:906:4e82:: with SMTP id v2-v6mr4770196eju.149.1547599335822;
        Tue, 15 Jan 2019 16:42:15 -0800 (PST)
Received: from mailer ([69.53.245.255])
        by smtp.gmail.com with ESMTPSA id by5-v6sm3069283ejb.7.2019.01.15.16.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 16:42:14 -0800 (PST)
Message-ID: <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com>
Received: by mailer (sSMTP sendmail emulation); Tue, 15 Jan 2019 16:42:08 -0800
Date:   Tue, 15 Jan 2019 16:42:08 -0800
From:   Josh Snyder <joshs@netflix.com>
In-Reply-To: <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
References: <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com> <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm> <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com> <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com> <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com> <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
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
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Thu, Jan 10, 2019:
> So right now, I consider the mincore change to be a "try to probe the
> state of mincore users", and we haven't really gotten a lot of
> information back yet.

<raises hand>

For Netflix, losing accurate information from the mincore syscall would
lengthen database cluster maintenance operations from days to months.  We
rely on cross-process mincore to migrate the contents of a page cache from
machine to machine, and across reboots.

To do this, I wrote and maintain happycache [1], a page cache dumper/loader
tool. It is quite similar in architecture to pgfincore, except that it is
agnostic to workload. The gist of happycache's operation is "produce a dump
of residence status for each page, do some operation, then reload exactly
the same pages which were present before." happycache is entirely dependent
on accurate reporting of the in-core status of file-backed pages, as
accessed by another process.

We primarily use happycache with Cassandra, which (like Postgres +
pgfincore) relies heavily on OS page cache to reduce disk accesses. Because
our workloads never experience a cold page cache, we are able to provision
hardware for a peak utilization level that is far lower than the
hypothetical "every query is a cache miss" peak.

A database warmed by happycache can be ready for service in seconds
(bounded only by the performance of the drives and the I/O subsystem), with
no period of in-service degradation. By contrast, putting a database in
service without a page cache entails a potentially unbounded period of
degradation (at Netflix, the time to populate a single node's cache via
natural cache misses varies by workload from hours to weeks). If a single
node upgrade were to take weeks, then upgrading an entire cluster would
take months. Since we want to apply security upgrades (and other things) on
a somewhat tighter schedule, we would have to develop more complex
solutions to provide the same functionality already provided by mincore.

At the bottom line, happycache is designed to benignly exploit the same
information leak documented in the paper [2]. I think it makes perfect
sense to remove cross-process mincore functionality from unprivileged
users, but not to remove it entirely.

Josh Snyder
Netflix Cloud Database Engineering

[1] https://github.com/hashbrowncipher/happycache
[2] https://arxiv.org/abs/1901.01161
