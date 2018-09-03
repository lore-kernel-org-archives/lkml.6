Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6736CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141052077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z08TH2Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141052077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeICGJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:09:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36121 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICGJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:09:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id v26-v6so14055043ljj.3;
        Sun, 02 Sep 2018 18:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Cd4fyT/Fu7wCKcr310U36adoZKAHuz5SMpXWrh8uwE=;
        b=Z08TH2EoeUaicVq+spiDmaekBYaV7Z1HUMMcrOhJock/5dcZL/nqUhVwWo0t73HK9x
         3YO9ReZPH/x0PoEuyx5+gs7cQNOZPI3vg9+9XgaAB+hKWafM2/+f7obuVwNYO6G3tMIK
         d6YwZPYmE+8/x9kT0a4LpsggddKm5VsosfSueOlzMX0C+/viyLhlxIIKef2UJlxosNLf
         i8LT00hv5uzTBvrTbgG4YzI0hLQJL8Xuu0+3HDnS41+jFmBRp0WMwWM+hsfK53jRcyZV
         DjgFGjHxxngvXUCCaup+8lXfgjOWOhbiNwCITz8BhRkB0dR6SIgY/XSdNHUzypdbEBs1
         Tj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Cd4fyT/Fu7wCKcr310U36adoZKAHuz5SMpXWrh8uwE=;
        b=S9kHgpqRd/XFzxPITTMX1T/FspnozEI/ipNPBQjWlURaKLlco7VUVeoKpoaEPVsHhv
         /3Pk32KCGOj6Ov3Ps6CAlsVhUrneEEK23SMQrlxYxUeK0hoVi52ETifiNJB9o7FXE4mQ
         WUhzrSyHSAQSzHCWVkwDzrg8bhKqBPet1+Bo/gj1zk60+auZhxufdYDoeat0rugrBKUT
         VyB966/1mMOpGCUV7j9hyZpouyOKtexy9A1VNT0zyO8HfPVIrRzTzLtVGQZtgGy9mJyk
         GoxThWb7yj4UpVN+T6BvGmj7w88ddPK7pqsind8JRy3f6HYbiqnZAWSb4QT38Cc7YKL7
         6HFg==
X-Gm-Message-State: APzg51D7XRkK7EG+zl1VkidZgbaQLR8IRmIVIlDaGZKPtNkNkSmqDoPg
        eVc6U68zRYt/g8AcjegEHxOFFEqBgqajPW4+aes=
X-Google-Smtp-Source: ANB0VdZ1dt4Hd+nl2emWqXePFvK7IMZoVt0aoplalLTasECtPabRO4cH/8fjQPCSlJk6UpGNkMBcunNCm5GJNgJZntM=
X-Received: by 2002:a2e:5719:: with SMTP id l25-v6mr15867539ljb.125.1535939490080;
 Sun, 02 Sep 2018 18:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwiv-gK1wxw57TVK7GXe3bfkr=0eCS9zn7F_mZRYUL+2Ovr9w@mail.gmail.com>
 <20180828193517.GA158292@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180828193517.GA158292@bhelgaas-glaptop.roam.corp.google.com>
From:   Zihan Yang <whois.zihan.yang@gmail.com>
Date:   Mon, 3 Sep 2018 09:51:18 +0800
Message-ID: <CAKwiv-gOy3mhuYm7vEy74t9=hQp24RFRXwVzoaE-37X_nuAHww@mail.gmail.com>
Subject: Re: Peer bridge fixup issue under multiple pci domain
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, bp@alien8.de,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> =E4=BA=8E2018=E5=B9=B48=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:35=E5=86=99=E9=81=93=EF=BC=9A
>
> [+cc EDAC folks, LKML]
>
> On Sat, Aug 25, 2018 at 10:58:57PM +0800, Zihan Yang wrote:
> > Hi all,
> >
> > I'm trying to use multiple pci domain in qemu q35, but I find there
> > might be some issues in peer bridge fixup.
> >
> > In short, pcibios_fixup_peer_bridges function assumes only one pci
> > domain (0) by default. This is OK when as qemu by default uses only
> > one pci domain too. However, if I add another host bridge which is
> > put into pci domain 1 by using _SEG, and a pcie_pci_bridge is attached
> > to the bus 1 under this new pci domain 1 rather than domain 0, the
> > kernel will recognize the bus 01 differently.
> >
> > More specifically, pcibios_fixup_peer_bridges only reads all the buses
> > under domain 0 but it can read the pci bus 01 in pci domain 1 and treat
> > it as a peer bus of 0000:00. The consequence is this 01 bus is recogniz=
ed
> > as 0000:01, but it should have been recognized as 0001:01.
> >
> > The host bus 0001:00 can be recognized so I guess pcibios_fixup_peer_br=
idges
> > needs updating to take care of multiple domains? Or is it just an bios =
issue?
> > I'm not quite sure and I'm open to any suggestions.
>
> Is there something that actually does not work, or is this just a
> concern that the code looks wrong?

Sorry for the late reply, currently it is just a concern because the
qemu part is
still ongoing and I'm not quite sure about the root cause. But my disussion=
 with
qemu developers indicate my issue might originates from incorrect AML, whic=
h
includes _SEG, _BBN and _CRS as you state below. I will try to locate the r=
eal
cause recently.

> pcibios_fixup_peer_bridges() is ancient history from before x86 used
> the ACPI namespace to discover host bridges.  It blindly probes for
> devices on buses 0-255, but as you say, only in domain 0.
>
> Using multiple PCI domains really requires ACPI support so we know
> what the other domains are (_SEG) and how to access their config space
> (MCFG).  When we do have ACPI support in the platform and the kernel,
> drivers/acpi/pci_root.c discovers all the host bridges in all domains
> via PNP0A03 or PNP0A08 devices in the ACPI namespace, and in most
> cases pcibios_fixup_peer_bridges() will do nothing.
>
> However, there *are* systems where the firmware does not expose all
> host bridges and in those cases, pcibios_fixup_peer_bridges() can be a
> problem.  For example, Intel processors often have management devices
> on bus 7f or ff.  If the ACPI namespace doesn't have a host bridge to
> those buses, pci_root.c won't find them, but
> pcibios_fixup_peer_bridges() *will*.

Thanks for clarifying, does it only affect bus 7f/ff, or does it
affect other busses
as well? If only management devices are affected, then I think it is
not the cause
of my issue. But thanks a lot for your detailed reply.

> This leads to several problems.  Here's a dmesg sample from [1]
> (found by googling for 'dmesg log "PCI: discovered peer bus ff"'):
>
>   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>   PCI: Discovered peer bus fe
>   pci_bus 0000:fe: root bus resource [io  0x0000-0xffff]
>   pci_bus 0000:fe: root bus resource [mem 0x00000000-0xffffffffff]
>   pci 0000:fe:03.0: [8086:2d98] type 00 class 0x060000
>   PCI: Discovered peer bus ff
>   pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
>   pci_bus 0000:ff: root bus resource [mem 0x00000000-0xffffffffff]
>   pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
>   EDAC MC1: Giving out device to module i7core_edac.c controller i7 core =
#1: DEV 0000:fe:03.0 (INTERRUPT)
>   EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI =
controller: DEV 0000:fe:03.0 (POLLED)
>   EDAC MC0: Giving out device to module i7core_edac.c controller i7 core =
#0: DEV 0000:ff:03.0 (INTERRUPT)
>   EDAC PCI1: Giving out device to module i7core_edac controller EDAC PCI =
controller: DEV 0000:ff:03.0 (POLLED)
>
> Some of the problems are:
>
>   - Firmware may have omitted the host bridges to [bus fe] and
>     [bus ff] from the ACPI namespace because *it* is using those
>     management devices, so EDAC blindly using them is a potential
>     conflict.
>
>   - pcibios_fixup_peer_bridges() only scans domain 0, so if this
>     system had multiple domains, EDAC would only work on things in
>     domain 0, ignoring other domains.
>
>   - The PCI core can't do bus number assignment correctly for devices
>     behind bridge PCI0.  The firmware told us [bus 00-ff] was
>     available, so the core may assign bus number fe to some deep
>     switch hierarchy.  But bus fe conflicts with the devices on the
>     "peer bus fe".  This part is a firmware bug: it should have told
>     us that PCI0 leads to [bus 00-fd], not [bus 00-ff].
>
>   - The PCI core can't do resource assignment correctly for devices on
>     [bus fe] and [bus ff].  It has no information about what MMIO and
>     I/O port are routed to those buses, so it assumes *all* memory and
>     I/O ports are routed there, which is clearly incorrect.  This part
>     is a Linux bug; we really shouldn't be poking around for buses
>     that ACPI didn't tell us about.
>
> Bjorn
>
> [1] https://bugs.freedesktop.org/attachment.cgi?id=3D136529
