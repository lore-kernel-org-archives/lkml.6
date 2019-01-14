Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA272C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE5520883
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfoIlTwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfANXuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:50:06 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38098 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANXuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:50:06 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so365348ywb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQHx3NZsy6DsUJLY4dfvWhxqRVzQFLqXWlZ8Fa4UfxA=;
        b=MfoIlTwPD02dii+ydzJo/zwrd+1W/LinCYjXJhH200c0kpit9+chYjaSiGGzi/nIRm
         WzW2V2JqsddLPVYIbZTUDhnm5L0sqApEI51VGQ3h7Dt5CZP924bLEj7pkCkn5RWtcYof
         Sb9NJxFmQSQNvDA97sxmDjvRugkcW8ovYYWCWY42jeXfbd3w0FPmnI82NQpN/k1euIIP
         ux0XTWMRSYs8FyJ9j46CVUO5oMZmEPIocOzXl3/e8E4b0YpNcv4KdggXbWLX+GL7xizk
         BQawDA+te0XgtpI7+kVMXUem3/ANMqyqfCd7YuKAKnanUOpCGX8a3ynEaRxM6VfK3wuN
         lPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQHx3NZsy6DsUJLY4dfvWhxqRVzQFLqXWlZ8Fa4UfxA=;
        b=oukeeF9gHmU+Oiw5REYQNEOrhGM2AqlpE35nUJzqKPJkufqtHBIaXemp+aihKueLKZ
         KLROEma+PGxZxEm8rc3GJfCqsrsgwL6Y+k19IQsTbSfILgd/ErOK7WLKmujQwSw9vqLY
         WAKOfatHrbKKPwecqKCMvRcpkgKssQ1UwJ3gQU35Bukx7fIjEu/Y6290ZSDkB9hJQCnk
         HOr8p8Jyc2EqTZ9csVgk5cxfxNrYDblMQPqR7hoGrU6ngr17nafM2HdR3oOqwLjTZf52
         uUQbQrxIpb4GVgUinbEa+fZLba8mtFR/oXdiGCG+F2Yyw9QZvmiyOsdArAn9Nx0KbALK
         eXVw==
X-Gm-Message-State: AJcUukeTgfeBZ7BBLpEsF+ks731g9XmkjdiiFeGV1nylgH0saSP06IF9
        0NFRdllWEWULYrg9KGIijBxdBz8DaynrxISkdNuSUw==
X-Google-Smtp-Source: ALg8bN6kWUP5JQd4Fo1qC/aU4MeOww01RmiTIRTi9kmuASw3yH7jO+ydRGM8CbCrXm1mb01OJawPPEbDJN4rKRGW0Ds=
X-Received: by 2002:a0d:c182:: with SMTP id c124mr849186ywd.190.1547509804547;
 Mon, 14 Jan 2019 15:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20181129195548.204153-1-egranata@chromium.org> <20181207222223.GA240898@google.com>
In-Reply-To: <20181207222223.GA240898@google.com>
From:   Gwendal Grignou <gwendal@google.com>
Date:   Mon, 14 Jan 2019 15:49:53 -0800
Message-ID: <CAMHSBOU0qNrCfg5=N-4KXBS_0fTBRbHGY2V9R7Q9E9ZY7R-1Mg@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: Add support for MKBP more event flags
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enrico Granata <egranata@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 2:22 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Enrico,
>
> On Thu, Nov 29, 2018 at 11:55:48AM -0800, egranata@google.com wrote:
> > From: Enrico Granata <egranata@chromium.org>
> >
> > The ChromeOS EC has support for signaling to the host that
> > a single IRQ can serve multiple MKBP events.
> >
> > Doing this serves an optimization purpose, as it minimizes the
> > number of round-trips into the interrupt handling machinery, and
> > it proves beneficial to sensor timestamping as it keeps the desired
> > synchronization of event times between the two processors.
> >
> > This patch adds kernel support for this EC feature, allowing the
> > ec_irq to loop until all events have been served.
>
> Might be worth being more explicit in this commit message to say that
> you're adding support for EC_CMD_GET_NEXT_EVENT version 2?
>
> > Signed-off-by: Enrico Granata <egranata@chromium.org>
>
> Mostly looks fine; thanks for sending. I have a few small notes (and
> some of that is not necessarily something resolve in this patch), but
> with at least the cros_ec.h comment fixup, feel free to add my:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> > ---
> >  drivers/mfd/cros_ec.c                   | 20 +++++++++++++--
> >  drivers/platform/chrome/cros_ec_proto.c | 33 +++++++++++--------------
> >  include/linux/mfd/cros_ec.h             |  3 ++-
> >  include/linux/mfd/cros_ec_commands.h    | 15 +++++++++++
> >  4 files changed, 50 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index fe6f83766144f..17903a378aa1a 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -51,13 +51,16 @@ static const struct mfd_cell ec_pd_cell = {
> >       .pdata_size = sizeof(pd_p),
> >  };
> >
> > -static irqreturn_t ec_irq_thread(int irq, void *data)
> > +static bool ec_handle_event(struct cros_ec_device *ec_dev)
> >  {
> > -     struct cros_ec_device *ec_dev = data;
> >       bool wake_event = true;
> >       int ret;
> > +     bool ec_has_more_events = false;
> >
> >       ret = cros_ec_get_next_event(ec_dev, &wake_event);
> > +     if (ret > 0)
> > +             ec_has_more_events =
> > +                     ec_dev->event_data.event_type & EC_MKBP_HAS_MORE_EVENTS;
> >
> >       /*
> >        * Signal only if wake host events or any interrupt if
> > @@ -70,6 +73,19 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
> >       if (ret > 0)
> >               blocking_notifier_call_chain(&ec_dev->event_notifier,
> >                                            0, ec_dev);
> > +
> > +     return ec_has_more_events;
> > +}
> > +
> > +static irqreturn_t ec_irq_thread(int irq, void *data)
> > +{
> > +     struct cros_ec_device *ec_dev = data;
> > +     bool ec_has_more_events;
> > +
> > +     do {
> > +             ec_has_more_events = ec_handle_event(ec_dev);
> > +     } while (ec_has_more_events);
> > +
> >       return IRQ_HANDLED;
> >  }
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index b6fd4838f60f3..bb126d95b2fd4 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -420,10 +420,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
> >       ret = cros_ec_get_host_command_version_mask(ec_dev,
> >                                                   EC_CMD_GET_NEXT_EVENT,
> >                                                   &ver_mask);
>
> It's not exactly new here (although you're using 'ver_mask' in new
> ways), but cros_ec_get_host_command_version_mask() doesn't look 100%
> right. It doesn't look at msg->result, and instead just assumes that if
> we got some data back (send_command() > 0), then it must have been a
> success. I don't think that's really guaranteed in general, although it
> might be for the specific case of EC_CMD_GET_CMD_VERSIONS.
It is guaranteed: if msg->result is not EC_RES_SUCCESS, then ret can
not be greater than 0. At best it will be 0, or a negative number if
we can already qualify the error in the errno space (see
cros_ec_pkt_xfer_i2c() for instance).

Gwendal.
>
> IOW, to be definitely sure we're not looking at a garbage result in
> 'ver_mask', we should probably fixup
> cros_ec_get_host_command_version_mask().
>
> > -     if (ret < 0 || ver_mask == 0)
> > +     if (ret < 0 || ver_mask == 0) {
> >               ec_dev->mkbp_event_supported = 0;
> > -     else
> > -             ec_dev->mkbp_event_supported = 1;
> > +             dev_info(ec_dev->dev, "MKBP not supported\n");
> > +     } else {
> > +             ec_dev->mkbp_event_supported = fls(ver_mask);
> > +             dev_info(ec_dev->dev, "MKBP support version %u\n",
> > +                     ec_dev->mkbp_event_supported - 1);
> > +     }
> >
> >       /*
> >        * Get host event wake mask, assume all events are wake events
> > @@ -530,28 +534,19 @@ static int get_next_event(struct cros_ec_device *ec_dev)
> >  {
> >       u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
> >       struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
> > -     static int cmd_version = 1;
> > -     int ret;
> > +     const int cmd_version = ec_dev->mkbp_event_supported - 1;
> >
> >       if (ec_dev->suspended) {
> >               dev_dbg(ec_dev->dev, "Device suspended.\n");
> >               return -EHOSTDOWN;
> >       }
> >
> > -     if (cmd_version == 1) {
> > -             ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> > -                             sizeof(struct ec_response_get_next_event_v1));
> > -             if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
> > -                     return ret;
> > -
> > -             /* Fallback to version 0 for future send attempts */
> > -             cmd_version = 0;
> > -     }
> > -
> > -     ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> > +     if (cmd_version == 0)
> > +             return get_next_event_xfer(ec_dev, msg, 0,
> >                                 sizeof(struct ec_response_get_next_event));
> >
> > -     return ret;
> > +     return get_next_event_xfer(ec_dev, msg, cmd_version,
> > +                             sizeof(struct ec_response_get_next_event_v1));
> >  }
> >
> >  static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
> > @@ -607,11 +602,13 @@ EXPORT_SYMBOL(cros_ec_get_next_event);
> >
> >  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
> >  {
> > +     u32 event_type =
> > +             ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
> >       u32 host_event;
> >
> >       BUG_ON(!ec_dev->mkbp_event_supported);
> >
> > -     if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
> > +     if (event_type != EC_MKBP_EVENT_HOST_EVENT)
> >               return 0;
> >
> >       if (ec_dev->event_size != sizeof(host_event)) {
> > diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > index e44e3ec8a9c7d..eb771ceeaeed1 100644
> > --- a/include/linux/mfd/cros_ec.h
> > +++ b/include/linux/mfd/cros_ec.h
> > @@ -152,7 +152,8 @@ struct cros_ec_device {
> >       int (*pkt_xfer)(struct cros_ec_device *ec,
> >                       struct cros_ec_command *msg);
> >       struct mutex lock;
> > -     bool mkbp_event_supported;
> > +     /* 0 == not supported, otherwise it supports version x - 1 */
>
> This comment belongs in the kerneldoc, which is above the struct
> definition. You're invalidating the existing comment:
>
>  * @mkbp_event_supported: True if this EC supports the MKBP event protocol.
>
> Brian
>
>
> > +     u8 mkbp_event_supported;
> >       struct blocking_notifier_head event_notifier;
> >
> >       struct ec_response_get_next_event_v1 event_data;
>
> ...
