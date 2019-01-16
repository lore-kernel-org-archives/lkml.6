Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA9BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7920651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIoT07Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405427AbfAPQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:22:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54445 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfAPQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:22:50 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so3853924ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odzEPFh2R4153nbmby6d3fB0YZ9yrH7zNan7H4T23Zs=;
        b=vIoT07Qf/LQMlj7FzoIe5zbGbERviN40guiKKeko66HZ9iEd7VjHxOipK1gh8d1YLr
         GxEoq7CdrNAQa1njO2cATW8sbRr97IYd5SpVb9DwWbEyJPvFXmMkqPtxoN0lPptY97jS
         BJE7VNRWb05cQyjvoqYpEgm96YU0xcAwFunt/UD7gKQt/DEG2h59H6spkGoVpO9qHnA5
         poRUeGNeVy841Jd6ABC9LP9nCBQknYxyAoaDaXqPlF3tLRKDHCoAw5e0ojk+zeRjSF6y
         XHYqoByrH5aw3kS9XXTAvhBQYdfzGFB3Mp5L8ZnIyu9Eamv7/oC+2663ELKp4s9fHFov
         7e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odzEPFh2R4153nbmby6d3fB0YZ9yrH7zNan7H4T23Zs=;
        b=eDM6DIbYPVgrnSZjOgqtqPiv+wKZmla8262+brOuYoA29dASRwzEYZQkR+Lp11T/e1
         5LqGML64tWta/c04TDyRDiDUT23g4m36GUMoXA8A8VbM9qHmfUQMN+LYFt6o838ncI3Y
         HpojXlFFYThtGJ6ak8y3yVqhuwnIUzhigQUkBicgAYGps3wXaLTVO5FV4Ta9hBmrVHtt
         iev/3SZELURDOJCziXDUSlP3e9/fCzMMv1GRMAU6A9bNNa1VWc//IOAJeHA0jcRK10V9
         H1YERc1uOB+hWx0Q+AUMCszVp0+Y6biSLS9VmExuEJLCfVqKX2uTZ3vIXrcedYnxrSZI
         8mMQ==
X-Gm-Message-State: AJcUukcEYeIPmE4E4j8agKijVD6RDXsxMEvQ7ieHXzyHNhVePinVQZ4N
        LN/j8dSMCb49bg2uR/Ujy0grVAJHLLQTNsMQ4n0=
X-Google-Smtp-Source: ALg8bN56eZG90BjU47A9+yzw4uSiaytI2qC2ek9t8fGu1Nj0K8Y/HzrR00wzH4IjGxw63UsFf3E/BYLwGkBrg7V/aJc=
X-Received: by 2002:a02:13c6:: with SMTP id 189mr5635699jaz.117.1547655769320;
 Wed, 16 Jan 2019 08:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20190116050435.11624-1-ck.hu@mediatek.com> <20190116050435.11624-2-ck.hu@mediatek.com>
In-Reply-To: <20190116050435.11624-2-ck.hu@mediatek.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 16 Jan 2019 10:22:38 -0600
Message-ID: <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: Add ability for clients to abort data in channel
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:07 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> This patch supplies a new framework API, mbox_abort_channel(), and
> a new controller interface, abort_data().
>
> For some client's application, it need to clean up the data in channel
> but keep the channel so it could send data to channel later.
>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/mailbox/mailbox.c          | 23 +++++++++++++++++++++++
>  include/linux/mailbox_client.h     |  1 +
>  include/linux/mailbox_controller.h |  4 ++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index c6a7d4582dc6..281647162c76 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -428,6 +428,29 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
>  }
>  EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
>
> +/**
> + * mbox_abort_channel - The client abort all data in a mailbox
> + *                     channel by this call.
> + * @chan: The mailbox channel to be aborted.
> + */
> +void mbox_abort_channel(struct mbox_chan *chan)
> +{
> +       unsigned long flags;
> +
> +       if (!chan || !chan->cl)
> +               return;
> +
> +       if (chan->mbox->ops->abort_data)
> +               chan->mbox->ops->abort_data(chan);
> +
> +       /* The queued TX requests are simply aborted, no callbacks are made */
> +       spin_lock_irqsave(&chan->lock, flags);
> +       chan->cl = NULL;
> +       chan->active_req = NULL;
> +       spin_unlock_irqrestore(&chan->lock, flags);
> +}
>
Why not just release and then request channel again ?
mbox_abort_channel() is just a copy of mbox_free_channel() and if the
abort can sleep, that is more reason to just do that.
