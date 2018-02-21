Return-Path: <kernel-hardening-return-11872-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225vm0HFUeFbJ1CLg5wg+CfZZPzzT3BjDH1g+zvyvWqcB3Sqbmn3APfpltzsFk0YbyONCQhL
ARC-Seal: i=1; a=rsa-sha256; t=1519253680; cv=none;
        d=google.com; s=arc-20160816;
        b=xOoyKT/yUvH1Gkn5QmivBnCNku4JG1xigJMJwwkVN1iPR2yVLENnnuZAF6KrFJuXDO
         MMG6azSGxliEQ26HqzowHj4jNJRpyx0SYkjJ0RoRFrPSLXrTy/XxhyzS4xC4VqEuMUJq
         CnPfq1k+kQR4QmhQdThEaZfvuWUy0gNR4TjWDu3x6zIeeWfGo3pGAvH0KmkP24flG9yW
         sp9aiPbXg1V1Y1FwREQ2/Gqy00Bjn4JO02k6tFVvSI2GHdSsAYvDZNaDnRM4M1ZNm53B
         y3v4Wu3tyjpTh5OTJBxxc35a91+T74kUKmyyFzSaJuBCpayHuDA6X2jePEDzT4Ur57rL
         p4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=1PZcvfUajswGpVWPSiVtIZHjBVvuJujtPvjGby0/8So=;
        b=plB2uYmMOb3LHqZjoa1n0dv6YG73h4PjzCOT8mTzzAUgecvCsUNo0V2XDG2xNducJq
         IzGFMGjuaQtV1LdRFunCECyUsd0r0XfpPUH2IcU/KNmM+D88WKUroB1ZZ8iuLobMw30+
         lkG/J/z9kicfUWpC0GH0pYt4uB54PJvaJ7okuqqv8GL1vJmGZ/GaX/zq6SUHNCyjCx9i
         UXPWD5uTEDjzZeNQOc2wm7iibgiVFRmarlUmL8kVj68YpRQFrSTaUOXiNlvk82hBMlwO
         Hr0garVM3Z2/cn9kin8owd+Pui/tqHboqSd+lip+DcsfA+OJK5sjliSxbd7cKtYQSWEk
         w9iA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DoNBnQ3c;
       spf=pass (google.com: domain of kernel-hardening-return-11872-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11872-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DoNBnQ3c;
       spf=pass (google.com: domain of kernel-hardening-return-11872-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11872-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 14:47:44 -0800
X-Google-Sender-Auth: zCp95De_eVCC1yv8AhW6v_B20fI
Message-ID: <CA+55aFz-AD8rWb66rjN-YhAtPXukMiGSFfW3nBMCp8k1RYUvOQ@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Kees Cook <keescook@chromium.org>, Patrick McLean <chutzpah@gentoo.org>,
	Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Bruce Fields <bfields@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1593052946989206033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 2:19 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> One can see that offsets used to access various members of struct path ar=
e
> different, and also that the original file from step 3 contains an object
> named "__randomize_layout".

Whee.

Thanks for root-causing this issue, and this syntax of ours is clearly
*much* too fragile.

We actually have similar issues with some of our other attributes,
where out nice "helpful" attribute shorthand can end up being just
silently interpreted as a variable name if they aren't defined in
time.

For most of our other attributes, it just doesn't matter all that much
if some user doesn't happen to see the attribute. For
__randomize_layout, it's obviously very fatal, and silently just
generates crazy code.

I'm not entirely sure what the right solution is, because it's
obviously much too easy to miss some #include by mistake. It's easy to
say "you should always include the proper header", but if a failure to
do so doesn't end up with any warnings or errors, but just silent bad
code generation, it's much too fragile.

I wonder if we could change the syntax of that "__randomize_layout"
thing. Some of our related helper macros (ie
randomized_struct_fields_start/end) don't have the same problem,
because if you don't have the define for them, the compiler will
complain about bad syntax.

And other attribute specifiers we encourage people to put in other
parts of the type, like __user etc, so they don't have that same
parsing issue.

I guess one _extreme_ fix for this would be to put

    extern struct nostruct __randomize_layout;

in our include/linux/kconfig.h, which I think we end up always
including first thanks to having it on the command line.

Because if you do that, you actually get an error:

    CC [M]  fs/nfsd/nfs4xdr.o
  In file included from ./include/linux/fs_struct.h:5:0,
                   from fs/nfsd/nfs4xdr.c:36:
  ./include/linux/path.h:11:3: error: conflicting types for =E2=80=98__rand=
omize_layout=E2=80=99
   } __randomize_layout;
     ^~~~~~~~~~~~~~~~~~
  In file included from <command-line>:0:0:
  ././include/linux/kconfig.h:8:28: note: previous declaration of
=E2=80=98__randomize_layout=E2=80=99 was here
       extern struct nostruct __randomize_layout;
                              ^~~~~~~~~~~~~~~~~~
  make[1]: *** [scripts/Makefile.build:317: fs/nfsd/nfs4xdr.o] Error 1

and we would have figured this out immediately.

Broken example patch appended, in case somebody wants to play with
something like this or comes up with a better model entirely..

               Linus

---

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index fec5076eda91..537dacb83380 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -4,6 +4,10 @@

 #include <generated/autoconf.h>

+#ifndef __ASSEMBLY__
+ extern struct nostruct __randomize_layout;
+#endif
+
 #define __ARG_PLACEHOLDER_1 0,
 #define __take_second_arg(__ignored, val, ...) val
