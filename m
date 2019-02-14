Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D87222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="SpU8nQc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfBNAl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:41:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43454 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfBNAlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:41:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id j1so3215094lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9qOJOuzsi5LWpYQ5B6tsZvJhD7uF4dq82zy+Mglx5W8=;
        b=SpU8nQc33J+OtOY7JfZK7igtMy8OtnKm+Q9m6VZRr3yD2HiPfJHk/7F5Qi/EcY40pm
         EOafe5WuLe1r3YnHPVsojJHyIrkt23VSBc/Z2PbjjVv/v8I41+qh5855ht3RJ48jw42c
         KQf+jCbx3Al2HfM8tIX/0JstVU2U+fhe91QmzT++ozQRK9MfywBkdwSeuahH6b/WQQKl
         tvUnYUj5Z0RdCxf0IRZP98X3nKd7DAOzCkN2I+RbOuF3drdh1Hv0EsAvY1z1JGl2ZbTu
         G4azF7ujwdzc4vUmyBRDdegp0YYRRft5eyU+PcPoevurMWrabQsOZOWcNJq/ypdFgE6E
         wswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9qOJOuzsi5LWpYQ5B6tsZvJhD7uF4dq82zy+Mglx5W8=;
        b=THINzCh0qdFp5y4KDkIhk3YCQEzybNoK/79XgoHSoJc39DoZYBJWPTB6Sy/04j0OmP
         JAfYX2KNy4NKH7hJNFImgPgHpereew4Qm4kgkA9clUGAea/lVindybCjVvqF1NXdx5gM
         sd2AtMkdZQA4xbX9w/jQstKPC4Q/tOP0mPZKsBXyYFeUb2ArAqPHY9fy7uM67W9f70Qi
         2Z7kl93LYchnDQBfX5flNse/Ir6RmqV1k+2OvJWU9CWygN2w29K4RJqck691UG8tv0nr
         Q5V87oK8ZgwHJOwyBLLSpDI3TEMv4QNnkpWawM8jFd95EjiV8o6HCYWMv5JtJHzxA8cf
         RR8g==
X-Gm-Message-State: AHQUAuYMPywmtRtuRmC/ddMW2CHhOi5TiTh9Jr8OpHmn1JK/WFf9Itmf
        8si5uNBVpcYdwIbBJDjPaANJbmf5Xg8y6Lq1s7lmMA==
X-Google-Smtp-Source: AHgI3IbdCSXo5HSZfnpRi0sybIm4inprpfV8+yCTVb4mbLAtvbh7cIHXQWWMNyzch31wk4oGLnC6eqecSe/5zT8ShkI=
X-Received: by 2002:a19:5013:: with SMTP id e19mr509928lfb.89.1550104879818;
 Wed, 13 Feb 2019 16:41:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:5612:0:0:0:0:0 with HTTP; Wed, 13 Feb 2019 16:41:18
 -0800 (PST)
In-Reply-To: <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
Date:   Wed, 13 Feb 2019 19:41:18 -0500
Message-ID: <CAN1fySXjLUYFw2JGQQ5xxqjX+6kygzqgUc6Oj-sbtq=ZjgfLTA@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        graham@grahamc.com, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>, mhocko@suse.com,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for CC'ing relevant folks.

On 13/02/2019, Richard Weinberger <richard.weinberger@gmail.com> wrote:
> [CC'in relevant folks]
>
> On Thu, Feb 14, 2019 at 12:19 AM Samuel Dionne-Riel
> <samuel@dionne-riel.com> wrote:
>>
>> Here is an example shebang causing an issue:
>>
>> #! /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
>> -I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-File-Slurp-9999=
.25/lib/perl5/site_perl
>> -I/nix/store/ha8v67sl8dac92r9z07vzr4gv1y9nwqz-perl5.28.1-Net-DBus-1.1.0/=
lib/perl5/site_perl
>> -I/nix/store/dcrkvnjmwh69ljsvpbdjjdnqgwx90a9d-perl5.28.1-XML-Parser-2.44=
/lib/perl5/site_perl
>> -I/nix/store/rmji88k2zz7h4zg97385bygcydrf2q8h-perl5.28.1-XML-Twig-3.52/l=
ib/perl5/site_perl
>
> This this ever work correctly? It is longer than BINPRM_BUF_SIZE.
>

Yes, this is longer than BINPRM_BUF_SIZE. This worked when the
interpreter knew to re-read the shebang, which among other
interpreters, perl did.

https://perl5.git.perl.org/perl.git/blob/04db542212fdad3a62f13afe741c99028f=
4bf799:/toke.c#l5524

>> (The shebang was artificially wrapped spaces replaced by newlines)
>>
>> Another contributor tracked the regression it to commit
>> 8099b047ecc431518b9bb6bdbba3549bbecdc343 in the 5.0-rc* tree.
>>
>> I bring no particular fix to the issue, but I believe it should at
>> least be fast-tracked to a revert for the stable and LTS branches, and
>> since 5.0 might drop soon, a solution worked on, or possibly a revert
>> until one is figured out.
>
> Your shebang line exceeds BINPRM_BUF_SIZE.
> Before the said commit the kernel silently truncated the shebang line
> (and corrupted it),
> now it tells the user that the line is too long.
>

Yes, the shebang line exceeds BINPRM_BUF_SIZE.

Before, the interpreter was still used (assuming it wasn't cut by the
length), and the interpreter was free to re-read the shebang if
desired.

With the new behaviour, instead of executing the interpreter with a
possibly truncated command line, the default script interpreter is
used, meaning that the perl script is being interpreted by the wrong
interpreter, giving copious amounts of irrelevant errors. This is not
telling the user that the line is too long.

This provably breaks the userland as under 4.14.98 the perl
interpreter is used when running the script, and under 4.14.99 bash is
used when running the script.

For a given script with a shebang of #!(124*A)ZBBB:

The behaviour as of before the regression:

sh: ./foolish: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZ:
bad interpreter: No such file or directory

As expected, it cuts the shebang.

The behaviour following the change is the script ends up being
executed by the shell interpreter, as if there was no shebang, and +x.

Quoted from `man 3 exec`

> If the header of a file isn't recognized (the attempted execve(2) failed =
with the error ENOEXEC), these functions will execute the shell (/bin/sh) w=
ith the path of the file as its first argument. (If this attempt fails, no =
further searching is done.)

The now returned ENOEXEC might be "more right", but changes the
semantics of a truncated shebang.

Here I am not debating the validity of using a truncated shebang, but
showing that the userspace behaviour changed in an unexpected and
breaking behaviour.

Am I under a wrong assumption that the kernel shouldn't break userspace?

--=20
=E2=80=94 Samuel Dionne-Riel
