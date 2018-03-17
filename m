Return-Path: <kernel-hardening-return-12687-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs6n7tFkerELrsoJLr3WGyQUxMe+fSk3k19O2QQwDMIZiTjhpMH9fNeQXffbAcZ3Hbr1rFp
ARC-Seal: i=1; a=rsa-sha256; t=1521317275; cv=none;
        d=google.com; s=arc-20160816;
        b=PMyc6AJjeteOrG5Ext4xGXPgVzgu8A3xyoy5xcc1r3M6+QhAH0v3vmqSr92WGyZIUu
         KyFCP+dBKeI5oGrSs4vLlbmPj3JWAodYCY6FtjHAMtFKWaHXTbGEOgKYbEP00WLKq06G
         rKkyWABjaWbpQ4/N7DTvrPWG7WgltCNkHOwF61vtrNs7nwaq2hmiAcfineBD5wMRJy/9
         AU/IpzKU1nDuHQ+HmVxQsqhS2RTY+Qmi5nZRvHEN+HehxVtejL736ptC5JoFpd0Fhnkx
         BKZjJ3wbHRKGrwX3wRNl6y/2m4DV0kvFZZhwZ+Codvh1OD6rBMFIzsa26vmEzNIJAGJ2
         zXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=K0ma1eCvv31PlpXtqHyGINJxnrvOQdHrFt74V+2axqA=;
        b=BeHG7uffMuOdCOUu7JKDnC6cWSk57BtrtIgXo2dTNXWZ/4oOAAuGHig17iYreq2q1T
         znu1Q8nXBgYimEXZATQEXxfEvvHzQilAaInjuAsfOBr0kX8IKqswHg0Bty0tvzhtzz5F
         nlJW57VxATr7KD1EaQQPz4pwI9SnLRKvfHqibRcGBze+mzze8a7u9R9IzRha/rAYnSS/
         I1G8EdBojieKZMydkJsSIKMqLa+MITTJ+h8RRVzo7MT+BtHXF5UgyOiOgkA6jqJ4SZDA
         /mFkF045xJAOGZH67/OvxxOGEfp66BUonbCq3gDLkbhKFo60nQCk4sT1V43aZaE5n04d
         nkgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YmboWTyv;
       dkim=pass header.i=@chromium.org header.s=google header.b=aEd7GQJP;
       spf=pass (google.com: domain of kernel-hardening-return-12687-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12687-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=YmboWTyv;
       dkim=pass header.i=@chromium.org header.s=google header.b=aEd7GQJP;
       spf=pass (google.com: domain of kernel-hardening-return-12687-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12687-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com> <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 17 Mar 2018 13:07:32 -0700
X-Google-Sender-Auth: mlaYqob5u4sFQC6sPCTUu3MeFbY
Message-ID: <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595216783112527048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 11:52 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So the above is completely insane, bit there is actually a chance that
> using that completely crazy "x -> sizeof(char[x])" conversion actually
> helps, because it really does have a (very odd) evaluation-time
> change.  sizeof() has to be evaluated as part of the constant
> expression evaluation, in ways that "__builtin_constant_p()" isn't
> specified to be done.
>
> But it is also definitely me grasping at straws. If that doesn't work
> for 4.4, there's nothing else I can possibly see.

No luck! :( gcc 4.4 refuses to play along. And, hilariously, not only
does it not change the complaint about __builtin_choose_expr(), it
also thinks that's a VLA now.

./include/linux/mm.h: In function =E2=80=98get_mm_hiwater_rss=E2=80=99:
./include/linux/mm.h:1567: warning: variable length array is used
./include/linux/mm.h:1567: error: first argument to
=E2=80=98__builtin_choose_expr=E2=80=99 not a constant

6.8 is happy with it (of course).

I do think the earlier version (without the
sizeof-hiding-builting_constant_p) provides a template for a
const_max() that both you and Rasmus would be happy with, though!

-Kees

--=20
Kees Cook
Pixel Security
