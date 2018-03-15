Return-Path: <kernel-hardening-return-12655-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsgBCJ+oPSDROREQ9jbQodnMbhEZsqYrV9fqNRUgjOl6X/mtJU1wowdMeE+gx8lwv6MyInw
ARC-Seal: i=1; a=rsa-sha256; t=1521157676; cv=none;
        d=google.com; s=arc-20160816;
        b=Pi/2x/Bnb6dWyH9MYH/G/Hg3v2MZzuO51dpKfh+RE00/dJv88fIVJaockh0s820KIL
         /icWBn9uIyoU5lsdzo+ckjDbP/ZgLw9Ngan1/FCVxp3+gGTk1Jmq6iKBsBbNgrbpUNGq
         Tcj4ymI5q9z06z2xoPpbTXO+9IvrMLcX2ctmlTzbB9sjP6Z98P6tfWX8g59KIIV1cTHw
         ganXvSZdmTgfIpXFinplBbLCdNg1d5O09AMj3Y+MLhYgXeC0/bSqgFyLqaj8PjEkd50H
         067xIXDOUqDRVgxEWW9SAjq87IcmuFIwLZqtYMb+9Q627nr3jiO+MVGzD7KWmpYAb3/w
         Luag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=YfxEL/C+UbapbY05OqrmW379qZDl5IR3AXQXw8zjOJY=;
        b=YhkgEoXfZ9A29VmPdewz5DkZKybtQcF16tJzgea6s430KHS5ibGJyLc3Wxy6df4gkk
         5AH9ndPjwjkajKdu+MuL3Vpim2B4EclAeiQyE0RqkXZ15+PIYU+gNeWggsGiHlvk6gew
         yeEnb9I9Yi9hypIRONrBvwY8ZE2N4luciJ4/8yi5puu3J9TsJ4Xt6fjyo59g7DctLTCg
         YseL24SLxM2aWLE65EZCbirYYNJirpxnU68Nc/KCpj7epuqYzTKdkRiTHPJK0mziPAbt
         d3zwqg8ERD01wuS4kKL1OxbhMnfDFF4TgC6vePBqOVF0KaLSYK1+82loDEtRnCGJYrJw
         PhoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qMkklJzm;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Q11Dr6ES;
       spf=pass (google.com: domain of kernel-hardening-return-12655-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12655-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qMkklJzm;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Q11Dr6ES;
       spf=pass (google.com: domain of kernel-hardening-return-12655-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12655-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFyRV9KXzeQZpVYsZYVUJm-ASgu_4_1+8Y8-0KH-YT2M8Q@mail.gmail.com>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
 <1521143266-31350-2-git-send-email-keescook@chromium.org> <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
 <CAGXu5jKtv=a8qTy1-AfbzNRB=Azb8V7Pt1M4QMVYNKg6+Ci7=Q@mail.gmail.com>
 <CA+55aFwDJ906oQ-98L2DNrjfKtb6cd5ykwMxpG942qxCFmAoEQ@mail.gmail.com>
 <CAGXu5jLHam5kz18k9uvhsz2WYodkF2v1tsEOV4Sx0O7jir4B3A@mail.gmail.com>
 <CA+55aFzO12QMFJHe8osoWfph8jnjgp_jLUQWmgbNmth_KwPxXw@mail.gmail.com>
 <CAGXu5jLHW00UmSDyAmdLpin6L636XbP3brH=pn4qh1bN87AirA@mail.gmail.com> <CA+55aFyRV9KXzeQZpVYsZYVUJm-ASgu_4_1+8Y8-0KH-YT2M8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 16:47:38 -0700
X-Google-Sender-Auth: huW7CvErzYdy3XZLrGfV0w4tJdg
Message-ID: <CA+55aFwQ=TzFLKq8h0Vj7M7=j-W0AwqLeqDSd6ncDjBpDxNucA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1595049432301301821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 4:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, the explicit typing allows that mixing, in that you can just
> have "const_max_t(5,sizeof(x))"

I obviously meant "const_max_t(size_t,5,sizeof(x))". Heh.

                Linus
