Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A391CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B72F2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B72F2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeH3R7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:59:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45311 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeH3R7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:59:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id g44-v6so9838366qtb.12;
        Thu, 30 Aug 2018 06:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYvtCHntOFf39RNiijk78XZLNHtjhDQz6GCS2aHc6Mc=;
        b=ugK8XhnfLfy8Lp91ND1+KCN6/jkYqJwOU3WvjI/EYMo/QpSa+qEUyiIGq5RfNhJAhM
         gokoBbK3rOlwhqtFWEYSI0fQrWv/QezUVvs5l+EL57clsSu/EAXaqSaMpC49hkwRrfH0
         UkWsySif0jB32LER/2RAAbM9xc3TYX2HhgjAcESf2t33emJEQ7qgJLDtTmFo2hkslntw
         wIUoPA/TsGSjiNnWi968IBrOLdhAKqME6t7S+fm9v9Z32cq/Uv0iziUn94SPhkLU5KTm
         mD+HioDSD63qGTv7swRYnfdNTbhZHWwSIHU6xji8CcP8MIcRQPlQRsatnaRM3TU6xoQJ
         1Usw==
X-Gm-Message-State: APzg51CqYF/Kfk5ZUK0pJmqEQLZU/qj5/bEb6TFOryGJHYyalhyf2mV9
        Scoe3KY9q4E+ZqtvlEgxZotGo7+/K33OtSbxpDA=
X-Google-Smtp-Source: ANB0VdYDMQoO6Z7nZJa9nF/MzXvN0FguuHGjDFApAM5yRqrk+nsXyCmRwdBFgcAv9MdJYx1a83WkBaEGYqcn8xd2UGg=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr11523359qvm.115.1535637423488;
 Thu, 30 Aug 2018 06:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
 <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
 <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com> <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
In-Reply-To: <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Aug 2018 15:56:47 +0200
Message-ID: <CAK8P3a1W2D5YWEC-VDkvQ8y3W8257g6X7B8_At7g8f9iE73a8w@mail.gmail.com>
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

On Tue, Aug 28, 2018 at 3:23 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > >
> > > On Tue, Aug 28, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> > > > >
> > > > > From: Aleksey Makarov <amakarov@marvell.com>
> > > > >
> > > > > This patch adds mailbox support infrastructure APIs.
> > > > > Each RVU device has a dedicated 64KB mailbox region
> > > > > shared with it's peer for communication. RVU AF has
> > > > > a separate mailbox region shared with each of RVU PFs
> > > > > and a RVU PF has a separate region shared with each of
> > > > > it's VF.
> > > > >
> > > > > These set of APIs are used by this driver (RVU AF) and
> > > > > other RVU PF/VF drivers eg netdev, crypto e.t.c.
> > > > >
> > > > > Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> > > > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > > > > Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
> > > >
> > > > Why does this driver not use the drivers/mailbox/ infrastructure?
> > > >
> > > This is a common administrative software driver which will be handling requests
> > > from kernel drivers and as well as drivers in userspace applications.
> > > We had to keep mailbox communication infrastructure same across all usages.
> >
> > Can you explain more about the usage of userspace applications
> > and what interface you plan to use into the kernel?
>
> Any PCI device here irrespective in what domain (kernel or userspace)
> they are in
> use common mailbox communication. Which is
> # Write a mailbox msg (format is agreed between all parties) into
> shared (between AF and other PF/VFs)
>    memory region and trigger a interrupt to admin function.
> # Admin function processes the msg and puts reply in the same memory
> region and trigger
>    IRQ to the requesting device. If the device has a driver instance
> in kernel then it uses
>    IRQ and userspace applications does polling on the IRQ status bit.

Ok, so the mailbox here is a communication mechanism between
two device drivers that may run on the same kernel, or in different
instances (user space, virtual machine, ...), but each driver
only talks to the mailbox visible in its own device, right?

What is the purpose of the exported interface then? Is this
just an abstraction so each of the drivers can talk to its own
mailbox using a set of common helper functions?

      Arnd
