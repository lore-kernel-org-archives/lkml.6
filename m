Return-Path: <kernel-hardening-return-12654-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvocRqgorOE/WLYZsOt6WA16GjAyZWdNOfDJ5iYlXYkMAnCY1mMRFkutyWuV8bgaVHS2sKF
ARC-Seal: i=1; a=rsa-sha256; t=1521157636; cv=none;
        d=google.com; s=arc-20160816;
        b=utguiMeZvT2IeA5wD4NQ/Xa7U+Hz/T3h/J/IXIa4GWg3nQQ3zuPadiMLrEHtSSie7z
         g37LOwR3Ps3aBdXY6GciCHhY3ESRoPsP2237z7uItThN5w8rIcwCqzA4dcQ7wiuNDSss
         0oN6jO4ehuWLMmcvNuRQQ3eVkc/DXEgH3Lc5MnkcjKWUe8+R4Lm9Zyps7kaFy9HUX0yU
         WZlARgun+wBAw/+REJ4CQN7IGLxJ8Yi2K0u/gF7NDmEe707aB3rKSvhKcsmcE4tgrAJ1
         o94liBA8e5mHJf98FLvK1C30Bh01KvDTpwJB4ag/4E6os1TUV2rJTTuzBMZ5nbXHzlXx
         AJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=gXBIuPhkn1Z41ykdvcMOIKoM12GcInqOhhOPHqm757s=;
        b=uWN9Np1tdRtoJQO0KB05w5nvR7YNeK97HHEVaAegKQMo1nmeMVwcfSBMIp+8XNe7Jb
         LRGcipSjmInlFc/zxj6v0LRQ8zGAmGfTHXWjyI8QMLzrqXZKar2Cblhjeo6SANkw6pEW
         PvKSP5JaI4LwRlYX2gJYxy/PCR4JwCPI/ffZ2XH9TvOma1P59MHyTCxAwbqas15/ZLhY
         k//kMm2Ht8BxCaKhUuwPP5NZM890IV8BOkh1fZz+LCNUvTKY0+wvRr1uGse/VhltjzND
         wrI3eEXzFTrL3HXCV2/51+ned+dQucAkafzUMJt3mB0WiU9ARWDG/x3VOvkaPWm2hfQH
         9dWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hTcuQPpx;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=CPuEt4Uo;
       spf=pass (google.com: domain of kernel-hardening-return-12654-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12654-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hTcuQPpx;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=CPuEt4Uo;
       spf=pass (google.com: domain of kernel-hardening-return-12654-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12654-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jLHW00UmSDyAmdLpin6L636XbP3brH=pn4qh1bN87AirA@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
 <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
 <CA+55aFzO12QMFJHe8osoWfph8jnjgp_jLUQWmgbNmth_KwPxXw@mail.gmail.com> <CAGXu5jLHW00UmSDyAmdLpin6L636XbP3brH=pn4qh1bN87AirA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 16:46:57 -0700
X-Google-Sender-Auth: OhXvZ_eMViHJrbEKhnmTtqbRZwY
Message-ID: <CA+55aFyRV9KXzeQZpVYsZYVUJm-ASgu_4_1+8Y8-0KH-YT2M8Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034361293703830?=
X-GMAIL-MSGID: =?utf-8?q?1595049389583985129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 4:41 PM, Kees Cook <keescook@chromium.org> wrote:
>
> I much prefer explicit typing, but both you and Rasmus mentioned
> wanting the int/sizeof_t mixing.

Well, the explicit typing allows that mixing, in that you can just
have "const_max_t(5,sizeof(x))"

So I'm ok with that.

What I'm *not* so much ok with is "const_max(5,sizeof(x))" erroring
out, or silently causing insane behavior due to hidden subtle type
casts..

                Linus
