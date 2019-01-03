Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C06C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B7821479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJgm5z9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfACTmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:42:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42814 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfACTmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:42:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so29936994edw.9;
        Thu, 03 Jan 2019 11:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpDldWQdY7CFYCkZ7bSRYabd9JkfXhNeAr+GDnlxXw4=;
        b=kJgm5z9AZ1+1sjYgm4scPkAfkoPtTTLI0ipPql98iMLvUnGb1q+h4JXlUcWbajmk8l
         olubO5H0TorozN1LSxkZblPZ1j3s2IadDzzdzUNmyWUNXC6foTYFi2oFvNITb2I1VK4E
         aWKhZKwmoB6lJCXsnaK3vuNQrDVnVJmAuiVKgw5/BRea/d2ARVKVS7x2RbQ5exDSEd9B
         Ok9591f+iloJTDF44RB6vR7JreOaB5gY4ha2DTGwvEuctucWjstvx3FGh95Bgy5juiMk
         unV7NnN5rIWkcqh6zDA9dkJp0bNgFD7hgHU+3Zv0p3kAFyr0GcfGX8Y4fHSOreSgRZAT
         Xl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpDldWQdY7CFYCkZ7bSRYabd9JkfXhNeAr+GDnlxXw4=;
        b=ipOEnAdz1QKXJsw6W377iL2JwEFS81sx6EkEqoh3Q8OzwX7lmp6H2gUCK2Zb5lpnxG
         v5X2vPLJ3MbBAtzj22vD345ngf3icLbkeODK0pNWkHo96OpNkIF0MtCD5WFlNEwRC+pl
         MpykM6kFpLz3+9jN5dR4XylmHLCb0TiEcej139AL0Z78J9F6Bl1E51Up8/9xme2hH4t+
         CCZAvABcSMQhjjixy3/aFDzXtHhaudMeF9g1ZpQmVVOYRPeTnCWyG+ktmnH5CZTDPZ2M
         u1mihqlYBVWwvxTqkGpbE/ahTclHYoePe4kfDclz8KuxAOHOVRmIJBxnetAVdTTzgN7z
         U3yw==
X-Gm-Message-State: AA+aEWYahuczyGi7oMpJBE30cSuqoo6Ygc97iE9DLU3nmPLPYjpAGUIs
        bo87Ph3MLyVssvh6Q2lzxL3HemAQydIo3Zl1n04=
X-Google-Smtp-Source: AFSGD/VYq1tmsiAqcEpzgeanvfNJlOt1V/c/wbZrlK/IvHLJHbuUHExxqCfiJeyazIyBAXkDqL6NgOPSyT5/FYCpGwY=
X-Received: by 2002:a17:906:77c1:: with SMTP id m1-v6mr36966148ejn.233.1546544542334;
 Thu, 03 Jan 2019 11:42:22 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com> <CA+FuTSfnaL3asZg6oDdwk2J741Cf9fbVxGrB_2jdXgOwvvk+tA@mail.gmail.com>
In-Reply-To: <CA+FuTSfnaL3asZg6oDdwk2J741Cf9fbVxGrB_2jdXgOwvvk+tA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 3 Jan 2019 13:41:43 -0600
Message-ID: <CAF=yD-L_ZfYDi5874LU54=iJD52P27EabTmHGqXS6t71y7Orxg@mail.gmail.com>
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

On Thu, Jan 3, 2019 at 1:39 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Jan 3, 2019 at 7:07 AM syzbot
> <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12245d8f400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com
> >
> > protocol 88fb is buggy, dev hsr_slave_1
> > protocol 88fb is buggy, dev hsr_slave_0
> > protocol 88fb is buggy, dev hsr_slave_1
> > FAT-fs (loop0): invalid media value (0x00)
> > FAT-fs (loop0): Can't find a valid FAT filesystem
> > Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:
>
> This sounds similar to the stack corruption fixed recently in commit
> e7cc082455cb ("udp: Support for error handlers of tunnels ...").
>
> That fix is for ipv4 gue_err(). ipv6 gue6_err() probably needs the same.

Correction. The fix is 11789039da ("fou: prevent unbounded recursion
in GUE error handler")
