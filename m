Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC02ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AD820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOksO5N6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AD820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbeGWMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:40:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42550 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387816AbeGWMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:40:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so45232pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XmCDVmfm1OGirlafY675LCKL+DRQ0miFDvKZzs4AvDA=;
        b=BOksO5N6k6cbmaEy1b5v9QwO6WgJMXH0A119XWWJbi0LHoSgdDmUH1lfUOyWKG0u+/
         PAHtwPY8TjPUGxS7UdDViHneLxjIiPzXFjQez7DSsx9k0rkhGdvhzM8yM++wvHVVsZuu
         uMWZaJVPG4mtEgoRPSHeO2lyNOo9s+AgBu3a/+/r3TQrhuOQ7N3zGT5P57sAIBGSgHWX
         ehGOW4csDT/2uOgWMdX/L5W6OFls8e4B17uPkRyq78UW4zJaJlB+ZJY5E0LookopMjY2
         OdnsYvN5pqG8rh6Bv2V+E3eZY2xFBT+yrm2N+ox05UWLjjGmBQYiTdatCP5GgVS+1S+H
         y2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XmCDVmfm1OGirlafY675LCKL+DRQ0miFDvKZzs4AvDA=;
        b=M5l87YaOvIe5EXIJBmXvd5/Qmyfes/FBIm6dEGduovQFlQm+QYzr/bybDWVfGVPr5M
         f4KvlCr3uE1du09OrPTNRZH3flKppKeEEJ410Zyo0F3K2oU+Ir0Y6ZQCwWuRPa/3uwYJ
         Bk/Tpn03xsEqkfhhvt5RB8Tn9y537/N8QD5qNSbpWmLsekWJ5T1DfTmAtl0MBRqmiqSY
         eue+Xx+dUXzWL+dl6NToMQsz2cg9MIlF7Ky2fEfyRJJarjOqzc8wA11S8sSa16vIzmqT
         jasDMTR173xgmcyVAvSNKJahZ+CZTgpLq9Lt9J0O6J77xwuuNhXTgqXSk+d/e/Dfqqy2
         PSPg==
X-Gm-Message-State: AOUpUlHetunWdykDGC+D/xhDAUDmcsKhx6SPcxM0jbCx5FxgmgoWS2wH
        80nUZkeHhzJsex03XJy1iaWvvyAt/naSvB6BpbRYww==
X-Google-Smtp-Source: AAOMgpfHZcg0BCAG3ADMAdFv5tkbQHfG4NgwAWKLJWIIPoyY3g1bHGqVORBTcS9qQ4DxyISZ8CVPVxCKOOHw4iHJGUk=
X-Received: by 2002:a62:3f44:: with SMTP id m65-v6mr4910262pfa.98.1532345993470;
 Mon, 23 Jul 2018 04:39:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 23 Jul 2018 04:39:33
 -0700 (PDT)
In-Reply-To: <000000000000f0ec4f0571a91339@google.com>
References: <000000000000f0ec4f0571a91339@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Jul 2018 13:39:33 +0200
Message-ID: <CACT4Y+bhQGLGPKSy48JJ8pHai3C=CcLC4B0Xa0ODXwyvDsisFw@mail.gmail.com>
Subject: Re: linux-next build error (3)
To:     syzbot <syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com>,
        harry.wentland@amd.com, alexander.deucher@amd.com,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 1:38 PM, syzbot
<syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    6d93abaf4c5b Add linux-next specific files for 20180723
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e02f0c400000
> dashboard link: https://syzkaller.appspot.com/bug?extid=9118f0a7ae77f4eee4a9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9118f0a7ae77f4eee4a9@syzkaller.appspotmail.com

+Matthias,

I guess this is caused by one of the following commits, and probably
affects KASAN and similar tools:

commit cc32ad8f559c36ca2433d282aff690a6842a3a27
Date:   Thu Feb 8 12:53:16 2018 -0800

    amdgpu/dc/calcs: Support clang option for stack alignment

commit 37172013fa2e527735ec9eda51a11cfea3af0ff1
Date:   Thu Feb 8 12:53:14 2018 -0800

    amdgpu/dc/calcs: Consolidate redundant CFLAGS



>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f0ec4f0571a91339%40google.com.
> For more options, visit https://groups.google.com/d/optout.
