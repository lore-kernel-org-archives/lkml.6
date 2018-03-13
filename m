Return-Path: <msebor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520955675; cv=none;
        d=google.com; s=arc-20160816;
        b=NZfIzjVvDJhcNLcoqRMQaFXOaFmQwQqrE5swuShDmB64JaP79uyMnaoDhgKp7vDvD3
         GuYRd43/8Z6DPeD6yIOtYrW3rM4J0U+w2FFs5l6qbGCJCr1Hj5x+zpyrGufZ/mfywnlS
         1Y4RKIXL+KxWvDODUwSoAGRB9Qr/ISRDrwaFADsCIxW6srbofFppr8SeyeR3hRFGqsSK
         cyNz6J5KLTeIdt/jlrI369rWfIkVa+6Jv18gCooBHVyTd1admz9WGPruGEsXbSBIQYAA
         xeG+8iYa+67uL+A8cJThsQjYhg45K5MLsF9t2aiHDWKt8EKoQ5kdrh3BIIS0DwZUKOC2
         ajRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=BVldaviVHhVnx5VeI980KRW01vbMgdZPBeElPEnSibc=;
        b=jCLHCgZmzifEcggalTw6XilBgP/Mp5XnJzXDaoXgbq2AIG9DqvVjM6Glh2+Jq1z4HC
         /vLyJX6sZdoLQoTD86xtReYIcTEGyDf5yI4LE9hZJFV+xikGqO4YUmtwTmOx5q1WYryY
         JynngDePmJQQg7v9wFMV3AJ+PXHwv0FEb8EFWnedXXXkXlFoeMCg+RtRiwBWaCJiVrn+
         /CRmuwzA4AAhfgE2++1sJ0AdBfE3oEc9A8Z/rEv+29sQ0Wdpoey2g/pyIgPHkDfdfwR6
         zDnTT82wVZ+gKKvzQAB0HPnzeSziTfhvPntGFZVZp3vYfH32IXCHi18GhQJpVzAYLm+n
         7L1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CamNvBCd;
       spf=pass (google.com: domain of msebor@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msebor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CamNvBCd;
       spf=pass (google.com: domain of msebor@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=msebor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtd2mVnh+AlZ8uIlQAA9KRxkhAL33Svgr3FMH1l4h28lVJbN1GqElc3PyJGdSJodQ1phAInew==
Subject: Re: [PATCH] Support the nonstring variable attribute (gcc >= 8)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <20180217191035.gol4woxsgzpo4bfq@gmail.com>
 <alpine.DEB.2.10.1802181519400.205822@chino.kir.corp.google.com>
 <CANiq72=jgAzCDoU2Vkq0zVKNCDvwhPT7Eqpy5Af6W3=XacQnRA@mail.gmail.com>
 <CAK8P3a1d-DnF58zZqxMYE3DrtZO9Bs3a2o-cuvTupnJeTeG2ww@mail.gmail.com>
 <CANiq72mcBGXOw_YgtMFWU8VV5irhuDsb-VRuPjeW9=SbHuyRsw@mail.gmail.com>
 <d76825e1-6e0f-a75c-21b0-3501dbc9d7a9@gmail.com>
 <CANiq72nZRzMDF2ZpT1rOnyMvx75XijRpuWbymThV9Uy06WOBrw@mail.gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Rientjes <rientjes@google.com>,
 Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
From: Martin Sebor <msebor@gmail.com>
Message-ID: <cc031f0f-7fc7-4bf1-c99e-020dbf41d836@gmail.com>
Date: Tue, 13 Mar 2018 09:41:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CANiq72nZRzMDF2ZpT1rOnyMvx75XijRpuWbymThV9Uy06WOBrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592676488865934389?=
X-GMAIL-MSGID: =?utf-8?q?1594837617518893862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>>> Martin Sebor also asked me about this, he's the one that worked on
>>>> the gcc code that introduced the warning. Sorry for not replying earlier.
>>>>
>>>
>>> Maybe you can pass this to him? (maybe open a bug in gcc's bugzilla?)
>>
>>
>> I've opened bug 84725 to extend attribute nonstring to the other
>> two character types:
>>
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84725
>>
>
> Thanks Martin! Please let us know whenever it is in the gcc trunk.

No problem.  The patch has been committed into the trunk of GCC 8.
Let me know if there's something else.  It may be too late to make
any more changes like this before GCC 8.1 is released but further
refinements to suppress false positives can be made in GCC 8.2.

Martin
