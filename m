Return-Path: <kernel-hardening-return-12656-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvKPvnjyMx0qrNLIXWkE1FGccUpNFAVWukUmeVq9lerHySK3EMxIWuvr/Vp2SYndX24fE1Q
ARC-Seal: i=1; a=rsa-sha256; t=1521157790; cv=none;
        d=google.com; s=arc-20160816;
        b=jIwQN99RZ5d5s/svZJoQvSLeFZPu9tz/3OwvyBekSeWJVo4sN5PLx7ZdZLBRbLfmF4
         70JRzNprBl0L+xkpynlGDgw5//9hXnUxaEo1KK4pn8dDzooizaFLuugb8nUpZluYXLGl
         tz8gB28MR/kDcxYoqtOLnvVuRKmqa+BSJKXypqb4mYLAWsnjpXpktMJifsqVaxuykQFA
         9uE1mMIuvFT69i7swApvOmV0CN1VAlzKS2X/NVL9FYuVv5+JpvTPDMSFYBHtfPXOp+fc
         l5HJy/Bg233iUbTp4J1fpn1M03Wdk4+9K7MQoEpJihtVxnrdywdSC8TpYiLjLkaGWmr5
         TeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=0qPZuSo13ekjujWaXPTIJyoFtAvJ5K9PaL/mhuUHGyA=;
        b=jMYqIBbPl2nj1ILmnDP9p/8SUVFuOewMKU3g3PJvrr28QImjwILHfuOAG+Ptl8jw1W
         lqhE7XAY2Ye16KgRKqmpL8ajR0g4nzalJPAzUY/q96QLibmY7eNQ7pNZGm3SuJiWw25d
         T1gVAnbpcTSKrKxbbT+orVqheqi+gXyceYSq7XIACt0NEc1myo25yWJf8c9qNcZZQmuQ
         Om5lfFQLw+62OQVQBmYL5rPdbWy5nTwpmHJbijU0qEyvSvDjD6OixDmZWSi642kZ5c5u
         juc79PWwSl4byVTzDw1ho73QwUhKo50n5QO6h/XXwkJhJTBrnCreps7hgdyjnJ3RPZwK
         vemQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=l6bhoDU/;
       dkim=pass header.i=@chromium.org header.s=google header.b=N5ttl1nj;
       spf=pass (google.com: domain of kernel-hardening-return-12656-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12656-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=l6bhoDU/;
       dkim=pass header.i=@chromium.org header.s=google header.b=N5ttl1nj;
       spf=pass (google.com: domain of kernel-hardening-return-12656-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12656-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFyRV9KXzeQZpVYsZYVUJm-ASgu_4_1+8Y8-0KH-YT2M8Q@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
 <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
 <CA+55aFzO12QMFJHe8osoWfph8jnjgp_jLUQWmgbNmth_KwPxXw@mail.gmail.com>
 <CAGXu5jLHW00UmSDyAmdLpin6L636XbP3brH=pn4qh1bN87AirA@mail.gmail.com> <CA+55aFyRV9KXzeQZpVYsZYVUJm-ASgu_4_1+8Y8-0KH-YT2M8Q@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Mar 2018 16:49:27 -0700
X-Google-Sender-Auth: GJQmnthEuhRSx96PS_T8Sn0TkC4
Message-ID: <CAGXu5j+Dv_wQgHWgT=9eSoKX7AcqnumuRsNFUoZ765WWizKytw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Linus Torvalds <torvalds@linux-foundation.org>
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
X-GMAIL-MSGID: =?utf-8?q?1595049550889944626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 4:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> What I'm *not* so much ok with is "const_max(5,sizeof(x))" erroring
> out, or silently causing insane behavior due to hidden subtle type
> casts..

Yup! I like it as an explicit argument. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
