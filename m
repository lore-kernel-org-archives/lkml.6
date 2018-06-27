Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57262C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1B9266CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZqxa9tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1B9266CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeF0HQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:16:31 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40529 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeF0HQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:16:28 -0400
Received: by mail-ot0-f195.google.com with SMTP id f17-v6so1107216otl.7;
        Wed, 27 Jun 2018 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jfnN0i93NJF4R1piHbkVN8iziJe+IUypdrYn4XUE9h4=;
        b=RZqxa9tcIIad0og/wwcq5Teo/E6VlcRTW5V4om/XKnF3tMrfKOXO07i/gfPSmgcjOQ
         qVaXXgiQBNw6d+w628jCMsRI2+joWY6Bx/5TmYKnt+krQaRqz7sPa+BoYj6ZgRANAS57
         4DITU57HRZkGfi11DmtrC4mtIRYAky/v8WM+3sJWg7nR5jyC5gPIWbpV36bZ75IMn/Ov
         bJAY82nJCE5QtWsA6xx2WXzyNcaObMuC06Km5kVBGJ/vVZQH4bk2wo9QwJpfX/4Ra9Bw
         Kia8EWZjO/wTZfT+I/KwMfKxPPSEYY8SpAesS3iO2mXbszIKi1TCQw2Z9dX/WGHkkuxS
         6Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jfnN0i93NJF4R1piHbkVN8iziJe+IUypdrYn4XUE9h4=;
        b=NrBsNBYTAS9Ta2T+fSjxNW6edXLdLgwZBR1p85tBnLhcFugUZgSPT3VhRZFTgUQP8D
         H0yfixEXF8wRzgPszPjMY5HUxAIIpunrGbQR/0gYp3xJ6vf2ABPYtnRoPM3hsefWVHw3
         uvpqqaEFwNrcXgrOVssmpNeahhSezt9eAETbEqkYWu/psMA0iSa73kIECnhLrZo7ZeRu
         YNJ7SQFUZwFm0H7liw0w/9C3ouyeeLizeA6A2/mqjgEV5wAoorEa43DEUsMuuFIHPaOY
         ie/mmf9RClzN2Wqe54PsWefLZM1WaA7nLNHcLA8LQpvG7i9ERFQARCxmb0N8Qv5crtN5
         w7eA==
X-Gm-Message-State: APt69E3ujRlj0DkZoVEgmKr/0yRhxNlmtDhK3LJAaZ/lx8AFfPuo00Vd
        v/SUJ+huraLdqc/nyOtkZ8tONKc9aW9oxyvSor0=
X-Google-Smtp-Source: AAOMgpfEtTR/O/CEsL2/ujuA2lThCl536mKz7UUU9RGC2RzlOhnhEizyZ+4dXlgb2ThZfpkQQGHj0WpESwbmgdnU1pM=
X-Received: by 2002:a9d:1012:: with SMTP id h18-v6mr2567791ote.364.1530083788129;
 Wed, 27 Jun 2018 00:16:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 00:16:27
 -0700 (PDT)
In-Reply-To: <20180626203214.GA181504@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan> <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com>
 <20180626171406.GC146680@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0gt+4FiiBxEjdsEYLT+dQq=Q=mC7JtZPsYxps0_a1w-rg@mail.gmail.com> <20180626203214.GA181504@bhelgaas-glaptop.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jun 2018 09:16:27 +0200
X-Google-Sender-Auth: tXajli-0deEfO1iBVDg5ed-CSlM
Message-ID: <CAJZ5v0huyohQP1FF+9kbwCKFrJ5zJE_rCddqg7+V1msdpLZZOQ@mail.gmail.com>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:32 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 07:19:29PM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jun 26, 2018 at 7:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Tue, Jun 26, 2018 at 04:22:00PM +0200, Rafael J. Wysocki wrote:
>> >> On Tue, Jun 26, 2018 at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> > On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
>> >> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> >> >> +     /*
>> >> >> +      * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
>> >> >> +      * confuses the platform firmware, so avoid doing that, unless the
>> >> >> +      * bridge has a driver that should take care of PM handling.
>> >> >> +      */
>> >> >> +     if (pci_is_bridge(dev) && !dev->driver)
>> >> >> +             return true;
>> >> >
>> >> > It sounds like the question of whether leaving a bridge in D3 confuses
>> >> > the firmware has a platform-specific answer.
>> >>
>> >> Well, it may confuse the platform firmware in general.
>> >>
>> >> > How does the driver PM handling know how to do the right thing?
>> >>
>> >> For endpoints this is not an issue as they always have been expected
>> >> to be in D3 before passing control to the platform firmware on S3
>> >> entry, but we've never done that for bridges by default, except for
>> >> PCIe ports with PM enabled (in which case the driver decides whether
>> >> or not to enable it).
>> >
>> > If there's any spec reference for the expected power states of devices
>> > when entering S3, that would be useful here.  I can't tell if there's
>> > any guidance for this or if it's just figured out experimentally.
>>
>> It is not direct, but Section 16.1.6 of ACPI 6.2 says this in step 4
>> of the system suspend outline:
>>
>> OSPM places all device drivers into their respective Dx state. If the
>> device is enabled for wake,
>> it enters the Dx state associated with the wake capability. If the
>> device is not enabled to wake
>> the system, it enters the D3 state.
>
> Thanks, that's a very useful citation!

You're welcome! :-)

I actually need to withdraw the $subject patch as it doesn't help (I
misread the reporters response) and the one that does work is a bit
too intrusive IMO, so I'll investigate this a bit more.
