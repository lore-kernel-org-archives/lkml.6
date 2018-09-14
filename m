Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76718FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BF520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BF520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeINOY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:24:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38958 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeINOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:24:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id b19-v6so4773172qkc.6;
        Fri, 14 Sep 2018 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhVvzQ0WMIiiveH8tbznscp05Oy6tXnMO0INnwNj2M8=;
        b=WLKy+dRqeLgWoKKlDhzsW05JKq2QKcpFbvTHhnvElza80NEHSTBBbCkZlnqh6s4Az5
         zs4hge36rIZ3qxajT7D9tl29pl8DHbe7HGS5aPFTw7NU8URwYHiyd+CyQ9ERC1O2sEfJ
         ltcedCX0YMzlZ3ZF9XNTXcya4AiN/wnEaeeMcBkhKh/U4aNtonWGs3jvMEvso0E2VlTq
         AFAMsVnMeE+NWu2eS9t7jwFht/KHHLCJ+mipov3DqWdb5M3Dse2S3kwesK42LFrQ7FX/
         KOZvK9B1pj9Xf4wTFxYl6OOfcdGVg7K2CLS31v3BO79p1D5rrHCKNjxxnu8QYZpd2XhE
         d4mg==
X-Gm-Message-State: APzg51Cwwakzth4AGAzsdKn393MJMIdb6J+Zi8XA6c6+oNjAnhdsWyip
        gtWlwRcAHbnAcvQJaulnGUveQg1ejDaRduvL4QI=
X-Google-Smtp-Source: ANB0Vdbba3qHgONLdClNl/Iet9UBZxLjV8la/rc9xHm74I7EK5a+BktcJf5WC6NnbOWX7ShXe9DuZu9kA+ZD1h+UH3I=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr7942423qkc.107.1536916251580;
 Fri, 14 Sep 2018 02:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
 <153622557736.14298.10350496216090814292.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622557736.14298.10350496216090814292.stgit@warthog.procyon.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 11:10:35 +0200
Message-ID: <CAK8P3a3bSArr5-TowR5VTV1xbvO62ubiP0_6tJrFf=zqvEUeAg@mail.gmail.com>
Subject: Re: [PATCH 11/11] UAPI: Check headers build for C++ [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 11:21 AM David Howells <dhowells@redhat.com> wrote:

> +
> +typedef __s8                   int8_t;
> +typedef __s16                  int16_t;
> +typedef __s32                  int32_t;
> +typedef __s64                  int64_t;
> +typedef __u8                   uint8_t;
> +typedef __u16                  uint16_t;
> +typedef __u32                  uint32_t;
> +typedef __u64                  uint64_t;
> +typedef long int               intptr_t;
> +typedef unsigned long int      uintptr_t;
> +typedef unsigned short         u_short;
> +typedef unsigned int           u_int;
> +typedef unsigned long          u_long;
> +typedef char                   *caddr_t;
> +
> +typedef __kernel_clockid_t     clockid_t;
> +typedef __kernel_ino_t         ino_t;
> +typedef __kernel_pid_t         pid_t;
> +typedef __kernel_sa_family_t   sa_family_t;
> +typedef __kernel_size_t                size_t;
> +typedef __kernel_uid_t         uid_t;
> +
> +typedef unsigned long          elf_greg_t;
> +typedef elf_greg_t             elf_gregset_t[1];
> +typedef unsigned long long     elf_fpregset_t[1];
> +typedef unsigned long long     elf_fpxregset_t[1];
> +
> +#define INT_MIN ((int)0x80000000)
> +#define INT_MAX ((int)0x7fffffff)
> +
> +extern size_t strlen(const char *);
> +extern void *memset(void *, int, size_t);
> +extern void *memcpy(void *, const void *, size_t);
> +extern __u16 ntohs(__u16);
> +extern __u16 htons(__u16);
> +extern __u32 ntohl(__u32);
> +extern __u32 htonl(__u32);
> +
> +typedef uint32_t               grant_ref_t;
> +typedef uint16_t               domid_t;
> +typedef unsigned long          xen_pfn_t;
> +
> +#define MSG_FIN         0x200
> +
> +typedef int SVGA3dMSPattern;
> +typedef int SVGA3dMSQualityLevel;
> +
> +struct sockaddr
> +{
> +       sa_family_t     sa_family;
> +       char            sa_data[14];
> +};
> +#define sockaddr_storage __kernel_sockaddr_storage

I think we need to reduce that list as much as we can. In
https://patchwork.ozlabs.org/patch/968814/, Joseph Myers pointed
out  header file (linux/elfcore.h) that simply cannot be included from
user space at all, because its dependencies cannot be met without
running into conflicting type definitions, and he would like to include
that file in order to automatically check that it's compatible with
the glibc version (I pointed out a couple of architectures on which
it is in fact incompatible right now).

In the list above, I see multiple classes of bugs that could be
addressed:

- references to identifiers that are only present in kernel internal
  headers: SVGA3dMSPattern, MSG_FIN, xen_pfn_t, ...
  I think these are all simple bugs, and we should either remove
  the references, or make sure the respective dependencies are
  included in the uapi headers as well, possibly renamed with
  a __kernel_ prefix to avoid clashing with user space headers.

- references to user space types that should use the uapi
  internal types: sockaddr_storage, clockid_t, uid_t, ...
  I think these just need to get the __kernel_prefix
  consistently as we did a few years ago. Note that using
  the headers otherwise is broken anyway when the types
  in libc are different from the ones in the kernel.

- standard types (uint32_t): either include the correct user
  space headers ifndef __KERNEL__ or use the kernel types

- standard functions (memcpy(), ntohs(), ...): These should
  already be handled in the headers by including the user space.
  If we missed any, we should probably do the same thing
  there.


       Arnd
