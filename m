Return-Path: <miguel.ojeda.sandonis@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520956691; cv=none;
        d=google.com; s=arc-20160816;
        b=xjLkskzwGLC+UDQq7zj8wm6bORIdC3zQiSXAfzFeLlwtfFJ6sSNLNy0Lh2lC5HPvIg
         3L4NcHSH6oMacN84m+sqNHPXJ6pgQ6Le0G+Ea8M39E/7hKvNO/RdXQqYZLwK6iqsOrVr
         zwkkvmYkcB9bMdibIkAP5r7OypDXlWEFEBQlfSoSSNOxwtFpRWe8ORH2DAcf3q7SAmUH
         rx5/7qLii8bwFSrMBz4SnoOma+mk+0WJWmRpoeF9tAa3yq1LMOcNIcVHYgVy0CTlpzek
         QU4JlvzbsJy4i7b7BdhzvSWZGbp9HYd1H2orVduXDr1dR0p0PwYkE2iyjzYiEXyuAk0M
         vngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2xpGIz2JXcNdG9BkYNUQGjb2gyPriRmFNxpxjIXc69g=;
        b=TUzoHrPF1qSlQO9xqjrW8XwiEjLDCtBu2Ilc3kh/Y5Cv42JOEUgbi6Vnftwv2oWaqE
         yIrNiua7L23o6lZ5QP5MjkMri8jhlwd+Xamhc3YAuF31WjrCKj8cVZvfIlR7+AiHamVT
         yc7vl8rhXCYtZcfKIFHf+5qXpCl4M5sC4gJqKy9naD6wSvRKQivv4CO+3tWj/twrDsZl
         16uNa9Y2J5KoOl0jfF3nccvTmVHCR9So1sQMtm4ON4Egs8KAbWZ5p+GjbbQYt93o1jhn
         roaW9qP03Yg6iVzHbtXNrmi0St3vzudKmLGA6GLW9rXoi0z2S4kDG+wo4MNLzIo25H3/
         hfPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QucsxXnC;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QucsxXnC;
       spf=pass (google.com: domain of miguel.ojeda.sandonis@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=miguel.ojeda.sandonis@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuEM0/x/1QJiv19ztK5jsMFUJIzthIzWEg2t9zBUU0n1AYRGrLhDKIgNkT9hW27vVQ7VTvRdhTcZG2d4rDuEoU=
MIME-Version: 1.0
In-Reply-To: <cc031f0f-7fc7-4bf1-c99e-020dbf41d836@gmail.com>
References: <20180217191035.gol4woxsgzpo4bfq@gmail.com> <alpine.DEB.2.10.1802181519400.205822@chino.kir.corp.google.com>
 <CANiq72=jgAzCDoU2Vkq0zVKNCDvwhPT7Eqpy5Af6W3=XacQnRA@mail.gmail.com>
 <CAK8P3a1d-DnF58zZqxMYE3DrtZO9Bs3a2o-cuvTupnJeTeG2ww@mail.gmail.com>
 <CANiq72mcBGXOw_YgtMFWU8VV5irhuDsb-VRuPjeW9=SbHuyRsw@mail.gmail.com>
 <d76825e1-6e0f-a75c-21b0-3501dbc9d7a9@gmail.com> <CANiq72nZRzMDF2ZpT1rOnyMvx75XijRpuWbymThV9Uy06WOBrw@mail.gmail.com>
 <cc031f0f-7fc7-4bf1-c99e-020dbf41d836@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 13 Mar 2018 16:57:49 +0100
Message-ID: <CANiq72mqdz=TjZYeK_HcW4O6MjYi7tsajgZW-9FiZL7BS38w6Q@mail.gmail.com>
Subject: Re: [PATCH] Support the nonstring variable attribute (gcc >= 8)
To: Martin Sebor <msebor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	"Lendacky, Thomas" <thomas.lendacky@amd.com>, Will Deacon <will.deacon@arm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592676488865934389?=
X-GMAIL-MSGID: =?utf-8?q?1594838683232139162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 4:41 PM, Martin Sebor <msebor@gmail.com> wrote:
>>>>> Martin Sebor also asked me about this, he's the one that worked on
>>>>> the gcc code that introduced the warning. Sorry for not replying
>>>>> earlier.
>>>>>
>>>>
>>>> Maybe you can pass this to him? (maybe open a bug in gcc's bugzilla?)
>>>
>>>
>>>
>>> I've opened bug 84725 to extend attribute nonstring to the other
>>> two character types:
>>>
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84725
>>>
>>
>> Thanks Martin! Please let us know whenever it is in the gcc trunk.
>
>
> No problem.  The patch has been committed into the trunk of GCC 8.
> Let me know if there's something else.  It may be too late to make
> any more changes like this before GCC 8.1 is released but further
> refinements to suppress false positives can be made in GCC 8.2.
>

Thanks a lot, I see it in gcc's
2bc9729cac37dee999f4fb48a166cffc198293aa ("PR tree-optimization/84725
- enable attribute nonstring for all narrow character types"). I will
compile it and see how it goes.

Cheers,
Miguel
