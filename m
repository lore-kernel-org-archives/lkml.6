Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518368071; cv=none;
        d=google.com; s=arc-20160816;
        b=szOBunr6DKwmej21ePqoirowt//17gItVzIYf1PXFdkeP9KTgmhr4G5DBQHTju1lH9
         Vv52tVF3k6Xzi7W26hg9Dheu8n/5CsgDaSNCG3orVFMyQg939vHpm5y1ZakwLGnOFlNM
         y4eNkl+uJNTkyW9MT4oteLaob68zYwYhvwr+UXaoi6kH1r/2g6zM8xN0AeCZAHTqE2u8
         Sv7n2uOzRzJZgfszDS8sT3/TWW+8ZodoPhH9lriP0hvRUtGFQllKEqLfRcNqavJo4YHL
         CDocWTzMpBy3e4auB7ztiBh553lV2R3FUn23nbLApQ18w9+x7Mv4YFy7xZSfG9xsWJtH
         2pxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=L5/lIblhSt4e/vq8V6l5cy+0+IASedlDPzll0b1sDHk=;
        b=FoObLb6Q5b7a0wzvchI0UFSAqNIeJIhLpoZ+XM2+Qzg7wXkPU9qjyiZAs+m9LhwbgI
         S941GThPhOPxoSaGfi1w9nAarkCNoWBRsgr+VzEsmSzyqedMqKZW3MKWyj6Tg7sxEopf
         ZtA9GlkoBpaoxJUzNNtMWuYG73DNunIX7WP9bwJNwYnBem+NcZ/Qjse0UV1zKY3VYvtl
         yQg+x9dFYtq5EKq+cu3w+zhnkU2tlltmTPtGmpWU2l4iJYybP0G/YaS5qIyeRqqPKxVH
         ssLdYFJnY1X6oDYzyTREI2EoRRq/b2Ug+imfC/xfwBrAdl87K8cwjguHsxGEbpU2j4mG
         v/aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CT0/tBFF;
       dkim=pass header.i=@chromium.org header.s=google header.b=czmURFT1;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CT0/tBFF;
       dkim=pass header.i=@chromium.org header.s=google header.b=czmURFT1;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x224xjpTRQUuhnmR0Wy9X0f5QUEdIa9NfIvzFgFeSCYysnpbAYjBCQZwzVmqKhXG4cuLG6fdUXvvr/GhwdHurH/U=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com> <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Feb 2018 08:54:29 -0800
X-Google-Sender-Auth: ErJn72A6nhwoI-pDu82phzuUvbM
Message-ID: <CAGXu5jJXn0YgPz9fzrHrWOhQCB_+iN2TJ4AQXjozxh32pBowhQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592124319031107439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 11:28 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Feb 10, 2018 at 8:46 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Argh. I wanted to get rid of all that entirely, and simplify this all.
>> The mentioned script (and bugzilla) was from 2006, I assumed this was
>> all historical.
>>
>> But if it has broken again since, I guess we need to have a silly script. Grr.
> [...]
> Oh well. It looks like we really have to have those nasty exceptions
> from the normal rules.

Yeah, I was really disappointed to discover the broken gcc case Arnd
had while I was testing the new ..._AUTO option. I thought I was going
to be able to throw away a whole bunch of the complexity too. :( And
this was on top of the recent discussion about raising the minimum gcc
level to a place where there wasn't any need for the "old broken gcc"
stack-protectors checks. But, no, that would have been too easy. :(

-Kees

-- 
Kees Cook
Pixel Security
