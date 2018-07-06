Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50CDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5671D22BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6tViIRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5671D22BD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934519AbeGFUtB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:49:01 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35952 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeGFUs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:48:59 -0400
Received: by mail-ua0-f193.google.com with SMTP id y8-v6so8318149uan.3;
        Fri, 06 Jul 2018 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iR0DbJH0B0z0mgk3O7Mdvyprx21gQsWz8JWgQG6Lgow=;
        b=W6tViIReXsjNCDP4lF9zUJe9+AG8mISRnypyu0LLmPj3/16tKfWPWuJFr0vMToG80O
         JcvArZa/dcMQtf9S83QyLH4eEYDHca/MLONAoVAJPnCLoxJp78EVM81rUQj8l3DiRbBZ
         0IxggpJr75EVp7Hw02F6BAPpYuTGhZpeC4CA7xhnQI8fLt0PTAsAzaQCEe6HAef18xrQ
         vXXSlDrCydKImqrQuvVfobiyX6gB4ar4/7kHAEUvtAP4uer3+q6K5vseBodXxpSAneUR
         xMp37Btn6MwPq0oLLo/WaDFE/WuZimvu+JbYAjEQZPJRLEq7xrdABnQrp+qv/N431kXm
         9CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iR0DbJH0B0z0mgk3O7Mdvyprx21gQsWz8JWgQG6Lgow=;
        b=ZsW8JVpUUA21bRQMiD8VXhPC2mXZAMCJLRQN+Sb3yYvv/+XZkwEz+H4TJeKYkT0Uxy
         GpKJTiJyD73My09I8dtF9ODFZ6Fnx3PNrL0cYZ7NvXuGmf4i9NreE8lR9Q1vcj6cp2J1
         XRta9fgSmjtfqMyuaX6PJVimXtE8fIMJeZH6DUX7P/L0MdaGgzoRxG1ERc9h8zQMXLqq
         magR00sGBvkEX0wewYfrA8F0AO9Lt3spKKrPHAvTQWEr/G2tZRpGYXJJ4WxaJm7giAcq
         GALFvRFUpLuUsp4pAaaGMnQLm8pmGWEYDdVMZEQTv3QXVUcsX4RebpWTetK0AJh0icIW
         GNdw==
X-Gm-Message-State: APt69E2NwbtBkxIVaesniNIPlApGMy6etTx7jeQQl8hVRo3wp0is6sny
        W/j1vE2KIDaqv257fUzfAkNylIcbgxC7DnxGL+4=
X-Google-Smtp-Source: AAOMgpezOVXVX83wfLt0Pm5g12cObn6LwYsoALzee1bfXuNCrZz02PZW8CbgNGxi3m2kmjDjR2b4sn0v/zBwatqztwY=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr7165199uai.47.1530910138639;
 Fri, 06 Jul 2018 13:48:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 13:48:58 -0700 (PDT)
In-Reply-To: <20180706183928.GA3583@cisco.lan>
References: <20180706143919.GA2344@kroah.com> <20180706162457.20489-1-tycho@tycho.ws>
 <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com> <20180706183928.GA3583@cisco.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 Jul 2018 23:48:58 +0300
Message-ID: <CAHp75VeAoL9aN4pX4G9WGPS4Oxi=G6PyF7qCCyZ1fNH=gKHYiw@mail.gmail.com>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and uart_shutdown()
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 9:39 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Fri, Jul 06, 2018 at 07:49:09PM +0300, Andy Shevchenko wrote:
>> On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:

>  but without the initialization I get,
>
>   CC      drivers/tty/serial/serial_core.o
> In file included from ./include/linux/seqlock.h:36:0,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from drivers/tty/serial/serial_core.c:10:
> drivers/tty/serial/serial_core.c: In function =E2=80=98uart_startup.part.=
20=E2=80=99:
> ./include/linux/spinlock.h:260:3: warning: =E2=80=98flags=E2=80=99 may be=
 used uninitialized in this function  -Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/serial_core.c:184:22: note: =E2=80=98flags=E2=80=99 wa=
s declared here
>   unsigned long page, flags;
>                       ^~~~~

Hmm... I didn't see such warning. How you run make?

Btw, you adding the only places with such assignments in this file.
So, I would not do in your case, until entire file would be fixed.

(But warning looks bogus, or you have some patches on top of current
vanilla / next)

--=20
With Best Regards,
Andy Shevchenko
