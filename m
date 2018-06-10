Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id enejNy8gHVuWWAAAmS7hNA
	; Sun, 10 Jun 2018 12:59:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97448607E7; Sun, 10 Jun 2018 12:59:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIrfBj/o"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EF52A605A5;
	Sun, 10 Jun 2018 12:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF52A605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeFJM65 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:58:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44597 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeFJM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:58:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so8834828pfk.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CyVx3rPECO+kXmX0lqr9ulOw5iBa3ezodrqQdZ8d+3A=;
        b=MIrfBj/oYauGjR1EL4vAbxZ1pNsXygr664fQojZ1WsQfbEJ4bAAokZhPxBbQX+8RQ9
         Sy8hd+qvXeHEvd77Jzp19IND/4TdDoxTJHEAAGd9OCr+1P/fnLar0qVscTomcl4PZS3l
         qG6C7EzBuNAjZ2olfaBcfuZFxIUdb3svYk/nFpNTOE1Gnirww+XXrm+B7XZ30QxQmoEE
         bpToBj9B2/34sHwcQk2NmBN6kEW4OSQkFBFy02Xgjnnpo/iTC0KUdNInuicn1MiDYI0c
         q4yWY2Bag4JUpAIvdqGip3okQpy6w3L1J2lvsUswfq6FrCEnoPjIUyqbFqk6CseYzobL
         bJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CyVx3rPECO+kXmX0lqr9ulOw5iBa3ezodrqQdZ8d+3A=;
        b=HWb5kVSqBdi4KImbqiGcSxS21i4ot/W+mS8CbfQUn5Z8M72sTh+1eSGX7v8NljfWcv
         96xfen0F0KYM+1WyjyYEC4o6YAsHUyDXqSddS3JzPyAZQzLZgAJWGkf3XDf3ZLWXm7rH
         BZQQvxu+ZBRPJQQx7pFfQHd+MKw04ZG1qw1CeLy+rzDMwdN3R/BT84YJ7TjyoErwbKe/
         8sGis4ijBhZ+2l9vuhvpFQz1DCU7/ywu27jxk7Uy5WwOj0Jiih0GRojFzU3U2lC2XE55
         9UP0QR6xXBgyEmBlEkFjsxWtjZZicbSwnL9xTNIMwh+AUSNC0vxyXrZnRjHM5fOiuUHV
         fxig==
X-Gm-Message-State: APt69E3uxnd07OO/3zue6QhC4eI+lFXbGIRIeRdlhYYbCb/tKM+YfF+O
        nGH/+PdC0Vrk6f84sAB/J+l8blUTH2rVdqzDYSPdMQ==
X-Google-Smtp-Source: ADUXVKIe3EsSU5qnvuc4ZK7FcXHZK5uLmsW7qb+XBByOQmLQkN5ObkWuTRSiEs8U7Jl/vKpRcmadgIufOKdRa9q4dgg=
X-Received: by 2002:a62:a38d:: with SMTP id q13-v6mr13660648pfl.49.1528635534378;
 Sun, 10 Jun 2018 05:58:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Sun, 10 Jun 2018 05:58:33
 -0700 (PDT)
In-Reply-To: <13f6777a-2170-d0cc-1066-1b48a27ec981@i-love.sakura.ne.jp>
References: <00000000000092de58056e3d4b96@google.com> <10d6b170-b820-3077-8737-c9d06e98d0fb@I-love.SAKURA.ne.jp>
 <CAJ+HfNhnmvTHsE7cgi8pROjprsYvCZuzZDmYmpiUx4jqtHboUw@mail.gmail.com>
 <CACT4Y+bfZK6yucoDrXPPW3Tc40RYq61u0Zcb=CKtdao8E+v1cQ@mail.gmail.com> <13f6777a-2170-d0cc-1066-1b48a27ec981@i-love.sakura.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 10 Jun 2018 14:58:33 +0200
Message-ID: <CACT4Y+Y6TDof6vvdQYHF_W8aAgHPuW_DS2A9HCudmYx549u0Ag@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in xdp_umem_create
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
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

On Sun, Jun 10, 2018 at 2:53 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/06/10 20:52, Dmitry Vyukov wrote:
>> On Sun, Jun 10, 2018 at 11:31 AM, Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gma=
il.com> wrote:
>>> Den s=C3=B6n 10 juni 2018 kl 04:53 skrev Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp>:
>>>>
>>>> On 2018/06/10 7:47, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    7d3bf613e99a Merge tag 'libnvdimm-for-4.18' of git://=
git.k..
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1073f68f8=
00000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df04d8d0a2=
afb789a
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4abadc5d691=
17b346506
>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=3D13c9756=
f800000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16366f9f8=
00000
>>>>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
>>>>> Reported-by: syzbot+4abadc5d69117b346506@syzkaller.appspotmail.com
>>>>>
>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>> random: sshd: uninitialized urandom read (32 bytes read)
>>>>> WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0=
x70 mm/slab_common.c:996
>>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>>
>>>> syzbot gave up upon kmalloc(), but actually error handling path has
>>>> NULL pointer dereference bug.
>>>>
>>>
>>> Thanks Tetsuo! This crash has been fixed by Daniel Borkmann in commit
>>> c09290c56376 ("bpf, xdp: fix crash in xdp_umem_unaccount_pages").
>>
>> Let's tell syzbot about this:
>>
>> #syz fix: bpf, xdp: fix crash in xdp_umem_unaccount_pages
>>
>>
> Excuse me, but that patch fixes NULL pointer dereference which occurs aft=
er kmalloc()'s
> "WARNING: CPU: 1 PID: 4537 at mm/slab_common.c:996 kmalloc_slab+0x56/0x70=
 mm/slab_common.c:996"
> message. That is, "Too large memory allocation" itself is not yet fixed.

You are right! I fixed it up. Thanks
