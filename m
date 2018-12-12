Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A3320851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePZTXi8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A3320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeLLGRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:17:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43254 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLGRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:17:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so8352576pfk.10;
        Tue, 11 Dec 2018 22:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XRB0xc5f6XftsKHZZCs7smeMOtDCq8a8bNoufdtiss=;
        b=ePZTXi8PtrmkrD44NaC6OyS8P/ABX6p4GFy6AbUJMBkd9cL1qriDJGz5FIiDTQFvil
         o97v5f1aJ4T/NwFc8B0J/t5JzBhCMNFeNz603YjuVp+xYAATfCm3+avmEytlc581BRV/
         9hAqPjfVlFGrlPrJrCjS+DCO//GbJPmvTnWFtbG2Y3vSp9WBsDCv7Sadyp21Ci1ENBa1
         Rr3wSxKXHW2ibQIf1bEkIHA6riaKlA8GKOK2cfk4Js5DcOT0Su8oJmFUnTnHPW0Fl0Re
         XFIgSqwiu7DbUfwBHSxyCgPLdCx9YyKpADOZdkgo1/5ZYN1IZUN1C1EhYoboxYkoiseE
         mmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XRB0xc5f6XftsKHZZCs7smeMOtDCq8a8bNoufdtiss=;
        b=jA/kdLRnQXivWI6UfKY8hwFUsWbCOQMiE9j7w3hAchlMXLI7dfLFp6YqVwN8Kcj2DY
         b6eMsC9Vxuw+opmlkTZIPQVtIUL2krVy5XAeZGvtSrN1GXU6lZE93zPhbMwYU7d4JFKB
         umnTRF0VZPHSPZ1Fw4GnnKTdlQ1W4oijgZ1kQmabf+bgcjI+lzZYKrwqve2KaLeUI2V3
         tLC2v7J2x/KohfiJlaUCNVCkB+HUg0EBwp2filfmqi+GVP/b4HBFpvQq2mdPlBgXild9
         +g07n21COnPpKGM8hih+4KsFReTSOBwIHInAoZpww2X4hdEe8BSY7NyTIDl1GiVS7d5v
         CghQ==
X-Gm-Message-State: AA+aEWZXXMlmCoGtqvSJ1I8K3Ve41NH7SYNgIAkPkoONMYXdjTPZbYuC
        LL+Y0xjm2gghYNT8Kmbs77NqsD1j6IN9+Nj2RCU=
X-Google-Smtp-Source: AFSGD/WMbuK3ZQKy3b2zq57SmlxMVaZ58u6moOTKN6LLhNK0i9n5+EU6NbKJoXF6XmgbkDQE2wFOMNCqGdLaAQ/l7hU=
X-Received: by 2002:a62:8a51:: with SMTP id y78mr18872060pfd.35.1544595437727;
 Tue, 11 Dec 2018 22:17:17 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001568af057cb456a8@google.com> <CACT4Y+ZtAP4AVX9nARw+3PEdFL_WX3r37TAPuy=zBdZkg-0pRg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZtAP4AVX9nARw+3PEdFL_WX3r37TAPuy=zBdZkg-0pRg@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 11 Dec 2018 22:17:05 -0800
Message-ID: <CAM_iQpUZmbsEPAz9s1bDVHbm08+h4WE4mvoxitttDCsXMQvQ4g@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in __inet6_bind
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        tipc-discussion@lists.sourceforge.net,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:04 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Dec 11, 2018 at 1:41 AM syzbot
> <syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    3f06bda61398 kmsan: remove excessive KMSAN wrappers from a..
> > git tree:       https://github.com/google/kmsan.git/master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13ca6b05400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9b071100dcf8e641
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c56449ed3652e6720f30
> > compiler:       clang version 8.0.0 (trunk 348261)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com
>
> This looks like a bug in TIPC, +TIPC maintainers.
>

It looks more like udp_sock_create6() doesn't initialize
udp6_addr.sin6_scope_id.
