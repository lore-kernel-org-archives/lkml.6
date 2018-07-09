Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DE5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCBC2064D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oM0yxqzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCBC2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932597AbeGII6R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:58:17 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46235 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeGII6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:58:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so34452953oie.13;
        Mon, 09 Jul 2018 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VTy8vICghECqfcbn7Gda10IJWciTtUhK+dQZzvTMA3s=;
        b=oM0yxqztg5U3H9CmeteJT1uyg9otVqkpsP8f0SGnWLZo7R3vR+Ei8o7lnwe01WxAae
         cOGU6PSnXhBbQsQy9LDQnjh4MCK5fQ9SCG+GAs7NWdXBp22tdteqiyW/OHuOls8/Ao5q
         2G03xN0PEF/Xa3Zsff3lanIcMZqZG3fKGASDtQ9afibGNhq0EEgFvO18FwgqGsZzcTKo
         nflG8ZivH+zkqdODf5vgZqboqYUe/CE4MaRR4wDsTLDrkQBv2laKP0j6tgtxmhXg3wpJ
         H7D7mtZlNS7e/kfgqH2elSJ7lydF0/3YkZ8MWjXgof2um4P4AtHGJS4a4WqWq8BT0Qtu
         9ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VTy8vICghECqfcbn7Gda10IJWciTtUhK+dQZzvTMA3s=;
        b=rKgNseZdxPhsRLoPOq6tigASeqHPDCXD95H/LNiV23jK1SohTIpYW3nRANgI1rSRCn
         0a6tfffFTxHVSPoTjIH32iNicv8mrGSy9YU2hBttzA4XLuOa5o1YeqPtTHczFOyOlq3g
         EZ74AO3WvFVy3dTiiyvJ6ip2114w4Mx+CNfmRoEJ+1+LGOdDINnhbRXWoZa6x3qhCXbV
         uTrPhPzg/FQaf2DFnyqqDz71ZwaEp5fzRVrOZnbbMhvqogZ2xZQH/TIhrk2gP29mVRd6
         HqJeWMaGrRBSOy2Ivaant5057M2wnIrOZSXXGf11ProVeioFUophaye+AJzNz6Qq5xF/
         DYMw==
X-Gm-Message-State: APt69E0eOWHkoBZeRU4NRZWW9VWHLD+AX6IAyMdgCo4ilpXKYsm2htWO
        QpoZ+Wai0v1pBYonBGipHWiMgLjOh6pAzVuxuwA=
X-Google-Smtp-Source: AAOMgpfEbvgXpPVGHO4lql27X0izxofNbh9oWNQ2LecU+LctTICS7OuOfyL13c66eC3vT//W8JHE4V9RYoTM6Wj/Z6c=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr23821881oib.116.1531126693872;
 Mon, 09 Jul 2018 01:58:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 01:58:13 -0700 (PDT)
In-Reply-To: <CAFgQCTvGJVBdGLz0R74jO3f1nY3aWprGoADUXzw4E6jxOxWHBg@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
 <20180706083603.GA9063@wunner.de> <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
 <CAFgQCTugu5XO06_xXb4ihkdfGJxtFX0813g2J-Jk2JeYtPP1vA@mail.gmail.com>
 <CAFgQCTsCjkDWJsNog_sTnS-ZaZ87fMFpKq1ekVSUG4MDs6K_jw@mail.gmail.com>
 <CAJZ5v0gxJ9LJ328WbgPrZCV-0SEiO31trsTSYYS8L95P4kfkbA@mail.gmail.com>
 <CAFgQCTvYwjKtx+AQf-kQjTsJMPRz48vgJ__jqNpwZuayG21oQw@mail.gmail.com>
 <CAJZ5v0gSo-jFO0h+aLkeyGGxRL+tdsRtGi0WFhhGQbZvezJmkA@mail.gmail.com> <CAFgQCTvGJVBdGLz0R74jO3f1nY3aWprGoADUXzw4E6jxOxWHBg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Jul 2018 10:58:13 +0200
X-Google-Sender-Auth: IKExnHo0oP9LxlpHRhZjm8nsYkw
Message-ID: <CAJZ5v0hMjoEy6Fe1Rcc1Uq_wQnDCAYYkEv4R024h0iq5krSiMQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Rafael Wysocki <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 10:40 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> On Mon, Jul 9, 2018 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Jul 9, 2018 at 8:48 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
>> > On Sun, Jul 8, 2018 at 4:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

[cut]

>>
>> I simply think that there should be one way to iterate over devices
>> for both system-wide PM and shutdown.
>>
>> The reason why it is not like that today is because of the development
>> history, but if it doesn't work and we want to fix it, let's just
>> consolidate all of that.
>>
>> Now, system-wide suspend resume sometimes iterates the list in the
>> reverse order which would be hard without having a list, wouldn't it?
>>
> Yes, it would be hard without having a list. I just thought to use
> device tree info to build up a shadowed list, and rebuild the list
> until there is new device_link_add() operation. For
> device_add/_remove(), it can modify the shadowed list directly.

Right, and that's the idea of dpm_list, generally speaking: It
represents one of the (possibly many) orders in which devices can be
suspended (or shut down) based on the information coming from the
device hierarchy and device links.

So it appears straightforward (even though it may be complicated
because of the build-time dependencies) to start using dpm_list for
shutdown too - and to ensure that it is properly maintained
everywhere.

Thanks,
Rafael
