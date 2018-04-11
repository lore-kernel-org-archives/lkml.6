Return-Path: <kernel-hardening-return-12970-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/sVAt9+x/cSU4Jhr6PgfH6G0sDOmbaB6lLG5GoPxttdGLfBkqED6Nrd+DFvP0U/Qm68aym
ARC-Seal: i=1; a=rsa-sha256; t=1523427032; cv=none;
        d=google.com; s=arc-20160816;
        b=cpzU2e/FmyXSQ8ATqtoZQZBUV23A6+3sbS7+/fd0PmHR+xYWli5CUiZhxFbZ+KCb/D
         Ey4Flu+LphZjKcNBFoQP/+Rl5BEwXXC8x392GTHznUOnptkoaxrZn2Ald1Ra4GbDz6ia
         GSbCpCEzAMW4oMtCxTFM16jl/eTlb0CxWoS7NNCZiNxv6OWCNTgheNXKRnzFhvMxmzaz
         TEH00MW/0rYFgaVVYkMQGGI65WVs6WxDPINt1vvOvZt+FXkesM+hf9f5pJtjTm47PP/v
         tXP5N2FjyvNXDEm2LR23CH/eWnT0IKxJBP3+mMtJgsfzS+33L8dl+Yx51tZ/eyMZtoiT
         Wgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=KiaJn3fMXul+0D8ySFqNIjco5teJSjCN4WGC/8K9lhk=;
        b=P86Xdr4V4eWlenXm/BDkimJq9GbA+/Ip+JLYAOLOrnFEXvYhm7RFlBrZ7VwCQRgQRd
         xOeeplYzRX7PWwYDcAZftM+hde4Tt66aLPstv+9KdHaYr0/0LayvzlxVBno7C02ha36h
         iPUBXD0G2CEBKFiME+GSrfADpt4/FdQdGv/Itd3wxYc9khanHbzXgWLkoL3Glkj3Foit
         9vwdElM7qR8lWUFiVTimSR6dJhYwjcDjLDgw1xP4SSLZ5oLZYmKoQCIcUo89o7SjxbLG
         O75t/NHG/EUyTWiReh/THFkzk2hGxD6/JuxTMeEgANO/JVQVSaUD/f3tQRfSYDmWm61m
         pS2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kyfwjsgr;
       spf=pass (google.com: domain of kernel-hardening-return-12970-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12970-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kyfwjsgr;
       spf=pass (google.com: domain of kernel-hardening-return-12970-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12970-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKXMx1hzQX6g=Y51mdTgHoYp4vuVUvri3=s7Fn9NgmZmA@mail.gmail.com>
References: <1519729200-16056-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5jKYSRqsHo8rqvyR1ZLQ2MT+UnG=F4_RTEp7Sq9q9qsPtw@mail.gmail.com>
 <CAGXu5j+RELwBqkLrpQ0zHdHM3u2FxgcKokumtSS8KpkCeUgT2g@mail.gmail.com>
 <CAJHCu1LAvw5N8cXr-L8goEXUN5+jAdC4aUv3jNW0FxO9W_VH1w@mail.gmail.com> <CAGXu5jKXMx1hzQX6g=Y51mdTgHoYp4vuVUvri3=s7Fn9NgmZmA@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 11 Apr 2018 08:09:49 +0200
Message-ID: <CAJHCu1LCwxRmcMr0V4GavxT4DEiS1PMUTSQ_XyVrcXYHCcQdBQ@mail.gmail.com>
Subject: Re: [PATCH v4] Protected FIFOs and regular files
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, David Laight <David.Laight@aculab.com>,
	Ian Campbell <ijc@hellion.org.uk>, Jann Horn <jannh@google.com>,
	Matthew Wilcox <willy@infradead.org>, Pavel Vasilyev <dixlor@gmail.com>,
	Solar Designer <solar@openwall.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
	"Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593551596949260408?=
X-GMAIL-MSGID: =?utf-8?q?1597429023633726732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-10 23:23 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Wed, Feb 28, 2018 at 1:22 AM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> 2018-02-27 21:22 GMT+01:00 Kees Cook <keescook@chromium.org>:
>>> On Tue, Feb 27, 2018 at 11:47 AM, Kees Cook <keescook@chromium.org> wrote:
>>>> [...]
>>>>
>>>> I think this looks great.
>>>>
>>>> Acked-by: Kees Cook <keescook@chromium.org>
>>>
>>> Tested-by: Kees Cook <keescook@chromium.org>
>>
>> Awesome! Thank you very much for your help!
>
> Salvatore, do you want to send this again as a v5 with my two
> follow-up patches, as I have them here:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/userspace/protected-creat
>
> or would you like me to send those?

I have no preference. You can send them, if you want to.
I have no problem in either case.

> I would expect this series to land
> via the -mm tree, since that tends to be the catch-all. (In which
> case, the series should be To: akpm with everyone else in Cc.)

Salvatore
