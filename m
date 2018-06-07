Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qtl4JP15GVs/NwAAmS7hNA
	; Thu, 07 Jun 2018 18:33:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BD91E606FA; Thu,  7 Jun 2018 18:33:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5lXkeYP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 36B55601C3;
	Thu,  7 Jun 2018 18:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36B55601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936370AbeFGScz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:32:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41745 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936302AbeFGSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:32:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so5318276pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IXOe7+uT1GYsiSUyKJ8VUXZKJgiLgPxJLViEuU/dBRY=;
        b=N5lXkeYPQK/t5bb+FllX+eMRdW1sjgXjP57RDyCDWv0V8t+dceWc20bePtbaH1gBf8
         O20i2EKrzcfPFRn/1fu95r3CdrV58Bd+jr/XmZoa243lOiVlR188wS25HdageHf78Ca4
         +FvNIEs4clYVY7cfu0LjkPhXW8M6WaouuLVG3q1msQxB0xm8h225mDJzrxmJDaDAACCF
         A1n55i2PFru54t52lWsH44iIi00IErjE/X+kYJSdia2Ej4/ZcqoJkGsKFn9zc9IkqIsB
         ZWaIBhZ6GDgi6C/25mStiR/ZcdPwV2al3FFWYSxWSlMUHChdrtxG8zzpWkkecSYC68QS
         iEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IXOe7+uT1GYsiSUyKJ8VUXZKJgiLgPxJLViEuU/dBRY=;
        b=C3aSDBVXI6e4qOlbZQXbw366p7T2Jv92rDTwVZc+6VEegtIq0hMzN/vKBe05gj7z16
         y/6HK6SihdK1icVMRYpIPPvAg0tzmsmt6cfTzCbQv0mI1Lp9Hh5EoeWRU2SrIpLFw4TL
         ohzLnzlWBT2K0VAXJHApZZf+2BYT8FmwJKF2JmDKR9Id1OUx9MVwYgEDM6Hkdk+Bj6wT
         xtdmV1BDFkOLIQvRxMtS1NBM62DDjRlBe6ATyiQoX2OWJWEJ00QTUM1+tzRkbaBCMGrx
         tuhS9+LMmvvkobZrj4QM+P3wk816/DKPCnEQhtlNhnZ5a7MxWxf7jyhezL6afD0a+QFA
         IZ8Q==
X-Gm-Message-State: APt69E0UVBNaJ+PBa+fCp8xppccL5SK4FbAvSsAEUEAE4BtOvwvkooz6
        efY+sNDiUywAHuLSBijcioD7MVCrKmWbf5twy3YgSQ==
X-Google-Smtp-Source: ADUXVKInDj3iQdegEmWQmvKZWPDcoljuwTimyT6oheAl/LxJHAzfz0FEiahcR2CGinN3cHNvDjV4tC9IOTEemf6HpyA=
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr2786412pff.199.1528396368418;
 Thu, 07 Jun 2018 11:32:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:32:27
 -0700 (PDT)
In-Reply-To: <20180607181222.GD5527@wotan.suse.de>
References: <000000000000271c83056dd6acc6@google.com> <CACT4Y+ZO9pbQ+5gyZPW4DZFKtJbciwmx=gWGxzx2sp2fy8+d6Q@mail.gmail.com>
 <20180607160659.g3x2pwdbxcsx5yxs@ast-mbp.dhcp.thefacebook.com> <20180607181222.GD5527@wotan.suse.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 20:32:27 +0200
Message-ID: <CACT4Y+ZzSfCvYaGwbz2Y_5DfpeBOfm621is_hQWik119VGOERg@mail.gmail.com>
Subject: Re: bpf-next boot error: KASAN: use-after-free Write in call_usermodehelper_exec_work
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        syzbot <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 8:12 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> > <syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com> wrote:
>> > > Hello,
>> > >
>> > > syzbot found the following crash on:
>> > >
>> > > HEAD commit:    69b450789136 Merge branch 'misc-BPF-improvements'
>> > > git tree:       bpf-next
>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1080d1d7800000
>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2c73319c406f1987d156
>> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> > >
>> > > Unfortunately, I don't have any reproducer for this crash yet.
>> > >
>> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > > Reported-by: syzbot+2c73319c406f1987d156@syzkaller.appspotmail.com
>> >
>> >
>> > This crash now happens on every other boot of mainline tree. This
>> > prevents syzbot testing of new code, and just boots machine with
>> > corrupted memory. Were there any recent changes in umh? +Alexei, you
>> > seem to touch it last. Could your change cause this?
>>
>> looking into it. I think I see the issue. Trying to reproduce.
>
> And this is why a test driver would be useful ;)

And also testing everything with KASAN and LOCKDEP ;)
