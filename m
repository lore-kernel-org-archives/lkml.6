Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EB620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBK6T36z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfAQSAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:00:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34422 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfAQSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:00:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so4782115pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JYwxidj+UlC9J8m7R8E8uZr+X7AneZl9KiO0sSarm0w=;
        b=PBK6T36zWujzaNSnM7l6vEMDi0/KwlbOcZV6QJZWzTWq3nCYiodzeV0fCWBigW9YJz
         3FIvLeyVAue1B8ruMB20QMlCin3rzVMBQw8jGhACOfb/dnKkZP5pwha4ldanI1W1rjIy
         kwXLn6knDMZonZ/sxobUr0RUJ3FhUzDnmEFdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYwxidj+UlC9J8m7R8E8uZr+X7AneZl9KiO0sSarm0w=;
        b=XFbvD/nyg0Iu0RyOJA9XKf7fXBkAOJSUNTwrrRPsywhf14K6fmIxNBMJbtiibyceXM
         hvruPFQSFy6LAhE6O10luTBVpFqP44FihfeWomd309JVQqLoyYGxk9bVvyqerKm2F+5d
         TtYCC+EhDzAtdkmwmDFFd+VrPKU56HMHjZsKJR+SR63CWSCbVdIzzboEDsNC2cx7+j8L
         BIPmzwfe9gP6H3qg8nTMIyuWQCLGz21ZZNibKVr1HE3gCx7xpbUapXMPNxhVVG8yO1fm
         X0Dd1arxvC3+jHOtTMHRw8WOyFghX0CkoVmDueTTGwIbnjLsPWmaeBJ63sHQ1gumRot0
         KzDA==
X-Gm-Message-State: AJcUukcpQqnDMaVwTxzmgNDzQdkapRg236qSJaGnUse7W97xOQsfA+h+
        zujvSaeQf/gWeZXB1SwAfJa5EA==
X-Google-Smtp-Source: ALg8bN5+UaYkJ7GAR4NCPSL/YaTC3TpQElvXkEZR3UtujTahtTzwQu8IfiOO9ukKYM4kZdiGt8WmMQ==
X-Received: by 2002:a65:5387:: with SMTP id x7mr14427393pgq.412.1547748010797;
        Thu, 17 Jan 2019 10:00:10 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b202sm5351959pfb.88.2019.01.17.10.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:00:10 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:00:07 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     xiang xiao <xiaoxiang781216@gmail.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: Re: [PATCH 1/1] remoteproc: fix recovery procedure
Message-ID: <20190117180007.GX9278@minitux>
References: <1547031403-34535-1-git-send-email-loic.pallardy@st.com>
 <CAH2Cfb_4qFAEjiANLpRmQL5o9-JCPHCBULLz5-r=zbK9EwiT_A@mail.gmail.com>
 <a7040498e7dc4e64b0748052c3ff3403@SFHDAG7NODE2.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7040498e7dc4e64b0748052c3ff3403@SFHDAG7NODE2.st.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 12:23 PST 2019, Loic PALLARDY wrote:

> Hi Xiang,
> 
> > -----Original Message-----
> > From: xiang xiao <xiaoxiang781216@gmail.com>
> > Sent: samedi 12 janvier 2019 19:29
> > To: Loic PALLARDY <loic.pallardy@st.com>
> > Cc: bjorn.andersson@linaro.org; ohad@wizery.com; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> > POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org; s-
> > anna@ti.com
> > Subject: Re: [PATCH 1/1] remoteproc: fix recovery procedure
> > 

Thanks Loic for picking this up again.

> > Hi Loic,
> > The change just hide the problem, I think. The big issue is:
> > 1.virtio devices aren't destroyed by rpproc_stop
> Virtio devices are destroyed by rproc_stop() as vdev is registered as rproc sub device.
> rproc_stop() is calling rproc_stop_subdevices() which is in charge of removing virtio device and associated children.
> rproc_vdev_do_stop() --> rproc_remove_virtio_dev() --> unregister_virtio_device()
> 

Xiang is right, unregister_virtio_device() ends up decrementing the
refcount of device and might free it, but it's not guaranteed.

So I think we need to decouple the rproc_vdev and virtio_device, to
allow the latter to potentially outlive the prior.

> Please find below trace of a recovery on my ST SOC. My 2 rpmsg tty are removed and re-inserted correctly
> root@stm32mp1:~# ls /dev/ttyRPMSG*
> /dev/ttyRPMSG0  /dev/ttyRPMSG1
> root@stm32mp1:~# [  154.832523] remoteproc remoteproc0: crash detected in m4: type watchdog
> [  154.837725] remoteproc remoteproc0: handling crash #2 in m4
> [  154.843319] remoteproc remoteproc0: recovering m4
> [  154.849185] rpmsg_tty virtio0.rpmsg-tty-channel.-1.0: rpmsg tty device 0 is removed
> [  154.857572] rpmsg_tty virtio0.rpmsg-tty-channel.-1.1: rpmsg tty device 1 is removed
> [  155.382327] remoteproc remoteproc0: warning: remote FW shutdown without ack
> [  155.387857] remoteproc remoteproc0: stopped remote processor m4
> [  155.398988]  m4@0#vdev0buffer: assigned reserved memory node vdev0buffer@10044000
> [  155.405910] virtio_rpmsg_bus virtio0: creating channel rpmsg-tty-channel addr 0x0
> [  155.413422] rpmsg_tty virtio0.rpmsg-tty-channel.-1.0: new channel: 0x400 -> 0x0 : ttyRPMSG0
> [  155.421038] virtio_rpmsg_bus virtio0: creating channel rpmsg-tty-channel addr 0x1
> [  155.429088] rpmsg_tty virtio0.rpmsg-tty-channel.-1.1: new channel: 0x401 -> 0x1 : ttyRPMSG1
> [  155.437338] virtio_rpmsg_bus virtio0: rpmsg host is online
> [  155.442401]  m4@0#vdev0buffer: registered virtio0 (type 7)
> [  155.461154] remoteproc remoteproc0: remote processor m4 is now up
> ls /dev/ttyRPMSG*
> /dev/ttyRPMSG0  /dev/ttyRPMSG1
> root@stm32mp1:~#
> 
> As vdev is including in a larger struct allocated by rproc, it is safe
> to set it to 0 before initializing virtio device while rproc subdevice
> sequence is respected.
> 

It's likely that this works in most use cases, but if for some reason
there's additional references held those will operate on the object past
your clearing of it.

Regards,
Bjorn

> > 2.and then rpmsg child devices aren't destroyed too
> > Then, when the remote start and create rpmsg channel again, the
> > duplicated channel will appear in kernel.
> > To fix this problem, we need go through rpproc_shutdown/rproc_boot to
> > destroy all devices(virtio and rpmsg) and create them again.
> Rproc_shutdown/rproc_boot is solving the issue too, except if rproc_boot() was called several times and so rproc->power atomic not equal to 1.
> Using only rproc_stop() and rproc_start() allows to preserve rproc->power and so to be silent from rproc user pov.
> 
> Regards,
> Loic
> > 
> > Thanks
> > Xiang
> > 
> > On Wed, Jan 9, 2019 at 6:56 PM Loic Pallardy <loic.pallardy@st.com> wrote:
> > >
> > > Commit 7e83cab824a87e83cab824a8 ("remoteproc: Modify recovery path
> > > to use rproc_{start,stop}()") replaces rproc_{shutdown,boot}() with
> > > rproc_{stop,start}(), which skips destroy the virtio device at stop
> > > but re-initializes it again at start.
> > >
> > > Issue is that struct virtio_dev is not correctly reinitialized like done
> > > at initial allocation thanks to kzalloc() and kobject is considered as
> > > already initialized by kernel. That is due to the fact struct virtio_dev
> > > is allocated and released at vdev resource handling level managed and
> > > virtio device is registered and unregistered at rproc subdevices level.
> > >
> > > This patch initializes struct virtio_dev to 0 before using it and
> > > registering it.
> > >
> > > Fixes: 7e83cab824a8 ("remoteproc: Modify recovery path to use
> > rproc_{start,stop}()")
> > >
> > > Reported-by: Xiang Xiao <xiaoxiang781216@gmail.com>
> > > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_virtio.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_virtio.c
> > b/drivers/remoteproc/remoteproc_virtio.c
> > > index 183fc42a510a..88eade99395c 100644
> > > --- a/drivers/remoteproc/remoteproc_virtio.c
> > > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > > @@ -332,6 +332,8 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev,
> > int id)
> > >         struct virtio_device *vdev = &rvdev->vdev;
> > >         int ret;
> > >
> > > +       /* Reset vdev struct as you don't know how it has been previously
> > used */
> > > +       memset(vdev, 0, sizeof(struct virtio_device));
> > >         vdev->id.device = id,
> > >         vdev->config = &rproc_virtio_config_ops,
> > >         vdev->dev.parent = dev;
> > > --
> > > 2.7.4
> > >
