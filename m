Return-Path: <kernel-hardening-return-12099-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvf6qwV4OzW9AV5TwnEc6d+qrh2pfJUcqZtAf9SWFWs45rC7YCEUlhYZxMHrVifNJB5E5le
ARC-Seal: i=1; a=rsa-sha256; t=1520242136; cv=none;
        d=google.com; s=arc-20160816;
        b=NM+xSqBOaVAs+QCVQhbiUPEKODFhUjhlsdHLVKJlZfvVe2cP089oX9fVg8SuuXQjcs
         TFkn68UnEp/3wLZV0q6XXCAGHQ66t5glASVsXhZWorKjLYLzi5RvFYZYN1aAq+udC/4B
         mVOXe9yAXT0YIYbZf7+5C526rORoNsdlDALoZWcfZ9huP3F+7Pq/fGkBFyHZsSSRLvM3
         s2JFst7kLGinVPsT7QcmPRh4t6vm0fZ4zXwSm5ECuhOOH2avF9DJ53aTfFA2gMYt7luz
         rbJOXZdgarGfTrTRCL8N4tTL8qlDGKf60e3vXr/MR5jyQBM5rn4QaJ9LhHhTaR5C5Q93
         Htyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature:dkim-filter
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=svNnamZ4e7++WbRMEbLIhS9XGzMU9g5NerVRXAksQ5I=;
        b=UjlZ4Qv1hgrG2Z6EFOL0i1/eBKg1Lfp0wtBHu725eTWF3SLpp06Liy/t8/nkZOfLM8
         f+Z1M+TcuptoVqMzC3a9m+nyO3srgaoFdYx1qoC2VomOsZy3Eb6PY4Loy9e+8VuXSjgt
         YFfX9fWD7Ls8bD2e36Vc9AcifAEXs/F2rdQB4vo7X5Nj8fGwXB0frk5MT253ySNgAbFG
         /sMHpym5/TZZ8gIMl00kegERNKZNsIfLMFhJl6TY9urnyeBeY+mntg4uSsP9hayxEUBE
         7B+glxJknSLk/q9oE9KIQX2U6L4mfsWGqhxE7yrE/VLhJzNJXsvyC203VrFEsOrUiOAE
         POzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=11o4V7ES;
       spf=pass (google.com: domain of kernel-hardening-return-12099-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12099-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=11o4V7ES;
       spf=pass (google.com: domain of kernel-hardening-return-12099-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12099-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w259SQLj014789
X-Nifty-SrcIP: [209.85.213.49]
MIME-Version: 1.0
In-Reply-To: <CA+55aFz-AD8rWb66rjN-YhAtPXukMiGSFfW3nBMCp8k1RYUvOQ@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name> <CA+55aFz-AD8rWb66rjN-YhAtPXukMiGSFfW3nBMCp8k1RYUvOQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 5 Mar 2018 18:27:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASKHOb5GNPu9XHWxyq-iucxTRkw99_7wL4zgm5HNc6_SA@mail.gmail.com>
Message-ID: <CAK7LNASKHOb5GNPu9XHWxyq-iucxTRkw99_7wL4zgm5HNc6_SA@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Kees Cook <keescook@chromium.org>,
        Patrick McLean <chutzpah@gentoo.org>, Emese Revfy <re.emese@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Bruce Fields <bfields@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1594089419138074718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

2018-02-22 7:47 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Wed, Feb 21, 2018 at 2:19 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>>
>> One can see that offsets used to access various members of struct path a=
re
>> different, and also that the original file from step 3 contains an objec=
t
>> named "__randomize_layout".
>
> Whee.
>
> Thanks for root-causing this issue, and this syntax of ours is clearly
> *much* too fragile.
>
> We actually have similar issues with some of our other attributes,
> where out nice "helpful" attribute shorthand can end up being just
> silently interpreted as a variable name if they aren't defined in
> time.
>
> For most of our other attributes, it just doesn't matter all that much
> if some user doesn't happen to see the attribute. For
> __randomize_layout, it's obviously very fatal, and silently just
> generates crazy code.
>
> I'm not entirely sure what the right solution is, because it's
> obviously much too easy to miss some #include by mistake. It's easy to
> say "you should always include the proper header", but if a failure to
> do so doesn't end up with any warnings or errors, but just silent bad
> code generation, it's much too fragile.
>
> I wonder if we could change the syntax of that "__randomize_layout"
> thing. Some of our related helper macros (ie
> randomized_struct_fields_start/end) don't have the same problem,
> because if you don't have the define for them, the compiler will
> complain about bad syntax.
>
> And other attribute specifiers we encourage people to put in other
> parts of the type, like __user etc, so they don't have that same
> parsing issue.
>
> I guess one _extreme_ fix for this would be to put
>
>     extern struct nostruct __randomize_layout;
>
> in our include/linux/kconfig.h, which I think we end up always
> including first thanks to having it on the command line.
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


Sorry for chiming in late.

I noticed this thread today,
honestly, the commit made me upset.


Can I suggest another way to make it less fragile?
__attribute((...)) can be placed after 'struct'.


So, we can write:


struct __randomize_layout path {
        struct vfsmount *mnt;
        struct dentry *dentry;
};


  instead of


struct path {
        struct vfsmount *mnt;
        struct dentry *dentry;
} __randomize_layout;



If we force the former notation,
the undefined __randomize_layout results in a build error
instead of silent broken code generation.


It is true somebody can still place
__randomize_layout after the closing brace,
but can we check this by coccicheck or checkpatch.pl?
(we can describe it in coding style documentation, of course)


IMHO, we should not (ab)use include/linux/kconfig.h
to bring in misc things.


--=20
Best Regards
Masahiro Yamada
