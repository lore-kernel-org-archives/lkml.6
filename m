Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB65C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A896218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlCs6tfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeL2AMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 19:12:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37995 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeL2AMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 19:12:41 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so19832196otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 16:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mtj1PqgoZTm/oiNODLBlwpCVxbSYRtKotA2P1yjpfX8=;
        b=JlCs6tfS6PRQNLvutosN4Kpk6uWm1WOa51W2RdGjPYpZc2GfwruDKEiiB7TGnbcZJj
         TR4JaiF8nx8zgfa4OgXzIzzNJAw94dS1aYvXtl0L5x4J3YV3CmFUrHEX4yCF29Pw/Crv
         rE4/v8E/RkPr+C5SlbBX2YMWkO6ahrrJtgX/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mtj1PqgoZTm/oiNODLBlwpCVxbSYRtKotA2P1yjpfX8=;
        b=pWsEPhUt/NW6iBPIDeNJqodHhI0rPznAJLnA1n6x6NXYgfKEuL/2l9RtdLpFuXFkB+
         ksz6pkMsQjycj2ivln75NgWXHdc1I5A5W/8VbSzRkmvfzY+7uer+cbEBf2hFtOw6bDy9
         nQFlPff79Lh1Ogrz82U4EFDRtXW2Zdrz0XNwHd+9cXljTF8xOFMg0S2zbucvA9rDCxyn
         G8iW37DvJb9aO+R1DUrGgSLTtUv+VecEHyaLr4f53HGb6fbay7JKX3PN8qU11a+C1j1S
         eVNpGWEySz7XwCPX7EVaAnJZZleBUAc1n/LWlHkk6PzKfH5b1DP+0ow50cLDS5m+8fry
         LzzA==
X-Gm-Message-State: AJcUukehzaYsBTY11gNy0/U/0mYUWRUN4ekzvQ3GvVXwpcbDQJC304xO
        zUT/CxDVk3XN5ehKlOfo0Md1JdhSL3rLEelyy/AlFQ==
X-Google-Smtp-Source: ALg8bN50x0bPRzN8Cf7rDCPgaHPBJEnBP7OO3HOy5pWYTdHLwLGF1EjRnaIcbfJ9qa9yXf5LV1bx6/Z+rbIni66IXc0=
X-Received: by 2002:a05:6830:1115:: with SMTP id w21mr19418042otq.316.1546042359608;
 Fri, 28 Dec 2018 16:12:39 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de> <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
 <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca> <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
 <1EF1B31A-83D8-4642-BEBF-F56E45485223@dilger.ca>
In-Reply-To: <1EF1B31A-83D8-4642-BEBF-F56E45485223@dilger.ca>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Sat, 29 Dec 2018 00:12:27 +0000
Message-ID: <CAFEAcA8Yq=CEyAUer1TcaSzuzcdNi3OUi4c67B6e+OkhmcKvbg@mail.gmail.com>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>, libc-alpha@sourceware.org,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Van Hensbergen <ericvh@gmail.com>, hpa@zytor.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 23:16, Andreas Dilger <adilger@dilger.ca> wrot
> On Dec 28, 2018, at 4:18 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> > The problem is that there is no 32-bit API in some cases
> > (unless I have misunderstood the kernel code) -- not all
> > host architectures implement compat syscalls or allow them
> > to be called from 64-bit processes or implement all the older
> > syscall variants that had smaller offets. If there was a guaranteed
> > "this syscall always exists and always gives me 32-bit offsets"
> > we could use it.
>
> The "32bitapi" mount option would use 32-bit hash for seekdir
> and telldir, regardless of what kernel API was used.  That would
> just set the FMODE_32BITHASH flag in the file->f_mode for all files.

A mount option wouldn't be much use to QEMU -- we can't tell
our users how to mount their filesystems, which they're
often doing lots of other things with besides running QEMU.
(Otherwise we could just tell them "don't use ext4", which
would also solve the problem :-)) We need something we can
use at the individual-syscall level.

thanks
-- PMM
