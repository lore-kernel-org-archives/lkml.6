Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2895B20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3+X3ZMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfBVTge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:36:34 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40654 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfBVTge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:36:34 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so3826198qta.7;
        Fri, 22 Feb 2019 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y51dB0aqTGODRaybxZKTV+dTRQtGmgOm+yCQn7zZ5xA=;
        b=I3+X3ZMoLFZwxHnpIQcrDx6N3nyPm590UypgKxxeHeqOuXmxqIFM2Mq+cpJQj5segr
         wiB87gQ+wOOPSe2TLEjhRvFQxy0IiZ5UZqlydorjLhkna7oE7LAzSA6b4fxly6Id8Ml/
         ULFKN3mw2S4POtMxMSWAJN5kJkCnD6ICT/wcLZ5W/6Uy7i3jfGW0qOh1A42OA+9QAC/7
         5RBzvEquYy+zUHoYF3Z+Ef4ScMjsJ7EN4Y2eCoXerApHEThMvoVcrmv0IyBTVA1MofDB
         U8wr0pPcS6LPVXBwuv/kuevi99llFV1Ks8qXRycyLqQs8KhKH5wkQPdiBKfHh0JnNA3n
         1dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y51dB0aqTGODRaybxZKTV+dTRQtGmgOm+yCQn7zZ5xA=;
        b=IqS3KF3GzdqUEujKG9p2G9xyF3+aQOn3CcykKX3EDQhJWFpKktEd7wo6ZXtTfU894Y
         qOtXBGjiIgCY1Gl2o/hKFyXh3NynyZAHkyK/nCGXHmKxaK+QgOp1EKRqC96Iy805ZPoz
         1CqvLNvFH7pO786p1vpTYAw0yf38XkajJwuJfyl995SQ+pnrLQIGTcR0uRFFnaKsjn97
         wHBPeGwExRQCLu9FAdPk5Tg1UswLeX7Vf8E6bzYlR/wMFqbdz6+formzvgdAgHSzrqDQ
         vgyTwgt1rWeznUlzIH7fGluZwiuC/5exry3XjS5sU/y0PZZWWaH4ti973n3smE4zsh4Z
         gKtg==
X-Gm-Message-State: AHQUAuYeY+TRfmrjKRL6PGElEV183pLRBkwmxvCRUdUXLYR+V5ZDTK8o
        915623XPrQrQ+tkMtwKnnus3PMWSIdBkqiIdQjc=
X-Google-Smtp-Source: AHgI3IZVd1kc9fOl8srRuV+jPWW8udzC0+QuF7PaCKKg9BAunljqP9YWHtVdGS/jldJubHKOdXkVvK98YcPG2Ga+92o=
X-Received: by 2002:a0c:8aa1:: with SMTP id 30mr4436113qvv.1.1550864192640;
 Fri, 22 Feb 2019 11:36:32 -0800 (PST)
MIME-Version: 1.0
References: <1549955596-19784-1-git-send-email-xiaoxiang@xiaomi.com> <5cf04a05-938a-2dd0-d36b-e939f0c935ff@st.com>
In-Reply-To: <5cf04a05-938a-2dd0-d36b-e939f0c935ff@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Sat, 23 Feb 2019 03:36:21 +0800
Message-ID: <CAH2Cfb9NQeZFuPexG31FR_jNUvRbh_M=5tAgfsSxsZ-UxF91DQ@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: acknowledge the received
 creation message
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, Kumar Gala <kumar.gala@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        QianWenfa <qianwenfa@xiaomi.com>,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Fri, Feb 22, 2019 at 6:44 PM Arnaud Pouliquen
<arnaud.pouliquen@st.com> wrote:
>
> Hello Xiang,
>
>
>
> On 2/12/19 8:13 AM, Xiang Xiao wrote:
> > From: QianWenfa <qianwenfa@xiaomi.com>
> >
> > the two phase handsake make the client could initiate the transfer
> > immediately without the server side send any dummy message first.
> As discussed on OpenAMP mailing list, the first point (from my pov) is
> to figure out if this should be part of the rpmsg protocol or service
> dependent (so managed by the rpmsg client itself)...
>

Here is my thought:
1.The ack message don't have any side effect except kernel send back
the local address through NS channel directly.
2.But without this message, remote side can't send the message first
due to the lack of kernel address information.
The second limitation is very strange for all developer I think.

>
> >
> > Signed-off-by: Wenfa Qian <qianwenfa@xiaomi.com>
> > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 664f957..e323c98 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -71,6 +71,7 @@ struct virtproc_info {
> >
> >  /* The feature bitmap for virtio rpmsg */
> >  #define VIRTIO_RPMSG_F_NS    0 /* RP supports name service notifications */
> > +#define VIRTIO_RPMSG_F_ACK   1 /* RP supports name service acknowledge */
> >
> >  /**
> >   * struct rpmsg_hdr - common header for all rpmsg messages
> > @@ -115,10 +116,12 @@ struct rpmsg_ns_msg {
> >   *
> >   * @RPMSG_NS_CREATE: a new remote service was just created
> >   * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> > + * @RPMSG_NS_ACK: acknowledge the previous creation message
> >   */
> >  enum rpmsg_ns_flags {
> >       RPMSG_NS_CREATE         = 0,
> >       RPMSG_NS_DESTROY        = 1,
> > +     RPMSG_NS_ACK            = 2,
> >  };
> >
> >  /**
> > @@ -330,13 +333,14 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
> >       int err = 0;
> >
> >       /* need to tell remote processor's name service about this channel ? */
> > -     if (rpdev->announce && rpdev->ept &&
> > +     if (rpdev->ept && (rpdev->announce ||
> > +         virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_ACK)) &&
> >           virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {Regarding this condition i have a concern. If rpdev->announce is false
> but  VIRTIO_RPMSG_F_ACK feature is set, this should generate an ack message.
> Seems that this condition can occurs depending on the rpmsg_device
> struct provided on registration, when rpmsg_dev_probe is called.

The ack message can't be sent before device probe success, otherwise
the early ack make  the remote side consider kernel driver is ready
and send the message immediately, but nobody can receive the message
actually.

>
> >               struct rpmsg_ns_msg nsm;
> >
> >               strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> >               nsm.addr = rpdev->ept->addr;
> > -             nsm.flags = RPMSG_NS_CREATE;
> > +             nsm.flags = rpdev->announce ? RPMSG_NS_CREATE : RPMSG_NS_ACK;
> >
> >               err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
> >               if (err)
> > @@ -820,6 +824,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> >       struct rpmsg_channel_info chinfo;
> >       struct virtproc_info *vrp = priv;
> >       struct device *dev = &vrp->vdev->dev;
> > +     struct device *tmp;
> >       int ret;
> >
> >  #if defined(CONFIG_DYNAMIC_DEBUG)
> > @@ -847,21 +852,30 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> >       msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> >
> >       dev_info(dev, "%sing channel %s addr 0x%x\n",
> > -              msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
> > +              msg->flags == RPMSG_NS_ACK ? "ack" :
> > +              msg->flags == RPMSG_NS_DESTROY ? "destroy" : "creat",
> >                msg->name, msg->addr);
> >
> >       strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
> >       chinfo.src = RPMSG_ADDR_ANY;
> >       chinfo.dst = msg->addr;
> >
> > -     if (msg->flags & RPMSG_NS_DESTROY) {
> > +     if (msg->flags == RPMSG_NS_DESTROY) {
> >               ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
> >               if (ret)
> >                       dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
> > -     } else {
> > +     } else if (msg->flags == RPMSG_NS_CREATE) {
> >               newch = rpmsg_create_channel(vrp, &chinfo);
> >               if (!newch)
> >                       dev_err(dev, "rpmsg_create_channel failed\n");
> > +     } else if (msg->flags == RPMSG_NS_ACK) {
> > +             chinfo.dst = RPMSG_ADDR_ANY;
> > +             tmp = rpmsg_find_device(&vrp->vdev->dev, &chinfo);
> nit-picking... replace &vrp->vdev->dev by dev and change tmp by a more
> explicit name.

Ok.

> > +             if (tmp) {
> > +                     newch = to_rpmsg_device(tmp);
> > +                     newch->dst = msg->addr;
> > +             } else
> typo: braces
>

Ok.

> Regards,
> Arnaud
> > +                     dev_err(dev, "rpmsg_find_device failed\n");
> >       }
> >
> >       return 0;
> > @@ -1028,6 +1042,7 @@ static struct virtio_device_id id_table[] = {
> >
> >  static unsigned int features[] = {
> >       VIRTIO_RPMSG_F_NS,
> > +     VIRTIO_RPMSG_F_ACK,
> >  };
> >
> >  static struct virtio_driver virtio_ipc_driver = {
> >
