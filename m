Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520845023; cv=none;
        d=google.com; s=arc-20160816;
        b=cGL3ehQe7rmgDTm+gRjeeneL4kSk6vKgrbeIW0iCPoB1H8NAiwxl+bPPkklZ8LJPQc
         ZZXTd+1quMdS57jqMf3E2DxF2dyOcuCSFqJIaxKS70hHMLZG+2g77FC/I3PsvL5Us2wI
         5QB1ZT9i/sZcdo0MuVtcdwHopSfV5IdUeeaLi2SGhJd/5fxAMjsGeLCXdbdN0wA2+NQW
         7iXpgoSp9iL5Z76RnEvuAsx8ys6tnHqNvOpN4fN5vVxfq3HYxMwo8va92I0X6EbtzXFZ
         H/YBe2XqU0XGRhn5lUvtLy98bo+LYxLclucz4PdTQwp5HaBilTkHjnSvoSeWAeUmNfJE
         N1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bq6uDqw9+PrN9wYmEEnfHHsm/oJ9CTcx8tovGYqOkek=;
        b=0+NpHMK3Bran1ES9xxaQQJc+jeMzMbkrlk4EvisDy5wpO+nqZzN6frD7MOGW1QRVeA
         8C8llAbu2H4K9hifIxyIr8o7ySl8Gqlji7W0Lmn+OxKmHPXozDPq2tN0anq+vrfgQHM0
         QU9Ugeyl2X/ZwpIWoCGwjlDdOkyN5Tx1+nd8QlxjagmC8o5DrAVCCTOAWujPEA+t92S0
         oDx8DAgTKJLmXGsiworMPO4cmGvvXhMv/DuKb6TW5HuYr/DqxI/X95hZDrURxMEtfL87
         5i+4tJFtqMbW+5tWHlRLKoLSE2zgNHaPWiDsumz5h+S7DRqHsgJGtG0/h6E5uifSyAwR
         onxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wSz7Ct5M;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=wSz7Ct5M;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtLo9e7Q6o8G0NeL4fPezb+7GHPrfRKVu1BAQf+j2X3xZpNiAt5wtRVBfT2KJHMnjrVVlUSaPGhtW3D8ds1lvg=
MIME-Version: 1.0
In-Reply-To: <20180308.150309.1043571795208899259.davem@davemloft.net>
References: <CACT4Y+Z_DV6sgQ7FodoxBj8MdVkcij3bS0P1pp9GOMDS4-f92A@mail.gmail.com>
 <20180104112028.GA7583@kroah.com> <CACT4Y+Z2-Z6GN0SDb5jySJkCrTRxf9qvdzuyM_OoruCTB9EoqQ@mail.gmail.com>
 <20180308.150309.1043571795208899259.davem@davemloft.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Mar 2018 09:56:42 +0100
Message-ID: <CACT4Y+Z7E1e05R1pBhS4oD7Moy8sn3N7POvuDTCYNDYDc_uE=Q@mail.gmail.com>
Subject: Re: LKML admins (syzbot emails are not delivered)
To: David Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588652385455174541?=
X-GMAIL-MSGID: =?utf-8?q?1594721591151500424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 9:03 PM, David Miller <davem@davemloft.net> wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
> Date: Thu, 1 Mar 2018 17:22:54 +0100
>
>> The problem strikes back.
>> Again people complain that a email does not appear on LKML:
>> https://www.spinics.net/lists/kernel/msg2735905.html
>> Though, it appeared on syzkaller-bugs group:
>> https://groups.google.com/d/msg/syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ
>> https://groups.google.com/forum/message/raw?msg=syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ
>> syzbot now receives and logs bounce notifications, but there were none...
>
> The problem is that the name 'kernelci.orgbot' has a special character
> in it, namely "."
>
> And when such special characters occur in email headers, the string
> in question must be surrounded by double quotes.
>
> People have to do this when they use my name "David S. Miller" as
> well, for example.
>
> So I think if you put double quotes around kernelci.orgbot when it
> is provided in email headers, the problem will go away.
>
> Please also make sure that multiple From: headers are not being
> generated or anything like that.


Thanks for looking into this, David!

But I don't see kernelci.orgbot referenced anywhere in the emails.
E.g. in the one that was linked above:
https://groups.google.com/forum/message/raw?msg=syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ

Which one do you mean? syzbot takes emails from get_maintainers.pl, I
guess kernelci.orgbot is not usually there. And syzbot does not
includes names, just email addresses.
Could a dot in email address produce the same result? E.g.
To: foo.bar@something.com
? I see such addresses in some of the emails (but not in the one
referenced above).

Is it possible to revive autoanswer@vger.kernel.org? It would
hopefully allow us to debug this without bothering you.


Possibly related, when I am searching for "syzkaller" I am finding
entries like the following titled "This message generated a parse
failure. Raw output follows here. Please use 'back' to navigate.".

https://lkml.org/lkml/2018/3/10/73
https://lkml.org/lkml/2018/2/27/581
https://lkml.org/lkml/2018/2/22/774

Could this "parse failure" explain the undelivered emails? How can I
figure out what exactly caused the failure?

Thanks again
