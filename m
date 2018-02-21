Return-Path: <kernel-hardening-return-11875-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227wBN7f6tvC6abuokYZWbaOf3lCMHhRckNjrSwh/4i2p6CaZuUQKAlF635DPAFLCVEDKE4v
ARC-Seal: i=1; a=rsa-sha256; t=1519256094; cv=none;
        d=google.com; s=arc-20160816;
        b=WjIueYJ+3EK3/+6IVgJp9xQ18nZ5SqaZntvWFFu5gQ8PnXt/xgwGGGEc3EjuewVe4r
         Zys8VshDKkCr3s5bA4qHhLg6LtoFNquJ64RRNl4O80FR9L2cOV9Zdlz8AlvGKjrrO7zT
         G921IpYSLvE7/b6BQlLGlmdp+3ufi7Zn1BigIELmMnpSQ6VlXQno3pQCnOlw1qcb928G
         V5cc0mSPD2LXgvE3dHQYldm4F7wcd0frgKAZ19d5gMvumeeWzGXbr5Q4faWvl5fdQfV0
         jjG9ufAskm9u5q6jvwygEuLJbw+zVfgzrs8xsDpl9omwea7MwRRNu+FqFZ7gyy5Spduy
         LwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=o6DqJNfOgH3nYE82vx50b9CcHkB0V50Dl3KssZOVJi8=;
        b=W4YLP/Js/x7FhZy9/FzbhuWVAhmFmd/UKmUwc+pZDDQwPcfBhsAIbHA0z7LfrPvL+r
         6CtCVuCcSTvefHqKa/1P/mKkXCkxqFiDoZrWq8gTKiLv9rSI8yIlruw0inB5wi8lN8sr
         eMH7tmzKQ5NU3TBY8dgyVpJl9Ok6kC3fERRwWD1w5sjtRFs4/plbpR3tAPp+AmgcZ/Fm
         bJ/F32uFAvhX2LJPp+5+IjtJno6F5Zo3om7dzYn0JC7FVdNRrgW9PV3fpZSlYjX9vczn
         B+P6W3dbWRoooVUSYDPRK3GARVCnMbu/WFRpOCOxDVE4xDeyRERDvMZS58V0kSqztL3p
         QbHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=nJ0R1NhD;
       dkim=pass header.i=@chromium.org header.s=google header.b=EGVutQ1J;
       spf=pass (google.com: domain of kernel-hardening-return-11875-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11875-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=nJ0R1NhD;
       dkim=pass header.i=@chromium.org header.s=google header.b=EGVutQ1J;
       spf=pass (google.com: domain of kernel-hardening-return-11875-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11875-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFz-AD8rWb66rjN-YhAtPXukMiGSFfW3nBMCp8k1RYUvOQ@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name> <CA+55aFz-AD8rWb66rjN-YhAtPXukMiGSFfW3nBMCp8k1RYUvOQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 15:34:34 -0800
X-Google-Sender-Auth: vGP1LJdVqZuU7F5i1OK_bfc07_E
Message-ID: <CAGXu5jK3ZEs5SauEMHA3BnAyM1zbOkoG5cbM3B44_67TH1EZ=A@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Patrick McLean <chutzpah@gentoo.org>,
	Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Bruce Fields <bfields@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1593055477723117146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 2:47 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And other attribute specifiers we encourage people to put in other
> parts of the type, like __user etc, so they don't have that same
> parsing issue.

Looking at other attributes we use on structs, we may have similar
risks for these:

__packed
____cacheline_aligned
____cacheline_aligned_in_smp
____cacheline_internodealigned_in_smp

But they just haven't been used in places that we could trip over it
as badly, AFAICT.

> I guess one _extreme_ fix for this would be to put
>
>     extern struct nostruct __randomize_layout;
>
> in our include/linux/kconfig.h, which I think we end up always
> including first thanks to having it on the command line.

We could do that for all the above, but I wonder if the real problem
is our convention of using "regular" names for these kinds of
attributes instead of parameterized names. If we always used something
like:

#define __struct(x)   __attribute__(x)

We'd avoid it, but we'd uglify our struct attributes:

struct thing { ... } __struct(randomize_layout);

though trying this now creates other problems. Hmmm.

(Regardless, let me send the nfs fix separately...)

-Kees

>
> Because if you do that, you actually get an error:
>
>     CC [M]  fs/nfsd/nfs4xdr.o
>   In file included from ./include/linux/fs_struct.h:5:0,
>                    from fs/nfsd/nfs4xdr.c:36:
>   ./include/linux/path.h:11:3: error: conflicting types for =E2=80=98__ra=
ndomize_layout=E2=80=99
>    } __randomize_layout;
>      ^~~~~~~~~~~~~~~~~~
>   In file included from <command-line>:0:0:
>   ././include/linux/kconfig.h:8:28: note: previous declaration of
> =E2=80=98__randomize_layout=E2=80=99 was here
>        extern struct nostruct __randomize_layout;
>                               ^~~~~~~~~~~~~~~~~~
>   make[1]: *** [scripts/Makefile.build:317: fs/nfsd/nfs4xdr.o] Error 1
>
> and we would have figured this out immediately.
>
> Broken example patch appended, in case somebody wants to play with
> something like this or comes up with a better model entirely..
>
>                Linus
>
> ---
>
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index fec5076eda91..537dacb83380 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -4,6 +4,10 @@
>
>  #include <generated/autoconf.h>
>
> +#ifndef __ASSEMBLY__
> + extern struct nostruct __randomize_layout;
> +#endif
> +
>  #define __ARG_PLACEHOLDER_1 0,
>  #define __take_second_arg(__ignored, val, ...) val



--=20
Kees Cook
Pixel Security
