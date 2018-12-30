Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D45EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77A22075D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKc2RPvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeL3N7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 08:59:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40033 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeL3N73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 08:59:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so21964689oth.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3160XWMiyGzMoXzkO7EYYdMp0aFg5cJaC9940mnNcWo=;
        b=XKc2RPvZQVeuWAaTWfgDbuJio2dLv/dbkoWL4LNQyLCxXhAUoUiq9uAXVuBeopBk68
         iAeRKjI6jmj+SkFQIeh9ndywg6YUskgg9WYejOpoTnVTw+rlrj5C2HTKGXdX4SGEHt+A
         1WPCk1olN0QdCFvFTbAlUv2HP8jwmnKKNXXto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3160XWMiyGzMoXzkO7EYYdMp0aFg5cJaC9940mnNcWo=;
        b=JoE2aBznfHpedeD0DbqM8Q9JPLiWQhOWjC4vux+wS20RVuRce7q2umLc7bft1XkeBi
         6NmNKyo0f3DjSvHQ8uR0o4Vq1+5HeHVJDkmTq7qbSk9KOQ+jR3WOLaetnozT5YIFJpl9
         mdBgHH7M+9lVDyUpNIfdlvOJGtZDKgDhaQVmICtoN92N80TKExynQCH/SJ0RkVen6X20
         5NHsRiN2C5SBqTKH7W68M66dwZEMBxXOBuLPXlYiLH2kHoDTfmDuqN3AfIaDtq8nLYJa
         GK8xjZh5mLfLN/2VrPsPdwHoWc/5m7T82K8b5kzcMkVXxWQnNXPn2/dAJz910Ao0AILn
         uD7A==
X-Gm-Message-State: AJcUukf9RqM91PPzqCURSHqYGKdHUQrxR/Sd7EhJdcTXd2xhyXCsMJL4
        BLMfVU3ShOIQlS6zVGeuRws6CmdIeby6X/muzEGSSA==
X-Google-Smtp-Source: ALg8bN4lVhCZEsV89Vf+mkEkaKeAec3bwxw/d9th/6lwTBitXu/PpuaRXoNIotq3lwyxfR7L/qnr35jSWYS6s9wPe/o=
X-Received: by 2002:a9d:6f0b:: with SMTP id n11mr5442838otq.363.1546178368822;
 Sun, 30 Dec 2018 05:59:28 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de> <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
 <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca> <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
 <1EF1B31A-83D8-4642-BEBF-F56E45485223@dilger.ca> <CAFEAcA8Yq=CEyAUer1TcaSzuzcdNi3OUi4c67B6e+OkhmcKvbg@mail.gmail.com>
 <20181229015453.GA6310@bombadil.infradead.org> <CALCETrUJn4cV+o3scP1EzYS=JA--5KUXvjuxZDbsnhXra1vrwA@mail.gmail.com>
In-Reply-To: <CALCETrUJn4cV+o3scP1EzYS=JA--5KUXvjuxZDbsnhXra1vrwA@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Sun, 30 Dec 2018 13:59:17 +0000
Message-ID: <CAFEAcA_gV734EAxDii8XBOPr82kLYtsZmW5jYfQnT_DEpGOkpQ@mail.gmail.com>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        libc-alpha <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Ron Minnich <rminnich@sandia.gov>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018 at 16:49, Andy Lutomirski <luto@kernel.org> wrote:
> > Could you use a prctl to set whether you were running in 32 or 64 bit
> > mode?  Or do you change which kind of task you're emulating too often
> > to make this a good idea?

QEMU's linux-user mode always only runs the single process,
which is a fixed guest architecture. But it also wants to
make system calls on its own behalf, as well as the ones it
is passing through from the guest, and I suspect it would
confuse the host libc if we changed the semantics of those
under its feet.

> How would this work?  We already have the separate
> COMPAT_DEFINE_SYSCALL entries *and* in_compat_syscall(). Now we=E2=80=99d=
 have
> a third degree of freedom.
>
> Either the arches people care about should add reasonable ways to
> issue 32-bit syscalls from 64-bit mode or there should be an explicit
> way to ask for the 32-bit directory offsets.

The first of those is not sufficient for QEMU if done
as a per-architecture thing, because there may not even be
a 32-bit syscall interface on the host kernel. The second
sounds better -- there's nothing conceptually architecture
specific about what we want to do or which is tied to the
idea of whether there's a 32-bit compat mode in the host
architecture or not.

thanks
-- PMM
