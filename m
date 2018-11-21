Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C138C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BF0206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4K0JgNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BF0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbeKVIaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:30:11 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:34165 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbeKVIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:30:11 -0500
Received: by mail-ed1-f43.google.com with SMTP id b3so6116930ede.1;
        Wed, 21 Nov 2018 13:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbLZhKaFrImgSQZp0hI5VXqY5OtZj7kXKOoHxFXUKiI=;
        b=o4K0JgNwt/H1ZeC6OCaEH1FsOdJglCAhV23BM72OCf4i87CjyyrAxNV0yXmNO8cFVN
         i2tBjXb3RMdd5ey+KzepVL/2ujye4A2N0hN/AQSee2C3cx1vcQdHLvjD6uNlepskyGDB
         H9liAHKsUxfD5E7dMKrcvifV3k0FPmQr6uUNvhI1bmptVZG74nNSsjiqdxdC1LOf0Owb
         m2V0CRmin5En4bOjMlkqlfS8muHyMRHaWjHH0FlO81B31G9ZFrfHOhljcZcZ7mqZPI3p
         fvwBkGIPAXRDV+cAp6thJkPESwpIkNnbfk73xadAqdImmX6AAmOl2CKtkU5YQPQjx3bL
         IyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbLZhKaFrImgSQZp0hI5VXqY5OtZj7kXKOoHxFXUKiI=;
        b=eJ8vRqkV2d8LtHMyLdiCaXbu8mcqb6rIKZU3yiB/6ZlK3J98xuq9ohqKCA7CdDUXKC
         ZHjywcGw5OTQXP/osuJCpb7NhZ1lYxeu1aTzgaT/ScsIXXswPvBH3WnNtlNbVqZn62Fm
         RGx7fZf+3UKM3Kl9QeJf5LVlkM5DJvHMz9ip55aTI9qFu0/v+PWoIfm+j1AXpZTknXsU
         66WZojOfX/oOmIiIURXoNclNc4rBmZ8YMEQG/oqqMN+2ah+jHZYmc9lUNgw5ZVAJPATE
         e3749bt0ZEzcoxJ3cXHW9nggBPxlaJGgWnSAjU7rLLOCOAQDdevpkZ+pWj8+732+I7AN
         lSuA==
X-Gm-Message-State: AGRZ1gL6T2PNrQ01/6Qpnl2Qh1JDgJW83HNQI9DPCp5aROGseDOwzV4z
        VlhtNeo8jhaw744wm5ZmWN+QPmpw31Yd5vuFnBQ=
X-Google-Smtp-Source: AJdET5d0QmsZNMxkCDzJOQS3ziTEDOBV6RDfjer2JXoguyyor/xXQZiCxhy0p5RoJZ18zFZ2785s4x3gAjfCVF59+bQ=
X-Received: by 2002:a17:906:2555:: with SMTP id j21-v6mr6255759ejb.103.1542837239680;
 Wed, 21 Nov 2018 13:53:59 -0800 (PST)
MIME-Version: 1.0
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de> <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
 <20181121202034.GA10697@lunn.ch> <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
 <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com> <7d6362e1-e197-d338-d6b0-9036c3802e2c@gmail.com>
In-Reply-To: <7d6362e1-e197-d338-d6b0-9036c3802e2c@gmail.com>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Wed, 21 Nov 2018 17:53:46 -0400
Message-ID: <CAB9dFdvw8QqzaVYV3bOMGtACyvqWnE9uy96m1tu2C+jjzQR9_Q@mail.gmail.com>
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
To:     hkallweit1@gmail.com
Cc:     andrew@lunn.ch, norbert.jurkeit@web.de, nic_swsd@realtek.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        michael.wiktowy@gmail.com, jcline@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 4:52 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 21.11.2018 21:49, Heiner Kallweit wrote:
> > On 21.11.2018 21:32, Heiner Kallweit wrote:
> >> On 21.11.2018 21:20, Andrew Lunn wrote:
> >>>> request_module() is supposed to be synchronous, however after some
> >>>> reading this may not be 100% guaranteed. Maybe the module init
> >>>> function on some systems isn't finished yet when request_module()
> >>>> returns. As a result the genphy driver may be used instead of
> >>>> the PHY version-specific driver.
> >>>
> >>> Hi Heiner
> >>>
> >>> That would be true for all PHYs i think. We would of noticed this
> >>> problem with other systems using other PHY drivers.
> >>>
> >>>     Andrew
> >>>
> >> It could be a timing issue affecting certain systems only. At least
> >> for now I don't have a good explanation why loading the module via
> >> request_module() and loading it upfront manually makes a difference.
> >>
> >> One affected user just reported the PHY to be a RTL8211B. This is
> >> what I expected, because this PHY crashes when writing to the MMD
> >> registers (the MMD registers are used otherwise by this PHY).
> >> See also commit 0231b1a074c6 ("net: phy: realtek: Use the dummy
> >> stubs for MMD register access for rtl8211b").
> >>
> >> Let's see whether the other affected systems use the same PHY
> >> version.
> >>
> > Next report is also about a RTL8211B and as I assumed:
> > - W/o manually loading the realtek module the genphy driver is used
> >   and network fails.
> > - W/ manually loading the realtek module the proper RTL8211B PHY
> >   driver is used and network works.
> >
> > So it seems that even after request_module() the PHY driver isn't
> > yet available when device and driver are matched.
> >
> > If further reports support this (pre-)analysis, then indeed it
> > seems to be a timing issue and a proper fix most likely is
> > difficult. As a workaround I could imagine to add a delay loop
> > after request_module() checking for a Realtek PHY driver via
> > driver_find(). When adding one small delay after this we should
> > be sufficiently sure that all Realtek PHY drivers are registered.
> >
> Uups, no. We talk about phylib here, not about the r8169 driver.
> So we need a different solution.
>
> >> Heiner

Thanks for the explanation, better than my crude attempt at
understanding what was going on.

If you have any proposed fixes or diagnostic patches based on current
mainline I can quickly compile and test them here on an affected
system.  It doesn't fail consistently for me (as others have
reported), but that could be because it depends on the timing.

Marc
