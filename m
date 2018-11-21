Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A74206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tazi0ZOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A74206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeKVJuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:50:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33623 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbeKVJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:50:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so6251005eda.0;
        Wed, 21 Nov 2018 15:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfpSOcf5s2x/gFUSI7UGKnb+J+hB1LFjN6oa5ok1I7Y=;
        b=tazi0ZOeGdoExzmqVnAw/88/9jff/K2bf5vNWXxyp3E3mNfEPr82yPbijGIHaKx/9c
         rldsBYqq+q4TVEl5of/OVTdukDgbwdO8VCBN1CiBiBywbQ6jxzdQ4+c1xGCZrLLGVVBq
         O81yOn8eXvPdCsRy0vd5/74hx7mPmafuzNMKidY6EENEiQQGNLaFJSFMgoXcCQyDdvrU
         OevnAPOBcmbng7vTgyXx0+5n5om4ZyIZpm2Qry7Ek3VO58OB54yYnpy4tE4dr6eMHcX3
         eRP9MbbnXKTxrdsfjudrn5+jUCpYnMtTF0maXfaePxuXfY3ew8lUZMnZEHOjGFCSLHzd
         RIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfpSOcf5s2x/gFUSI7UGKnb+J+hB1LFjN6oa5ok1I7Y=;
        b=KHyx6DAOBPHRqDbpJibRx9WdCDyw0sSMIBiu74NZ19Lpv0QGMVutT/7AVyrxN3sHs6
         Ehg/HBzSQW7+4UGIDdjAC13g9t34/Q1KLxKOUMJ6hts5JhJAaEtSb/447mxtaxvwa03U
         TioIx+vr+J4Nz887+iMFHvjKlRcL3zoT6unNjQXEk8QBXDxfr5S2EwcFq15sO5EG4Ybf
         /CrblPDCDpAfk9yfVBTEMMq64LIbbAvUGeQkxcymzu3WkdqQYppiUBwuY3zsCmvq+u0n
         T2jAtkQHQ+P+lS2LUfAdIm5wtTANKhqtKUqU9lr16Nsua7+itT5F92EpUuFbtI2+UThE
         aNgw==
X-Gm-Message-State: AGRZ1gKdebf4K1fcBw7CV1VynT+ZsvMtBFhVmMAuK0YltfxmnbBWCD0v
        35+wTK4FWCTHAedfokc3J80dy38Ym771svEf7EVuwGES
X-Google-Smtp-Source: AJdET5d4SAtmjVy3ucWgYsxfpXhfX+dIrJLfYJ2E0k8OXq4cmgJ6NDrqlsxDzizGJ+9jf30M8YdBG2qAWi7T5E/K/3M=
X-Received: by 2002:a17:906:abd3:: with SMTP id kq19-v6mr6233062ejb.116.1542842023795;
 Wed, 21 Nov 2018 15:13:43 -0800 (PST)
MIME-Version: 1.0
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de> <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
 <20181121202034.GA10697@lunn.ch> <eda84d0b-2d9f-07ae-34a1-767bc5200964@gmail.com>
 <6aeba3d6-2292-1221-9be7-1c0bb7cbc203@gmail.com> <7d6362e1-e197-d338-d6b0-9036c3802e2c@gmail.com>
 <CAB9dFdvw8QqzaVYV3bOMGtACyvqWnE9uy96m1tu2C+jjzQR9_Q@mail.gmail.com> <a995b6f6-c5b1-877c-581c-39c0897e7703@gmail.com>
In-Reply-To: <a995b6f6-c5b1-877c-581c-39c0897e7703@gmail.com>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Wed, 21 Nov 2018 19:13:31 -0400
Message-ID: <CAB9dFdsq7EBNm1Y1nK2tqOvg5ikyTm4ZGTQddsNAp1BaA0J_XQ@mail.gmail.com>
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

On Wed, Nov 21, 2018 at 6:28 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 21.11.2018 22:53, Marc Dionne wrote:
> > On Wed, Nov 21, 2018 at 4:52 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 21.11.2018 21:49, Heiner Kallweit wrote:
> >>> On 21.11.2018 21:32, Heiner Kallweit wrote:
> >>>> On 21.11.2018 21:20, Andrew Lunn wrote:
> >>>>>> request_module() is supposed to be synchronous, however after some
> >>>>>> reading this may not be 100% guaranteed. Maybe the module init
> >>>>>> function on some systems isn't finished yet when request_module()
> >>>>>> returns. As a result the genphy driver may be used instead of
> >>>>>> the PHY version-specific driver.
> >>>>>
> >>>>> Hi Heiner
> >>>>>
> >>>>> That would be true for all PHYs i think. We would of noticed this
> >>>>> problem with other systems using other PHY drivers.
> >>>>>
> >>>>>     Andrew
> >>>>>
> >>>> It could be a timing issue affecting certain systems only. At least
> >>>> for now I don't have a good explanation why loading the module via
> >>>> request_module() and loading it upfront manually makes a difference.
> >>>>
> >>>> One affected user just reported the PHY to be a RTL8211B. This is
> >>>> what I expected, because this PHY crashes when writing to the MMD
> >>>> registers (the MMD registers are used otherwise by this PHY).
> >>>> See also commit 0231b1a074c6 ("net: phy: realtek: Use the dummy
> >>>> stubs for MMD register access for rtl8211b").
> >>>>
> >>>> Let's see whether the other affected systems use the same PHY
> >>>> version.
> >>>>
> >>> Next report is also about a RTL8211B and as I assumed:
> >>> - W/o manually loading the realtek module the genphy driver is used
> >>>   and network fails.
> >>> - W/ manually loading the realtek module the proper RTL8211B PHY
> >>>   driver is used and network works.
> >>>
> >>> So it seems that even after request_module() the PHY driver isn't
> >>> yet available when device and driver are matched.
> >>>
> >>> If further reports support this (pre-)analysis, then indeed it
> >>> seems to be a timing issue and a proper fix most likely is
> >>> difficult. As a workaround I could imagine to add a delay loop
> >>> after request_module() checking for a Realtek PHY driver via
> >>> driver_find(). When adding one small delay after this we should
> >>> be sufficiently sure that all Realtek PHY drivers are registered.
> >>>
> >> Uups, no. We talk about phylib here, not about the r8169 driver.
> >> So we need a different solution.
> >>
> >>>> Heiner
> >
> > Thanks for the explanation, better than my crude attempt at
> > understanding what was going on.
> >
> > If you have any proposed fixes or diagnostic patches based on current
> > mainline I can quickly compile and test them here on an affected
> > system.  It doesn't fail consistently for me (as others have
> > reported), but that could be because it depends on the timing.
> >
>
> Thanks for the offer. Can you try the following diagnostic patch
> and check whether it helps?
>
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 55202a0ac..84f417f8b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -607,6 +607,8 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
>          */
>         request_module(MDIO_MODULE_PREFIX MDIO_ID_FMT, MDIO_ID_ARGS(phy_id));
>
> +       msleep(1000);
> +
>         device_initialize(&mdiodev->dev);
>
>         return dev;

I was not able to get it to fail with that extra delay; hard to be
100% sure but the network starts even when switching over from the
distro kernel after a boot where network failed to start.

There's a side issue that network startup is taking a full minute
longer than it should, but that's possibly unrelated.

Marc
