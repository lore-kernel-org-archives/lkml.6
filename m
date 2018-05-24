Return-Path: <jakub.kicinski@netronome.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527125638; cv=none;
        d=google.com; s=arc-20160816;
        b=v4C36wzewyuMDgmpjKsirljDArP77f5nPqSkNb3u5v9LoJo2TRTka8A4tRcPCRlwtl
         w8/U2UK/CqH1iv3wvAKj92CPf87SqhrinUdSo/eBOpwUtOPJ0wYRpQUEdlnvy5Z70dsA
         9NWS80QyjmIERilFWZU3SfP+x47YR8l+SP8N4GIoqttmm17pBt9CyWIET1o4dt/vuZKk
         AJsQFVuosP6dnNJrXwU6GTn4EUaZV8rzIl7Oqo/WdKvUtAaGzrwv3oB73qMA3bbKyyq5
         6Di4D3HJSI5Pq4MLHF14nvHXuX+dqrIMDyMqyjtdlYwG/ZSLpoJdBBG1jYwIEf7TQRo8
         L60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=t+XmRALHh5eiYcPjdJzt5GESxrhGgLxb5o2gXZa9gdk=;
        b=xTNzcKfMuZYL6eBxGfvyfmsjYiMjk/sZEGvP023qwJRWAwt9VC4OyWAiEyrqG3XA1D
         Gi0cRbZ9gc0DXs6J8Qp5CVC5Dw732l0Apcl6Xczdi1vlIXXL43cEnGLsdVzjG1UJadvl
         f70RJ1fe22tmiGqZVGkNbsCjSGi6IlcXgsJzW/v1aP9P7nH5HxT2l8ReB5pqa5mm3B+l
         SZiN4Asy8kB1VHGh3yR+HOOK2lLMe/CET//G7LWrlmmP4ksG/ArekkYWXTdXsCSEFApY
         Wb47pieylJCKOtrA/hgV67yexexRHI+iQJLzEv8/pTcxYuJj7YRmT1QD8EXz17jr/Da4
         hogQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@netronome-com.20150623.gappssmtp.com header.s=20150623 header.b=VnuzGw67;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of jakub.kicinski@netronome.com) smtp.mailfrom=jakub.kicinski@netronome.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@netronome-com.20150623.gappssmtp.com header.s=20150623 header.b=VnuzGw67;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of jakub.kicinski@netronome.com) smtp.mailfrom=jakub.kicinski@netronome.com
X-Google-Smtp-Source: ADUXVKLoFoOb7Ay7diY/NGlkrorzBzhu+aHhxuacMrPF3N478W3X5pt8lHD1X82hYlyNBSqz0e2+NA==
Date: Wed, 23 May 2018 18:33:52 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, <daniel@iogearbox.net>,
 <torvalds@linux-foundation.org>, <gregkh@linuxfoundation.org>,
 <luto@amacapital.net>, <mcgrof@kernel.org>, <keescook@chromium.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@fb.com>
Subject: Re: [PATCH v3 net-next 0/2] bpfilter
Message-ID: <20180523183352.7ccc3f5d@cakuba>
In-Reply-To: <20180522022230.2492505-1-ast@kernel.org>
References: <20180522022230.2492505-1-ast@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601129157450149170?=
X-GMAIL-MSGID: =?utf-8?q?1601307294007279561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Minor glitch with Ubuntu 18.04:

$ gcc --version
gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0

In file included from /usr/include/fcntl.h:290:0,
                 from ../net/bpfilter/main.c:7:
In function =E2=80=98open=E2=80=99,
    inlined from =E2=80=98main=E2=80=99 at ../net/bpfilter/main.c:58:13:
/usr/include/x86_64-linux-gnu/bits/fcntl2.h:50:4: error: call to =E2=80=98_=
_open_missing_mode=E2=80=99 declared with attribute error: open with O_CREA=
T or O_TMPFILE in second argument needs 3 arguments
    __open_missing_mode ();
    ^~~~~~~~~~~~~~~~~~~~~~
scripts/Makefile.host:107: recipe for target 'net/bpfilter/main.o' failed
make[3]: *** [net/bpfilter/main.o] Error 1

I can't repro on Fedora 27 gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5),
perhaps the GCC is broken on that Ubuntu 18.04 box of mine.  The warning/
/error, however, looks potentially legit?
