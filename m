Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD9024310
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c99D5l6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD9024310
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeFVNzW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:55:22 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:56129 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeFVNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:55:20 -0400
Received: by mail-it0-f67.google.com with SMTP id 16-v6so2926473itl.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wksJ9WfOU/30g8pLMLAOLM9Wm/VsFzNBIYpGo7Bf6Us=;
        b=c99D5l6b5eLkKWInarxrX1t+CaBy/QqP1mXGs8LCnJi10ni+XGSR8nomDbcY2R6Fhd
         CBZC+Sw3zdkcEMGkwMPUBGuSgJ//h5PuGxk7oFdrKETwLq3aAJM3w0hilWheJeoi7e3J
         FeuXVLzuBnJKzSce0kioNGZM31jFIRL66bwtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wksJ9WfOU/30g8pLMLAOLM9Wm/VsFzNBIYpGo7Bf6Us=;
        b=F0ajdts6h6LVwXTbJenJ+sLGP0QcpCTI8dhEFHElzHCYLyLNG4Jgy6S/hLZdoZqkYV
         GB/Vb5Ugx+L3k9DYKkadQdBX4U807pgi4dMeCEPYhUNF918rrmnkqn3G2ng2VVQp+ooX
         ZTuEMDD2yUQ1+7RkOHNx5r2YOst4O73Ox7YbcZupTaKtMO+EA/+ae+mQBFelt2xdc9SX
         yKJGBzLlia1lNHjeh9kfIcqVRNI6MWbdCi5OB5BhuS6XkGZYeG4qcWE7jTTB2wru8gzb
         inlLeQgh0kmPK4wRGtMBeE8MVi+OH0kS5S50Nw/Mxh7zBnhEYEBZtcsOUFbA/1k6+Etf
         /jzQ==
X-Gm-Message-State: APt69E340rqGZGCBYDdZV9teXpZKmqj2ZdItZkxY7yZ0CJ7uUaHdxKl8
        6RU+dR3RZZVKgnP5Li2ZXJ4RpzswD8BScZ0bwzCpuw==
X-Google-Smtp-Source: ADUXVKLVz5DGGRK5MW2YsWDCnZ+htwC7b8rg7YNDUlIeYuIF44t2d2uoZNNyx4OVgn/AhJGq0TtMd703pCfQubLh+O0=
X-Received: by 2002:a24:3105:: with SMTP id y5-v6mr1633262ity.138.1529675719896;
 Fri, 22 Jun 2018 06:55:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 06:55:19
 -0700 (PDT)
In-Reply-To: <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_voOZ7YUL8pckww4mTt4PVcu7y69mf-z7ZZe1bJ81Shw@mail.gmail.com> <2a805337-c0b5-e134-7695-5a543ecaa26a@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Jun 2018 15:55:19 +0200
Message-ID: <CAKv+Gu9HAJRHwjYLNjf+gg=1vFoFu3BJphifKKE-aR4o_MW84A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 June 2018 at 15:52, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Ard,
>
> On 6/22/2018 7:21 AM, Ard Biesheuvel wrote:
>> Apologies for only bringing this up now, but I think this patch is
>> wrong after all.
>>
>> screen_info.lfb_base is supposed to be a CPU address, and so
>> translating it like this is wrong. If you end up with a PCI address
>> here, you have made a mistake in hacking support for PCI outbound
>> translations into UEFI. Other users such as UEFI itself or GRUB will
>> treat this as a CPU physical address as well, so the kernel should not
>> treat it any differently.
>
> The behavior I'm seeing is from a UEFI BIOS vendor. I did not write the
> code for it...
>
> I was asked to debug it.
>
> I'd like to dive into your statement about UEFI and GRUB using this address
> as physical addresses.
>
> AFAIK, all PCI outbound requests go through PCI IO protocol in UEFI and the
> translation information is hidden inside the UEFI PCI Host Bridge driver.
> Drivers are not allowed to access PCI resources directly especially as a
> memory mapped address.
>
> This particular vendor is programming the BAR address into the GOP protocol.
> Since the host bridge driver is doing a translation, we are hitting this
> issue.
>
> Is there a UEFI spec reference about the definition of this field?
>

Yes, it is part of the PCI I/O protocol definition. FrameBufferBase is
described as

"""
Base address of graphics linear frame buffer. Info contains
information required to allow software to draw directly to the
frame buffer without using Blt().Offset zero in
FrameBufferBase represents the upper left pixel of the
display.
"""
