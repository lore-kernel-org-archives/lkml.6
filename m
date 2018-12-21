Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA41C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8303B218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hyoizdan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeLUJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:28:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35094 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbeLUJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:28:52 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so5727438itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bInkCh3vUiFCq9C3gpAc0IBU3JBsd9a1+6vvSMxsWLE=;
        b=Hyoizdan++QLb4u6jryHrJmbtlifz4QZrUstzmmZR0SQ4VuRPXQo/zNOtHEo4IDeGz
         lLDAJ6c70AdbKpSMIJzI8n0Kx7G7VGi1rNwKYdXbAVBHGikyRP7sqc9u2fICHYrvzMq1
         wZz6fUsxfy9CKBPLWEI8nEChoqTSYwXUI3V/Et1kSg3OdIfmFHFAZN1QnX6JISQOdHKg
         Bt+Xr8Zxw3oN5jzDUBJfES3DzQ+XnJkMPPynlPlId8m0TJONOoL0EgB1ekVeQPNEB2W2
         TpeMSiucsUU5c0t00t2tsSqI6OwZFuRufE9dQ1Djka0C/K/Kz046CcmZUUGYVAajPe8B
         MiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bInkCh3vUiFCq9C3gpAc0IBU3JBsd9a1+6vvSMxsWLE=;
        b=jgnI8Edr25SFNwMFL9NGrrnpcXRYxm2+RUUUQxn62fLpkVO3m5OMvqrpBAvdRTfXEM
         TeO4vhdVrVoOVcmRBpUPyzcfl357sLLVHzg6EVMNNF6x9UqivPSn2Vmj5Ui9R/yWU1Si
         93SxomQFuuGPxJE5UrxWy+5mDdcoSIu3xnBAZ4DkiKkVMTpbaobHEmyC5Itm/PGnWkzq
         /2LLZFKVIEhCHk+bz4h9BlAQO4DLoftw1lZQXQl5byuc5eOs9s+jmG5fExx85T9uyqSk
         lTAbrBlmH/yI2uHyPZIdVraqENkLrp0dRIlMmJOK6MPRffs6Gri6/C5uGSqAGJhQPbSh
         GOvg==
X-Gm-Message-State: AJcUukftLayxc6O1KNaf0usb5RcDZG0/FlILpsh5FAOt/bYz1mw2Rqpd
        ZAGH/IFZBD202rXKuUea2rtWoLgMeC5ilWhtN6c=
X-Google-Smtp-Source: AFSGD/Vf0qZu8I0mi14LZQp3KgT03vrGCB0HokLubnqYXbKDphST8paf8MCiCT6ioeGD1WSQwNm6bvcDR3ao1RJ+nZQ=
X-Received: by 2002:a24:d745:: with SMTP id y66mr1268966itg.18.1545384531764;
 Fri, 21 Dec 2018 01:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20181221075442.17109-1-gregkh@linuxfoundation.org> <20181221075442.17109-7-gregkh@linuxfoundation.org>
In-Reply-To: <20181221075442.17109-7-gregkh@linuxfoundation.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 21 Dec 2018 10:28:48 +0100
Message-ID: <CAOi1vP8rYT4w65m7qEPqiXEWhCGkSAZctgMoOO_bfzVtTA7BxQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] block: rbd: convert to use BUS_ATTR_WO and RO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Sage Weil <sage@redhat.com>,
        Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 8:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> We are trying to get rid of BUS_ATTR() and the usage of that in rbd.c
> can be trivially converted to use BUS_ATTR_WO and RO, so use those
> macros instead.
>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Sage Weil <sage@redhat.com>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/block/rbd.c | 45 +++++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8e5140bbf241..d871d364fdcf 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -428,14 +428,13 @@ static bool single_major = true;
>  module_param(single_major, bool, 0444);
>  MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: true)");
>
> -static ssize_t rbd_add(struct bus_type *bus, const char *buf,
> -                      size_t count);
> -static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
> -                         size_t count);
> -static ssize_t rbd_add_single_major(struct bus_type *bus, const char *buf,
> -                                   size_t count);
> -static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
> -                                      size_t count);
> +static ssize_t add_store(struct bus_type *bus, const char *buf, size_t count);
> +static ssize_t remove_store(struct bus_type *bus, const char *buf,
> +                           size_t count);
> +static ssize_t add_single_major_store(struct bus_type *bus, const char *buf,
> +                                     size_t count);
> +static ssize_t remove_single_major_store(struct bus_type *bus, const char *buf,
> +                                        size_t count);
>  static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth);
>
>  static int rbd_dev_id_to_minor(int dev_id)
> @@ -464,16 +463,16 @@ static bool rbd_is_lock_owner(struct rbd_device *rbd_dev)
>         return is_lock_owner;
>  }
>
> -static ssize_t rbd_supported_features_show(struct bus_type *bus, char *buf)
> +static ssize_t supported_features_show(struct bus_type *bus, char *buf)
>  {
>         return sprintf(buf, "0x%llx\n", RBD_FEATURES_SUPPORTED);
>  }
>
> -static BUS_ATTR(add, 0200, NULL, rbd_add);
> -static BUS_ATTR(remove, 0200, NULL, rbd_remove);
> -static BUS_ATTR(add_single_major, 0200, NULL, rbd_add_single_major);
> -static BUS_ATTR(remove_single_major, 0200, NULL, rbd_remove_single_major);
> -static BUS_ATTR(supported_features, 0444, rbd_supported_features_show, NULL);
> +static BUS_ATTR_WO(add);
> +static BUS_ATTR_WO(remove);
> +static BUS_ATTR_WO(add_single_major);
> +static BUS_ATTR_WO(remove_single_major);
> +static BUS_ATTR_RO(supported_features);
>
>  static struct attribute *rbd_bus_attrs[] = {
>         &bus_attr_add.attr,
> @@ -5934,9 +5933,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>         goto out;
>  }
>
> -static ssize_t rbd_add(struct bus_type *bus,
> -                      const char *buf,
> -                      size_t count)
> +static ssize_t add_store(struct bus_type *bus, const char *buf, size_t count)
>  {
>         if (single_major)
>                 return -EINVAL;
> @@ -5944,9 +5941,8 @@ static ssize_t rbd_add(struct bus_type *bus,
>         return do_rbd_add(bus, buf, count);
>  }
>
> -static ssize_t rbd_add_single_major(struct bus_type *bus,
> -                                   const char *buf,
> -                                   size_t count)
> +static ssize_t add_single_major_store(struct bus_type *bus, const char *buf,
> +                                     size_t count)
>  {
>         return do_rbd_add(bus, buf, count);
>  }
> @@ -6050,9 +6046,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
>         return count;
>  }
>
> -static ssize_t rbd_remove(struct bus_type *bus,
> -                         const char *buf,
> -                         size_t count)
> +static ssize_t remove_store(struct bus_type *bus, const char *buf, size_t count)
>  {
>         if (single_major)
>                 return -EINVAL;
> @@ -6060,9 +6054,8 @@ static ssize_t rbd_remove(struct bus_type *bus,
>         return do_rbd_remove(bus, buf, count);
>  }
>
> -static ssize_t rbd_remove_single_major(struct bus_type *bus,
> -                                      const char *buf,
> -                                      size_t count)
> +static ssize_t remove_single_major_store(struct bus_type *bus, const char *buf,
> +                                        size_t count)
>  {
>         return do_rbd_remove(bus, buf, count);
>  }

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
