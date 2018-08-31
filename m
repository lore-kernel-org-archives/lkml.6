Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6532C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0CB20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0CB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeHaSYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:24:03 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35340 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHaSYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:24:03 -0400
Received: by mail-qt0-f194.google.com with SMTP id j7-v6so14689499qtp.2;
        Fri, 31 Aug 2018 07:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TP8ZGwsEQsRzmKoj0dBlNuXeVoWE5a822Ceik/rVN28=;
        b=HHzCE3z67iUppeLTCzG0QwJIeCfLHLIFVQpxLusiTKcQvMwRD3qV8b8kcSY3tq4k55
         TdEDEHppPGJ6pcS2tAGDWzt5ClAnj8GEvUtjs+ol2pBCDZzAAeHUbVMPEZcd87D5kO7r
         XusBlSlv69q68eoOXKThYGyQiOLSKMucrkJaSeDl4gNagnwpkQwVAdG70AU6RJzjaDe+
         260K3Njggk1MnpHyKrWve7F4ZwLuUcDkAS5Kpx3t783k7nKMZZ2/ZbVgbcZQzXKyiJk8
         TM1lWoYAT9WeP7RctfJNBiJUTVvekgLW0Dt8Lgo8B57LeKEmsHX+FvfH8DlQkxrqTxCD
         LkXQ==
X-Gm-Message-State: APzg51BcdGUYIOetlvBX5f1QUxTl/NQ47FAKUxVMTktWu1UcokAPp7jU
        2YgrSx3uvHTbYXw25Pi6pI17q3m1kHtq12BrvcI=
X-Google-Smtp-Source: ANB0VdbqVySie6pyJZyzfEtDAoMBUS94R3uJMIE5QiCNDo2Qap0n7hN/+jsJpfqds6oh1VE7CSlP0We6xp/gWM7M7Z8=
X-Received: by 2002:a0c:c171:: with SMTP id i46-v6mr15625072qvh.40.1535724980590;
 Fri, 31 Aug 2018 07:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
 <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
 <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
 <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
 <CAK8P3a1W2D5YWEC-VDkvQ8y3W8257g6X7B8_At7g8f9iE73a8w@mail.gmail.com> <CA+sq2CfjJjswOwypNMtro+g8TeHGoBqAeKpFrf2ys-1=Xg+qHw@mail.gmail.com>
In-Reply-To: <CA+sq2CfjJjswOwypNMtro+g8TeHGoBqAeKpFrf2ys-1=Xg+qHw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Aug 2018 16:16:04 +0200
Message-ID: <CAK8P3a3q_rY6VHwX9xQ9VMNC_4EmJLKzzDPL28SE13qNHX7=aA@mail.gmail.com>
Subject: Re: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, amakarov@marvell.com,
        sgoutham@marvell.com, lbartosik@marvell.com,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 8:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> On Thu, Aug 30, 2018 at 7:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Aug 28, 2018 at 3:23 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > On Tue, Aug 28, 2018 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > Any PCI device here irrespective in what domain (kernel or userspace)
> > > they are in
> > > use common mailbox communication. Which is
> > > # Write a mailbox msg (format is agreed between all parties) into
> > > shared (between AF and other PF/VFs)
> > >    memory region and trigger a interrupt to admin function.
> > > # Admin function processes the msg and puts reply in the same memory
> > > region and trigger
> > >    IRQ to the requesting device. If the device has a driver instance
> > > in kernel then it uses
> > >    IRQ and userspace applications does polling on the IRQ status bit.
> >
> > What is the purpose of the exported interface then? Is this
> > just an abstraction so each of the drivers can talk to its own
> > mailbox using a set of common helper functions?
> >
>
> Yes, that's correct.
>
> In kernel there will be a minimum of 3 drivers which will use this
> mailbox communication.
> So instead of duplicating APIs and structures in every driver, we
> thought of adding them in this AF driver and export them to ethernet
> and crypto drivers.

Ok. My feeling is then that the API is fine, but that it should not
be part of the AF module but rather be a standalone module.

My comment about the generic mailbox API no longer applies
here: you don't have a single shared mailbox hardware interface,
but each device has its own mailbox register set, so there
is no point in setting up a separate device for it, but I see
no need for creating an artificial dependency on the AF
driver. E.g. in a virtual machine that only has one ethernet
interface, you otherwise wouldn't load that driver, right?

         Arnd
