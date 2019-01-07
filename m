Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F7206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxzeObZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfAGTTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:19:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39207 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:19:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so596128pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdY+FQ4vmBWmv7Uxo+1l55P42pudhz5vFXJr/uJbib4=;
        b=IxzeObZqagNtcozqqsAjTXKQ8Pdkf/VSX9tIThcApRmY7BsYYtDId7CY8RjXcF0CMB
         zj5DoUpL2CCnp9sRtz1pvHXxgfJcp3J//QJ9BBPAVtwhRdnKrkA9zy7qhhut9bqiK54s
         5ajIUKtHepfUoAGDyrzQ+dYwLtvYXI01w0bVC11tO8G3BWe+GyOH8T39QUzlxDEHHiCY
         4hlM4dM1YYc4KDxi9kV18FAxamVgxbiibcatVWoxNaL1L2PSeThGzAemIvKiuJ/eJUGH
         Pz9BdjVZ93dh8ANH5w3NYCE4/JfDRqk1jEnASfeGrVxrSBVzLXfzhz/A0FjD5cwAACpZ
         bmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdY+FQ4vmBWmv7Uxo+1l55P42pudhz5vFXJr/uJbib4=;
        b=dl/l0nQJhWmLOsyB9hJEmGoLakJJQtLQ3ml5byMtYEH+H4/AaW/UdEWG0swVDhNiqs
         t/O3lgpvWqMnGfZwU8WyRUVPK7FkY2EH5j5W2/fgrkDgOlEeibV4fqrHqL7YhCKJQWJK
         iytzL9mSrCqTYRvk8Ch/PtHW7Rgo9owqAQX5zKlq7cWyyyohgmLaLVBE7MwUWFVvHnMD
         1P2p51ZixDP7DHlGpQnr2hQ2QXZbvIdktdr9MsD4UTtytRpbS4s/ijZ4E2BJU//knqP/
         mQO89MpBGTk3m/201+T/f7YzR8fTd8TWP9SI8VPbEKMxvewe03Q/cNxeO+U3xip8vAuz
         ZEEw==
X-Gm-Message-State: AJcUukdUjL/3oowGwNdSpKGfi26FZue4jhYrPNbgWzmDcIifmtXQ7548
        aJ83cvRXwUArL0+5v6q3a5JLo98Q0YR5kNe+R/9Gpw==
X-Google-Smtp-Source: ALg8bN5wQZsDoSzm6MwA9uImpmyLMmj0qXxb4rPQv7wwqLwplXAEKkaEwKSHBuAlnZU2EVkXS7zbZ+rvolutn8SyoYw=
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr61962557plb.238.1546888755716;
 Mon, 07 Jan 2019 11:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181231181209.28695-1-natechancellor@gmail.com> <nycvar.YSQ.7.76.1901051128160.1783@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1901051128160.1783@knanqh.ubzr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Jan 2019 11:19:04 -0800
Message-ID: <CAKwvOd=NfK-P_Z=W=h5-5c2Jv3vfB0FsmdHcZeWEN1y_Fg=YAw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Remove '-p' from LDFLAGS
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 8:34 AM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> On Mon, 31 Dec 2018, Nathan Chancellor wrote:
>
> > This option is not supported by lld:
> >
> >     ld.lld: error: unknown argument: -p
> >
> > This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
> > that tree). Given that the lowest officially supported of binutils for
> > the kernel is 2.20, which was released in 2009, nobody needs this flag
> > around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
> > linker flag") did the same for arm64.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-by: Stefan Agner <stefan@agner.ch>
>
> You may now submit your patch to RMK's patch system:
> http://www.arm.linux.org.uk/developer/patches/

http://www.arm.linux.org.uk/developer/patches/info.php
"""
Mailing your patch.
Mail it to patches@armlinux.org.uk and check the reply.
"""

*sighs in GitHub*
-- 
Thanks,
~Nick Desaulniers
