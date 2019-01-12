Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6069DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9020657
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 11:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="q4bN6db5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfALLR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 06:17:27 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41122 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfALLR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 06:17:27 -0500
Received: by mail-yb1-f194.google.com with SMTP id j10so6869551ybj.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hpB80OZch2doC79iwWSNYvVOSmB5piRkJwncHsc0O74=;
        b=q4bN6db5xBhOi8U3b2R1nd4KoyCOUzZ5R2VFvhCL9+0QV8PQAmx1lIjXv6YVIqtoYP
         QUjXG50uEqzh0+HXponj1qh9uS8qxqnUBaNopMl0evR8jnQrTejoC5FqQfS56tcvFBJE
         UgoOsdc8VZvIOVRFPp3ano3+pJqiFB8+cW8kDv4h75UWc20idXZhG4eZ+QL+YShcjDOG
         ZBtUx9qbRDluF4MoiCWXSSnSufnJY0oy5j9Xba+mwBAkCQNLHxjMbm5isMgC09X0swTc
         fjB3WiSiSfJpwxRkKBAgsXsnp2kLb4R7wFMNCl9WI313DtKIumH0odYaVQ+0aZ5Y4SV0
         M4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hpB80OZch2doC79iwWSNYvVOSmB5piRkJwncHsc0O74=;
        b=mxhQWPm7DcvdjLdu1xhn23ri1ODlgy6jwNq33Lr3cGF1OMHKeL11HU7nutkm6vk01R
         rUKYoRUlsBcI0HjrHwg+DIy9QVy3urU5IFb2bAgWK4EKz/pQXHEirciFNgtrr9o4TNGj
         Z8maF3xJpVAVkF/4kpYczvaJKJYnu5YGDbCk5FWPuqXFsa5slNPrYV3M+6vw/Q9iS0ym
         PhD/j61zmTxd6EK56uN72XKxz5Hjyd3spp+Tc/8IpL1wOw1Vfq2ieIAp4+rqJjTDVSL4
         yA25KGfCA+0VIxwO8OVcMF7P6S59sPxWFyrXZ/PeQW7rdV+lghJ56psFbJq7qSoR0Qf9
         LbAA==
X-Gm-Message-State: AJcUukeUgdk/3+bss7MXDDBhsT2cUB2HvWp8YmJfBXuAuoR5avMUuVmp
        C2nk8JngH9BboHw8jNF2njfEW1YAdTZK2ekDJWuitQ==
X-Google-Smtp-Source: ALg8bN7FMZtyBu5CDKszZ2dqst7IkBkpuxrFlys50U6BxQxiRPKiSdOJsgYbGaJ6TA0eb0ekwKYrLEf7/mxoWaBZ518=
X-Received: by 2002:a25:8741:: with SMTP id e1mr16293634ybn.342.1547291845441;
 Sat, 12 Jan 2019 03:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20181110232034.17277-1-andreas@kemnade.info> <20181111024648.7rt7rlhaqihtqecv@earth.universe>
 <20181112215812.18ebca35@aktux> <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
 <20181112222726.73m2oca7hankvcjs@earth.universe> <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
 <20181113170128.0f59ef0e@kemnade.info> <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
 <20181116204601.4e1aa0de@kemnade.info> <09AFE47C-D188-4397-A2CD-C70FFAC3B677@holtmann.org>
 <20190104064403.325771fd@kemnade.info> <B5CEA49A-0F54-40C5-BCEA-7875BE1358E3@holtmann.org>
 <20190104205600.3e6b31c9@aktux>
In-Reply-To: <20190104205600.3e6b31c9@aktux>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Sat, 12 Jan 2019 12:16:49 +0100
Message-ID: <CABdtJHuHrp6iPEWaCJ1_dMg0reED8ScKTjnW9aRa2JvMnHtH_A@mail.gmail.com>
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via serdev/devicetree
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 8:57 PM Andreas Kemnade <andreas@kemnade.info> wrote=
:
>
> Hi Marcel,
>
> On Fri, 4 Jan 2019 10:07:34 +0100
> Marcel Holtmann <marcel@holtmann.org> wrote:
>
> > Hi Andreas,
> >
> > >>>> Btw. I see nothing standing in the way of merging btuart.c driver =
and then go from there. Either I dig this out and submit or someone else do=
es.
> > >>>>
> > >>> Do you mean this?
> > >>> https://patchwork.kernel.org/patch/10490651/
> > >>
> > >> yes, that one.
> > >>
> > > Hmm, there seemed to be nothing in the pull requests regarding btuart=
.
> > > Did you change plans?
> >
> > because I only submitted it as RFC. We can easily merge that one upstre=
am since it is rather trivial. The main problem is how you want to do the d=
evice matching. Do you have a DT entry for your really simple devices?
> >
> Hmm, in that link it is non-rfc. So someone picked you rfc patch up and
> submitted it?
>
> You might see what we are already doing here:
> http://git.goldelico.com/?p=3Dletux-kernel.git;a=3Dblobdiff;f=3Darch/arm/=
boot/dts/omap3-gta04.dtsi;h=3D4d2bac4293938de4a15a59979616909cf8842524;hp=
=3Dbfced960d63ec40cf9db4901374b331737a9a168;hb=3Df78bf51754e35010de40518b9a=
8a148d0269bbc8;hpb=3Db6805813a9ab5b0d66b44cc54a0059eca4dd0a98
>
> We are using compatible =3D "wi2wi,w2cbw003-bluetooth"
>
> But I think we should also add a generic device string like
> bluetooth,h4
> So if people dig out older hardware, they can just add that to their
> device trees and have bluetooth
>
> The full patchset we are currently using is here:
> http://git.goldelico.com/?p=3Dletux-kernel.git;a=3Dshortlog;h=3Drefs/head=
s/letux/bluetooth-h4-serdev
>
> Regards,
> Andreas

Good timing for this thread.  I have just integrated the mynewt blehci
firmware for the nina-b1 chip integrated onto our SOM.  This is
exactly the functionality I need in the kernel to make the
initialization seamless.  A generic device string is exactly what
would be needed for most devices that are running in this
configuration.  We may also want to have a generic reset_gpio handler.

-Jon
