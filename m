Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5783C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2BA20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+JoAaIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2BA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeILLo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:44:26 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34662 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeILLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:44:26 -0400
Received: by mail-io0-f171.google.com with SMTP id c22-v6so664231iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caXjF4eWsjhzV0BwFAtoYMuoK0vWgJpU77C9E1JCdtg=;
        b=r+JoAaIeYBd5m1K2MFb+Ox6TXsNt22/AGKy/n+HatrfXNcktpMgfGh5cnGDUPuExnl
         rX5C+v7yCL9eSVq6u3fhQPDqDMr0q2lqftUcBm6xso8xa9r5ZZihr9RTKMZ7kFrDtGI2
         VExa2UhYSe55YTaw+o6/LCaTLr/u0zXYdQbyI3Cft+nhtDkFef8eHBjHEdX22bDiMGl6
         mH01Crf7pXEWSfvH2fmD071zzVMtSiiRqy3E1gKv9WoLNl/jTaoyM13oB+lT6nLoDhWW
         +862qOPo7dckdESJBi172LgZaSdizXogR3ODZJ1NvFBxbvkRPidXoDIyjVmJPuMKViVi
         u4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caXjF4eWsjhzV0BwFAtoYMuoK0vWgJpU77C9E1JCdtg=;
        b=boFs/IgQrlkRco4U5//GpJ9EDOwah8Ks6mcriAbBOInU25utIZryZuZlYvcmru8qjx
         6DV6iTDnFC9QqAJw9Zng9doqIC5kNQNgxvwkcnhja0dseUcuPUWLHt54l45Yzyu+Q58n
         TqnyBC3Cjfp061d3vgUEJs9WltaLwibtiRno5Tey6H8iZWrTz9b3us3yORsQs8I86jRs
         dHGqidoElKer+/PLwoZUto6+NJf4wE7BGkv+axELS4AK1ShFTM/YXPoobFsD/VlhotC6
         y+nDPVWT6DzXs5tbIjHJhCY2S0upNGRtM5Bmj2J933Unx2VC/6b90VUiM0EB/z5nXw2y
         7ayQ==
X-Gm-Message-State: APzg51B2vGYeV6MqNIvl/zq/kJYApMo0oV5mct48YNVmr/mlF3IX1DA7
        WFGXEpvvUFJLe30iLaHNSXI960JqdRLazZCXMFmWPvk=
X-Google-Smtp-Source: ANB0Vdb/aA+NzyhSLfeLDsPloBDxjtYxJAGmk+19v6E9x9MUFXXBujDWjDHkl375ckc9zcI49Aewd0nuiXUc7BqQxjA=
X-Received: by 2002:a6b:7a03:: with SMTP id h3-v6mr347280iom.36.1536734482499;
 Tue, 11 Sep 2018 23:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <s5hk1ns1m8n.wl-tiwai@suse.de> <20180911093324.GB10436@kroah.com>
In-Reply-To: <20180911093324.GB10436@kroah.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 12 Sep 2018 14:41:10 +0800
Message-ID: <CAFgQCTtA0zFti3-X6r2E+60mWTWxzKoRehzE18Lg0M5D-MeM9w@mail.gmail.com>
Subject: Re: [REGRESSION] Errors at reboot after 722e5f2b1eec
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.de, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        jnwang@suse.com, bpetkov@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 5:37 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 11, 2018 at 10:17:44AM +0200, Takashi Iwai wrote:
> > [ seems like my previous post didn't go out properly; if you have
> >   already received it, please discard this one ]
>
> Sorry, I got it, it's just in my large queue :(
>
> > Hi Rafael, Greg,
> >
> > James Wang reported on SUSE bugzilla that his machine spews many
> > AMD-Vi errors at reboot like:
> >
> > [  154.907879] systemd-shutdown[1]: Detaching loop devices.
> > [  154.954583] kvm: exiting hardware virtualization
> > [  154.999953] usb 5-2: USB disconnect, device number 2
> > [  155.025278] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.081360] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.136778] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.191772] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.247055] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.302614] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.358996] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.392155] usb 4-2: new full-speed USB device number 2 using ohci-pci
> > [  155.413752] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.413762] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.560307] ohci-pci 0000:00:12.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.616039] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.667843] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.719497] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.772697] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.823919] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.875490] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.927258] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  155.979318] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  156.031813] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  156.084293] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:12.1 domain=0x0006 address=0x0000000000000080 flags=0x0020]
> > [  156.272157] reboot: Restarting system
> > [  156.290316] reboot: machine restart
> >
[...]
> > The errors are clearly related with the USB device (a KVM device,
> > IIRC), and the errors are not seen if the USB device is disconnected.
> >
Sounds like the io pgtbl is invalidated before ohci-pci. But I can not
figure out why, since it is very late to tear down of iommu, which is
after device_shutdown()

Cc James, could you try to enable initcall_debug, and paste the
shutdown seq with 722e5f2b1eec ("driver core: Partially revert "driver
core: correct device's shutdown order"") and without it?

Thanks,
Pingfan
