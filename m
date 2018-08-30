Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADFCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E7520835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJGFw/qD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E7520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeH3Wke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:40:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41128 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeH3Wkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:40:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so8958098wrb.8;
        Thu, 30 Aug 2018 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcQ8owcppVEFIYb2YIOo4LepepkxBcVtZIlrtg8OzOA=;
        b=BJGFw/qD2hlTwvzJyrIIhxbWACxFpZc6H4FfunZmJzTTrQr7JyUvApaV3a28HIEh9U
         RyOjguUZcT9qOVfvXuBWo5IsgyihaFCuObHisXetB4ZStKO1IstKi9XhZkWZEL9sL0/j
         xHlyqnFd0yRSyXZS/DnzfWd1mXOrFV4Rk9IIvdjMcH3hzln2LP8uzJZuiUxz9NGOc17H
         9xhB9b+DBWwDbKdCX11cIakF2AZ46jIZMi+zRkZnZlxj48So0xNso0gFhIxExxQi5hFb
         1VYHkZMGsF2FBEX7Oqv8xdVQ5cLjGW6M5MuQIudDIA0+k4fDXtSgZiC5WSj+Uh3tRKYl
         gKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcQ8owcppVEFIYb2YIOo4LepepkxBcVtZIlrtg8OzOA=;
        b=gtACozguZTs7jiSyFOq5I8aKYAB7+IX6MprjqRa19Y9R4mWZT2/JoP8CZCU73Yem9A
         Sk5PEZtiMxCUo8SFOksB2ykbNDNOlRnG+VWSKftuGDJRwM483X2+blFWnhuaiyy2DzwS
         eFOFhJp5QGGRaHRxFkk1ly/rgH9ZPiqm5j5Z6cDT6PDx2nwZ+cTgP00PAVHtKisqQYMs
         UFZ8eEyKDFN46eK+YD8TLSkQHnD57wQ1es5boJQ7DXwd2oOs+UOS2NFewhVWmd/HK6AC
         7kf6MeOyJaT+yd/iP00R+eAHKRDuxmVp20qzJhDmZjPA91dh9h/8AKbNT8AbHIjyPn5C
         AVJA==
X-Gm-Message-State: APzg51BJRPQCsHPTpYjgugRt1/pRiteVgnGaR3udjFba2O71UasP0BaT
        EcEB+m9Lh03cuK6WlaFPcdO5IDWuEEjSN2794S8=
X-Google-Smtp-Source: ANB0VdY8B2QjIlNb/Avp+tnJ4vHVuyNllUsLMsGvx7hsOjepeuPL7l1Rr8Vc8SpW38PVfs5+K0JEhjmQukIei73p97k=
X-Received: by 2002:a5d:61c1:: with SMTP id q1-v6mr8855124wrv.33.1535654222913;
 Thu, 30 Aug 2018 11:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
 <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
 <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
 <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com> <CAK8P3a1W2D5YWEC-VDkvQ8y3W8257g6X7B8_At7g8f9iE73a8w@mail.gmail.com>
In-Reply-To: <CAK8P3a1W2D5YWEC-VDkvQ8y3W8257g6X7B8_At7g8f9iE73a8w@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Fri, 31 Aug 2018 00:06:51 +0530
Message-ID: <CA+sq2CfjJjswOwypNMtro+g8TeHGoBqAeKpFrf2ys-1=Xg+qHw@mail.gmail.com>
Subject: Re: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Aleksey Makarov <amakarov@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 7:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 3:23 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> >
> > On Tue, Aug 28, 2018 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 28, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >
> > > > > On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> > > > > >
> > > > > > From: Aleksey Makarov <amakarov@marvell.com>
> > > > > >
> > > > > > This patch adds mailbox support infrastructure APIs.
> > > > > > Each RVU device has a dedicated 64KB mailbox region
> > > > > > shared with it's peer for communication. RVU AF has
> > > > > > a separate mailbox region shared with each of RVU PFs
> > > > > > and a RVU PF has a separate region shared with each of
> > > > > > it's VF.
> > > > > >
> > > > > > These set of APIs are used by this driver (RVU AF) and
> > > > > > other RVU PF/VF drivers eg netdev, crypto e.t.c.
> > > > > >
> > > > > > Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> > > > > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > > > > > Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
> > > > >
> > > > > Why does this driver not use the drivers/mailbox/ infrastructure?
> > > > >
> > > > This is a common administrative software driver which will be handling requests
> > > > from kernel drivers and as well as drivers in userspace applications.
> > > > We had to keep mailbox communication infrastructure same across all usages.
> > >
> > > Can you explain more about the usage of userspace applications
> > > and what interface you plan to use into the kernel?
> >
> > Any PCI device here irrespective in what domain (kernel or userspace)
> > they are in
> > use common mailbox communication. Which is
> > # Write a mailbox msg (format is agreed between all parties) into
> > shared (between AF and other PF/VFs)
> >    memory region and trigger a interrupt to admin function.
> > # Admin function processes the msg and puts reply in the same memory
> > region and trigger
> >    IRQ to the requesting device. If the device has a driver instance
> > in kernel then it uses
> >    IRQ and userspace applications does polling on the IRQ status bit.
>
> Ok, so the mailbox here is a communication mechanism between
> two device drivers that may run on the same kernel, or in different
> instances (user space, virtual machine, ...), but each driver
> only talks to the mailbox visible in its own device, right?

Yes.

>
> What is the purpose of the exported interface then? Is this
> just an abstraction so each of the drivers can talk to its own
> mailbox using a set of common helper functions?
>
>       Arnd

Yes, that's correct.

In kernel there will be a minimum of 3 drivers which will use this
mailbox communication.
So instead of duplicating APIs and structures in every driver, we
thought of adding them
in this AF driver and export them to ethernet and crypto drivers.

Thanks,
Sunil.
