Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E53C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717572085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpN1F+Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfAUNWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:22:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36618 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfAUNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:22:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so23499033qtn.3;
        Mon, 21 Jan 2019 05:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1tIPAUtnGBtTrGE3nT4Kn6WZXC880HnLALlIkib5dc=;
        b=UpN1F+MvEJiuZ5xUlpMcYAx5nVGLncJgoM5l4ZKjtcD00Sz+d050DUMP7knidNWpDv
         7kkClSp8SCABFAJDw6DeuykRr7NnS+KrU3rn7g38kMtjyZAzbZMDkfICHUH4Uj+FLe0/
         DGrOHzmwmH/82ZOpc5DEX0DA8fc1HkyLy+zwPRZ4dWGXai8SVEgtfvs5Kdvv7p3++2Ut
         Hc9nKwE8sicXStso0N3ozJ+eiZj8e3HZxDS/V3r1w5dkNvq0wIB/GVHqvlUi3kR1A9Fe
         1Y58G7XVPqwnKUOCcCFFdY29tHgXyjtD9n7ipqXkrk5vwop+K39gVE84aBwdspq3ki8e
         apMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1tIPAUtnGBtTrGE3nT4Kn6WZXC880HnLALlIkib5dc=;
        b=Xfw/jnVOHMXLcMIrhk7gDBgp+2sxpc0i/AkXQCtjHj3r7Ro0XaiVcpHQWr2l200sly
         vPeBwZrva5AsX3AuMCrdywqN/0qzc9Za0J1m7xUxgzrqffjUfzAw3KaAH9etgMiltLlz
         jtYqnK63TLg+O+cGHEPW58qlcVZsA/OX9yD/F/fzipK/8FNv9e/zt9d7IRA3PiqcTORh
         aqSP4rOcrlJwrhYx3FJY5I8kV0U7Ki68s7vRcnq3RgTeAwz2YtHyiMLMOc7/0sBxrhQ9
         INdvhU/FStTWYOb288J3Deouk/5iT1P7A0a5SwTyQsMJeaBRufY3tgSgdH9sHc6w2MGd
         uFYA==
X-Gm-Message-State: AJcUukeQe+jo38K0eRW5HLrWU4ZZbskF59nuj/C2d9suIo07pJH6kAl8
        vNORLU90ptIaGl3oeS+OdGu6HI3M5MOJWbeThP8=
X-Google-Smtp-Source: ALg8bN7p3jK/K6Y7u8UvBYrKhLtVhE6dTs3jEkcZWzra1aM+DLYv6b4+nzOManGBy3ELrBOUDjymJl+nxJdyCXfejaw=
X-Received: by 2002:a0c:81c4:: with SMTP id 4mr26557175qve.156.1548076942778;
 Mon, 21 Jan 2019 05:22:22 -0800 (PST)
MIME-Version: 1.0
References: <1547031403-34535-1-git-send-email-loic.pallardy@st.com>
 <CAH2Cfb_4qFAEjiANLpRmQL5o9-JCPHCBULLz5-r=zbK9EwiT_A@mail.gmail.com>
 <a7040498e7dc4e64b0748052c3ff3403@SFHDAG7NODE2.st.com> <20190117180007.GX9278@minitux>
 <d17b43ecf7c74c03b3d7a540f4d262e1@SFHDAG7NODE2.st.com> <cea725c192b64f088ae28ab953e3eac7@SFHDAG7NODE2.st.com>
In-Reply-To: <cea725c192b64f088ae28ab953e3eac7@SFHDAG7NODE2.st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Mon, 21 Jan 2019 21:21:57 +0800
Message-ID: <CAH2Cfb_pN+mGavhbTvG4uoqzkG21xxv1_8=6-beGYr-egGK+-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] remoteproc: fix recovery procedure
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:44 AM Loic PALLARDY <loic.pallardy@st.com> wrote:
>
>
>
> > -----Original Message-----
> > From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> > owner@vger.kernel.org> On Behalf Of Loic PALLARDY
> > Sent: jeudi 17 janvier 2019 21:52
> > To: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: xiang xiao <xiaoxiang781216@gmail.com>; ohad@wizery.com; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> > POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org; s-
> > anna@ti.com
> > Subject: RE: [PATCH 1/1] remoteproc: fix recovery procedure
> >
> > Hi Bjorn,
> >
> > > -----Original Message-----
> > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Sent: jeudi 17 janvier 2019 19:00
> > > To: Loic PALLARDY <loic.pallardy@st.com>
> > > Cc: xiang xiao <xiaoxiang781216@gmail.com>; ohad@wizery.com; linux-
> > > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> > > POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org;
> > s-
> > > anna@ti.com
> > > Subject: Re: [PATCH 1/1] remoteproc: fix recovery procedure
> > >
> > > On Mon 14 Jan 12:23 PST 2019, Loic PALLARDY wrote:
> > >
> > > > Hi Xiang,
> > > >
> > > > > -----Original Message-----
> > > > > From: xiang xiao <xiaoxiang781216@gmail.com>
> > > > > Sent: samedi 12 janvier 2019 19:29
> > > > > To: Loic PALLARDY <loic.pallardy@st.com>
> > > > > Cc: bjorn.andersson@linaro.org; ohad@wizery.com; linux-
> > > > > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> > > > > POULIQUEN <arnaud.pouliquen@st.com>;
> > > benjamin.gaignard@linaro.org; s-
> > > > > anna@ti.com
> > > > > Subject: Re: [PATCH 1/1] remoteproc: fix recovery procedure
> > > > >
> > >
> > > Thanks Loic for picking this up again.
> > >
> > > > > Hi Loic,
> > > > > The change just hide the problem, I think. The big issue is:
> > > > > 1.virtio devices aren't destroyed by rpproc_stop
> > > > Virtio devices are destroyed by rproc_stop() as vdev is registered as rproc
> > > sub device.
> > > > rproc_stop() is calling rproc_stop_subdevices() which is in charge of
> > > removing virtio device and associated children.
> > > > rproc_vdev_do_stop() --> rproc_remove_virtio_dev() -->
> > > unregister_virtio_device()
> > > >
> > >
> > > Xiang is right, unregister_virtio_device() ends up decrementing the
> > > refcount of device and might free it, but it's not guaranteed.
> >
> > But it that case calling rproc_shutdown() doesn't guarantee devices are free,
> > it is the same.
> > The only difference will be that rproc_vdev will be released by rproc and
> > then reallocated. So virtio device allocation is restarting with a virgin memory
> > buffer. But you will have some ghost devices and restart may failed too.
> > I post a fix [1] last summer to be sure virtio device won't be released while
> > still registered or registering... So there is still potential issue.
> >
> > >
> > > So I think we need to decouple the rproc_vdev and virtio_device, to
> > > allow the latter to potentially outlive the prior.
> > >
> > I checked how to decouple at least the allocation because one issue here.
> > The main issue is that all references are done based on container_of().
> > I look for a fix having the less impacts on the current code, but still possible to
> > create cross pointer references between rproc_vdev and virtio device.
> > It will clean up the memory allocation procedure, but the problem is still
> > there if sub virtio devices not well release.
> > We need to not be able to restart remote processor if at least one sub device
> > was not correctly release...
> >
> > > > Please find below trace of a recovery on my ST SOC. My 2 rpmsg tty are
> > > removed and re-inserted correctly
> > > > root@stm32mp1:~# ls /dev/ttyRPMSG*
> > > > /dev/ttyRPMSG0  /dev/ttyRPMSG1
> > > > root@stm32mp1:~# [  154.832523] remoteproc remoteproc0: crash
> > > detected in m4: type watchdog
> > > > [  154.837725] remoteproc remoteproc0: handling crash #2 in m4
> > > > [  154.843319] remoteproc remoteproc0: recovering m4
> > > > [  154.849185] rpmsg_tty virtio0.rpmsg-tty-channel.-1.0: rpmsg tty device
> > 0
> > > is removed
> > > > [  154.857572] rpmsg_tty virtio0.rpmsg-tty-channel.-1.1: rpmsg tty device
> > 1
> > > is removed
> > > > [  155.382327] remoteproc remoteproc0: warning: remote FW shutdown
> > > without ack
> > > > [  155.387857] remoteproc remoteproc0: stopped remote processor m4
> > > > [  155.398988]  m4@0#vdev0buffer: assigned reserved memory node
> > > vdev0buffer@10044000
> > > > [  155.405910] virtio_rpmsg_bus virtio0: creating channel rpmsg-tty-
> > channel
> > > addr 0x0
> > > > [  155.413422] rpmsg_tty virtio0.rpmsg-tty-channel.-1.0: new channel:
> > > 0x400 -> 0x0 : ttyRPMSG0
> > > > [  155.421038] virtio_rpmsg_bus virtio0: creating channel rpmsg-tty-
> > channel
> > > addr 0x1
> > > > [  155.429088] rpmsg_tty virtio0.rpmsg-tty-channel.-1.1: new channel:
> > > 0x401 -> 0x1 : ttyRPMSG1
> > > > [  155.437338] virtio_rpmsg_bus virtio0: rpmsg host is online
> > > > [  155.442401]  m4@0#vdev0buffer: registered virtio0 (type 7)
> > > > [  155.461154] remoteproc remoteproc0: remote processor m4 is now up
> > > > ls /dev/ttyRPMSG*
> > > > /dev/ttyRPMSG0  /dev/ttyRPMSG1
> > > > root@stm32mp1:~#
> > > >
> > > > As vdev is including in a larger struct allocated by rproc, it is safe
> > > > to set it to 0 before initializing virtio device while rproc subdevice
> > > > sequence is respected.
> > > >
> > >
> > > It's likely that this works in most use cases, but if for some reason
> > > there's additional references held those will operate on the object past
> > > your clearing of it.
> >
> > In fact, as the memory is free/kzalloc, virtio device fields are not all at 0 as
> > during boot sequence.
> > As mentioned below issue is coming from kobject state_initialized field which
> > is not in a correct state.
> > This field is only set by kobject_init().
> > I think normal way of working is to release memory when a device is no more
> > used.
> > But another solution could be to reset it in kobject_cleanup() or
> > kobject_del() in order to have a symmetrical procedure.
>
> Reading some literature, it is a bad idea.
> Having a look to device_initialize () function description, it is clearly mention device struct must be 0 (except fields provided by user) before. (Same in kobject documentation)
>
> Extract drivers/base/core.c [1]
> * All fields in @dev must be initialized by the caller to 0, except
>  * for those explicitly set to some other value.  The simplest
>  * approach is to use kzalloc() to allocate the structure containing
>  * @dev.
>
> So memset or kfree/kzalloc of virtio_device manadatory.
>
As Bjorn note, it's very dangerous to do memset in rproc_vdev_do_probe
blindly, since subsystem or userspace may still hold the reference on
rpmsg device which will block the release process of virtio device. If
we do memset before the release, the later will make a panic mostly
like.

> Regards,
> Loic
>
> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L1482
> >
> > Regards,
> > Loic
> > [1] https://patchwork.kernel.org/patch/10544757/
> >
> > >
> > > Regards,
> > > Bjorn
> > >
> > > > > 2.and then rpmsg child devices aren't destroyed too
> > > > > Then, when the remote start and create rpmsg channel again, the
> > > > > duplicated channel will appear in kernel.
> > > > > To fix this problem, we need go through rpproc_shutdown/rproc_boot
> > to
> > > > > destroy all devices(virtio and rpmsg) and create them again.
> > > > Rproc_shutdown/rproc_boot is solving the issue too, except if
> > > rproc_boot() was called several times and so rproc->power atomic not
> > equal
> > > to 1.
> > > > Using only rproc_stop() and rproc_start() allows to preserve rproc-
> > >power
> > > and so to be silent from rproc user pov.
> > > >
> > > > Regards,
> > > > Loic
> > > > >
> > > > > Thanks
> > > > > Xiang
> > > > >
> > > > > On Wed, Jan 9, 2019 at 6:56 PM Loic Pallardy <loic.pallardy@st.com>
> > > wrote:
> > > > > >
> > > > > > Commit 7e83cab824a87e83cab824a8 ("remoteproc: Modify recovery
> > > path
> > > > > > to use rproc_{start,stop}()") replaces rproc_{shutdown,boot}() with
> > > > > > rproc_{stop,start}(), which skips destroy the virtio device at stop
> > > > > > but re-initializes it again at start.
> > > > > >
> > > > > > Issue is that struct virtio_dev is not correctly reinitialized like done
> > > > > > at initial allocation thanks to kzalloc() and kobject is considered as
> > > > > > already initialized by kernel. That is due to the fact struct virtio_dev
> > > > > > is allocated and released at vdev resource handling level managed
> > and
> > > > > > virtio device is registered and unregistered at rproc subdevices level.
> > > > > >
> > > > > > This patch initializes struct virtio_dev to 0 before using it and
> > > > > > registering it.
> > > > > >
> > > > > > Fixes: 7e83cab824a8 ("remoteproc: Modify recovery path to use
> > > > > rproc_{start,stop}()")
> > > > > >
> > > > > > Reported-by: Xiang Xiao <xiaoxiang781216@gmail.com>
> > > > > > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > > > > > ---
> > > > > >  drivers/remoteproc/remoteproc_virtio.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/remoteproc/remoteproc_virtio.c
> > > > > b/drivers/remoteproc/remoteproc_virtio.c
> > > > > > index 183fc42a510a..88eade99395c 100644
> > > > > > --- a/drivers/remoteproc/remoteproc_virtio.c
> > > > > > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > > > > > @@ -332,6 +332,8 @@ int rproc_add_virtio_dev(struct rproc_vdev
> > > *rvdev,
> > > > > int id)
> > > > > >         struct virtio_device *vdev = &rvdev->vdev;
> > > > > >         int ret;
> > > > > >
> > > > > > +       /* Reset vdev struct as you don't know how it has been
> > previously
> > > > > used */
> > > > > > +       memset(vdev, 0, sizeof(struct virtio_device));
> > > > > >         vdev->id.device = id,
> > > > > >         vdev->config = &rproc_virtio_config_ops,
> > > > > >         vdev->dev.parent = dev;
> > > > > > --
> > > > > > 2.7.4
> > > > > >
