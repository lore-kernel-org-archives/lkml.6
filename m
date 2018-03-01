Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519921395; cv=none;
        d=google.com; s=arc-20160816;
        b=TYDlKw+H9TLBF7dZ2WRinNJwg5s1gSeBuz4UUsrQR9q5FhEGcnnxgQFxUK2aWUrPIC
         azNTDPx/fUNYEL2Srx4GFN1i0NDg76F694hIrWycleKdVsi2XqojYxx1EzoTQt4EVLGn
         SKPsEVOc7D0n8S95KrRwyWKzC1vsMF/rtXruYHSKW8/XUHUd5ezG1IWIOHY4F8eIb3fq
         2Aue1hzzqe9ZO0BIVdOKuo/LqR81FOp7qnc7yOJlRdZMj+t27yYIzMlHhF7HhXxRqiHZ
         Zhgj8wDxqj5xl4GxhaM4ywU0meMaP5KFuhqOP+KDuCxRGojhOejmwX9OTOpH5BgE+ctw
         sMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=svW4ZtT3d8Ky1L43fjcMPbyE+chJwsq92DVRkaM1Wgg=;
        b=apJrW/UWZdipY74LGeF9re9uD6vqUNJw07hV8ngl337yBd2jHrpcz43PTPa+DJenbF
         LOAo881cqkXhvtnl5ZH3E5Ai2oBXCqd5uzjZNoKajN/a+rNZXe97ASlUVQ4CvRWcJkHd
         Oi+2BJFsXkLeEKe3UrWG/BWg8+8ySpWY7Oi93Pq6lZzOm7x2uo2atlyYsd0hmANYE/8w
         t/XTJQVtGttgCHhou1XHOgK66a7kE0zokkL/TDMap9ur1zZshbauJbQoSuc0/y9WdJ3m
         xN4s0XkrI/iKxaYoRvr5dMrQm/Y3xcGZLXWvZn2jVdJGXMI7jAUu5RSkzhbiSPuoo6f0
         2Xtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QH6NFtAQ;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QH6NFtAQ;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELuoEkEofLU4GjmevkNzmCZaVkUEadiDIGtxQyO+dMG8RiZ32s/O6jQua9xpjGZCV3t7HG3rs/5IYr962PP6PyY=
MIME-Version: 1.0
In-Reply-To: <20180104112028.GA7583@kroah.com>
References: <CACT4Y+ZNJRzPxxPQNR88vcPxD54mHY-evhMwR39iMsJh_NwaEA@mail.gmail.com>
 <20180104092327.GA26245@kroah.com> <CACT4Y+aN4TxTE4PYjL7Uos7hatWMonU73As5ddq8iU0cPb29rg@mail.gmail.com>
 <CACT4Y+Z_DV6sgQ7FodoxBj8MdVkcij3bS0P1pp9GOMDS4-f92A@mail.gmail.com> <20180104112028.GA7583@kroah.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Mar 2018 17:22:54 +0100
Message-ID: <CACT4Y+Z2-Z6GN0SDb5jySJkCrTRxf9qvdzuyM_OoruCTB9EoqQ@mail.gmail.com>
Subject: Re: LKML admins (syzbot emails are not delivered)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, syzkaller <syzkaller@googlegroups.com>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588652385455174541?=
X-GMAIL-MSGID: =?utf-8?q?1593753097546797559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Jan 4, 2018 at 12:20 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>> > On Thu, Jan 04, 2018 at 10:09:16AM +0100, Dmitry Vyukov wrote:
>> > > Hello,
>> > >
>> > > Some of syzbot emails don't appear on LKML mailing lists, while they
>> > > were mailed as any other emails. Here are few examples:
>> > >
>> > > "KASAN: use-after-free Read in rds_tcp_dev_event"
>> > > https://groups.google.com/d/msg/syzkaller-bugs/nEeIAsNLWL4/1GzamOmRAwAJ
>> > >
>> > > "general protection fault in __wake_up_common"
>> > > https://groups.google.com/d/msg/syzkaller-bugs/4TrrZ0bIViw/rBcYLUJHAgAJ
>> > >
>> > > Does anybody know how to get in contact with real people behind LKML
>> > > and/or bugzilla?
>> > >
>> > > I am trying to understand why this happens, but failed so far (it does
>> > > not do any obviously prohibited stuff, and replies to these emails are
>> > > delivered).
>> >
>> > You should get a bounce notice from vger if the email is being rejected.
>>
>>
>> The problem is that it's not _me_, it's a computer program which uses
>> some mail delivery system which I don't have full visibility into.
>
> But you, or someone, should have access to that email address to see any
> responses sent to it.  If no one can, then it's just a spam bot and if I
> were vger's postmaster, I would blacklist it as well :)
>
> Good luck!
>
> greg k-h


The problem strikes back.
Again people complain that a email does not appear on LKML:
https://www.spinics.net/lists/kernel/msg2735905.html
Though, it appeared on syzkaller-bugs group:
https://groups.google.com/d/msg/syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ
https://groups.google.com/forum/message/raw?msg=syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ
syzbot now receives and logs bounce notifications, but there were none...

FWIW I've filed support ticket
https://rt.linuxfoundation.org/SelfService/Display.html?id=53105
