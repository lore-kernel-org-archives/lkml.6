Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A76C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDA521486
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grDVUf+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDA521486
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeHUXqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:46:37 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44303 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHUXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:46:37 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so6469063ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBR0uGqbt2FyRWWJNPBkwyEEjZQxjdqPUp/OeJ5cwxE=;
        b=grDVUf+weT/k1MnT75YVAcNLfJpMkI1GBRpe6ZriNJuBM9JqEMfQF0DpI3OTwDJjeN
         M8atRociX+NsmzHshw1BQHpxCQr+rKd8HGBW9gQVVikUR5PPieV9eztTiUkMQPgCWk1f
         iMny8pud3smmLL5NtM3NmNpPlJ98IMTbtoGdicbsKDirWU6RKiXuUFZORhOUAMW642zl
         D3Jhq/Oiv1Q3xRaoiy2jmQTVvyTUXVfTI8IOBMWxNWRO9GRSTpeTyAyUn4QNURbJXRSj
         +BWLiCCSxunsLQMqyxueJynIjsThTyijyjTgt+BOVD9zeNM7lyAE1gLATdSXy0Le43PS
         sF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBR0uGqbt2FyRWWJNPBkwyEEjZQxjdqPUp/OeJ5cwxE=;
        b=gWl6eXPtF+6wjveaNoNuRKQRmbbJsB6ilQnE9M0+XGsOFqtoSwrSNibQRwYVRKNfLe
         q9YV0VxmoemEZ5o+6RfkOJVshRz6bNvcR9WL3V4XetMe0RWZOZP4jShIzJOv2WnsPIFY
         GvVER5TZYl+Cdz/wFUIrtitTrIDlnXEZl41iO8x26UyRXl5uHsBFGT6nsZcRAX+l+VLb
         ex1XfdS9hwcT7uo0Jv2kheS8cU6zNUd3d1jPFy0CLtRc6p/jTguasPy8O5O3xJtT+U7l
         qFPQ9LmoWP+pm+vGuIBxqk8r6LRDD/H8dkOpikfEkQoue0Q5PB23M5+za5mkRc6hNoS2
         KQgQ==
X-Gm-Message-State: AOUpUlH/KOyUWHbDeI3kL0kW3BEjBBRfj4Qbj5INaI/XZd3ofDeKA/OA
        iMz59cshqzIMjfnMuEZ0vQzlOa7dElQjmrZQjQiIXg==
X-Google-Smtp-Source: AA+uWPxYfFbPdlv41OwymiYD0U8en360RbqlpKGqcgac2BOmgp40JahQ61iKugHTJincAe29uQl1ApYoOmqlf/w0TVY=
X-Received: by 2002:a25:d493:: with SMTP id m141-v6mr26618425ybf.224.1534883098665;
 Tue, 21 Aug 2018 13:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
 <20180821054704.jlqk5zrlbbsjsd4g@wunner.de> <20180821072541.tcdg5fkk4zrwxahj@wunner.de>
 <20180821165042.GC154536@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180821165042.GC154536@bhelgaas-glaptop.roam.corp.google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 21 Aug 2018 13:24:22 -0700
Message-ID: <CACK8Z6FTy8CyYbuaOu1Fucty1AMYRmsKQAXFJJhELq-qt5cb9A@mail.gmail.com>
Subject: Re: Enumeration issue with QCA9005 AR9462
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mmyangfl@gmail.com, ashok.raj@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 9:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rajat, Ashok]
>
> On Tue, Aug 21, 2018 at 09:25:41AM +0200, Lukas Wunner wrote:
> > On Tue, Aug 21, 2018 at 07:47:04AM +0200, Lukas Wunner wrote:
> > > On Mon, Aug 20, 2018 at 06:06:24PM -0500, Bjorn Helgaas wrote:
> > > > mmyangfl@gmail.com reported a problem [1]: on v4.17, a QCA9005 AR9462
> > > > wifi device was present at boot, but disappeared after suspend/resume.
> > > >
> > > > He also tested a recent kernel (5c60a7389d79, from Thu Aug 16),
> > > > where the suspend/resume problem doesn't seem to happen, but the wifi
> > > > device isn't enumerated correctly at boot-time.
> > > >
> > > > [    0.928714] pciehp 0000:04:00.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> > > > [    0.928752] pciehp 0000:04:00.0:pcie204: Slot(0-1): Card not present
> > > > [    0.928811] pciehp 0000:04:00.0:pcie204: Slot(0-1): Link Up
> > > > [    0.928815] pciehp 0000:04:00.0:pcie204: Slot(0-1): No adapter
> > > >
> > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=200839
> > > > [2] https://bugzilla.kernel.org/attachment.cgi?id=277923
> > >
> > > The hardware appears to be broken in that the Presence Detect State bit
> > > in the Slot Status register is 0 (Slot Empty) even though the slot is
> > > occupied.
> > [...]
> > > Possible solutions:
> > >
> > > (a) Be lenient towards broken hardware and accept DLActive+ as a proxy
> > >     for PresDet+.
> > >
> > > (b) Add a blacklist to pciehp such that it doesn't bind to [1ae9:0200].
> > >     The bug reporter writes that "it's a single Half Mini PCIe card,
> > >     with two chipsets (Wil6110? + AR9462) combined by a PCIe hub".
> > >     This sounds like it's not really hotpluggable.
> > >     (Is Mini PCIe hotplug capable at all?)
> > >
> > > Let me go through the driver and see if (a) is feasible and how intrusive
> > > it would be.
> >
> > So (a) would seem to be feasible, we could add a quirk for devices like
> > this to call pciehp_check_link_active() in pciehp_get_adapter_status().
> >
> > Alternatively, we could generally add a call to pciehp_check_link_active()
> > in get_adapter_status(), pciehp_check_presence() and pcie_init() and thus
> > avoid a quirk for this specific device.
> > The existing call in __pciehp_enable_slot() could actually be removed,
> > this code path is only entered if either PDS or DLLLA is set.
> >
> > And the third option would be to add a quirk like quirk_hotplug_bridge()
> > which sets is_hotplug_bridge = 0 on this broken device such that pciehp
> > doesn't bind to it in the first place.
>
> It sounds like with (a), you could make this work without having a
> Wil6110-specific quirk, i.e., if the Link Status says the link is
> active, we assume a device is present.  That seems reasonable to me
> and it sort of fits with these previous changes:


I also like idea (a) and think it makes sense. One thing to note is
that we may pass the same confusion ("how is my wifi detected when no
card is not present on the slot") to userspace in case anyone looks in
/sysfs (but I don't think anyone looks that deeply).

Thanks,

Rajat


>
>
>   385895fef6b5 ("PCI: pciehp: Prioritize data-link event over presence detect")
>   e48f1b67f668 ("PCI: pciehp: Use link change notifications for hot-plug and removal")
>
> Bjorn
