Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7427C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D5B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLXweYn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D5B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeH1RPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:15:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38877 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH1RPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:15:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so2009232wmi.3;
        Tue, 28 Aug 2018 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDB5UGECM9fpAuGLlbmJ1QkkSPVv+HvJdEBGQ/7Vm7M=;
        b=WLXweYn6urpyz4X/tAoNpw5nwvra7cWNt4iAPYJhIq4f5pBcmap+kZkWF+UjMPUZs/
         2SIlpirD3nulJgog9IlIdPNaKcalo5EKrMJYlPy8Y6NZ+6fnxQkvigHMOod6ormo2fXu
         ACDwfvsj8QrezxFfi4nNXhy0Zmvb/LTHxG5UVGu85m8xqUyU/MVSEo25UUfijxut4Gj6
         OBnz9+KUQb41nSYkvQLqii+BuZ6K8z9Wfgh7P8u/gdIEqWfD+PrgvUbQdG6uTEBJYCDB
         qZ1hK3XeSpd5zfEGpcGo6iFh+t4p2FLddZpCb+m/tk7CpleXEcGhsQLn82Dc/mm60wl/
         Xt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDB5UGECM9fpAuGLlbmJ1QkkSPVv+HvJdEBGQ/7Vm7M=;
        b=iAuqr1x1M++aQPrcOr9FXQ74fvn2EWagFYH2bTj4bnob9+X4uIjOeUmLDgqJlQed8Q
         /0TANOgn9zg+jzgoTJG+ESlM9W1rZ8ZsCWcSVIeOchSRrXFndVvUleRrmrEg+Pn+br8e
         /i0rz032hePxljnlhycS/3o4hXz98CY+ifNcS/cB39VrpjpO7jNMJAbz1EuMzmmbCXfy
         i8hvKUpbuIFxj7KuGdY9qVVfjvmRaxzB8VEPvESh7DG1rvAisRBNv87O1qK/mGV2v1Xt
         oiFSKq4aTyS/7J8b8ubJIzxbJ56VUORv+1z1n7i8q3Kf42Hq3bClhcT511Kf81ICOW4R
         AJDQ==
X-Gm-Message-State: APzg51BKF/Vnx6dPBKniFmw8plz/RPN1qI+Ep3Z7+s4SwraRqDrJ8mo9
        ehY8indcLQsCMWwV8MCEMHNzx7gFG4VFUTbzkOOAYg==
X-Google-Smtp-Source: ANB0VdZLlIvOfdzZZNGbz4r4NjhU3rmHWY0Jzd7YCVaRADdMcRKCBfHY62L10dBkNj4DDSWwtaAknfqLJd1qBbd9+r0=
X-Received: by 2002:a1c:1d87:: with SMTP id d129-v6mr1342228wmd.34.1535462635340;
 Tue, 28 Aug 2018 06:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
 <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com> <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
In-Reply-To: <CAK8P3a1CvX1V8h20s_=XUUYfR-zYNwETg5p6dCtpVUqZ89K-tg@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 28 Aug 2018 18:53:43 +0530
Message-ID: <CA+sq2Cdn6ut3kdTWoOgCayO2evQrD9TjBaUpVUR3_rWZFxYeig@mail.gmail.com>
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

On Tue, Aug 28, 2018 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 2:48 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> >
> > On Tue, Aug 28, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> > > >
> > > > From: Aleksey Makarov <amakarov@marvell.com>
> > > >
> > > > This patch adds mailbox support infrastructure APIs.
> > > > Each RVU device has a dedicated 64KB mailbox region
> > > > shared with it's peer for communication. RVU AF has
> > > > a separate mailbox region shared with each of RVU PFs
> > > > and a RVU PF has a separate region shared with each of
> > > > it's VF.
> > > >
> > > > These set of APIs are used by this driver (RVU AF) and
> > > > other RVU PF/VF drivers eg netdev, crypto e.t.c.
> > > >
> > > > Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> > > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > > > Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
> > >
> > > Why does this driver not use the drivers/mailbox/ infrastructure?
> > >
> > This is a common administrative software driver which will be handling requests
> > from kernel drivers and as well as drivers in userspace applications.
> > We had to keep mailbox communication infrastructure same across all usages.
>
> Can you explain more about the usage of userspace applications
> and what interface you plan to use into the kernel?

Any PCI device here irrespective in what domain (kernel or userspace)
they are in
use common mailbox communication. Which is
# Write a mailbox msg (format is agreed between all parties) into
shared (between AF and other PF/VFs)
   memory region and trigger a interrupt to admin function.
# Admin function processes the msg and puts reply in the same memory
region and trigger
   IRQ to the requesting device. If the device has a driver instance
in kernel then it uses
   IRQ and userspace applications does polling on the IRQ status bit.

>
> Do you things like AF_XDP and virtual machines, or something else?

I meant drivers in DPDK which may or may not use AF_XDP.
And yes if a PCI device is attached to a virtual machine then that
also uses the same mailbox communication.

Sunil.

>
>         Arnd
