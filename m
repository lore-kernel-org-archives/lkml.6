Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2254A222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXZt5+4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfBMEk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:40:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45875 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfBMEk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:40:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so1764068ota.12;
        Tue, 12 Feb 2019 20:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2O/L6iDMn8Hbl4EBzvoA26ZPT18ydXKdDpuh/VfFDNw=;
        b=dXZt5+4aliqsrLPgKycT2ujKAkUG3bnxY4C9kQOBvIehvz/li8BHg9XZVoq+LPWpgf
         wVxT2yF9OT3f2pFBjiLPTi8gVv0jeZTQpn7IohVKwJfpxaksm5BUTY3jw145x2QHy0zm
         5zVrsFcualL7m32fuH+OwDWfmVDHOo51N2LJ8WArUzuhlOfPu4fbhjFAW4DIbKpnhb4n
         YvQWqlHD1n5Kc9OtO5LyaLM27oMA721r5QcsqIfKNho2v1l1TdUftJpi91Ncqg10cx/j
         x3ZsnPnoZu6WWHFMp/dyK/N5BqYZXRpEy6iVcXXBQct/O4A6Lj56oJswTTdk4gRUPMpb
         LkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2O/L6iDMn8Hbl4EBzvoA26ZPT18ydXKdDpuh/VfFDNw=;
        b=VcCmjPtmaEU3NL72iFZPPBHfUtk2HelMnvclpL+zTiLECNE30lPp9jqVivjwUJBr8m
         gsQDK8oIjyo7zhx08oLJcyno+wiG4ZnDTlEIj9v/gUaRYcLzTf3YkEpbfx26kmh1dC2l
         Wi317h75SP+JrfOor1kNR3Ay/G8RZ/vd20y+iw/M+DKIiXU3l/Pjj6FBClOTa6NBVZ9u
         Gu90WFSvTWeDb9SYCH7sHTetvJiqX4TjjuuVwMZVKdLoycn8QcgvRep+9OXgiYyJHHCi
         QzTpIt7ktjaCMULbXG+lA5i0wA5y9yJd5WEKDxwsdZcR4n/syapQecdpubN+5AJuVtRF
         eSHA==
X-Gm-Message-State: AHQUAuZj8mt8PxMjXoqkyBAh+A5WMlTBUq+p4l6axQZsZc6awH/DG5Fn
        ZEyGkuZCE6FneyVArH6oE/qMBEedgUnoFXiX6tk=
X-Google-Smtp-Source: AHgI3IaHZ6KcVlpx88GucMcF11lDl98740xoW2VKb7BnQ4LA+iP4nzCYMbYsmdZcnKwzcj9wbXna7cynD3exhQZLtGc=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr6829242otn.95.1550032824873;
 Tue, 12 Feb 2019 20:40:24 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
 <20190211212734.01909e62@archlinux> <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
 <20190212204730.16864802@archlinux>
In-Reply-To: <20190212204730.16864802@archlinux>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 12 Feb 2019 23:40:13 -0500
Message-ID: <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 3:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> Good question on whether it is guaranteed to read in increasing register
> order (I didn't actually check the addresses are in increasing order
> but assume they are or you would have pointed that out ;)
>
> That strikes me as behaviour that should probably be documented as long
> as it is true currently.
>

Looking at the datasheet closely... this chip doesn't seem to support
bulk/raw accesses. At least, it's not documented. So maybe we should
steer clear of that, and tell the regmap core, via .use_single_read
and .use_single_write in regmap_config.

So once these flags are set, we could call regmap_bulk_read() on the
LO/HI combo registers, and it would probably work. But do we really
want to? The LO register, when read, cause side-effects
in the corresponding HI register. That's weird / unexpected for developers.
Maybe it makes sense to make this explicit, not implicit. In addition,
bulk_read() behaviour changes in the future may break the register
reads ?

> >
>
> If we clear just the right one, (which I think we can do from
> the datasheet
> "1: Software clear after writing 1 into address 0x01 each bit#"
> However the code isn't writing a 3 in that clear, so I'm not
> sure if the datasheet is correct or not...
>
> and it is a level interrupt (which I think it is?) then we would
> be safe against this miss.
>
> If either we can only globally clear or it's not a level interrupt
> there isn't much we can do to avoid a miss, it's just a bad hardware
> design.
>

I think we're in luck, and this would work ! Note 1 on page 12 of the
datasheet:

"Note1. The INT pin will be set low and set INT status bit when ALS or
PS or (ALS+PS) interrupt event occurrence.
User can clear INT bit and individual status bits when reading the
register 0xD(ALS) , 0xF(PS) and 0xD+0xF(ALS+PS) respectively."

>
>

I'm sorry to wear out your patience, but I think there are more
synchronization issues lurking here.

The iio_push_event(THRESH) tells interested userspace processes:
"hey, maybe you want to check if a threshold is crossed", right?
Is my understanding correct?

If so, I think it's possible that a threshold is crossed, without
userspace knowing. To see why, let's look at the handler again:

static irqreturn_t ap3216c_event_handler(int irq, void *p)
{
        /* imagine ALS interrupt came in */
        regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
        if (status & als) iio_push_event(LIGHT);

        /* imagine schedule happens here */
        msleep(...);
        /* while we are not running, userspace reacts to the event,
         * reads the new ALS value.
         * Next, imagine a _new_ ALS interrupt comes in, while we are
         * still sleeping. the irq does not get re-scheduled, as it's
         * still running !
         * Next, we proceed:
        */
        ap3216c_clear_als(data);
        /* at this point there has been a new ALS interrupt without
         * userspace knowing about it.
         */
}

The _chance_ of this happening is very low, as ALS/PS events are quite
widely spaced. But we're not an RTOS. Question is: do we want to take
the risk? Idk, perhaps it's ok to trade simplicity for the low chance of
missing a threshold.

+static int ap3216c_write_event_config(struct iio_dev *indio_dev,
+                                    const struct iio_chan_spec *chan,
+                                    enum iio_event_type type,
+                                    enum iio_event_direction dir, int state)
+{
+       struct ap3216c_data *data = iio_priv(indio_dev);
+
+       switch (chan->type) {
+       case IIO_LIGHT:
+               data->als_thresh_en = state;
+               return 0;
+
+       case IIO_PROXIMITY:
+               data->prox_thresh_en = state;
+               return 0;
+
+       default:
+               return -EINVAL;
+       }

I think this may not work as intended. One thread (userspace) writes
a variable, another thread (threaded irq handler) checks it. but there
is no explicit or implicit memory barrier. So when userspace activates
thresholding, it may take a long time for the handler to 'see' it !

One way to guarantee that the irq handler 'sees' this immediately
is to grab a mutex, which issues an implicit memory barrier.

>
>

Allow me to suggest a simple, straightforward way to make all the above
issues go away (if indeed they are issues) :

First, disable fine-grained regmap locking, by setting .disable_locking
in regmap_config.

Next, read ALS and PS _exclusively_ in the irq handler, guard it with
a mutex:

static irqreturn_t ap3216c_event_handler(int irq, void *p)
{
    int ret = IRQ_NONE;

    mutex_lock(&data->m);
    regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
    if (status & als) {
        /* mutex m ensures LO and HI are read non-interleaved */
        regmap_read(data->regmap, ALS_LO, &als_lo);
        regmap_read(data->regmap, ALS_HI, &als_hi);
        /* mutex m's memory barrier lets userspace 'see' data->als change */
        data->als = als_lo | (als_hi<<8);
        /* mutex m's memory barrier lets us 'see' do_thresholding change */
        if (data->do_thresholding)
            iio_push_event();
        /* mutex m prevents userspace from reading the cached value
         * in between iio_push_event() and als_clear(), which means
         * userspace never 'misses' interrupts.
         */
        als_clear(data);
        ret = IRQ_HANDLED;
    }
    ( ... ps case left out for brevity ... )
    mutex_unlock(&data->m);

    return ret;
}

Now, ap3216c_read_raw becomes:

ap3216c_read_raw()
{
    mutex_lock(&data->m);
    switch (mask) {
        IIO_CHAN_INFO_PROCESSED:
            switch (chan->type) {
                case IIO_LIGHT:
                    *val = some_function_of(data->als);
            }
    }
    mutex_unlock(&data->m);
}

and ap3216c_write_event_config becomes:

ap3216c_write_event_config()
{
    mutex_lock(&data->m);
    switch (chan->type) {
       case IIO_LIGHT:
               data->als_thresh_en = state;
               goto out;
    }
out:
    mutex_unlock(&data->m);
}

In fact, we'd need mutex_lock around any function that touches the
regmap, cached data, or threshold enable/disable flags.
