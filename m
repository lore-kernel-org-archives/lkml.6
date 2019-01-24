Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6274C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C93218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdZ2c7BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfAXWr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:47:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39179 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAXWr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:47:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so3572097pld.6;
        Thu, 24 Jan 2019 14:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jqEUm7Ndx9ETfUXXHdsk1ogwVhiYknV9yQlU0FZwyE8=;
        b=DdZ2c7BYy8XwypSkp2THfVU8zPDcJcLaqveuy+iek/UXD4J+i5K6OezydoZUkdDK2i
         48BKTB+r0Eeh7D9M2lEmMyaiYyBFzNMJSzVLaR/Fu4C/+yy0Sx9wX31ZUKCgVb/Q2LJC
         Zt9jma+rWUqezoa9XkaZ4r81lc7+GkyGZR1GiZ/wp48F1g3UNYKmwWbBd9eYgLeQkLhh
         fcONAgZQwLp/YBPNaBEdxWFcYNirtUkmVxR1pXvkxTOWnLqz0ccII2+8JVjl2CFwadmN
         LALVCXOitvySVQu/gLe6K35bMgSsvdb1YQGvpN3N/14jvUAAcqwY7SmnM+Lxxzl2ybel
         ZvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jqEUm7Ndx9ETfUXXHdsk1ogwVhiYknV9yQlU0FZwyE8=;
        b=CEB5ScszRunpLIjDaGhpdZHJhAvovwsp8o2HqfnGNytti7jQJEE3WQS9G/uUnxBjxw
         ufWGMBaO3hVhmnOltwEBdOTlqYfodaYtDUbQFFKqlzqjF6AOq51nU7rtPvAH5aXZNROs
         7IUlHXGxtVMXhhM0QkQlYqEN/JEZquGfk6gI2uU8aftT5Pj7Dp73MmoFliWST9RCbQCo
         E1/THpvQbjUa4lhacB6EmgiGAN7griA3qr9y80LkIggbK57a49siSD2B/OolDpBQEpzl
         GSeaDv1OE/8PuLNI4JL21LDW5qxIA/PyeXbP4cOh2tOf5M7mpw8ZyJQPQueVOwvI7kr1
         vT7A==
X-Gm-Message-State: AJcUukc/CjgaNlIJzIeLgVea60snLrPZxejT+riKyb9ZEtyLJyMjNy47
        Yjo77EttGRmvR/DJa6ylxXPrFcJjTrjZ9XRdj77EFnuA
X-Google-Smtp-Source: ALg8bN4xcTvPfSpV6k/3WpIUFr+txtGb2aQYd5OHvqCr4EL4JhsNUe88xmI5+rIma8QQ2Hv0mdybzZFbGsEsKKLTxk0=
X-Received: by 2002:a17:902:e28e:: with SMTP id cf14mr8534181plb.311.1548370075632;
 Thu, 24 Jan 2019 14:47:55 -0800 (PST)
MIME-Version: 1.0
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
 <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
 <CAHp75Vd+p8d87v_YEkzMLh8sxmvPYk3XeFdkpsrY_jTsC2zHCQ@mail.gmail.com> <d24b4177fda84042b4f59f2bb77e149e@atfkex01.bachmann.at>
In-Reply-To: <d24b4177fda84042b4f59f2bb77e149e@atfkex01.bachmann.at>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Jan 2019 00:47:43 +0200
Message-ID: <CAHp75Vc0OShOP_MzCuaObJQcnHcyJF1pvPnD9mNugK92rKAPqA@mail.gmail.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
To:     "KHUENY.Gerhard" <Gerhard.KHUENY@bachmann.info>
Cc:     Guan Yung Tseng <guan.yung.tseng@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 1:15 PM KHUENY.Gerhard
<Gerhard.KHUENY@bachmann.info> wrote:
>
> Hi,
>
> I would appreciate this change since this would solve my problem also ;-)
>

I have sent couple of hours ago the patch to upstream. If I'm not
mistaken, you did test it and I put deliberatly your tag. Tell me if
it's not the case or, if you have a chance, test it.

> Best regards,
> Gerhard Kh=C3=BCny
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: linux-serial-owner@vger.kernel.org <linux-serial-owner@vger.kernel.o=
rg> Im Auftrag von Andy Shevchenko
> Gesendet: Mittwoch, 23. J=C3=A4nner 2019 17:07
> An: Guan Yung Tseng <guan.yung.tseng@ni.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; open list:SERIAL DRI=
VERS <linux-serial@vger.kernel.org>; Linux Kernel Mailing List <linux-kerne=
l@vger.kernel.org>
> Betreff: Re: [PATCH] 8250_pci.c: Update NI specific devices class to mult=
i serial
>
> On Wed, Jan 23, 2019 at 5:18 PM Andy Shevchenko <andy.shevchenko@gmail.co=
m> wrote:
> >
> > On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com=
> wrote:
> > >
> > > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > > The reason of doing this is because all NI multi port serial cards
> > > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> > > serial_pci_is_class_communication test added in the commit
> > > 7d8905d06405
> > > ("serial: 8250_pci: Enable device after we check black list").
> >
> > Guan, can you provide an output of the
> >
> > lspci -nk -xx -vv -s <BDF>
> >
> > of your device, where <BDF> is a PCI address in a form of bus:device.fu=
nction?
>
> While I'm still wondering of the above, can you also test the bellow patc=
h if it fixes your issue?
>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



--=20
With Best Regards,
Andy Shevchenko
