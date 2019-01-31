Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A7DC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05CA20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cfYVpzfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfAaRyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:54:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42225 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfAaRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:54:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so2986546lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/WNqBHx6t0a72y8JdVi8XzoM/zCOUk1EICcdBncvRA=;
        b=cfYVpzfF0BxeHbpmKTdtGzAEB++lXqSbRRBs/Mg7UrvWqhXLJQH+FkTiYQe0w2vdL6
         h+bs4UA2X9lTfD/JhRPt4W6/luECWOyqyTerzsu6KhEAfexcIeF33M8b5v6vrPX0DkBd
         ZOf//JDvJCzdvZkr/rTXN7MxegBSBgRnzMxFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/WNqBHx6t0a72y8JdVi8XzoM/zCOUk1EICcdBncvRA=;
        b=ObK4QqNsRcEJs5zc20EhuiXB/SWiDYrIPKIlmViE8+mLZAB7+k0VlNsO3pqIp/BnJw
         dP8ZgDZW6q2cvd0Vnj/Ar61iR6UXb8JIe+F0k+RmQmU+6k88Ki3DVrMotJIapicrjOlY
         m2DWHVozO2KIZIaNpAPrtf+fOgxBEapVoL5YYfjYXMNOorEO+YAiAPN5CtRDepddpSt8
         K8O3xVKKTbdRzDNNqswu4Z2CqFqc9LfaDCVJLe941z/ImvP77wHkY8uVbd/ujD8a3GQc
         1vjFPx9tfxqMWKHWWdQMiQxOp6xYtakTXgAlO1DPshO5K+/RJuDZncga4bIJhR6oX5yn
         /BOQ==
X-Gm-Message-State: AHQUAuZzJLVJnUq1xPNNyidkyJN5qE32S988JhXsPFDxndhcSWVDMxvH
        70U04qsii/ujX5KLEOpszrgg3Au3Vj4=
X-Google-Smtp-Source: AHgI3IaM5uGV3l+vEACDxcKk/P4kzhRBjGz4XbMATTj1MV94V50vyKKh70Fvp7Rj8skV1w76NjUVyA==
X-Received: by 2002:ac2:5551:: with SMTP id l17mr2335018lfk.24.1548957274192;
        Thu, 31 Jan 2019 09:54:34 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w9sm955486lfc.66.2019.01.31.09.54.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:54:33 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id a8so3016171lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 09:54:32 -0800 (PST)
X-Received: by 2002:a19:ef15:: with SMTP id n21mr28224071lfh.21.1548957272169;
 Thu, 31 Jan 2019 09:54:32 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz>
 <20190131095644.GR18811@dhcp22.suse.cz> <nycvar.YFH.7.76.1901311114260.6626@cbobk.fhfr.pm>
 <20190131102348.GT18811@dhcp22.suse.cz>
In-Reply-To: <20190131102348.GT18811@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 09:54:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkiNPWb97JXV6=J6DzscB1g7moGJ6G_nSe=AEbMugTNw@mail.gmail.com>
Message-ID: <CAHk-=wjkiNPWb97JXV6=J6DzscB1g7moGJ6G_nSe=AEbMugTNw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT is
 set for the I/O
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 2:23 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> OK, I guess my question was not precise. What does prevent taking fs
> locks down the path?

IOCB_NOWAIT has never meant that, and will never mean it.

We will never give user space those kinds of guarantees. We do locking
for various reasons. For example, we'll do the mm lock just when
fetching/storing data from/to user space if there's a page fault. Or -
more obviously - we'll also check for - and sleep on - mandatory locks
in rw_verify_area().

There is nothing like "atomic IO" to user space. We simply do not give
those kinds of guarantees. That's even more true when this is a
information leak that we shouldn't expose to user space in the first
place.

                  Linus
