Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A5221780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZFfWG5SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A5221780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbeKOVp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:45:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbeKOVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ORFPRvrXilF0DxPU2KcAqBgeHqM25qDZgeVxuO/aNMA=; b=ZFfWG5SODhCYAurfCKYNqGORh
        jNOUAw3nvuZXAoES57a7N/qMvoLRYABMVgZuhCaaG/DhaIbGE768bDnhESFgl41NMbLNrUuCWi4Sr
        KfjTwQ0yrCBc88nHDtQECMhIwur7+7Cn3JjNkjwba0emgWVfHnCSOY6GCQRReFauLoCarFlV+5ruZ
        EHEu5Nafjr6B+8wanJ0OTS0HiYbnSBP5rTqoKB6Kxt1ibba75JGJIepuyzNh20ZM6N+Xe9L+/ebJp
        lEeeGIkTsycdOrgvqv+R01beHABwINCKRIk3+MlioE9PX1c3tAb6Pu7Hpd+WGDXZxOr52fkZXu78V
        jqIPDVw1Q==;
Received: from [64.114.255.114] (helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNFyZ-0008OA-2o; Thu, 15 Nov 2018 11:38:23 +0000
Date:   Thu, 15 Nov 2018 03:38:20 -0800
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Logitech QuickCam USB detected by Linux, but not user space
 applications
Message-ID: <20181115033813.6ff626d5@silica.lan>
In-Reply-To: <b9140bbf-1537-1431-1250-da0a21208992@molgen.mpg.de>
References: <b9140bbf-1537-1431-1250-da0a21208992@molgen.mpg.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 15 Nov 2018 11:42:32 +0100
Paul Menzel <pmenzel@molgen.mpg.de> escreveu:

> Dear Linux folks,
>=20
>=20
> I tried to get a Logitech QuickCam USB camera working, but unfortunately,=
 it is=20
> not detected by user space (Cheese, MPlayer).

Could you please try it with Camorama?

	https://github.com/alessio/camorama

>=20
> It=E2=80=99s an old device, so it could be broken, but as it=E2=80=99s de=
tected by the Linux
> kernel, I wanted to check with you first.
>=20
> Linux 4.18.10 from Debian Sid/unstable is used.
>=20
> ```
> $ dmesg
> [=E2=80=A6]
> [ 2891.404361] usb 3-3: new full-speed USB device number 4 using ohci-pci
> [ 2891.626934] usb 3-3: New USB device found, idVendor=3D046d, idProduct=
=3D092e, bcdDevice=3D 0.00
> [ 2891.626945] usb 3-3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
> [ 2891.626951] usb 3-3: Product: Camera
> [ 2891.626957] usb 3-3: Manufacturer:
> [ 2893.110249] calling  media_devnode_init+0x0/0x1000 [media] @ 11704
> [ 2893.110256] media: Linux media interface: v0.10
> [ 2893.110329] initcall media_devnode_init+0x0/0x1000 [media] returned 0 =
after 56 usecs
> [ 2893.210078] calling  videodev_init+0x0/0x79 [videodev] @ 11704
> [ 2893.210084] videodev: Linux video capture interface: v2.00
> [ 2893.210123] initcall videodev_init+0x0/0x79 [videodev] returned 0 afte=
r 21 usecs
> [ 2893.333140] calling  gspca_init+0x0/0x1000 [gspca_main] @ 11704
> [ 2893.333148] gspca_main: v2.14.0 registered
> [ 2893.333161] initcall gspca_init+0x0/0x1000 [gspca_main] returned 0 aft=
er 3 usecs
> [ 2893.370672] calling  sd_driver_init+0x0/0x1000 [gspca_spca561] @ 11704
> [ 2893.370751] gspca_main: spca561-2.14.0 probing 046d:092e
> [ 2893.482675] input: spca561 as /devices/pci0000:00/0000:00:12.0/usb3/3-=
3/input/input17
> [ 2893.485415] usbcore: registered new interface driver spca561
> [ 2893.485434] initcall sd_driver_init+0x0/0x1000 [gspca_spca561] returne=
d 0 after 112054 usecs
> [=E2=80=A6]
> $ ls -l /dev/video*
> crw-rw----+ 1 root video 81, 0 Nov 15 09:26 /dev/video0
>=20
> $ mplayer tv:// -tv driver=3Dv4l2:device=3D/dev/video0
> MPlayer 1.3.0 (Debian), built with gcc-8 (C) 2000-2016 MPlayer Team
> do_connect: could not connect to socket
> connect: No such file or directory
> Failed to open LIRC support. You will not be able to use your remote cont=
rol.
>=20
> Playing tv://.
> TV file format detected.
> Selected driver: v4l2
>  name: Video 4 Linux 2 input
>  author: Martin Olschewski <olschewski@zpr.uni-koeln.de>
>  comment: first try, more to come ;-)
> v4l2: your device driver does not support VIDIOC_G_STD ioctl, VIDIOC_G_PA=
RM was used instead.
> Selected device: Camera
>  Capabilities:  video capture  read/write  streaming
>  supported norms:
>  inputs: 0 =3D spca561;
>  Current input: 0
>  Current format: unknown (0x31363553)

The problem is likely here: mplayer is probably not using libv4l2. Without
that, it can't decode the spca561 specific output format. It is probably
due to some option used when mplayer was built.

In the case of Cheese, it uses Gstreamer, with defaults to not use libv4l2
either. On newest versions of it, there is an environment var that would
allow enabling it (I don't remember what var).

Anyway, Camorama is always built with libv4l2, so it should work out of
the box (although I recommend it to use the latest version, as we did
lots of improvements there, including support for the latest Gtk libraries).

> tv.c: norm_from_string(pal): Bogus norm parameter, setting default.
> v4l2: ioctl enum norm failed: Inappropriate ioctl for device
> Error: Cannot set norm!
> Selected input hasn't got a tuner!
> v4l2: ioctl set mute failed: Invalid argument
> v4l2: ioctl query control failed: Invalid argument
> v4l2: ioctl query control failed: Invalid argument
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Cannot find codec matching selected -vo and video format 0x31363553.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> No stream found.
>=20
> v4l2: ioctl set mute failed: Invalid argument
> v4l2: 0 frames successfully processed, 0 frames dropped.
>=20
> Exiting... (End of file)
> ```
>=20
> Do you have an idea, what the issue. I know it worked fine several years
> ago.



Cheers,
Mauro
