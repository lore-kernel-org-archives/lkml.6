Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3360C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37AC2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ROWLTkl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBEHQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:16:26 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:42011 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:16:26 -0500
Received: by mail-lf1-f49.google.com with SMTP id l10so1821926lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 23:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgdDrEwRt2DcpNMQgDQ7LK+wdPfSmuc4/VBeDOvNh8s=;
        b=ROWLTkl6aQWh6v4hDyodVTmi62aCjx3oJ3nOE4h/bRrNbt5gz5CQAJHmOnqGnqBKLS
         E3v5lJDRWBRGLKXHpkKHL36TLgLdbBIaI5qMC++5W8vI36p8DuGFSJvPkC/ZfkTb/tvi
         n3XYFHHlTj2tGSBRrlxH7DCv5Ayw7V47zImQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgdDrEwRt2DcpNMQgDQ7LK+wdPfSmuc4/VBeDOvNh8s=;
        b=JRLmsIT9bCVHRK3WfuDS2kgwiJHwZvm7ZnTWUOAWZS8/gs3DMML80BJtF71XxXjTYv
         WN/ov0gqFQJqwHr3F6anCdmNcYEfR89ObR5LkqhW0/OGiMpIJ83QAF94f1Be56uDXTvT
         CFfVMB90Wu8gBL50CVx2AZRKeuFMN+6VTaSZsf6Q6yXdCNM/iVTe2xQGhoJ1TCnh1Tom
         L309h2TZz1iCaIQK3KT3h4RwSnJErYnCLsCDr7LvDUMB0E6pvhan9kLYL0Jdh8QL7H1o
         ZrgtlprItbLfbyQcJ2NlrhNVUjRxAHuValVUTXTZzto01WbnFaOzl4byaE5HYxZz536Z
         j4EA==
X-Gm-Message-State: AHQUAuYp48wFainXMJnkgNX9atKVwCAg/OLUHJa8IdppQiXC0hCFVX91
        LNZ5AySAir+/+feea6DAtY8u6+cwLZJWKA==
X-Google-Smtp-Source: AHgI3IbYAHyQxOSk6AQJUVgp1mol9PGo42Zyr33g+SqeP6ycx4mMw7SK9aa+lrHD6fq7jZEy9na4OQ==
X-Received: by 2002:a19:f607:: with SMTP id x7mr2048868lfe.51.1549350983628;
        Mon, 04 Feb 2019 23:16:23 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t23sm3596937lfl.59.2019.02.04.23.16.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 23:16:22 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id z13so1811712lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 23:16:21 -0800 (PST)
X-Received: by 2002:a19:ab09:: with SMTP id u9mr2059854lfe.149.1549350981411;
 Mon, 04 Feb 2019 23:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20190204091300.GB13536@shodan.usersys.redhat.com> <alpine.LSU.2.11.1902041201280.4441@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1902041201280.4441@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Feb 2019 07:16:05 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjXP6dnbdeLryqrMCG8+-yk1G7gcSKiopDKDEj0AdzdAA@mail.gmail.com>
Message-ID: <CAHk-=wjXP6dnbdeLryqrMCG8+-yk1G7gcSKiopDKDEj0AdzdAA@mail.gmail.com>
Subject: Re: mm: race in put_and_wait_on_page_locked()
To:     Hugh Dickins <hughd@google.com>
Cc:     Artem Savkov <asavkov@redhat.com>, Baoquan He <bhe@redhat.com>,
        Qian Cai <cai@lca.pw>, Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 8:43 PM Hugh Dickins <hughd@google.com> wrote:
>
> Something I shall not be doing, is verifying the correctness of the
> low-level get_page_unless_zero() versus page_ref_freeze() protocol
> on arm64 and power - nobody has reported on x86, and I do wonder if
> there's a barrier missing somewhere, that could manifest in this way -
> but I'm unlikely to be the one to find that (and also think that any
> weakness there should have shown up long before now).

Remind me what the page_ref_freeze() rules even _are_?

It's a very special thing, setting the page count down to zero if it
matches the "expected" count.

Now, if another CPU does a put_page() at that point, that certainly
will hit the "oops, we dropped the ref to something that was zero".

So the "expected" count had better be only references we have and own
100%, but some of those references aren't really necessarily private
to our thread.

For example, what happens if

 (a) one CPU is doing migration_entry_wait() (counting expected page
refs etc, before doing page_ref_freeze)

 (b) another CPU is dirtying a page that was in the swap cache and
takes a reference to it, but drops it from the swap cache

Note how (b) does not change the refcount on the page at all, because
it just moves the ref-count from "swap cache entry" to "I own the page
in my page tables". Which means that when (a) does the "count expected
count, and match it", it happily matches, and the page_ref_freeze()
succeeds and makes the page count be zero.

But now (b) has a private reference to that page, and can drop it, so
the "freeze" isn't a freeze at all.

Ok, so clearly the above cannot happen, and there's something I'm
missing with the freezing. I think we hold the page lock while this is
going on, which means those two things cannot happen at the same time.
But maybe there is something else that does the above kind of "move
page ref from one owner to another"?

The page_ref_freeze() rules don't seem to be documented anywhere.

             Linus
