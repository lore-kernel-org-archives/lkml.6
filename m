Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A3120666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4L6rPva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A3120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeIXVV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:21:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33869 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbeIXVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:21:26 -0400
Received: by mail-it1-f194.google.com with SMTP id o72-v6so3963255ita.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gvPXXlrUbVTMwB1tJjvvSiSIV6mZVBmgBtwQQGBgml0=;
        b=D4L6rPvadMwZ1BF5zDX8gKnYYWUUvePQB7hITGrSa22Een0z7oArBZDou3Pk8/vy3Q
         EJvzRpGLZDeFFcfftQeYCstBF3QccjS+FtdQLfso6oVHMqHfqWw9kFwMU8mRiC7aZnLi
         jv5Ybq5H9QFOV/njrsfMqfuQAu0HvW3WeVhjjyQqR/0VxFnaWBF+TBnno5DGRS5rUeYg
         NMPKSF8L7v3pue9076wQqUBWAm6A/JqTcBfi/LXwuKtDgvV6o9MB8Oy21upNZPySpdxf
         cotFsjfdGCZBvzPbxzVy4mLsUNyWSruldUz9OaiWHlKRix9psGtQDMjSamaa03ppsHZA
         MJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gvPXXlrUbVTMwB1tJjvvSiSIV6mZVBmgBtwQQGBgml0=;
        b=Y/xdfbJ+Gty9TXqjHTbb3VpCDhSf+6QssUkdM0CetVtrT7kGjoh0W7NmNvqhnILbk8
         ki6Vu6RFV66nGTZccTbGBZjHZiOVeqI3PULDh0I+wzjc9Ljev75Btv94bOdOTgHmY3k6
         AoKAxDwHApSgChb+zDkFtWlCtisHjka+ZPVkXTZI1LOv3Ag+TfvKCvw6MiAJTkuSUQiL
         ZFYl7UFJHR2joVqX8nvjkYWFwnfzcKaLqEloJ2MmQGcJRiFOOTapNw9uztChGI3LuiWL
         Fi0fUmVfBXdsuWsPyb9vBVjOP4We0MctYaMczjh7bl+CXmPbDagXq7RnZvqmnocXaUB/
         5rew==
X-Gm-Message-State: ABuFfog358WXVucMy/rtnVKUQkiHShrFOwsBxZo0TXe4x5Jz5i5QWiR4
        GKAbawSJ8ZuIL0yiwbxWNf/6n++wgOdA5eo9+WCR2g==
X-Google-Smtp-Source: ACcGV61DlsZzZkeBvvl5wuTbysIv7ZaQMPE7bNreFdDBbNF97Wcg+HiJi/pfxEY1XLn3AaLfw+imV0JpYrQO6EsFOIw=
X-Received: by 2002:a24:d286:: with SMTP id z128-v6mr7995835itf.14.1537802326053;
 Mon, 24 Sep 2018 08:18:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 08:18:25
 -0700 (PDT)
In-Reply-To: <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com> <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Sep 2018 17:18:25 +0200
Message-ID: <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     Christopher Lameter <cl@linux.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 5:08 PM, Christopher Lameter <cl@linux.com> wrote:
> On Sun, 23 Sep 2018, Dmitry Vyukov wrote:
>
>> What was the motivation behind that WARNING about large allocations in
>> kmalloc? Why do we want to know about them? Is the general policy that
>> kmalloc calls with potentially large size requests need to use NOWARN?
>> If this WARNING still considered useful? Or we should change it to
>> pr_err?
>
> In general large allocs should be satisfied by the page allocator. The
> slab allocators are used for allocating and managing small objects. The
> page allocator has mechanisms to deal with large objects (compound pages,
> multiple page sized allocs etc).

I am asking more about the status of this warning. If it fires in
input_mt_init_slots(), does it mean that input_mt_init_slots() needs
to be fixed? If not, then we need to change this warning to something
else.
