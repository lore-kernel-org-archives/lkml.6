Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70A9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81237240F9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRDhoRY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81237240F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeGDRXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:23:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53626 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeGDRXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:23:38 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so8649273itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mEUCAwGEilbfJ/quvX0zpFygHqSVZLrnWMLsGtyjsA=;
        b=HRDhoRY99jgU6cIRv0r4r1StZyo93k7wj0f8qHGtjxqE8HlKcmCJB4Gfbay79s8F++
         jGpqNF9nxH1ma/pMlDIHaWRWzP041BtTLUYahsL3WHSJRMkocrHNoEtp/1HGPUWXWHzC
         bMs+CbubBdUvXfqNBLYpMVukKbvl7j13OD+f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mEUCAwGEilbfJ/quvX0zpFygHqSVZLrnWMLsGtyjsA=;
        b=d/iNmNbM/N2bBF+gAjl5ztp/ahKQ3kDdf9YT756CQZD5dRDdc4xo7tSGtFt8j7XC6P
         fzh8I5kcOGZxWGofq9z5jKU/31HvyXTf4+azv0Zg7jppwQLDJ5GNc+Smuk1uRB0zUAn1
         BryLI9gGE7oIZ6JfuO4z15kS2zDGlE9nZWKQpO51XBWz0gt1d5JMwnD3VVfyLJdU1lpJ
         7Q+0QcS6hpK50wek0ZSiQz8trX42x9JPSNWuUwnr7GA4zfxQbj0rc0mzZPiIbh/cQQs7
         rtedFy6ld44zRw7dS9fXdO94pi8I1DfS5PPr95/ncfzCJm50EZGixFEo8SYGOvsLg/Bg
         fkCA==
X-Gm-Message-State: APt69E3uZr3/48+bGLo1i2END3431cSyH3RYzzb5pEnpjpryCvm3gVlb
        92mEOm82kvun4jTr6dHPJ51AMUSomYnwKRlrYxI5uA==
X-Google-Smtp-Source: AAOMgpdmhPhJs1Z3Mqzb+p2XJ+hyW04bFZHQMU9UGTZd6WjeeK2jkinWr8l4N/X4yfL5Ca0+YtR0BVURGzcf1ApBDKw=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr2392473itf.70.1530725018072;
 Wed, 04 Jul 2018 10:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <7606bdc53c26c332b2bbff0f865380fb0e874b56.1529607879.git.vilhelm.gray@gmail.com>
 <b7c690eb-274e-3377-cf8a-2f9ab836677e@lechnology.com> <20180703141620.GB14958@sophia>
In-Reply-To: <20180703141620.GB14958@sophia>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Jul 2018 19:23:26 +0200
Message-ID: <CACRpkdbq1ued8gA-zcJYtK2jYJyMbuSkvinCvuoz_VGU=i+1nQ@mail.gmail.com>
Subject: Re: [v7,03/10] docs: Add Generic Counter interface documentation
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 4:16 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Mon, Jul 02, 2018 at 02:37:53PM -0500, David Lechner wrote:
> >On 06/21/2018 04:07 PM, William Breathitt Gray wrote:
> >> +Userspace Interface
> >> +===================
> >> +
> >> +Several sysfs attributes are generated by the Generic Counter interface,
> >> +and reside under the /sys/bus/counter/devices/counterX directory, where
> >> +counterX refers to the respective counter device. Please see
> >> +Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
> >> +information on each Generic Counter interface sysfs attribute.
> >> +
> >> +Through these sysfs attributes, programs and scripts may interact with
> >> +the Generic Counter paradigm Counts, Signals, and Synapses of respective
> >> +counter devices.
> >> +
> >
> >Have you considered a character device in addition to the sysfs interface?
> >
> >I basically have many of the same concerns that resulted in a char dev for
> >gpio[1].
> >
> >- With sysfs, you *can* technically poll for events, but then you have to
> >   seek and read or re-open the file.
> >- File permissions are annoying if you want a non root user to be able to
> >   use the device.
> >- A single program can't claim exclusive access to a device.
> >- There is no automatic cleanup if a userspace program accessing the device
> >    crashes.
> >
> >[1]: https://www.elinux.org/images/7/74/Elce2017_new_GPIO_interface.pdf
>
> Those look like good technical reasons for implementing a character
> device for the Generic Counter interface. I chose to implement the sysfs
> interface because I was using the IIO code as a reference, but I
> personally don't have much opposition to a character device in addition.

IIO is also using a character device for outputting events and sensor
data. In IIO sysfs is only used for configuring what events and
data should come out of the character device.

> I'd like to get Jonathan's opinion on this as well if possible -- I
> vaguely recall us considering this option briefly last year when the
> Generic Counter interface was still in its beginnings. I've CC'd Linus
> Walleij as well for input as the GPIO maintainer.

The GPIO character device was based on the IIO character device.

We have one TODO item: to merge the timestamping format
between GPIO and IIO and use the same sysfs file for configuring
the time base.

Yours,
Linus Walleij
