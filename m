Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11300C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA92217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sro6cm8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBRTgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:36:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40144 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBRTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:36:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so30200446oth.7;
        Mon, 18 Feb 2019 11:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOgLOSyhNJEm2kI71BkED8gf/b8v+/2mCm5wJ4HWDVY=;
        b=Sro6cm8LtEaiFOo+6rddm/BD3UPAQfuGAdGdB+0Xy0cOxDAmJXurYYbS/EzdpUdMD4
         o+Mpjo6dM2wFzrs6qIxhW/fKymcHzJEAlVa+CE2pFcxEr4NaD4NJ0qv8mN1rI/Zc/3Po
         JQmSzoN/0iCGRvxVzvEOEG4Ze6MTA8SBO36/ecEwu7bjlLSpKZklr7FAFKVbRGi1HfGm
         +24XoWcaJu9ieNN+8fAs3T96R316PSglz/y9jT8kVdQPM5R9829eK0dLTb0Sz8efX7PE
         o3+Bi2yz2EkEz4BYkj48Zql1eQRSQNgRir+9l2tNSQ/kHpBtLE96zDeo4j+EPtr6y2ll
         +3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOgLOSyhNJEm2kI71BkED8gf/b8v+/2mCm5wJ4HWDVY=;
        b=tabW2jisn8pUiDqojIxO4CF0kzGWDwlfWyIs+xy48BaTSUw4aXiRC6/IALU0AvXvjk
         c07lLRV7ZTFWp/2numNVcDwYqTR4o7x1vgHci1TzLF3kLIbjmB+wRDMETtlw3Gkagza7
         A94eqy9vLuVoYEFjfn8S5NQQxz/jaG0LpVhmUT2jJWKutU3RyfqMCgfAL8swfM8jKV/3
         3UHP91Uw6p68oelxKNWmQirzo11P1q6BwMxCpmbiQvh0qJ8ymo3U1mG/9W2IGpGU6Rab
         9avsl1C/lgNFoX7aXGZapVhehDPAP4y94sMCyCd0uhP5r4pXnm7NjTdb37quF6NhEaiu
         s7ZA==
X-Gm-Message-State: AHQUAube6pc9rnUko5k6/Z4zgCtQGsvB7752bm5gV1rayVr1zy19dZyO
        jk+MJPuoJLrxg8sfm0Uc/x7tSdDmEYau3QcK0fk=
X-Google-Smtp-Source: AHgI3IbntwkE3tX0v9iyqFrFRQdJ+FiY43O2mHD08CNZ1rn7c5F4BROEblNkVCxoZ6qag0m2Mzz3ushvlvrtuh9rElw=
X-Received: by 2002:aca:37d5:: with SMTP id e204mr287472oia.134.1550518563343;
 Mon, 18 Feb 2019 11:36:03 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
 <20190211212734.01909e62@archlinux> <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
 <20190212204730.16864802@archlinux> <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
 <20190218151606.00000d10@huawei.com>
In-Reply-To: <20190218151606.00000d10@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 18 Feb 2019 14:35:51 -0500
Message-ID: <CAGngYiVQLwFxNJcCCH3byL=_p=L_BjMHJ1kCbjR8XkOF2mN3Ew@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
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

Hi Jonathan,

Thanks again for your clear and extensive feedback !

On Mon, Feb 18, 2019 at 10:16 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> I suspect that would break lots of devices if it happened, but
> fair enough that explicit might be good.  One option would be
> to document clearly in regmap the requirement that bulk read is ordered.
>

Yes, it would be interesting to hear the regmap people's opinion on ordering.
In the mean time, we can make this explicit.
Re-reading the thread, I can also see that Peter Meerwald-Stadler was first
to spot this race condition.

> What we need to guarantee is:
>
> 1) If the sensor reads on an occasion where the threshold is passed, we do not miss the event
>    The event is the threshold being passed, not the existence of the reading, or how many
>    readings etc.
>
> 2) A data read will result in a value.  There is no guarantee that it will match with the
>    event.  All manner of delays could result in new data having occurred before that read.
>

My feedback was based on two incorrect assumptions:
a. the interrupt fires whenever new PS/ALS values become available (wrong)
b. there are strict consistency guarantees between the THRESH event, and what
userspace will read out (also wrong)

Taking that into account, I am 100% in agreement with your other comments.
Thank you so much for the explanation!

There is one exception, though:

> > +static int ap3216c_write_event_config(struct iio_dev *indio_dev,
> > +                                    const struct iio_chan_spec *chan,
> > +                                    enum iio_event_type type,
> > +                                    enum iio_event_direction dir, int state)
> > +{
> > +       struct ap3216c_data *data = iio_priv(indio_dev);
> > +
> > +       switch (chan->type) {
> > +       case IIO_LIGHT:
> > +               data->als_thresh_en = state;
> > +               return 0;
> > +
> > +       case IIO_PROXIMITY:
> > +               data->prox_thresh_en = state;
> > +               return 0;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +static irqreturn_t ap3216c_event_handler(int irq, void *p)
> > +{
> > + if ((status & AP3216C_INT_STATUS_PS_MASK) && data->prox_thresh_en)
> > + iio_push_event(...);
> > +
> >
> > I think this may not work as intended. One thread (userspace) writes
> > a variable, another thread (threaded irq handler) checks it. but there
> > is no explicit or implicit memory barrier. So when userspace activates
> > thresholding, it may take a long time for the handler to 'see' it !
>
> Yes.  But if userspace took a while to get around to writing this value,
> it would also take longer...  It's not time critical exactly when you
> enable the event.  One can create cases where someone might
> care, but they are pretty obscure.
>

Are you sure? I suspect that it's perfectly possible for the threaded irq
handler not to 'see' the store to (als|prox)_thresh_en for a _very_ long time.

AFAIK only a memory barrier will guarantee that the handler 'sees' the store
right away. A lock will do - it issues an implicit memory barrier.

Most drivers use a lock to guarantee visibility. There are a few drivers that
resort to explicit barriers to make a flag visible from one thread to another.

E.g. search for mb() or wmb() in:
drivers/input/keyboard/matrix_keypad.c
drivers/input/misc/cm109.c
drivers/input/misc/yealink.c
