Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64F120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F2Z1siwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBYTyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:54:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36734 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfBYTyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:54:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id v10so8578585lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMjSLSh3kp6WB7h5Y9AuNjxZZ/9KcGlk9e4LZplkaBE=;
        b=F2Z1siwEJ5qc+oOUttqdscrbgsALxm3T8O/vOxq1if/vkdiJLNLY86YME4c917bI82
         VuttugCNtmEi6CzrZCyPzZLzA/YktR8+oMz8EO3tK0dR1oz/n0g5BVMz298PkeUDRdxt
         hV4MfN7wOXi0TdMHZ+OTZiDno30IadTVuUOOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMjSLSh3kp6WB7h5Y9AuNjxZZ/9KcGlk9e4LZplkaBE=;
        b=nuf37DyTa8GJrh7jfAYs0R3r8Qno9Pmfx2i5e5hBhSjoHyTSnOoElZ3e3Pl2rkzoAr
         h3oqdIPQlMd16u9DkIjmWFGSdLcZXopaIhwtu84SCoH13MebJtDvGtSyxugeRKebyY4J
         BuVTzLyUNbmdVl83D4GbxmbS/VPWN+fTt13JroBEzyEJnV9FBlvoO/dD1kcI2oSlwl/O
         ZqnHQrbffncrF9XLU0ze8XWTK0nYl8XEmx0KpVFPHMWc8iI74rHwPuBGG3oUPmpNemjw
         v/pf3juL/iwNqW+UliW+niVojfSOwKWpQ7AAIqOKXPo3FEZGIQH1BCzpr1rCzXQI/IeY
         Q2Dg==
X-Gm-Message-State: AHQUAuZL5722kkU1+J9Uf/VQDy1nMr64ht8lTP0fQedsBIWFtMa37yWE
        0EX0ccOYZLkv5SciaPPQz4OK1+tn5PM=
X-Google-Smtp-Source: AHgI3IZy56XkmAOW1U52BiteRj/N16/xqHu3XByfL8dalBxeoooULTIhIp8kT24qcK3ijEI8/b0Fmw==
X-Received: by 2002:a2e:6505:: with SMTP id z5mr11037489ljb.180.1551124450478;
        Mon, 25 Feb 2019 11:54:10 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u3sm2489522lje.61.2019.02.25.11.54.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:54:09 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id h10so7798460lfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:54:09 -0800 (PST)
X-Received: by 2002:ac2:415a:: with SMTP id c26mr11947222lfi.62.1551124448787;
 Mon, 25 Feb 2019 11:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20190221222123.GC6474@magnolia> <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Feb 2019 11:53:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
Message-ID: <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
To:     Hugh Dickins <hughd@google.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:35 PM Hugh Dickins <hughd@google.com> wrote:
>
> When we made the shmem_reserve_inode call in shmem_link conditional, we
> forgot to update the declaration for ret so that it always has a known
> value.  Dan Carpenter pointed out this deficiency in the original patch.

Applied.

Side note: how come gcc didn't warn about this? Yes, we disable that
warning for some cases because of lots of false positives, but I
thought the *default* setup still had it.

Is it just that the goto ends up confusing gcc enough that it never notices?

                Linus
