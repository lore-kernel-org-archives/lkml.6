Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84DD206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fld8rBR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84DD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeIFOaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:30:24 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32947 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeIFOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:30:24 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so19407840oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEnfbQdQssnPZEjwAc90RMsQaOFDdGItpNqCQ19dKmc=;
        b=fld8rBR1pPY/qa29koPFYsyKjgrYrnK1xMNZ9QEdlUsbKo2Pq0Ki2CCH5iJF6MIEUU
         S525o5Iez/RtZorPvCZ7kbrEVsHWw0W+LwtwYlF2Wwaue+q6Kllt7G2K5lXC7pIS/Pvk
         NiP+IyIvS3l5tg0+a11b//PQnUr1PaEU+CNpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEnfbQdQssnPZEjwAc90RMsQaOFDdGItpNqCQ19dKmc=;
        b=rJLzNyAEaE0dWmd8dI2cDglMWCtRkM2r5c4bU8xtCiVYQTzwzd8DsFZ7whMJn2fdhE
         tWwapw+3qhro5NhffPDEfbcBs8FG1sM4m35RkAdx+iDp3V3dzKigMddKIYoyec0FTGbU
         iIl4N70el52eWWeKHUcAYo5TEsIDyiraBJ5DMgMRu0Xdp2BHPQeClKwcjAax3qEuIm1S
         xAQJoWOrvElVrkp1GrFfSXoNyOMqK3vHqxht3W0qVFzb79sYeMdibOfqp9Upd+SffZo5
         UJX877d6Ft/1PB2m/auWkSmbJ6I+yqrTj3xwPZf4q7ELYOYX8/57IBYu0/G3GZeA6r5m
         z46Q==
X-Gm-Message-State: APzg51BkL85SPWI9VntQgu79YC/B07SdPagn7twbULP6nidJO2QRzkFp
        CVQBK4YCtmDDQTnxiB775ht+ZPNt7hKxpbo+Ss9uqg==
X-Google-Smtp-Source: ANB0Vdb/AE4aODbQ4Jkqk6rR5v5zdErWgqNJO/bAIBa3nbP+X5drnEyHzic/YfMPY9sTN5/qDuqhOaAL6+HkVGO1GwA=
X-Received: by 2002:aca:4d56:: with SMTP id a83-v6mr1845979oib.205.1536227742456;
 Thu, 06 Sep 2018 02:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180718160956.19864-1-enric.balletbo@collabora.com> <CAFqH_50x-HONi0k1sbztPVQQGtCfuP17W-9+zTr3B=JC_CEBrw@mail.gmail.com>
In-Reply-To: <CAFqH_50x-HONi0k1sbztPVQQGtCfuP17W-9+zTr3B=JC_CEBrw@mail.gmail.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Thu, 6 Sep 2018 17:55:29 +0800
Message-ID: <CANLzEks7FX81Ay1bC3zkWYnHYU9cV=9JyffTNg6iR3OXuYHspg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: platform/chrome: some more cleanups between
 these subsystems.
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,
On Mon, Aug 27, 2018 at 6:39 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Lee, Benson,
>
>
> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
> dia dc., 18 de jul. 2018 a les 18:11:
> >
> > Dear Lee, Benson,
> >
> > This is another patchset to try to cleanup a bit more the interaction
> > between the mfd subsystem and platform/chrome.
> >
> > The first patch moves some cros-ec include files from include/linux/mfd to
> > platform/chrome. They are specific to the lpc transport driver and are not
> > related to the mfd subsystem, so, there is no reason to have them living
> > in include/linux/mfd.
> >
> > The second patch tries to cleanup and fix some kerneldoc commments in
> > the remaining mfd/cros-ec include files. For now I only improved a bit
> > the documentation and fixed the warnings reported by kerneldoc. I think
> > that there is still a lot of improvement pending, specially in the
> > cros_ec_commands.h file, but this is something I'd like to have the
> > agreement of the chromeos folks as I know this file is used as interface
> > for the EC firmware. As far as I know the kernel doesn't cares about this,
> > but I know this is source of conflicts for the chromeos folks.
> > Usually, in the chromeos kernel, the cros_ec_commands file is synced
> > with the version available from the EC firmware but maybe we should
> > reconsider this and have a well documented file in the kernel and sync
> > in the other way. I am just thinking out loud.
> >
> > Best regards,
> >  Enric
> >
> >
> > Enric Balletbo i Serra (2):
> >   platform/chrome: Move mfd/cros_ec_lpc* includes to drivers/platform.
> >   mfd: cros_ec: Fix and improve kerneldoc comments.
> >
> >  drivers/mfd/cros_ec_dev.h                     |  13 +-
> >  drivers/platform/chrome/cros_ec_lpc.c         |   3 +-
> >  drivers/platform/chrome/cros_ec_lpc_mec.c     |   3 +-
> >  .../platform/chrome}/cros_ec_lpc_mec.h        |   6 +-
> >  drivers/platform/chrome/cros_ec_lpc_reg.c     |   3 +-
> >  .../platform/chrome}/cros_ec_lpc_reg.h        |   6 +-
> >  include/linux/mfd/cros_ec.h                   | 214 +++++++------
> >  include/linux/mfd/cros_ec_commands.h          | 295 +++++++++++-------
> >  8 files changed, 322 insertions(+), 221 deletions(-)
> >  rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_mec.h (96%)
> >  rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_reg.h (94%)
> >
>
> Now that rc1 was released, a gentle ping for if you can take in
> consideration these patches for 4.20.
>

Sorry for the delay. I can review these for 4.20. I'll let you know if
I have any questions.


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
