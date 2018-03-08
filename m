Return-Path: <danielmicay@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520485528; cv=none;
        d=google.com; s=arc-20160816;
        b=KIwHXHlNhIoSMXneq32H6Zg8l7ggub+ER8c38TS4oR8iwqp9noJJfXrogyT/rMEn8f
         gd2x0RHu3PxgAKic29J/6ejWqHigMZEa+9FO6+SceaJWUEaMlRrmwbAFG++gn1UviFNr
         Vpb4KQpvg7xwnJQiXXAZBhsnBR2JpaXv06QVU9xya798Kya5ZKHaN3q+HUb02GirIBr9
         SBgX/uvI+DjmrvaEhh6+Uh8WhbaVGVWdPzvx0eVHH5wgA8pxqTfazovsNPcmdeNvx0I+
         g7OaFVngly2ncxO49PYSVAY6QBBsLKwcuuEMq2TfnHfEKOI9eVr0zFbAIylPWg93j9Lp
         oFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=zfM2bxS7xt9wQqWjnpnRSqzOYo0lMaER0svbFOuzi1E=;
        b=vmvnXkfWn2ViLUBwtdPCJNfOxq/73gO9yy5xl/RQAy2eBD2OBlDlyHqZJ+rQFagCc5
         NOLU3EmBGnKpnIbenJqS7ExtOp+DNgtFmmPqt/rtVNfgyNXCmEmZczLeLRdK4WlHKuba
         9k74d/SXU9IkuXwy/D68CZG/+qid9xhHgh9mMuvqML5vYDrHe0x9RstBIQownbh2XEmK
         21VGdIsHNyf3SWDJKEqv919AvcFdnbtt+N6By+qnIiJSsL6TwRhHqKY7hRTTDmZiKYDl
         xTHWdnZnL5Di3QCwU3u3QggEGao2U3PfBNOLxZeSM2PKfW19wwhdy+LG8Atp9QQw6gfl
         Z/pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G7+AuHvM;
       spf=pass (google.com: domain of danielmicay@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=danielmicay@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G7+AuHvM;
       spf=pass (google.com: domain of danielmicay@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=danielmicay@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsdJzAo90tgy6IN/EPaBN+pXqloKPZnv+M5crajjfyoudQVhJCLqORmG7bY2QOgGU+rr0AXoI+cBSC+34pGOLc=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com>
References: <CAGXu5jJaVPPjqtpOLapk8ABT93zaUoaKR-i7Ga6LVSK2OiX_tQ@mail.gmail.com>
 <CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com>
From: Daniel Micay <danielmicay@gmail.com>
Date: Thu, 8 Mar 2018 00:05:27 -0500
Message-ID: <CA+DvKQ+bZauBVA9G-E74ibRuDyfiZfduwycVwBH3jKDyjDe4Zg@mail.gmail.com>
Subject: Re: VLA removal (was Re: [RFC 2/2] lustre: use VLA_SAFE)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Joern Engel <joern@logfs.org>,
	"Tobin C. Harding" <tobin@apporbit.com>, "Tobin C. Harding" <me@tobin.cc>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Tycho Andersen <tycho@tycho.ws>,
	Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>,
	James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594301344989798721?=
X-GMAIL-MSGID: =?utf-8?q?1594344633218812175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 7 March 2018 at 13:09, Linus Torvalds <torvalds@linux-foundation.org> wr=
ote:
> On Wed, Mar 7, 2018 at 9:37 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Building with -Wvla, I see 209 unique locations reported in 60 directori=
es:
>> http://paste.ubuntu.com/p/srQxwPQS9s/
>
> Ok, that's not so bad. Maybe Greg could even add it to one of those
> things he encourages new people to do?
>
> Because at least *some* of them are pretty trivial. For example,
> looking at the core code, I was surprised to see something in
> lib/btree.c

Some are probably just the issue of technically having a VLA that's
not really a VLA:

    static const int size =3D 5;

    void foo(void) {
      int x[size];
    }

% gcc -c -Wvla foo.c
foo.c: In function =E2=80=98foo=E2=80=99:
foo.c:4:3: warning: ISO C90 forbids variable length array =E2=80=98x=E2=80=
=99 [-Wvla]
   int x[size];
   ^~~

I don't really understand why the C standard didn't make `static
const` declarations usable as constant expressions like C++. They made
the pointer conversions more painful too.

It would be nice to get rid of those cases to use -Werror=3Dvla though.
