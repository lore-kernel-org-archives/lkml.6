Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LoAwE/IQHVu0dAAAmS7hNA
	; Sun, 10 Jun 2018 11:53:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 25E52608B8; Sun, 10 Jun 2018 11:53:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZiNS491"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 48FBE60791;
	Sun, 10 Jun 2018 11:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48FBE60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeFJLw6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 07:52:58 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46007 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753891AbeFJLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 07:52:56 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so8422889pgv.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2hlrKDP0eiPoD9M/bjAFnVtnaw6G0riqYguxq1ehoEE=;
        b=pZiNS491Vx9neo+/tv39TCXlrVb7pTuXWsYx0hY/xjcXqRt3rlCEQU++ALFTk469MV
         kXDlDNvu0BepoW0mJDY+IDZ7UlhCspQ25QSciq85XCzqpv+p03Es+/br8UOZ5s/mSW5U
         k9KapbCYu8RsFVj0mdvViQpRF55haUSDQAthCTD6LzazM2Tp5Z1tUj0NCKSwi26xFfqt
         4kEaLEPf3dNnsxs2ETB3hrV3xFQRqPjbW/va4mc7S89wYh/tKGW1Wj9DqKBLDNjriUl6
         EgDWi9WZ5OACm1mhOlk9/1wRjLDrf6j+9ZlxyIkzXafacaoQTbSe/l9T5DgRrBvWg1gS
         KevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2hlrKDP0eiPoD9M/bjAFnVtnaw6G0riqYguxq1ehoEE=;
        b=uTa3KM2U6DnheNw7aLRt2vl9ogvVwe0lSr4S+IirKnhe5GDFPh2upzMVg8w3th9H64
         f33tfuIEvJPqlDQxZlPXbdvXSwzTiQXG0/m54fEXMureG+OTNmyH/kZLciNXvYAlQTN4
         1x3daTktGbz4HZEcD8TXNbiSTF6AGLUtgDO+sHtvahROphhGqE/Yhe+joQRAvLCM0yR6
         L0CQjSjiSCttY9XcZrbvq/TEjxyD8QLOtnsRYc1q6QiX6twcDyyZ88bZSssmQwS/g3Jd
         tGFYLgf1zp4h4DyR2+NnvZq9YAaCuYPfiN3rrCEPFFovLOz1ciWCqXdcAzRWrx33PaFi
         hf/g==
X-Gm-Message-State: APt69E11Gnd+nRDSiJRsfDwEZjIkNh2rByw8zvWhCjpwFlb5/qx7tQIF
        K2v8XlWqpF2DkChkH1VxV7yWCERmYAryH4zPfYfMjQ==
X-Google-Smtp-Source: ADUXVKK/cAYZApDKg3rITqsZRBn53YyXWZ1XsLt43JZIAW9iUGUIc8l3yGzpDr1GYQfBQtkVjBG8gEcOtpUL1XUWrOQ=
X-Received: by 2002:a65:4bcd:: with SMTP id p13-v6mr11404146pgr.114.1528631575874;
 Sun, 10 Jun 2018 04:52:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Sun, 10 Jun 2018 04:52:35
 -0700 (PDT)
In-Reply-To: <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
References: <00000000000092de58056e3d4b96@google.com> <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
 <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 10 Jun 2018 13:52:35 +0200
Message-ID: <CACT4Y+bfZK6yucoDrXPPW3Tc40RYq61u0Zcb=CKtdao8E+v1cQ@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 11:31 AM, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.=
com> wrote:
> Den s=C3=B6n 10 juni 2018 kl 04:53 skrev Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp>:
>>
>> On 2018/06/10 7:47, syzbot wrote:
>> > Hello,
>> >
>> > syzbot found the following crash on:
>> >
>> > HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://g=
it.k..
>> > git tree:       upstream
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1073f68f80=
0000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df04d8d0a2a=
fb789a
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D4abadc5d6911=
7b346506
>> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=3D13c9756f=
800000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16366f9f80=
0000
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the com=
mit:
>> > Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
>> >
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> > random: sshd: uninitialized urandom read (32 bytes read)
>> > WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x=
70 mm/slab_common.c:996
>> > Kernel panic - not syncing: panic_on_warn set ...
>>
>> syzbot gave up upon kmalloc(), but actually error handling path has
>> NULL pointer dereference bug.
>>
>
> Thanks Tetsuo! This crash has been fixed by Daniel Borkmann in commit
> c09290c56376 ("bpf, xdp: fix crash in xdp_umem_unaccount_pages").

Let's tell syzbot about this:

#syz fix: bpf, xdp: fix crash in xdp_umem_unaccount_pages
