Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5468217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="YXWrMfn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfBLQav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:30:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46283 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfBLQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:30:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1471879pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ZVc7WV639WV9kilY4vR4rmkhbR6bzSk0gLD3+9UNr4=;
        b=YXWrMfn6LWX2Gs6gPYXii2eQ12NXfQQNIMNY7D2qDNDwwpAvN3sX/JmZlVp2RAPYLG
         pgBjBFZs0zFwExAoy40dvtWrxyWmT5z101WseQJpMuflyAJl8oKAWZBYngadrfbKcQd1
         7Q6US4eMz9VelcnWEedMY3VIDIDUyXkuqqnJ9YJdFmq+/iP360lkYXD584EOkA6O9oyE
         A05owad4M9U+DBX7gW29LUKTjHTnrreRHV49WCY6TKiMl7qfnmlBpcMxTck050k5bVud
         hif50UZrdnY/xsc6hnOt5MGLvQWMvWwyVCvYk2sbLm8UsOh0vGSUIt9wiiPoLPCysYWv
         +l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ZVc7WV639WV9kilY4vR4rmkhbR6bzSk0gLD3+9UNr4=;
        b=qiB74vUezjiDxEukPkYObQnWD6eWTUYljocH75hCMS60mZS2ff0kCBGVx78zQlk6cY
         wQDbHdXsdr9u7ZuNa/9ZecmtCZh8goJcIOIOqJZkQpX5BpYvSHZtJELJSSi0nZq+gzqk
         mVwtgaJ/rSs3X2xbE4avIPAkRYdDorlzWhLzoR/JY/+ax0vXgRWpunIUGe/oC4hPlj9c
         4gbzIRD2DSl40attoCFmKlIp5GM900MBUQ+5ga4vLmbusXXP+kf8R6s2nvj7wXL3A5qH
         byTkZQHQDrLzDb1dwvp+HK79xFw7aTpoKD7E14ngKCWtc1KLfYRFSApWV6nmPkv4EOwQ
         tnUg==
X-Gm-Message-State: AHQUAuYwecwK0G2D4N9AZeX7ej5+VoClc03Eq7djzlX/VGSl8jTesU9t
        nb0K7uDohFkLDue8O6e7t4CInRH75yOBqITHQLENIw==
X-Google-Smtp-Source: AHgI3IZ6eeCXyjy2ZCSTpfHxYZ2JR1mV9zgVKC9w+HvxHCdvmgc7N85IUk9D/LOFfxnOyUZTJmmft933w/QdSkVSw7s=
X-Received: by 2002:a63:e74e:: with SMTP id j14mr4377394pgk.449.1549989049486;
 Tue, 12 Feb 2019 08:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20190210192408.GA81989@bebop> <CAHp75Vc_0tLLSeVjiBLFXZXJSw7Evf=vmBrgbtsj11_SWS_rOg@mail.gmail.com>
 <691cc9a7-e126-a7cf-b3b2-ce5a77eadbeb@gmail.com> <CAOcMMieCjobcM_d-ojuL88cOWFCFZbo=z5X=QWyqi_q7LZ5xHw@mail.gmail.com>
 <e1be4724-38df-ac86-551c-7cfaf8e50b19@gmail.com>
In-Reply-To: <e1be4724-38df-ac86-551c-7cfaf8e50b19@gmail.com>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Date:   Tue, 12 Feb 2019 08:30:38 -0800
Message-ID: <CAOcMMifw3SZ7hp-ZPAVZeRPOpgYmqi3nkNSwZizWnNgVDBUyEw@mail.gmail.com>
Subject: Re: X450LCP lost abillity to turn the screen off
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 6:31 PM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
>
> Hello Jo=C3=A3o,
>
> On 2/11/19 5:14 PM, Jo=C3=A3o Paulo Rechi Vita wrote:
> > Hello Marcos,
> >
> > On Sun, Feb 10, 2019 at 5:05 PM Marcos Paulo de Souza
> > <marcos.souza.org@gmail.com> wrote:
> >>
> >>
> >>
> >> On 2/10/19 9:45 PM, Andy Shevchenko wrote:
> >>> On Sun, Feb 10, 2019 at 9:24 PM Marcos Paulo de Souza
> >>> <marcos.souza.org@gmail.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> Since 5.0.0-rc4 I vefiried that my ASUS laptop
> >>>
> >>> Can you be more specific, what model, BIOS version, etc (also would b=
e
> >>> nice to have dmi strings from it, I guess dmidecode tool would help).
> >>
> >> dmidecode attached.
> >>
> >>>> cannot turn the screen of
> >>>> anymore. There were several commits in 5.0 merge window touching thi=
s
> >>>> functionality like:
> >>>>
> >>>>   71b12beaf12f platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0=
x34 scan codes
> >>>>   b3f2f3799a97 platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
> >>>>   78f3ac76d9e5 platform/x86: asus-wmi: Tell the EC the OS will handl=
e the display off hotkey
> >>>>
> >>>
> >>> Can you bisect or just try to revert one-by-one from above and see
> >>> which one is a culprit?
> >>
> >> I already did some primary analysis, and it seems the commit 3f2f3799a=
97
> >> maps the x035 (which is Alt+f7 in my laptop) to SCREENLOCK, which is
> >> wrong because alt+f7 should be Screen Toggle. I will try to revert thi=
s
> >> commit, or remap to KEY_DISPLAYTOGGLE or KEY_DISPLAY_OFF, and test if =
it
> >> works.
> >>
> >
> > User-space does not act on KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF, these
> > values should be used when the hardware is turning the screen
> > back-light ON and OFF. According to Asus BIOS engineers, the
> > back-light used to be driven by the hardware, but they have changed to
> > the this new approach of telling the OS to drive the back-light for a
> > while now (no specific dates or BIOS / windows driver versions were
> > shared). They we actually surprised when we told the that some
> > machines still have a working implementation (and selected by default
> > unless told otherwise) of the old behavior, which sounds like it is
> > the case for the machine you have at hand.
> >
> > The new behavior, as defined in their spec is to only notify the OS of
> > the keypress with 0x35, and have the OS "close" the screen, with the
> > screen being "opened" on mouse or keyboard activity. This closely
> > matches the screen lock behavior on Linux platforms, so we are mapping
> > it to KEY_SCREENLOCK in the kernel, and it then gets mapped to
> > XF86ScreenSaver by xkeyboard-config, and finally gnome-settings-daemon
> > uses it as a lock screen shortcut (look for "screensaver" in
> > plugins/media-keys/shortcuts-list.h on the gnome-settings-daemon
> > repository).
>
> Interesting.
>
> >
> >> But yes, I'll do my best to track the problem ASAP at my side. Please
> >> let me know if I can provide any additional information.
> >>
> >
> > You can check what is being sent by the kernel with evtest, and what
> > is being sent by X with "xinput test <device id>" (and you can find
> > the device id with "xinput list"). And you can re-map it without
> > having to rebuild the kernel using udev's hwdb. But simply re-mapping
> > should not change anything, since userspace does not act on
> > KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF. If you want to switch back to the
> > old behavior you need to revert "78f3ac76d9e5 platform/x86: asus-wmi:
> > Tell the EC the OS will handle the display off hotkey".
>
> I tried reverting the patch and only recompiling/reinstalling the
> platform/x86 modules, but the problem still happens. My next step will
> be testing agains't 4.20, since my machine was working with 4.12, so I
> might try the major releases first.
>

So maybe your desktop environment (KDE) acts on KEY_DISPLAYTOGGLE /
KEY_DISPLAY_OFF and this is the only reason why this was working in
the first place? It would be sad to find out different DEs behave
differently in this situation, but IMO
include/uapi/linux/input-event-codes.h is not super clear about
whether userspace should act on these values or they are just intended
to notify userspace of a change so desktop notifications (like an OSD)
can be shown. If that is the case you will need to revert all 3
commits you listed earlier. Also, make sure to check with evtest which
values are being sent by the kernel to make sure the correct code is
being executed.

> >
> > That being said, I believe it would be more productive to figure out
> > why your userspace stack is not reacting to 0x35 / XF86ScreenSaver and
> > fix that. Which window manager / graphical desktop environment are you
> > using?
>
> Well, I'm using KDE Plasma 5 Desktop Environment (20170319-lp150.7.1) of
> openSUSE Leap 15.0.
>
> >
> > As a final note, from your dmidecode output I see you are on BIOS
> > version X450LCP.207, and there is version 208 available for download
> > on Asus website. I'm curious to know if it changes the old behavior
> > (with the patches you listed reverted), but I'm not responsible if a
> > BIOS update breaks your machine in any way, so just do it if you this
> > is something you are comfortable with and understand and assume all
> > the risks yourself. We have been reporting machines with the old
> > behavior back to Asus, but I don't know what they are doing with that
> > information, if anything. I'm adding your machine with the old BIOS
> > version to the list, so if you test the new BIOS let me know so I can
> > add that as well. But please don't feel any pressure to update the
> > BIOS if this is something you would not do otherwise.
>
> For now I would like to skip this upgrade, since it is nothing that I
> can play with now (I use this machine at work). I really hope that Asus
> could join fwupd, making such upgrades easier to apply on Linux machines.
>

Absolutely, don't worry about the BIOS update.

> Let me know if I can provide more info. I may have news in the next day
> about testing other kernels...
>

Thanks for your feedback.

--
Jo=C3=A3o Paulo Rechi Vita
