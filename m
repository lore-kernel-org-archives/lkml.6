Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E86C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73864214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbSjzeHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73864214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeJJA1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:27:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33349 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJJA1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:27:25 -0400
Received: by mail-it1-f195.google.com with SMTP id h6-v6so13798652ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBZlfKuhBfz/NRv7PAZTJHoU6gcIM6jPtVH/43LXlOc=;
        b=CbSjzeHNq2fse4t3CvDdGdD9gEvLdVgwMfS/ebX6vePpbu4QrNEOJOLz6CB/ihwmB/
         oBIqn3Jdp6aX3MdLObFOIw8+ODLEhTqDr5r6H189aL+10aPhmu1qHpy/gdnGChtclGjJ
         7Aa2437Dq2P9O5q8kR73VQNRh4CcymhUaFSqL5aghPoqEXRRcCyCyoXZ1hUd8BKFrsNT
         aRB6UjVs/CSqHVMYDoy02UjcZNfo27Zcm8u3EoLY8vyEwxRGRtPOXws5HDLDs5wfjUv+
         KKxSn9Zv+W2hzdDl+Bblvyjsvh8RjarUlSfUroZ2W1wyA5nGI/xr8kVpxEXIajW4RYnY
         hayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBZlfKuhBfz/NRv7PAZTJHoU6gcIM6jPtVH/43LXlOc=;
        b=CWuBvGp6BpcllWzAlXRnjIaO4IliSE80fUy2z23FxpbPkZZsfHXKjNh+QK1smsvzFT
         TBf4VHs+9nIQRyIEoi40ESZvcc4AyLFeww69RtdSbKYOq4VZPm+BRIpGJDPxq58BvBaK
         9zCmZkgWGZg9GLacILlCmpkNBlZTvGizbXquzMMf7+KAw5hhOM4gleksY6Lzez59JMcm
         hQcseVxLGJDGQhWEJUxSEufe9k5xJy+iewq/eyxWXZRi5+iPk05Pw6kCyFVqosY7t16/
         /AnD7YRU9KUKEq8mc+Z5k0dXbRcYYejxPCrJ3tZfobicd7vgEwpid1MohPUimcCukZe7
         Ckpg==
X-Gm-Message-State: ABuFfoht5OjkR6NcyCHTTBCktP+tHwuoERdr+Psc7jU2Y1RkKtk9NnJt
        vvs9fGQqNbLVWAFf8hDTsscfiqOtFtd2Rdrx301gJg==
X-Google-Smtp-Source: ACcGV60GwC77mgWnj+0sddA4Gfe+yM57cMfjptRb7SndR9OvfndXVvjTo/VpSGBb5mHGvZhq733WzjDG1MjCW+RkscE=
X-Received: by 2002:a24:6486:: with SMTP id t128-v6mr2454806itc.136.1539104967407;
 Tue, 09 Oct 2018 10:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009d47b2057782bab4@google.com> <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com>
 <CAF=yD-+Qh5f9kqmYLY5EyUwNPuyhMpBxz6dh_kfzFZsgE3UijQ@mail.gmail.com>
 <87va6bwlfg.fsf@linux.ibm.com> <48d891dd-3f45-c03c-a55b-bb153080881a@gmail.com>
 <CAF=yD-K3BeuUWf_2RhWoC6fx=+A49Nt1TOFOfzdwKfOdsv=TiQ@mail.gmail.com> <20181009170517.GA2821@splinter>
In-Reply-To: <20181009170517.GA2821@splinter>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 Oct 2018 10:09:15 -0700
Message-ID: <CANn89iKXvPmffDQDh_7musVioy8zEJ44ZxMa-kS0xn2ps9DYOA@mail.gmail.com>
Subject: Re: general protection fault in __handle_mm_fault
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        aneesh.kumar@linux.ibm.com,
        syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 10:05 AM Ido Schimmel <idosch@idosch.org> wrote:
>
> On Tue, Oct 09, 2018 at 12:02:58PM -0400, Willem de Bruijn wrote:
> > On Tue, Oct 9, 2018 at 11:00 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > > Well, this is a C repro, you can test this yourself instead of asking Willem who
> > > already did a painful bisection.
> >
> > Thanks Eric. It does take some effort to get the syzkaller environment
> > up and running [1] and I happen to have it ready, so I don't mind testing
> > a few patches.
>
> It is possible to ask syzbot to test the patch. I sent a couple of
> patches and got a response in 20-30 minutes. Very convenient.
>
> It is mentioned at the bottom of the report:
>
> "
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> "

One day syzbot will do the bisection as well maybe, once it has a
repro, this could be really nice.
