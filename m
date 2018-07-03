Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484B524267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYlbhzYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484B524267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbeGCJ0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:26:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:47088 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933822AbeGCJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:26:39 -0400
Received: by mail-io0-f193.google.com with SMTP id p7-v6so1090850ioh.13;
        Tue, 03 Jul 2018 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuarX8RTrcClthkY1ZvnvA9PDoBqntHpLNA/5uu5Ytc=;
        b=VYlbhzYeK9t0audM7hBIVINZ2H+/yEghTRSJCWLtvzrRvqXW7HH0h0E90B8I2FqP+2
         fmcpglUJgX/V4v9E7HKSSF+StLZarist4HLhKFyXbC0aPrbRx06DhNgz2mctPll0zaF5
         +er0D86qLYe1JLxnDHpjTkBV6j1Nj4Q+Ixk/KqoSMMnbfbEJjPYHngzymUujGr41FatY
         TfKIR4+j1h2g7qgAMf+PA4unRx9qRJz0qop8kHFH/Hx1dRpWhvUcvtVVOtvgnc/Eqk7b
         LG6AcWnMcNYtTo6cMIqx930uusvnTLoJ7scU/CxxI5mGJg/LpJwTT0ETePsKpyeoT3hp
         6naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuarX8RTrcClthkY1ZvnvA9PDoBqntHpLNA/5uu5Ytc=;
        b=G3XggXe3bPdMAelrI5rZ4anHHawEUIJ9epk9O5T1mC3cICrHx/cHBSICXrL+SUVnIt
         OyJ+YgVa6ns2qeS2+JCXd6JhnAan0SJs979Vru8BKisH6AYvFOuqepAqXimGqkXMl+yS
         tiu02aM0ThdJ1X24brekjqsEgEDY3qeZonZtXFXfD9EmslizXTBX1cEIbVOH06STW28P
         OCqhJQtWaHEb3zkjni8JzPKqEC+DWVdNWR4r7UZFMs7fqhQwDu9fCq4+rO6tU+Frjn+4
         hr0pmCmqEaQ2thlp5gmFTCXcJgUGTyuDscAquKmNsBi4Wwrb4TM4YO56uBPmrEEKoerj
         xfeA==
X-Gm-Message-State: APt69E2f2PYiPbhY2dyyiWI2zEYI7W2fQdtsL5RJ8km8MLFtZmTK73XX
        4imQnlR1cxrPFKZD5tS6gRpSdV0I8XKMtdl5OQ==
X-Google-Smtp-Source: AAOMgpdnlPE21MmIxXeBN7XB/mm7LJNjn1qghmEkRH8rHySfgvTzy4622ZHaWH5By+BUA7ms+7nc8I7vZANJ4iCDlgU=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr25201123iov.203.1530609999115;
 Tue, 03 Jul 2018 02:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-3-git-send-email-kernelfans@gmail.com> <20180703075106.GA21136@wunner.de>
In-Reply-To: <20180703075106.GA21136@wunner.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 3 Jul 2018 17:26:27 +0800
Message-ID: <CAFgQCTt0M=+AQKXFXcOkxppjnDK9EAyNxHN=2F+n_NvyN=rQqg@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown devices
To:     lukas@wunner.de
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 3:51 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Jul 03, 2018 at 02:50:40PM +0800, Pingfan Liu wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > places an assumption of supplier<-consumer order on the process of probe.
> > But it turns out to break down the parent <- child order in some scene.
> > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > have been probed. Then comes the bridge's module, which enables extra
> > feature(such as hotplug) on this bridge. This will break the
> > parent<-children order and cause failure when "kexec -e" in some scenario.
> >
> > The detailed description of the scenario:
> > An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> > match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> > to some issue. For this case, the bridge is moved after its children in
> > devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> > write back buffer in flight due to the former shutdown of the bridge which
> > clears the BusMaster bit.
>
> If you revert commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services
> during shutdown"), does the issue go away?

Yes, it is gone.
