Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF020874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebEovUAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBF020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbeGWIYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:24:50 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37503 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbeGWIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:24:49 -0400
Received: by mail-ua0-f193.google.com with SMTP id y10-v6so11129319uao.4;
        Mon, 23 Jul 2018 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DSs7QrMMMqUg/JvzHC8qvmT4dNtx3U4QeCQ6RMTFYFk=;
        b=ebEovUAgu5zLdFCoN1xnTg0zzOMPNp1nIaB0xLGmqE7ME1UqOO5Vxh4D4+dl9QV4nZ
         Xum3B03Zo5PEnm2zV0u9kbhbbY//Kd47SdK8skJ9DJTltGbxkS5J1BRCSOlZxPO7+1+0
         zEzGxzicpYysJJijcuTGkk3PDMF7ASHWpdTSK5VZQEhzRKrgrr9gYfQYmxoaLQ4347oC
         OeAFiCIMtBmh+lT18pN0vyXdYAsE1DAxj1+pnFh9a2PdM9AsdSf3nUfqvdmTeyjQ6BlF
         zm9hEtJxVb6xbPp6Ef59CfVVR4nKsu+g/dYhbGvS0q0sjQasP03ZzEwWn9VL1OxN+iYB
         rzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DSs7QrMMMqUg/JvzHC8qvmT4dNtx3U4QeCQ6RMTFYFk=;
        b=aYxdY/TsSNKl/ZXbflgfqp0LaNDBbrM0uqfMFmqMWU/RTrQm4iY9YJ3PtIlKvHcH8Q
         rpoJQ8dngxQyj7RVPdCUpS/ZexNrga7co21pJOQ0G3Slr8pE2EIRRkz9LWTr63by++VS
         4gg08VP26MzFBfxgW3vbwbw6+OAlJY5pvvsfwMb8CI1UHVsW/jQx19G9uNpqrgLoMDhr
         /81FZW1m3az1nOXAq/FHzOGNRx5b9m6X7zzQQykv/e/2gSrsMJ0Yo6U28ynZZQMsty58
         8zXVsdUb+rgHhUzUbZWHo9TfkRlFLPTuzdMRb/5sd+3Lp+ZYIqkPkxEcAp+VzSctsJGD
         o1aw==
X-Gm-Message-State: AOUpUlHP4GMr59VayjkHdXXPTiyPoX3IGSsNZwQwzib3/2qDgsfZaNo1
        gAunU3soWOh/vNEAY9BAZpL99u9KgzNcl4ou0pw=
X-Google-Smtp-Source: AAOMgpdayg7ABl8Mk8c+6LpHeO2Q40/w1otU5i+aP0PBcuBHeRzp8jTfrOt13xqr1HGN3D3ZGCDGJL8DSBqKMVj7NHs=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr7906084uai.122.1532330699236;
 Mon, 23 Jul 2018 00:24:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 00:24:58
 -0700 (PDT)
In-Reply-To: <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org> <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Jul 2018 10:24:58 +0300
Message-ID: <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C driver
To:     Peter Rosin <peda@axentia.se>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 9:12 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
>> +             /* Handle the remaining bytes which were not sent */
>> +             while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
>> +                    OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
>
> You moved the OWL_ line to the left instead of right, so this is still
> misaligned and thus not helping the reader.

Guys, wouldn't be better to


while (i2c_dev->msg_ptr < msg->len) {
 u32 fifostat = readl();

 if (!(fifostat & ...))
 break;
...
}

?

Same for the other branch.

Yes, it's more LOCs, but less bikeshedding,

-- 
With Best Regards,
Andy Shevchenko
