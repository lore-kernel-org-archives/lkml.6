Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C943C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA4A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reFt6qLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfBYUes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:34:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39667 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfBYUer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:34:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so4508126pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FmHMOey5zYjBqir8BQ2Fm5h9ilU4HwTBdoph5KPL7ck=;
        b=reFt6qLkikr9MV68tRlb6/U2JuvM9MZ/xzIst8WXo2yxanz2wdmpZf05dcf0bLx8er
         MBn4Ws5i620Rle3Zk+XgZb4UNrUa1zbCocRizS/ESBMQgucJespj897PEvYrT6HHxRt2
         xiAChdipZi7OZmIgTZ6wS5pS8jtmufH8qJKevVWtqWcmY1PJaqUNjNLzKGSuKUTmZXD0
         C6k3eKIX+OGC7OtYmWmGwpuAj2AHPc3lZSOn1mEI7+LLr2W7jS50bv5LRUMgXrU9gEiJ
         vQB35q+afCKz3T9efbDrfY90Jph3/DWI59rp4+Wg+FeOCcloJyGf6As2LPWDnHczSYYv
         9kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FmHMOey5zYjBqir8BQ2Fm5h9ilU4HwTBdoph5KPL7ck=;
        b=SE1Kkh9SV0Oqehe0Z7ABmUWLjipbOIEn2RXlhq9ym1CGihcMhFYxzx4I5eFc6oMo3W
         PVTv/coWPzikMIoPiZKXZicg00ZyIcGW8kt1E8aQ1cHg7v10CPaYUseDYFe71T6S/lpC
         KN2oGS7KQdCsjBm1tcd3c77HndvUMW9FyWd3Oc8+o48PVi1yzcGulKNYNAhwxD2oEoLF
         LgChNnBJbFj6M/Dj45p7pB4CN/uu6rfw1oKTO2dgiGNDJVsT90mzPk0bUtd7lT6Vo59T
         /f8crc5ryjtj8sfREwxLHDZ93anQB6AUMqWkCRxicHNUc+qg4Ktk+BCtfFV5+JyV7HOg
         BYSA==
X-Gm-Message-State: AHQUAuYxbMZ2C4E3FwCbyO524pzo8OiUpx+Obdu7q4HLjWVHxSCv84Q0
        LHAMiB7c2HgnfSIGJtVjf985ug==
X-Google-Smtp-Source: AHgI3IZ5cqwWWpP7deEcZ3lfdJVt2ZgT9Xp/tfF1Yd4X2yc1J58P0kYnE1LQfquVg9af5N14t/Gzog==
X-Received: by 2002:a63:d442:: with SMTP id i2mr20511933pgj.246.1551126885979;
        Mon, 25 Feb 2019 12:34:45 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id m64sm25530706pfi.149.2019.02.25.12.34.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Feb 2019 12:34:45 -0800 (PST)
Date:   Mon, 25 Feb 2019 12:34:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
In-Reply-To: <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1902251214220.8973@eggly.anvils>
References: <20190221222123.GC6474@magnolia> <alpine.LSU.2.11.1902222222570.1594@eggly.anvils> <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Linus Torvalds wrote:
> On Fri, Feb 22, 2019 at 10:35 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > When we made the shmem_reserve_inode call in shmem_link conditional, we
> > forgot to update the declaration for ret so that it always has a known
> > value.  Dan Carpenter pointed out this deficiency in the original patch.
> 
> Applied.

Thanks.  And I apologize for letting that slip through: Darrick sent
the patch fragment, I dressed it up, and more or less tricked him into
taking ownership of the bug, when it's I who should have been more careful.

But I'm glad it confirmed your rc8 instinct, rather than messing final :)

> 
> Side note: how come gcc didn't warn about this? Yes, we disable that
> warning for some cases because of lots of false positives, but I
> thought the *default* setup still had it.

I thought so too, and have been puzzled by it.  If I try removing the
initialization of inode from the next function, shmem_unlink(), I do
get the expected warning for that.

> 
> Is it just that the goto ends up confusing gcc enough that it never notices?

Since the goto route did have ret properly initialized, I don't see
why it might have been confusing, but what do I know...

I thought it might be because outside the goto route, ret was used
for nothing but the return value.  But that's disproved: I tried a
very silly "inode->i_flags = ret;" just after d_instantiate(),
and still no warning when ret is uninitialized.

Seems like a gcc bug? But I don't have a decent recent gcc to hand
to submit a proper report, hope someone else can shed light on it.

Hugh
