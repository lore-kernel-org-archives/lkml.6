Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1093C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F7B208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOYNb5oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F7B208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754821AbeFRPwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:52:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39993 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeFRPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:52:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so25436809lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AQD6G6yBWFaAofnHIYUzUxsr4JneB/w07fY1sdQAtJw=;
        b=TOYNb5oKrfS1/fmG6vG2inGd8bG1oE+/9h4WQS6TB1gravokP8u05+sCyGHBSbGiTj
         3MGyWejjkJ+ChmzkbhVu6XYy54rehO2IsnVjZxLik+LZ+6EPQCHQjhjxXYs8w0+NnSpq
         htlvmYHnf13j7A1s4ifKzczCbvnFwVaM975JZ5oeq0D6vCv4UEua3DhKM5LZCIFSLDlR
         D1UCUKfBh07BraugJKzqM1SVIwAz4yx9WVl6zS/NX7OouEGkxP+T9slS7eUXo6bRFU1+
         qaHDaDXZQWpIqfpYX5wQGf+gi+lkx6V1ZfmSoXP+estN8m46U53urmnaT+bBtJIUVMD+
         adRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AQD6G6yBWFaAofnHIYUzUxsr4JneB/w07fY1sdQAtJw=;
        b=KOya+QRQ4B/D+zFBxC6JlXfIdqI5QgsSb8mYLNMfLz/JT0SvwDCu1RuNxp8sqqfcW6
         QqpVF/vV7d3DMjnlAetUYYZHTKvGTRtFzqZ8Z0ZpIW81zO2jEfyuRdWH+F7lVuJE7nW0
         uKWum/oNZLUsrqTMeN629q0MHhxYN9kTsCEQsx8+pf2aEIL2x+9e5TkWJYmmvV4+0FcV
         qfSfAFT6Kt+Sg8YdouN1GhWx0yh7wyx96yqs1Vu5S0T4ifrRl7mK2nlc8GiuUNatLZ+i
         ve3oeFxv0D1m2+AZ8wVSOX4cvfjw1nn87JWN1X5v3sdF15G0Mnm6L4MPFUTvB5jjeo7y
         WV4Q==
X-Gm-Message-State: APt69E0MlW2FBPN58Ux6+SG8VoND31oEQXXxwGhxbBl3uqO7kZOdO4Ew
        kGZ4NqOkGRpTSJIPIYZNN14IoLUxa8v0lrCs7Uc=
X-Google-Smtp-Source: ADUXVKJschH0exks40jGmpuA98ZSkE5n0F1bdIPCykqGYXQ7ZtyvTyCjaORQk1UIxQId/5Ej87hU2/xrJ2+t/ubN5fA=
X-Received: by 2002:a19:97cb:: with SMTP id z194-v6mr8369747lfd.17.1529337164798;
 Mon, 18 Jun 2018 08:52:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:52:43
 -0700 (PDT)
In-Reply-To: <s5htvq0w12d.wl-tiwai@suse.de>
References: <20180618154108.2227779-1-arnd@arndb.de> <s5htvq0w12d.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 17:52:43 +0200
X-Google-Sender-Auth: USbGkKeL7L9P6a6ZrRg3DFdCr1k
Message-ID: <CAK8P3a13rsTxinJ5m6-VOZJx6pXeWav41AQNtS7dSMahYzqXaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: use ktime_get_raw_ts64() instead of getrawmonotonic64()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:45 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 18 Jun 2018 17:41:00 +0200,
> Arnd Bergmann wrote:
>>
>> The API got renamed for consistency and the old name will
>> be removed once the last users are gone.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> These two fixes can be postponed for 4.19, or urgently needed for
> 4.18?  I suppose the former, but just to be sure.

Not urgent at all. I also noticed (slightly too late) that the first one doesn't
even apply,
I had written it on top of my tree that contained the previously discussed
API conversion, which Baolin and I still need to follow up on. I'll fold
the first patch into that series, please apply just the seconds patch
for 4.19 for now.

        Arnd
