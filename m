Return-Path: <kernel-hardening-return-12665-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuq3DOrLi6zLiwWJDoHyP3PxCbiPMmv1AEychX4f8Np7DxknGWFJwNqBWuBULK6/85ys58f
ARC-Seal: i=1; a=rsa-sha256; t=1521221381; cv=none;
        d=google.com; s=arc-20160816;
        b=AV4J6PdHkP3ZZC2hyozM3Y5z3C1/bnhbWLo+Qd8XDtfLMcBIdg0OaCiwxyP0dGqp0Y
         rH35L1FnQWEknDiphXlt6V4vfSz+/CGhKcyZ3VChE52wq4a2r9npAd9Vz+TEmamj9A6k
         IS89BHW00zUhWW3tJ+oOWqDkRxWGwQjnqrtGiWaBP8ggNtM+B110fjZjVxZuVue7MiEg
         EnsuDV64jXhmDvCjVcESVCaDy+4CwuZMuyTgHgQrWhRBoswHVFValfAg8GZIz8U5Qkad
         TbZPb4QfDjW74BqJpG0h9zY5oY/ALtTVofDYcV6Zd2SqMIkBKjsCyTzpPOZf1aHBfTsV
         vkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Slj3yBwN0wiEz1KN606U5DYnW0FpaZjf/Aqp3IADf4U=;
        b=z4cxPKkp04rx/C20bXeH4n2ZXxvByWbGBSh0Y5B1NpsXdnNglqLSdoGLkq3Kv46oOv
         lRzFsGAayRfu5sBJ5JjlACxVX5tfjEkD7AZqlQQ93yd4ZcAajdGZb2xYqN+6QQI4+rMh
         f4V+eqORvHFZNsC7ps9XW3CWCm1PHms40VPwXkXg+rxVpCvMxjqp9GK6S/dBlHGWGZsy
         CYH92JqZgEWQsK39F/5N71F3lcEEW25gbM74FO9jQGU5ce0ypaNI7upzCLSozGXR4I4U
         GTdrQl0oLPsOsneyugPoYoc5YJtmH5Qk19w2uX4qwRg6+m0sI0fRz1NcL8MKW10p4iB4
         O+NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NWecBNfq;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=dz3Rrslg;
       spf=pass (google.com: domain of kernel-hardening-return-12665-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12665-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NWecBNfq;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=dz3Rrslg;
       spf=pass (google.com: domain of kernel-hardening-return-12665-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12665-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org> <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 10:29:16 -0700
X-Google-Sender-Auth: sr-pecB0Vpe9RLUGo9h0To0DogU
Message-ID: <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Florian Weimer <fweimer@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595116231455854839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 4:47 AM, Florian Weimer <fweimer@redhat.com> wrote:
>
> If you want to catch stack frames which have unbounded size,
> -Werror=3Dstack-usage=3D1000 or -Werror=3Dvla-larger-than=3D1000 (with th=
e constant
> adjusted as needed) might be the better approach.

No, we want to catch *variable* stack sizes.

Does "-Werror=3Dvla-larger-than=3D0" perhaps work for that? No, because
the stupid compiler says that is "meaningless".

And no, using "-Werror=3Dvla-larger-than=3D1" doesn't work either, because
the moronic compiler continues to think that "vla" is about the
_type_, not the code:

   t.c: In function =E2=80=98test=E2=80=99:
   t.c:6:6: error: argument to variable-length array is too large
[-Werror=3Dvla-larger-than=3D]
     int array[(1,100)];

Gcc people are crazy.

Is there really no way to just say "shut up about the stupid _syntax_
issue that is entirely irrelevant, and give us the _code_ issue".

                 Linus
