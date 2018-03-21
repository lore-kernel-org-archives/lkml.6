Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeCUJic (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:38:32 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43254 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeCUJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:38:30 -0400
X-Google-Smtp-Source: AG47ELul47a6GEo1O899kVwSlfgcW3Y94/+eOn4iZYbJ1aJPkHdiRnDXxTI2kkVyk4+Z0ck04nhaGy3X+dK0J1zTlUU=
MIME-Version: 1.0
In-Reply-To: <20180321095047.3aee181e@canb.auug.org.au>
References: <20180321095047.3aee181e@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Mar 2018 17:38:28 +0800
X-Google-Sender-Auth: dJnAhPljMYBWMn8kcpcQ-0Nsscs
Message-ID: <CAK8P3a1Njy=PWw+V0bc06z9VU-wPqGn1W8e1Lvc_hkb5A5UPLw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the arm64 tree with the asm-generic tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 6:50 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the arm64 tree got a conflict in:
>
>   include/uapi/asm-generic/siginfo.h
>
> between commit:
>
>   0d7d2a23a347 ("asm-generic: siginfo: define ia64 si_codes unconditionally")
>
> from the asm-generic tree and commit:
>
>   266da65e9156 ("signal: Add FPE_FLTUNK si_code for undiagnosable fp exceptions")
>
> from the arm64 tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

>  +#define __FPE_INVDEC  13      /* invalid decimal digit */
> - #define NSIGFPE               13
> + #define FPE_FLTUNK    14      /* undiagnosed floating-point exception */
> + #define NSIGFPE               14

The merge looks correct to me. I'm still rebasing my asm-generic tree
to integrate incoming Acks, so I think we're stuck with this one for a
bit.

        Arnd
