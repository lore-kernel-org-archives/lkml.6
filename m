Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59560C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B56B2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvVqy1Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B56B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438469AbeKWHnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:43:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389531AbeKWHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:43:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so10447903wrr.3;
        Thu, 22 Nov 2018 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G65Honag0Abrh6M83Iiav1b1DtyaPZ95P6+Mp4AEzZc=;
        b=qvVqy1TvKPgAIl/JM//WEijtA35bgNrPCWlD16egfx3ITK3I0mXGUMC5ho5+h1tvQW
         2TRo4Of1FXKrmHV/WIRZmZeerRAAUI8Zkv3W9UW+4OeDPNXbD4qKcONvbhbrl7XYVwec
         UgXxPfGEDQYWt3yflvJSaXcIIQnsqHzv4B3GVBrPg+yL6p2fcK3rFIRhSt9H49CjEIQp
         ua12PPeNXe2SIg6b8DhJ9AbAlomfVmnKzMubd2Buit0P/QlsoDoah8TIdVKudZ0GZCDw
         J59uEJDqP87MhBZughto0WT9QAg1nSXFYbNpHxEkTW5G5rMp4pbj4eAaPQeUHJvzCWdd
         5pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G65Honag0Abrh6M83Iiav1b1DtyaPZ95P6+Mp4AEzZc=;
        b=BBSboa0jWEQwZ8FsmoPUj9XSuD1SEJoJUpwIlB2qnVCyAdJPpO0oxtYkz8OJvXMEjs
         QaZDdbiNYFVUM4EqfG0zB0oHoeDJ8UO09skmZ888NYhkU09l4ioMi2rX4ljDC12XH7AS
         Doi2iswIyUSFWMiRtSnZSPNwE6kD7/kqTsGvrAhIMzBIU4W0bk53ab+vvMunV8cvmSao
         LnYxQR0/hGh91r9wZvzVga23bkj3j8twowyeTcCJWUYkm7IEEuxWZ765N9/Gzl7V+Ygu
         VmwS/SAxBKsHWJyrYPypg8MuxNWGVzcYsVCEB3zYUesx5j4JWE8X7nFykgSEQl5jCZtD
         JPrQ==
X-Gm-Message-State: AA+aEWb8HwLwYohrFhm35KKfY9Albocoe5KURjkm+XmQxXnKNhg1tLL4
        VnTA+Da4aJbjPYW2XRNlRTHATUIj4qr37ZuVJVnuSi+J
X-Google-Smtp-Source: AFSGD/WFE0cKxmkTkKrVYqYekhuw4Isx/SdvtrtZkn9oKZaLB2TlxL1ZXxo9Zj2dkp5iaCrOtOIG1MxzZBe3YPN+IsI=
X-Received: by 2002:adf:ef88:: with SMTP id d8mr11020278wro.163.1542920524950;
 Thu, 22 Nov 2018 13:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20181113055252.79406-1-sashal@kernel.org> <CAK+_RLnZiy13paU3tRggDpanLv=h+ZCcyXtOz_2UzWfy4tsu2w@mail.gmail.com>
 <CAK+_RLmkDfmxQcNMk7_eoC+=PQ=T9nPc=FVSiHbJADouypcEBQ@mail.gmail.com>
 <CAK+_RLmg=7Dz8umJYXr7at42Kw27H47prqmzLEGF-F5B2bviqw@mail.gmail.com> <20181122194223.GE9725@sasha-vm>
In-Reply-To: <20181122194223.GE9725@sasha-vm>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Thu, 22 Nov 2018 21:01:53 +0000
Message-ID: <CAK+_RL=6kT028dhRjjYdbyS2e=kOMRof7pPQLhkJ=V4W+sDzHw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 3.18 1/9] bfs: add sanity check at bfs_fill_super()
To:     sashal@kernel.org
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 at 19:42, Sasha Levin <sashal@kernel.org> wrote:
> Hm, but this one is not upstream yet? I'll wait with it until it gets
> some time to soak upstream.

It is in linux-next, so I assume it will propagate to the numbered
releases soon, see here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/bfs/inode.c?h=next-20181122
