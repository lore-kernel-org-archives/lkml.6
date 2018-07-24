Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E3FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD69820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2a95CH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD69820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbeGXQrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:47:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35473 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388319AbeGXQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:47:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id a5-v6so4540907qtp.2;
        Tue, 24 Jul 2018 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r2NvQ32/3TJuGxWnhIYaXT4o02GHAX5lhdRpMkKwc80=;
        b=N2a95CH0eoPNLflk2ooDnAJhpZIMrDpocEfljiMENUgOAQ8t0CMmS1aXTy6nL+d+Ly
         6ODDjau7J9yNCRAVyvnsEUkolSrcZF7JsHAToUmprzzg/g0bZNKBz1S5CUN0A8sGIDeN
         RYst73sJzlcc1kVWEAlkcaTPvMmaks13C27ev8HpsGY08XkSNg9aYwFJle9wrSIYU3H2
         Y4BaSrspSMKfEepdHPZp4I7NvELNVOpc5TnhUJd196Ct4BfsJHhGRqcASGyoHKQQPOA/
         srAkOSH4odqatzWQCv+NyCwTLDSNE67DmuLZTyqg5YwHL4NTSSHFO7XLjW0x+ICT6DCc
         qBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=r2NvQ32/3TJuGxWnhIYaXT4o02GHAX5lhdRpMkKwc80=;
        b=Z7IB3Iw/A/P3gc8qqfeBxH9fOW+dDtBbZLpz7Y+XtFn02OVyjzC9yZwmfJ1C7aha//
         zMgf+ge1wTvjfjf1aksxOk5c0W1xiLBHzzMgzYgp+1UOCBbS2VujdImsM5G0p+dXdEFn
         q9s4o74NaZElayK3kjjBAfbnawNWw081L7R1FqND5998CybfgQJkGTZNCH4zGU+Low4F
         T0fdqJQlxZjJI2m0XPXhpekgJDCKEgf5NlXXSMDUaua/422DBRzXJLmu3iBiacV3jOkE
         O5h6l/Z6Ex/EGusACyrJBxTxw4XYrEmOd00DhJJmWHZegq15L/uEqdicWCiQnCgD17C6
         7MPw==
X-Gm-Message-State: AOUpUlGRO4ou6ySfGJiuPSQoqIcNi3IesyzWC8nJFiOmsufFxQyQzJ3E
        JbgQp2kj0JpkeO/URUe8M9VCI01eCk2pFwQE/+w=
X-Google-Smtp-Source: AAOMgpcaM/1AV1TLuxpTt/HG/5ZAuIqdYl0XqDI3gJlFUJSAxnPKYxdEIiRQfyOaJuLpfikgWa8o1n0ZkqZYSVqlN8k=
X-Received: by 2002:ac8:3676:: with SMTP id n51-v6mr16826868qtb.163.1532446837337;
 Tue, 24 Jul 2018 08:40:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:40:36
 -0700 (PDT)
In-Reply-To: <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 17:40:36 +0200
X-Google-Sender-Auth: idNgmZlYSLkoITfn-DGB6S3RKT8
Message-ID: <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 5:15 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Jul 24, 2018 at 5:05 PM Arnd Bergmann <arnd@arndb.de> wrote:

>> That's not the case I was describing here, I was thinking of what
>> Wolfram described with the Renesas SoC that has two i2c masters
>> multiplexed through the pinmux layer. I would assume that we
>> can still do the same thing in i3c by shutting down the current
>> master without a handover, and reprobing everything from scratch.
>
> The major disadvantage of reprobing is that it may cause visual disturbances
> when i2c slaves are involved with e.g. the display pipeline (think HDMI encoders
> etc.).

Do you mean we should reuse the device pointer and association with
the driver even when we switch out the i3c master using the pinmux?

Or do you mean we need to be prepared for driving a single
slave through multiple masters over the lifetime of that device,
but using the i3c master handover protocol?
In the second case, how do we decide which master to use
for accessing a device for a given request?

       Arnd
