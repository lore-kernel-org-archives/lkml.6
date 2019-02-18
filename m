Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE327217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5ULmmvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfBRSZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:25:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32960 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbfBRSZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:25:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so20310471qtz.0;
        Mon, 18 Feb 2019 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0Cs1yYhphK+Bp6FriQhJZHT0gh7EecKmgRuXV91t/U=;
        b=A5ULmmvCXx+cxjZM85lIjf6KJPJ9AUdcGJ8LjAZyv8JSrsfar/myvNrpC1IOLWI0Mn
         veaD9ZYSquGNc55/LodytGc+AO7ZGCDEM8qKmK9xcq56ZZhix+9YvaMJt37aVoYh5eK1
         vlcxrwlAHO0SZw5tZ0qcjnhgypNutq4wuN2vSG1JzM3RLJkeTohCqLsxsqyAj9LD5zDF
         wf1T9p21jOa4Pz4ZQbwfwb6x9v0+S8WbUX45mT6+QRGHKX2yw3Tlszn7MQaWbqf+vT+Z
         lrTwExDpfF1J/RxQfCAbGYGLURYeBEZQwHanXZXw3S3k/2nkWnKv5Gj4fHQUvy2jVmUk
         CEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0Cs1yYhphK+Bp6FriQhJZHT0gh7EecKmgRuXV91t/U=;
        b=LwbJ4lxkuIMNay93Z/yRNqb0Ptv+Oh4LjU6T1uuHuyWN9QZEVUVmQKg4AeYsB2iHYn
         6K4dT4puseukBafuy520Ch1ls/gCiI8ADuplryW+7hdK+eM2UpE0Oew8FG0nWhpvTY4U
         nm4M1PYRtkomlRFa4OQd6tG+qZqsHzD9ujqZJsUMdRKcH9fsk6dOrOopVkLiFcY9uni9
         nOLdRjCIE6z6iuaBz6CgbE2AK6fHsMYvIlBH7aznZ+HlH5sfcfSo269gnkEu6Q4SbvOs
         gCAMaK0Ko0Moi2qOFJP/2fZLTcwt9FncsCgocKpYyi9xVrssnlPeZehzBvbEJ2Ob500/
         EIiQ==
X-Gm-Message-State: AHQUAubUQNwG9U10DOLV72VDinU1OYx/UQ7b6r2W8D6HTw6CCQD9VDO5
        L1Dhk4ZgO8tb5ReCz0CnZ3fIi7ll/9sZMs7THcxIAw==
X-Google-Smtp-Source: AHgI3IYlEAnnEm+IARKgtuoOiHdO6OfwQ1Wh1cF3B1w6toUIzjHZTA6fncy1o1CXbuNUVnQLERN/CY6NlvdHdo7vRNk=
X-Received: by 2002:ac8:7545:: with SMTP id b5mr19013261qtr.244.1550514322396;
 Mon, 18 Feb 2019 10:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20190216001533.5465-1-jbroadus@gmail.com> <20190218100652.GB27940@ediswmail.ad.cirrus.com>
In-Reply-To: <20190218100652.GB27940@ediswmail.ad.cirrus.com>
From:   Jim Broadus <jbroadus@gmail.com>
Date:   Mon, 18 Feb 2019 10:25:10 -0800
Message-ID: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by a i2c client device.
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     benjamin.tissoires@redhat.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Charles. I should probably correct the typos in my commit message.

On Mon, Feb 18, 2019 at 2:06 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Fri, Feb 15, 2019 at 04:15:33PM -0800, Jim Broadus wrote:
> > A previous change allowed i2c client devices to discover new IRQs upon
> > reprobe. By clearing the IRQ in i2c_device_remove. However, if an IRQ was
> > assigned in i2c_new_device, that information is lost.
> >
> > For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> > are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> > client device structures are initialized during an ACPI walk. After
> > removing the i2c_hid device, modprobe fails.
> >
> > This change caches the initial IRQ value in i2c_new_device and then resets
> > the client device IRQ to the initial value in i2c_device_remove.
> >
> > Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> > ---
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Apologies for the issues caused. I think this looks like a good fix
> to me.
>
> Thanks,
> Charles
