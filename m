Return-Path: <kernel-hardening-return-12110-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu2ch/nR4E2EIT+172iHdIBZt9ltCWSe/bjTAJP+J7/DYuHEMJqQ6S9thOrRS09Y1PFmJJg
ARC-Seal: i=1; a=rsa-sha256; t=1520277550; cv=none;
        d=google.com; s=arc-20160816;
        b=SzKmQWVSMhGMAUTFVN85W/Xh5RDHiTgeylUmB1Um16I1KDdKOX+h68GNwT6Sg5D82X
         6pkuYqvVRiC2a9MN0ViCCk9xJ4wDN9Uoqe4QNICB6Mq0lhObgPJSngK2HtuH3YNnCodG
         v1inn6Rmh2kt113vnLZgA/eLZnA7tB8gRQyrOkc4LosFFHwK2W9Kq+YntssDftwKvBsI
         e/aOrwwn6KFwCf627cIkxNh8hQ+G4xbTzAStzCOpSY5Ru1HjtnUvzvCzFFfEdQWPFNDm
         tOVO7NsYYrFCWzJozjyB/RP593mwwgkH4wT03rm9bBmYKYSUd8ZDUP5l7npXFPI/GSkC
         NhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=g0mOUb/1TkeDlODQ3BwQSnWpEczEmXsSeF4xZG85ztU=;
        b=U2ecBPhSQLKtjSX2dnXvQmE2NRyagkVd1Itox9kq8b8eN9KkiViHMf8ga64hos3xok
         FMJiWWLvG7NnX2ig0JVlkK4twq8rwE9N40KKLFRPBKPbE5DpY5oj4jDEQSTFR0ZdSJ9+
         SsRVo8h1V4gbH0xWQZ7ToqbCzOcjj/a0vVcAoUBcMQTtEmJeYm2tutNC5QsxMiawY3lB
         rJ//c90gzgkqkiloje0sspROWPCxbf8fVWcxqSP4O8ymDQ6lSqMFMMro8V0qD83An49n
         JUeA21o6N/QX24ySiB1fTJH+1+1JKxPdIeMBNlXv3F7Ld1Sx4swIDbfRcgXEYEZ0pl/P
         5B7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eCwMUBtX;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=eqR1clod;
       spf=pass (google.com: domain of kernel-hardening-return-12110-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12110-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eCwMUBtX;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=eqR1clod;
       spf=pass (google.com: domain of kernel-hardening-return-12110-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12110-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAK7LNASKHOb5GNPu9XHWxyq-iucxTRkw99_7wL4zgm5HNc6_SA@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
 <CA+55aFz-AD8rWb66rjN-YhAtPXukMiGSFfW3nBMCp8k1RYUvOQ@mail.gmail.com> <CAK7LNASKHOb5GNPu9XHWxyq-iucxTRkw99_7wL4zgm5HNc6_SA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 11:18:50 -0800
X-Google-Sender-Auth: LtYe3bJUESP8QRIMRhRctN1_jy0
Message-ID: <CA+55aFyf9NkW26BNyEnvUT60u2oXezRiXMexdHy8yx1AD9aUYw@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Kees Cook <keescook@chromium.org>,
	Patrick McLean <chutzpah@gentoo.org>, Emese Revfy <re.emese@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Bruce Fields <bfields@redhat.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1594126552978221675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:27 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Can I suggest another way to make it less fragile?
> __attribute((...)) can be placed after 'struct'.

That avoids the actual bug, but it wouldn't have helped _find_ the
problem in the first place.

If somebody ever does the same thing, they'd hit the same issue. And
it's not just __randomize_struct, it's any of our other type markers.

We can say "don't do that", but if there is no automated checking,
it's still ripe to cause problems just because somebody didn't notice.

So I'd rather have something that causes a build failure when
something goes wrong, rather than silently accepting syntax that
wasn't intended.

                   Linus
