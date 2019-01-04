Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD35C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7D721871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuKrCxhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfADI6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:58:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38189 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfADI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:58:07 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so717938ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20usoIc4RkJRiBEBTyYQHbq1Jt7l3TB1S1E8Xf7YN58=;
        b=vuKrCxhZqA5l7H5Wi+/TUYqUIT95OSOWtAWoBrvDLvSO5SI5x3x/eBuYd9vJhnCLs/
         EUp3sByD67cqNh7z/YYEaPeuxexh+JQ2jscIS75yDSM08A5aeNnrnL4kO/5uGDv11haY
         pAWFl2sPWBkVjK8Ftz44xGAZThIt7RjzNB7JuHzRe+zs61hdpVJPsUt3Ms00gGJ032aO
         kUmzuoo6i3tFqR6blir6YsOEk7oO0Oy4xjc5en/u/vdanYrYLW4sik/8tL4Xkszq4biU
         b+AYUB+2W5VV0Qy3TFbfHt0STnZi+CnpuaLWJ6RpJ3rKTxFl+1qv+K/AgXxg6vx6uR1+
         FpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20usoIc4RkJRiBEBTyYQHbq1Jt7l3TB1S1E8Xf7YN58=;
        b=nu3JI9Lbx1AbV/hmp+8U8fqCibwdP74RoXGxKNQskuW48pCKM++6FhA+Rjq1apfpHw
         01q4weULwkUVBc72bjTYZQ5TPk3E6TeM1ukbeJ4cfNkWt+A1MJT6bWK7282AWlWadvJl
         bVPVgqsDEI8mXnJ7gnqePtN1aUnjFtQUI4Jk5tuWGo8BtVmxGQv1ulqMmdjvYE8OtCDe
         9GcDIYxLKsGLL3jpf8DqHS8+64riPmQe9eT51jo9E0kYccKm91owCFH3QFekGq5R/Lc4
         f+RVxhhlpQdCBxkTGNwa95+DcYBiG3MjwdgqJfL2Ah4NIvk2QDp3T3hhimZe4e4+YyWS
         Yomg==
X-Gm-Message-State: AJcUukds/5BcqOrX6NamUJ+QlSGdmLCSdqlCqclLFLV/JKO8Hb1R7a9F
        Yw1DMl8EODD3jPI2MvaE2Ejh4DJGnmHf4J+Pjv69Gg==
X-Google-Smtp-Source: ALg8bN6Cy6jiOwdeoPsYLCKaE7+c5pzwCJpP999/XZx+O44Ih0ik7j+lZ+wuGIz97quRKepGhThWGzgD+Ezw/aqeyO8=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr406231itl.144.1546592285557;
 Fri, 04 Jan 2019 00:58:05 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c06550057e4cac7c@google.com> <a71997c3-e8ae-a787-d5ce-3db05768b27c@suse.cz>
 <CACT4Y+bRvwxkdnyRosOujpf5-hkBwd2g0knyCQHob7p=0hC=Dw@mail.gmail.com> <52835ef5-6351-3852-d4ba-b6de285f96f5@suse.cz>
In-Reply-To: <52835ef5-6351-3852-d4ba-b6de285f96f5@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 09:57:54 +0100
Message-ID: <CACT4Y+YazhPjqkTRgAkyTFTDujcUEm32TxCUxSGG2tu5zb1Xtw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in mpol_rebind_mm
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        xieyisheng1@huawei.com, zhong jiang <zhongjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 9:50 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/3/19 9:42 AM, Dmitry Vyukov wrote:
> > On Thu, Jan 3, 2019 at 9:36 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >>
> >> On 12/31/18 8:51 AM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following crash on:
> >>>
> >>> HEAD commit:    79fc24ff6184 kmsan: highmem: use kmsan_clear_page() in cop..
> >>> git tree:       kmsan
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=13c48b67400000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=901dd030b2cc57e7
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=b19c2dc2c990ea657a71
> >>> compiler:       clang version 8.0.0 (trunk 349734)
> >>>
> >>> Unfortunately, I don't have any reproducer for this crash yet.
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>> Reported-by: syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com
> >>>
> >>> ==================================================================
> >>> BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:353 [inline]
> >>> BUG: KMSAN: uninit-value in mpol_rebind_mm+0x249/0x370 mm/mempolicy.c:384
> >>
> >> The report doesn't seem to indicate where the uninit value resides in
> >> the mempolicy object.
> >
> > Yes, it doesn't and it's not trivial to do. The tool reports uses of
> > unint _values_. Values don't necessary reside in memory. It can be a
> > register, that come from another register that was calculated as a sum
> > of two other values, which may come from a function argument, etc.
>
> I see. BTW, the patch I sent will be picked up for testing, or does it
> have to be in mmotm/linux-next first?

It needs to be in upstream tree. Since KMSAN is not upstream, we have
only 1 branch that is based on upstream and is periodically rebased:
https://github.com/google/kmsan
If the bug would have a repro, then we could ask syzbot to test this
patch on top of KMSAN tree. But unfortunately it doesn't.
