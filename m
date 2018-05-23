Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZozBaCjvZGUm3jw5L9mg+PgRZr8o0mHvLGl6jDBWhyg8s5VKS6kpgeRbE5eLYteYLOM5/h2
ARC-Seal: i=1; a=rsa-sha256; t=1527042276; cv=none;
        d=google.com; s=arc-20160816;
        b=yoKsznQzrM46U8QTQcTzLrkwdcjbByKdbA+2uQSBJaSdA5DgtzHc+8e0uEOPIB8kZA
         WHxfFAObJojZ9CLxjlulqxpIsLm/Dk+B1fRGYR13W8/n7UWwuo9naVMbonZUvk5f70Gc
         pzVlej5lNw9hR1RZiCwHwPxvdGM38N6Qx7AOEWo+XNBU3TJuUXTmNvc6hUd8EloL795m
         0U6sKuLRTIb03bXz+O3WTQSKya7R7MdGHzWDWqsLUEykI9T3g9NArb3t6bQndFRzBeJc
         2X/YoLklbNJAuiLBFcIV+6PUR5hY/27JWnGXRaGAC6cp2LrZ3g/vLkBTWLYJVnQWLC5/
         YzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=eByMF/nMJSh+MR2NsdGGms5DrH47jsT16JrrcTpEF7U=;
        b=bX9fbE5gvQcVqKkkmviAcW+Rl1Bj50a1nCE0o5KEmRJUxsVHG4mOrz+ywOxfayqf9d
         tt9wKWNJa+pz88y2rDgGW6YvkPadIJCDbyitbdKF6htgRSqwf7YHldZBaPCgPawOVreK
         /X02DweqN7zobdenqCRiPpLX49Xbf49KEn+qSEQqi3DmqkLHUcLb01Y5pO2zO0sEFxdY
         WaG7OskVtcZOjAn9bZQ2mBVH/LEQeMJ2sRJmwGHaxErr84szupV56JKDbAMsLZKeGcvh
         8SCEH2YnTvBmDGeNPOJW+wwy4hAwZZSfDinVw7NQ67E2mjursESblsnETsIi+bcxIwZT
         +JUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=idpp77Wl;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=idpp77Wl;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w4N2OJgA008914
X-Nifty-SrcIP: [209.85.217.179]
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQUF6YbHRTJOtQ9F91M-iqF1U+PemDAbsdx3qzcqg4Ufw@mail.gmail.com>
References: <20180522194928.GA29900@ravnborg.org> <CAK7LNAQUF6YbHRTJOtQ9F91M-iqF1U+PemDAbsdx3qzcqg4Ufw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 23 May 2018 11:23:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWHeR71=H5Z94jAMjRjE-kmjFaPrQy6_cd5=G_WHEpUw@mail.gmail.com>
Message-ID: <CAK7LNAQWHeR71=H5Z94jAMjRjE-kmjFaPrQy6_cd5=G_WHEpUw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] kconfig: drop localization support
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601195024335317921?=
X-GMAIL-MSGID: =?utf-8?q?1601219882716438607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-23 10:40 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-05-23 4:49 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
>> From b243b06da1417efe01ca7041371f4597584f8a10 Mon Sep 17 00:00:00 2001
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 22 May 2018 21:36:12 +0200
>> Subject: [PATCH 1/1] kconfig: drop localization support
>>
>> The localization support is broken and appears unused.
>> There is no google hits on the update-po-config target.
>> And there is no recent (5 years) activity related to the localization.
>>
>> So lets just drop this as it is no longer used.
>>
>> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>> ---
>
> Thank you for cleaing up!
>
>
> Ulf Magnusson originally mentioned this removal some time ago.
>
> So, here is his tag.
>
> Suggested-by: Ulf Magnusson <ulfalizer@gmail.com>
>
>
>
>
>
>
>> The patch is on top of the series "kconfig: refactor package checks for GUI frontends"
>> It was triggerd by a comment by Masahiro.
>>
>> I have compile time checked all targets - and checkted that they starts.
>> diffstat looks nice, and the simplification of the Makefile was worth it all.
>>
>> I considered a stepwise approach, but changes are all simple so ended
>> up with this "all-in-one-go" approach.
>>
>>         Sam
>>


Just a nit:


PHONY += xconfig gconfig menuconfig config syncconfig update-po-config \
     localmodconfig localyesconfig


The 'update-po-config' is left-over in the PHONY assignment.

This is simple, so I can fix it up locally.






-- 
Best Regards
Masahiro Yamada
