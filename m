Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22275C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE21920658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH+JVfLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE21920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH3V7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:59:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeH3V7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:59:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so8855517wrc.5;
        Thu, 30 Aug 2018 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwjXYU8YmUTvMNgco6t8puRj5FYzVGryWaQQJbRGf7E=;
        b=mH+JVfLIvo+7FctFTuK9oxLanUmC4jhbK/twkN5Q0ToHUD1Z77/3hPTULmUCOw1is3
         UOqikgaUeSTMsIvWvxR9nw1cXyLqfhIjsLGRZ5OQt/EvHlBKojmwttgTLYJZ1zeOVedh
         njShBfi0HpJsYRU1oUiTMrqWEwydLzk6OGUnXY+C5QjF28yeXk8KS5ow7kJlTOQjmM8r
         wwfzuj2fpFRk0Ga6d4anKQyKJNecpRWa272O5H1wv0PFk3cbVFTUf+j1AYwlRM5dLFWT
         vWmSXQZQGSXYkSwOnpQAWRX/RdJkIdeLP3+LZ1xejhtoeo801eSoWby6KpsItRpH3hUk
         kMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwjXYU8YmUTvMNgco6t8puRj5FYzVGryWaQQJbRGf7E=;
        b=He9Rr4QIgDdgt4+mufnqkSr/wvLEBUE1/59nNuLE2Jh3IcRrGB1e5pu1Mh6x4tRVO5
         LnB2PN1++1XCK+iUnSADKGGAd2DcZAcGj/+qNYC05eQ4AfK7f4L1sB1NhdQv6Gw0ZtEe
         rA4/RlS9Ml7cZxpi9+CCQWdhg+tdTq7NV/tWl1/p7rqBTiaoljQDmr1qOlMO5AzcW7mf
         uJcPmtfGwYh2w9qgu1Kv3JkY+AnWNu7kSZrTh4delGRlL4Hqm1mSP4bVPQEvTQjybjiw
         KvOXUQR5Vu9PFZirBJpCir0XXOIKrXWjyNQRbHCsAaROaLpd/MNGgFxLoLHGiTjzgaUg
         Wdpw==
X-Gm-Message-State: APzg51DIgqAt1vBWJOuuImTES6+WW2wBIq3FlW3/EMTefA+LnS9Ij/pt
        x4vx17SPM7EPkxDCcUbFSyZl6mDsMYfBLtdVXBc=
X-Google-Smtp-Source: ANB0VdaRnkPKgoozEHYi3UhBJWPGMOc133C4fRORG7gAzZNaPwEQ+9DfoHTIqOHEpZYZZYn/1bcbZaQx5qTKmwvoMKA=
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr7926777wre.12.1535651744869;
 Thu, 30 Aug 2018 10:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com> <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
In-Reply-To: <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Thu, 30 Aug 2018 23:25:33 +0530
Message-ID: <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 7:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 3:10 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> >
> > > > > If this is a regular PCI ethernet driver, why do you put it into driver/soc
> > > > > rather than drivers/net/ethernet/ ?
> > > >
> > > > No, this is not a ethernet driver, as mentioned in the cover letter
> > > > this driver and AF driver doesn't
> > > > handle any IO. There will be a separate ethernet driver (will submit
> > > > that as well in future) which will
> > > > communicate with these drivers for configuring hardware.
> > > >
> > > > The driver in question here is for a serdes controller which handles
> > > > physical ethernet interfaces.
> > > > Admin function driver gathers info w.r.t current state of physical
> > > > ethernet interfaces from this driver
> > > > and notifies actual ethernet driver about changes, if any.
> > >
> > > Ok. Can you describe the structure that the PCI devices appear
> > > in? It might help to be make the connection between the differnet
> > > patches to understand how things fit together. In the final
> > > picture, how many different pci_driver instances do you have,
> > > and what part are they for?
> >
> > List of PCI devices are CGX, RVU PF0-PFn SRIOV physical functions
> > and RVU VF0-VFn SRIOV virtual functions. No of VFs per PF is configurable
> > and done by low level firmware.
> >
> > List of PCI driver instances would be CGX driver, RVU PF0 (i.e admin
> > function) driver,
> > PF1-PFn either netdev driver or crypto driver, VF0-VFn functionality would be
> > same as their PF.
> >
> > The current plan is to have CGX driver, Admin function driver, PF
> > netdev driver, VF netdev driver and PF/VF crypto drivers.
>
> Ok, I think I understand the PF/VF distinction now. One (to me)
> surprising aspect here is that you not just have one physical function
> that you can use to assign resources to multiple virtual functions,
> but also a second level of virtualization that is used to assign
> resources to "physical functions" that are less physical than the
> name suggests.

Yes, PF is just for name sake, on-boot there is no difference between
PFs/VFs as such.
PF0 has privilege access to assign resources to all PFs and their VFs.
This admin function driver loads for PF0.

>
> The part that I have not grasped yet is what the split between
> the CGX and the AF is for, how they relate to one another, and
> what the software abstraction for the two is going to be.

In HW, CGX is a separate PCI device which handles the serdes and
physical ethernet interface.
Ethernet driver in drivers/net/ethernet can only communicate to
admin function driver since they share a mailbox memory.
So we had to bind both CGX and admin function drivers to almost work as one,
inorder to provide relavent info to ethernet drivers. That's why we
have many functions
from CGX driver which AF uses.

eg: Firmware gets to know about a physical interface status change,
which CGX driver gets
to know and it uses AF's mailbox communication to inform ethernet
driver about the event.

>
> > > Is the idea that an ethernet device driver always attaches to a
> > > virtual function that gets created by the main driver, and that
> > > the two drivers share no interfaces on the kernel side, or do
> > > you have multiple drivers linking to each other?
> >
> > Ethernet device driver can attach to both physical function and virtual function
> > whose HW resources are provisioned by admin function driver.
> >
> > Yes the PF/VF ethernet drivers and these drivers won't share any
> > kernel interfaces.
> > Physical ethernet interface is owned by ethernet driver only, this driver just
> > configures which ethernet driver instance uses which physcial interface.
>
> Ok.
>
>          Arnd
