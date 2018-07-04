Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7685DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327CE2466F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmQBqHX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327CE2466F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeGDDKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:10:47 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52989 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932396AbeGDDKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:10:42 -0400
Received: by mail-it0-f65.google.com with SMTP id p4-v6so5925988itf.2;
        Tue, 03 Jul 2018 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0V77Bh8P6rEzQ/hkYM+3I9NpS7CCK2BnbsTx78DJUg=;
        b=OmQBqHX7XySKf1r1dDSxI/uc+/kz6HsZdOXqxDPMNLn7LHc+i+Mji6xFQulS1DSdlj
         SVWQicXke8gJkOVY5cFZh6mmpi0TXuBSTDkPtw30k9jYf6W97kidNrgWe78keDX90ggv
         lfRecmZO4O2a3YgGQtn+gdpZx6a+W+lR3svHOGZc4eXOXEm8xonkg2zO2QGquhDmoUsB
         FNrcJxlUmAWz6RdHfbmNFdo1TPHYF60wbuAbSqjP0Xpx9sCIvu7kokakcyzkKJfBHqYw
         2yQdIM1e4VseVrYqvVD866dTogPxgose7orZ60FuBuT7GtOS59wkS5FE+NpW0K5hnhLO
         oVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0V77Bh8P6rEzQ/hkYM+3I9NpS7CCK2BnbsTx78DJUg=;
        b=a0WI4DQWL6kBq5VMF3+JPt9sApbACEAQISTd/WXV+PRnhm4sPehaeipXvpXqMvW2Xw
         4icVHjooL3wZWAxAxGr3lN+1MnGqLxGz4Q73F618X+m/S1FSdC/Ju8nszrZS/Iq9f4M8
         KabOR1hGJgp9nQCKHzopULTZ7j7kdlUQAbMn5h9btAlYJDdzXYZydfFREddMtgrPvV4u
         FYF9EpchVy1QHn2lm+fmKe501y9G/rmN7AKdoWcmO40qIpGwaAvmw/0sghOdTrgcWjpX
         Vj9io2bNPJtRx8u4kqfyEjw+LhcEVFhvqgnDcdoz+C9C8sx2pK2WF+z53OMJE6Pw2OkO
         DLpg==
X-Gm-Message-State: APt69E2F+jewM8JDjYy36dT2fqrewBlS5ZIudd12ud2LP0YBPRXimNTl
        PUhqsnWrzOZXQX/yU+lVQFZSPu/h9MO7SerDZszpitE=
X-Google-Smtp-Source: AAOMgpfNDJRikhzmgkfptwz/8MMkNrdv53xyyJVWlCs/xj9t2QHvHSO5EQTDQ8TzS3Bwq2YJc1KlOzmBf+P/g4UdY3Y=
X-Received: by 2002:a24:1fce:: with SMTP id d197-v6mr460505itd.52.1530673841828;
 Tue, 03 Jul 2018 20:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-3-git-send-email-kernelfans@gmail.com> <20180703075106.GA21136@wunner.de>
 <CAFgQCTt0M=+AQKXFXcOkxppjnDK9EAyNxHN=2F+n_NvyN=rQqg@mail.gmail.com>
In-Reply-To: <CAFgQCTt0M=+AQKXFXcOkxppjnDK9EAyNxHN=2F+n_NvyN=rQqg@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 4 Jul 2018 11:10:30 +0800
Message-ID: <CAFgQCTtY3=F5O6ibzS=7B1cDbzwn=OCnooHRP4HSEtoAO-eY6w@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 5:26 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Tue, Jul 3, 2018 at 3:51 PM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Tue, Jul 03, 2018 at 02:50:40PM +0800, Pingfan Liu wrote:
> > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > places an assumption of supplier<-consumer order on the process of probe.
> > > But it turns out to break down the parent <- child order in some scene.
> > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > > have been probed. Then comes the bridge's module, which enables extra
> > > feature(such as hotplug) on this bridge. This will break the
> > > parent<-children order and cause failure when "kexec -e" in some scenario.
> > >
> > > The detailed description of the scenario:
> > > An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> > > match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> > > to some issue. For this case, the bridge is moved after its children in
> > > devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> > > write back buffer in flight due to the former shutdown of the bridge which
> > > clears the BusMaster bit.
> >
> > If you revert commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services
> > during shutdown"), does the issue go away?
>
> Yes, it is gone.

Have not figured out why the issue was gone. But I think it just cover
some fault.

re-fetch the boot log of mainline kernel without any patch, and filter
out the pci domain 0004
grep "devices_kset: Moving 0004:" newlog.txt
[    2.114986] devices_kset: Moving 0004:00:00.0 to end of list   <---
pcie port drive's probe, but it failed
[    2.115192] devices_kset: Moving 0004:01:00.0 to end of list
[    2.115591] devices_kset: Moving 0004:02:02.0 to end of list
[    2.115923] devices_kset: Moving 0004:02:0a.0 to end of list
[    2.116141] devices_kset: Moving 0004:02:0b.0 to end of list
[    2.116358] devices_kset: Moving 0004:02:0c.0 to end of list
[    3.181860] devices_kset: Moving 0004:03:00.0 to end of list  <---
the ata disk controller which sits behind the bridge
[   10.267081] devices_kset: Moving 0004:00:00.0 to end of list  <---
shpc_probe() on this bridge, failed too.

Hence we have the bridge (parent) after the child in devices_kset.

Thanks,
Pingfan
