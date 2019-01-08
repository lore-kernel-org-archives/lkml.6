Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D421EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F3B2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyg7o4mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfAHV3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:29:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37144 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfAHV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:29:20 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so4362880iok.4;
        Tue, 08 Jan 2019 13:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjS78uQSbCdKCPygo0CoQj9gYIa5n4/romkv0n456+Y=;
        b=Qyg7o4mVqxawxBe4EdUFL8t/+X0LIBjR+JsHbwPd4l3Z+vmPATWIB59hpJiCBMydC8
         SKW9spP+0tNfpVYcy82Z5dESPcfxlob9rEHguF0roulT7lyvt/ILd6wKGZ33ksfvgq0u
         kVmiYVIMwRkRUM7FSi1ayrMZUh9bGHqC22tuqZmfhj4691aF8kPqVKzm5nfxxzYHqD/u
         Sz/8hc0o7YAcUeSCDIpIVcQ+VU/aftIxsK0reQx+7ya+owJ9xh095LUI3bAFrjfU8b8f
         LQpmA+kJKfUWi6LeUXFuEW9LpMNrVQB2dwaq6ox6WZSTnP5nRawvmxx5/QrNEQNMs6Gs
         nUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjS78uQSbCdKCPygo0CoQj9gYIa5n4/romkv0n456+Y=;
        b=bcnNwSprseTLLt2ma0YeiMjKOsEtaAE2izmreI0EGqRWVKTblCbKqnSgjZWsrGgum1
         6wiUDK7G6Xmr1JUM5TbgY7tUpukAs1TA4HGS21LnePqRN9kXWeKHNsSBQq5HSwqjegjM
         SI9eSdC8D40ZeHXo7AS8aOFcx3H67PajbgrrJxoPssXoYS80xzrqcoy5NQD22hES46xc
         Am8q1JvdFnE4BxmrH01LnsToTDllOsS4wNlM9z+3g+hfo1MFa4up4hxgBgmi3Mbr6CsV
         AiGRSpjbSqoBC1fw0YBHBoVWkAPPLuFHswmd/l9QrKeohyGQkKpAFiiXCuzFX8Fr7cet
         GEuA==
X-Gm-Message-State: AJcUukf09a4DGIzzIQZV0PYfosvi5u7TrOvdfQ0QzTxiupZMFLHhREVk
        tscItu9DReUd4RsnIMmNAgj6KRy04lLAhvlBmwU=
X-Google-Smtp-Source: ALg8bN5SW1k1cSp+b8s5Z3lPIKWAfapgdrB+ci7GO15oZ8FdL206oogHrlJ7RwN11610nK7mA22HPpd56e+aazMhpXU=
X-Received: by 2002:a6b:8b4e:: with SMTP id n75mr2015591iod.184.1546982958943;
 Tue, 08 Jan 2019 13:29:18 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
 <20190108200959.1686520-1-arnd@arndb.de>
In-Reply-To: <20190108200959.1686520-1-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 8 Jan 2019 13:29:09 -0800
Message-ID: <CABeXuvpprn_AXF0ama9CsHyZ1yb8FuUH25MXauLzHyahxr+Vwg@mail.gmail.com>
Subject: Re: [PATCH] socket: move compat timeout handling into sock.c
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ccaulfie@redhat.com, Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        cluster-devel <cluster-devel@redhat.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 12:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This is a cleanup to prepare for the addition of 64-bit time_t
> in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
> unnecessarily complex and error-prone, moving it all into the
> main setsockopt()/getsockopt() implementation requires half
> as much code and is easier to extend.
>
> 32-bit user space can now use old_timeval32 on both 32-bit
> and 64-bit machines, while 64-bit code can use
> __old_kernel_timeval.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This will make the other series so much nicer. Thank you.

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
