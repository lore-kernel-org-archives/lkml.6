Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746D6218D8
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPmc4QGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfACTjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:39:45 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34748 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfACTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:39:44 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so13689673ywb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 11:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eX3yXZ7poOrczyc60mCQA8UF8b3coP7tz1/VQkwG49c=;
        b=HPmc4QGX1+/qrlWZ3bRk2xKlD5Chv1XTrejF0X/wwWdvr3QQFlCf55gl4MXAIPpm7T
         YTGvQ/4bdZ20UbCGvXFTL3uA5i8uZSUGTN5DGII1iof3JhcBNvDGdZyFPD0yYEdcPQbu
         g6HcdjthGETEYnnhjuBYUY9FNFYTznNI+mfN0wZX73NN1KxeryqPBCCVcF7R9ld+6wCq
         N5BkzoFKwZB1k1u5HFZRwtz2SoKNnM66xLPR/9vlhWODsxJAyUbDpvX0Nq4rF/eLxD0T
         UsyY2qqtXN+WV2tVLFU4twOe24iXlYwoPmnxd5IzH9AX8SQVmEDhNRLYDcg0M8v8PHHP
         TSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eX3yXZ7poOrczyc60mCQA8UF8b3coP7tz1/VQkwG49c=;
        b=nkJmFpbRo4/cYTARE1SF7rsPqcRxaDOLa5oXpAbMN/IVK8zLcHUNIlyvNVTPXLJMpR
         tw/z4figQdYyz7SjAMBa0kjIA9Og73YbogAWMGtDahMvR01RS2+O86E5M6DcG1pIS9/y
         scCGx5nVwSa2vJlfx7Hym6iIAMLxjnaUDJnHGlm7WJvuicae2iyibSAtpusI1ASrmKr8
         dQZpTr/I/9mFVfZyE6Jxv0SZ8Q6jLIhnvSnkh2Uihq+109uTl/nXI78qQhytJFJIzi2E
         J8trisA388rhSFnAkLiQ/xU/tDHoeyh7b9u1UoQ4Ig0S5Gt7dsHXmG/8L1hv1wHuBf5Q
         fB1A==
X-Gm-Message-State: AA+aEWYvhPY1sit+p6K9tsGLGs23f4vuZzBMnYyl7gXc24NECLMP5cun
        4RuYRxdsdh3zldQ56G5hhfDLMrr0q2k=
X-Google-Smtp-Source: AFSGD/V1b5a2CbQ69ke2EeEjlvY9l6qNz+/7/aJIy6uWgK9ji416pWDt3d5wh+6oFrQ/UBh8DZufww==
X-Received: by 2002:a81:4412:: with SMTP id r18mr48751153ywa.204.1546544382607;
        Thu, 03 Jan 2019 11:39:42 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id x4sm44941841ywj.80.2019.01.03.11.39.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 11:39:41 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id j10so10824007ybj.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 11:39:41 -0800 (PST)
X-Received: by 2002:a25:b08b:: with SMTP id f11mr37222777ybj.236.1546544380862;
 Thu, 03 Jan 2019 11:39:40 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com>
In-Reply-To: <000000000000513fb7057e8d7013@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 3 Jan 2019 13:39:02 -0600
X-Gmail-Original-Message-ID: <CA+FuTSfnaL3asZg6oDdwk2J741Cf9fbVxGrB_2jdXgOwvvk+tA@mail.gmail.com>
Message-ID: <CA+FuTSfnaL3asZg6oDdwk2J741Cf9fbVxGrB_2jdXgOwvvk+tA@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, sbrivio@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 7:07 AM syzbot
<syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12245d8f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com
>
> protocol 88fb is buggy, dev hsr_slave_1
> protocol 88fb is buggy, dev hsr_slave_0
> protocol 88fb is buggy, dev hsr_slave_1
> FAT-fs (loop0): invalid media value (0x00)
> FAT-fs (loop0): Can't find a valid FAT filesystem
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:

This sounds similar to the stack corruption fixed recently in commit
e7cc082455cb ("udp: Support for error handlers of tunnels ...").

That fix is for ipv4 gue_err(). ipv6 gue6_err() probably needs the same.
