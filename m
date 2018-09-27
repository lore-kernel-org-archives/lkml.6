Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EB5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEEB2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="qgvNGY/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEEB2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeI0PVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:21:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55285 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeI0PVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:21:13 -0400
Received: by mail-it1-f196.google.com with SMTP id f14-v6so6944034ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=szaMs3zqbJs2twrKDCiBRLK6N5VPnWcr2R2RMmLGubE=;
        b=qgvNGY/U2XQxCjDkpNqeoUYAyKHqpDLN2IgZItB4m7K9lbVwxDhhJqoPPprC8xV7CD
         H42jnYjcHFNEWxFbr9haj+h5cmREI9b/hhtzy2ZekeLbQWxYkDBtCEZba3DVPWg90946
         Ll+6Qw5ouS04tNcY0wi9bmeD3OwxzJtwP2r7+5W/PVgb1Wl7u8MTBLDUOAjKFiBk/1CK
         C2j7JXhRDFeF9sj0Ed4+mtUuVbouRUtu3hvchYJnicVW59vBAwqUIzHBDqbmPCoenTyf
         8VLsKOSEzMkuJ+7fhxhKWN6jRAFqKHCxtFy33mMLAPTNkKeNjpHBFjk4q03luna2+GRm
         XmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=szaMs3zqbJs2twrKDCiBRLK6N5VPnWcr2R2RMmLGubE=;
        b=LfrgXWeeBYb2Uk8iGYw+PK3QxCUBwJ8/W++IAzbhrEVXiiwHD+fXx6pHtlQuQerRCY
         m9J5ia07mQ5fLA8wSkVLzfng4S8rV6xcymxc9SHqSVHq6QmGrS85sHRPESkVplBrrGSN
         LFXe0bhOk7I+vtrJc6U35Pq/9Dy7qQgR6noH0AAybwIZ1cqkBEhq4CizgxZxCG7y+0me
         vLoesWLhVPJq+U1gbPlZINUFgeN2IeoVcjbcsb5mUMsYFfRrHd3MMTct/9GQKQ8FKNir
         PDdNNQ3B83BnUMh8VVYLc5zmsVwyASefk0PnX+WZ97BzxK7X22wLHmVP4eJfssKjEiCm
         A0ag==
X-Gm-Message-State: ABuFfoh8Adl7DlyqDvyZb7mqlcEPtDtl9e5gOvSahqvKifd60XF53Hz6
        BAAruzPi5Xi8rR4tF4HYaJHHjLxIkTj/0mEQZqZaJg==
X-Google-Smtp-Source: ACcGV60/U6yf6Ab8Tl5hcbUsMtTjNqF63yVFF07NMqsvi7VKZA3dAvwnQF6Y6SH4tRKbEDFGQWRmQq/+wy6xligUHnM=
X-Received: by 2002:a02:4d1b:: with SMTP id l27-v6mr9062544jab.86.1538039040320;
 Thu, 27 Sep 2018 02:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
 <alpine.DEB.2.21.1809120826310.1427@nanos.tec.linutronix.de>
 <BF554FD5-17BA-4F16-9FDF-705D1FC76C12@canonical.com> <CAPpJ_edB_G5QPj-by9Y6Zjj36Xm9dmKXy8Kv5gXMf4YfybvuwA@mail.gmail.com>
 <CAHp75VcCLvb+LvE49YNWnptTMFpUNuj+Jao7udhQeLfOuHh2vg@mail.gmail.com>
In-Reply-To: <CAHp75VcCLvb+LvE49YNWnptTMFpUNuj+Jao7udhQeLfOuHh2vg@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 27 Sep 2018 17:03:24 +0800
Message-ID: <CAPpJ_ecm2fi5gHP_4xsGhdcuYeONF58yPh3bdnWTGRT5f=Rn+A@mail.gmail.com>
Subject: Re: Regression caused by commit 7bb05b85bc2d ("r8169: don't use MSI-X
 on RTL8106e")
To:     andy.shevchenko@gmail.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Steve Dodd <steved424@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2018=E5=B9=B49=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:08=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Sep 13, 2018 at 8:53 AM Jian-Hong Pan <jian-hong@endlessm.com> wr=
ote:
> >
> > 2018-09-12 16:19 GMT+08:00 Kai-Heng Feng <kai.heng.feng@canonical.com>:
> > > at 14:32, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > >> On Wed, 12 Sep 2018, Kai-Heng Feng wrote:
> > >>
> > >>> There's a Dell machine with RTL8106e stops to work after S3 since t=
he
> > >>> commit introduced. So I am wondering if it's possible to revert the
> > >>> commit and use DMI/subsystem id based quirk table?
> > >>
> > >>
> > >> Probably.
>
> Have you seen this thread:
> https://patchwork.ozlabs.org/cover/968924/
>
> and this one:
> https://patchwork.kernel.org/patch/10583229/

Ya!  It is the one.  And it is discussed in bugzilla
https://bugzilla.kernel.org/show_bug.cgi?id=3D201181
Now, the revert patch is submitted https://lkml.org/lkml/2018/9/27/224
However, still thanks for your information. :)

Regards,
Jian-Hong Pan

> ?
>
> > >
> > >
> > > Hopefully Jian-Hong can cook up a quirk table for the issue.
> >
> > Module r8169 gets nothing in the PCI BAR after system resumes which
> > makes MSI-X fail on some ASUS laptops equipped with RTL8106e chip.
> > https://www.spinics.net/lists/linux-pci/msg75598.html
> >
> > Actually, I am waiting for the patch "PCI: Reprogram bridge prefetch
> > registers on resume" being merged.
> > https://marc.info/?l=3Dlinux-pm&m=3D153680987814299&w=3D2
> >
> > It resolves the drivers which get nothing in PCI BAR after system resum=
es.
> >
> > After that, I can remove the falling back code of RTL8106e.
> >
> > Heiner, any comment?
> >
> > Regards,
> > Jian-Hong Pan
> >
> > >>
> > >>> It's because of commit bc976233a872 ("genirq/msi, x86/vector: Preve=
nt
> > >>> reservation mode for non maskable MSI") cleared the reservation mod=
e, and
> > >>> I
> > >>> can see this after S3:
> > >>>
> > >>> [   94.872838] do_IRQ: 3.33 No irq handler for vector
> > >>
> > >>
> > >> It's not because of that commit, really. There is a interrupt sent a=
fter
> > >> resume to the wrong vector for whatever reason. The MSI vector canno=
t be
> > >> masked it seems in the device, but the driver should quiescen the de=
vice
> > >> to
> > >> a point where it does not send interrupts.
> > >
> > >
> > > Understood.
> > >
> > >>
> > >>> If the device uses MSI-X instead of MSI, the issue doesn't happen b=
ecause
> > >>> of
> > >>> reservation mode.
> > >>
> > >>
> > >> Reservation mode has absolutely nothing to do with that. What preven=
ts the
> > >> issue is the fact that MSI-X can be masked by the IRQ core.
> > >
> > >
> > > So in this case I think keep the device using MSI-X is a better route=
, it's
> > > MSI-X capable anyway.
> > >
> > >>
> > >>> Is it something should be handled by x86 BIOS? Because I don't see =
this
> > >>> issue
> > >>> when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.
> > >>
> > >>
> > >> Suspend to idle works completely different and I don't see the BIOS =
at
> > >> fault here. it's more an issue of MSI not being maskable on that dev=
ice,
> > >> which can't be fixed in BIOS or it's some half quiescened state whic=
h is
> > >> used when suspending and that's a pure driver issue.
> > >
> > >
> > > Understood.
> > > Thanks for all the info!
> > >
> > > Kai-Heng
> > >
> > >>
> > >> Thanks,
> > >>
> > >>         tglx
> > >
> > >
> > >
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
