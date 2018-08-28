Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E634C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BBF20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP5tkFfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BBF20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeH1RQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:16:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH1RQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:16:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so1568772wro.11;
        Tue, 28 Aug 2018 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmNeqcQRBIWKANQgmgxzHwAzaBjSSTABgwGfO9UYits=;
        b=dP5tkFfbGNOCRnNFvAe47Nv7uATGEh1sA/BulQnEyEoNJwQSqi5PZHm+XwOJDXZMQR
         yos0XsxFn7MxoRm0tbMmlMJP3+jxN8KAKFDc6oSt6v9Ln3mlYaZeJLphgAkDMu3VcRKE
         XRSt0zry1nD9A52TYHIa1pEPUDhhUO87i2uVs8RfNoDajmzTkbcuuUpwyqphXaQYFku3
         oS84YU4qdA/Ftb6R2V9XajnKz7/nv6hp4U7gUYYCQ5UQrEEuZ3YD937aS0bBy0MlRqmf
         ur8Fps/UJ9doXiRVz8uG2lVpiKtK+jvR/nNO85Pkue/MG3MI6zfbNux6lMxI47ty7X+r
         +gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmNeqcQRBIWKANQgmgxzHwAzaBjSSTABgwGfO9UYits=;
        b=th+PlGeh2KPTqrBC1+quRUQFvmWJu0I3vIDUYiTXq7daCW5wD0Ptc0MOr428KW9Fxy
         +PP6QqxVv2Fj5ytzJlDi4xHc/2Kd6v7yaJHvGtXjUVnujVG+UWujwKi9LAfoQjetjCI/
         HCMSs4m2Mb4Vw8hjOzBzfsKE8msZjMLyagLQDcLliUoVgKQKPM2LdtQwtGrEQcJTq9ER
         gD2LHBZyuhz+vIXOnS64q+TgsCMHlPzGFJj+WZ4KSPxZapfhim8sZnxUCYaudxmRp88o
         MdcshBZdmw/tGMUdbaylJidew2R/lxa2ni8UjyODp8yZR8tEarTNaw/PTdxnOanU10yn
         VLMg==
X-Gm-Message-State: APzg51DLnyGyLJ1MO0cwJ63DlEjFyun29MM1+5Z4b6dB0+5ljAT6ye51
        BndLhsgFz5IHmCTxILdg5B9wpSsSLxWalNwNisU=
X-Google-Smtp-Source: ANB0VdaAgKmYlNMd06cHt3su0AmzudWYq/HCbT1OcV2wz2dpqVJT4JnP/21FulGBtB094ZYGSbqILBBCMH8FDxdzu8E=
X-Received: by 2002:adf:9051:: with SMTP id h75-v6mr1242885wrh.65.1535462671550;
 Tue, 28 Aug 2018 06:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com> <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 28 Aug 2018 18:54:20 +0530
Message-ID: <CA+sq2Cd3R0V5hcaF+ESfkOEBHgBwOB6b8Uwx7K+CeUN6gLFTOg@mail.gmail.com>
Subject: Re: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> >
> > From: Sunil Goutham <sgoutham@marvell.com>
> >
> > Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> > multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> > PF0 is called administrative / admin function (AF) and has privilege access
> > to registers to provision different RVU functional blocks to each of
> > PF/VF.
> >
> > This admin function (AF) driver acts as a configuration / administrative
> > software which provisions functional blocks to a PF/VF on demand for them
> > to work as one of the following
> >  - A basic network controller (i.e NIC).
> >  - NIC with packet filtering, shaping and scheduling capabilities.
> >  - A crypto device.
> >  - A combination of above etc.
> >
> > PF/VFs communicate with admin function via a shared memory region.
> > This patch series adds logic for the following
> >  - RVU AF driver with functional blocks provisioning support
> >  - Mailbox infrastructure for communication between AF and PFs.
> >  - CGX driver which provides information about physcial network
> >    interfaces which AF processes and forwards required info to
> >    PF/VF drivers.
> >
> > This is the first set of patches out of 70 odd patches.
> >
> > Note: This driver neither receives any data nor processes it i.e no I/O,
> >       just does the hardware configuration.
>
> Hi Sunil,
>
> Thanks for posting this first series, I'm glad we're seeing support for this
> chip family making some progress.

Thanks.

>
> My feeling overall is that we need a review from the network driver
> folks more than the arm-soc team etc, and that maybe the driver
> as a whole should go into drivers/net/ethernet.

This driver doesn't handle any network IO and moreever this driver has to handle
configuration requests from crypto driver as well. There will be
separate network and
crypto drivers which will be upstreamed into drivers/net/ethernet and
drivers/crypto.
And in future silicons there will be different types of functional
blocks which will be
added into this resource virtualization unit (RVU). Hence i thought
this driver is not a
right fit in drivers/net/ethernet.

>
> We support some couple of similar hardware already that has
> both support for virtual functions and for crypto offload, including
> the Chelsio cxgb4, Mellanox mlx5, NXP DPAA and probably others,

I agree, but i guess that is done to support inline crypto.
Here this driver has to handle requests from normal crypto driver
(drivers/crypto) as well.

> and we need to ensure that the exposed interfaces are all
> compatible, and that you use the correct subsystems and
> in-kernel abstractions for thing that are common.
>
>       Arnd
