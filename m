Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECAF2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECAF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeHaS2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:28:04 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44413 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeHaS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:28:04 -0400
Received: by mail-qt0-f196.google.com with SMTP id k38-v6so14666069qtk.11;
        Fri, 31 Aug 2018 07:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcgN41Oo+CGYVjK/ybf8jNPwH3OQYLcVcyZsNNok/II=;
        b=tWX8vIsS4l9IiR70G1fiPBWWgM2pPCTRW5isCvdrmY5oqIxphNJyGiOmF1XrulCZOl
         xm0c67zSeKPN8HM/T00NmnECAI4BCDX/GQXZ7BfZgDKbV0xWB16Kh+KiknLyiXeka643
         nEJgbdWe4Hxhk890Al4zBEYMzXK8Dz7cMUVYbJUF/PwPfEjbaWQj4WLMekII1qOXjhJC
         m/m6Cp3gBQ0ihrgkxKSsfKNfj5yCxuDUjyYLkyx5YQz75RNJcoWlR4AGhneir5JcydYm
         +LdOkYOYWo9NgZ+HQUGe/5YnwZpiO5nFqjTkb9JmIovqs6qNWUj26O0bmpcadm+k0rv/
         cwhQ==
X-Gm-Message-State: APzg51BtdsSYBlf+wBeO3PnXV1oZaX1qhNdxUS846L1hQDK9bPWP9qmv
        +aYfC/T3C2sExyvab+vKVWLfxBzasdmC3BU+Llg=
X-Google-Smtp-Source: ANB0Vdbdg2x7yiVTzlzC1xOPzxo6Or774Kb+Zwpm6Ymt3uMEU2tdICosoXK4hKccS0xjYL8Xv2lHRy9zZqt8z67HkcY=
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr16697275qtb.75.1535725219736;
 Fri, 31 Aug 2018 07:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
 <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com> <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com>
In-Reply-To: <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Aug 2018 16:20:03 +0200
Message-ID: <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, sgoutham@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 7:55 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> On Thu, Aug 30, 2018 at 7:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Aug 28, 2018 at 3:10 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > Ok, I think I understand the PF/VF distinction now. One (to me)
> > surprising aspect here is that you not just have one physical function
> > that you can use to assign resources to multiple virtual functions,
> > but also a second level of virtualization that is used to assign
> > resources to "physical functions" that are less physical than the
> > name suggests.
>
> Yes, PF is just for name sake, on-boot there is no difference between
> PFs/VFs as such.
> PF0 has privilege access to assign resources to all PFs and their VFs.
> This admin function driver loads for PF0.

ok

> > The part that I have not grasped yet is what the split between
> > the CGX and the AF is for, how they relate to one another, and
> > what the software abstraction for the two is going to be.
>
> In HW, CGX is a separate PCI device which handles the serdes and
> physical ethernet interface.
> Ethernet driver in drivers/net/ethernet can only communicate to
> admin function driver since they share a mailbox memory.
> So we had to bind both CGX and admin function drivers to almost work as one,
> inorder to provide relavent info to ethernet drivers. That's why we
> have many functions
> from CGX driver which AF uses.
>
> eg: Firmware gets to know about a physical interface status change,
> which CGX driver gets
> to know and it uses AF's mailbox communication to inform ethernet
> driver about the event.

Would it make sense then to combine the CGX driver and the AF
driver into a single module? It sounds like you can never really
use one without the other anyway, and that would make it easier
to have a sensible abstraction to user space.

      Arnd
