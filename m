Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0F2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsuBJSSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfBRGdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:33:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfBRGdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:33:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so15901784wrw.6;
        Sun, 17 Feb 2019 22:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHCudiFBm/jzc4dvlgpQ6a7QXYNqY+987pMivWSoyZk=;
        b=MsuBJSSIeGgjQ4zYmV+EZjNnmbGHHojlgGczNswkGXwu0B4rIDZPxsA/6sw8qgKGGf
         cl4UfWzzTI6FuCdus+pjdvyCvxRCBy0piyk4m2aLS3397+CFimVmpr5SZY35RMkLnZOR
         +h4xvo2/wVfLE/slwcsV1/l/P8a3C5btMH9vojNYTxKRno7Vdrtbzd76TD9488etd4QG
         clA+74fnpq0udhTPc6J2HuFx6cpthej1G+53oSbXt90fLUAKlfpOgQc+uYXbSZfUiYkP
         YA5GLZT2YKm4+nNjBVJbgd1jokCfFKqSd4MSUjQTughbcKQAtPKZ7DBSfw7ffEEjStu/
         3yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHCudiFBm/jzc4dvlgpQ6a7QXYNqY+987pMivWSoyZk=;
        b=We7Rnk8aPZ2tmvRs7vgoj6AoZISnjk0hK2+qPRkWp4Q5dg9FfHl+YWNFUdav8NhVqf
         FdOlvSyfNHqgJ7x42wvk58xt/sQ+b1oVspho51XlIJCzfeWnW9TSd1CUzgZR1MDkNhwj
         wwrDs2EaeaLWM8lxTdhtyO54Mk9pHboFq0QzPdxBRCx6Te5QblMVY0KMaqlrsfkdw16r
         biMJiMu3bfB/94fGMoCBnFIC5md4kEi2NRbl5b/DpeAHqGPh4bgMmpaaTJUY/QVKUJ/b
         mNXo1PJeH5PFZ40aqgwvXAf2xCNHlVsEJD2q0q4LOVzgrNvWemN9cFL0JClv1mcv67U7
         UxQw==
X-Gm-Message-State: AHQUAubG8OZgrin+I02q1yhm3QE1wEulSSFpLNJ6s+Uoh7UcgbEX6Nxd
        7Ap/GYTNeU0Re3Lj9KusgGEQGB93ND/6oOQwPkY=
X-Google-Smtp-Source: AHgI3IZcK0dDAbxkgTlyAFkQYAFnhrQ7YmZYsv9JLwv9GzCKowKM7c0tSc7Z7lD7up9wZg7Gm57L1zDnbjgxin31PrU=
X-Received: by 2002:adf:cd87:: with SMTP id q7mr16476213wrj.92.1550471609085;
 Sun, 17 Feb 2019 22:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20190129195214.30272-1-sxauwsk@163.com> <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
 <2019021615501780626817@163.com>
In-Reply-To: <2019021615501780626817@163.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Mon, 18 Feb 2019 12:03:18 +0530
Message-ID: <CAKfKVtGu3dzSR71-Rsp8SR8nq8-XhY5FrgDvxv9iu_L-TyL5+Q@mail.gmail.com>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive error interrupts
To:     "sxauwsk@163.com" <sxauwsk@163.com>
Cc:     "michal.simek" <michal.simek@xilinx.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
On Sat, Feb 16, 2019 at 1:21 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
>
> >Hi Sxauwsk,
> >
> >On Wed, Jan 30, 2019 at 3:13 PM sxauwsk <sxauwsk@163.com> wrote:
> >>
> >> When the adapter receive error interrupts, such as NACK, arbitration lost,
> >> cdns_i2c_master_xfer return to the caller directly instead of resuming
> >> the adapter which resulted in the adapter being out of control.
> >>
> >> So when driver detect err_status then try to repair and fix it.
> >>
> >> Signed-off-by: sxauwsk <sxauwsk@163.com>
> >> ---
> >>  drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> >> index b13605718291..e10048d7524a 100644
> >> --- a/drivers/i2c/busses/i2c-cadence.c
> >> +++ b/drivers/i2c/busses/i2c-cadence.c
> >> @@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
> >>         cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
> >>                           CDNS_I2C_IDR_OFFSET);
> >>
> >> -       /* If it is bus arbitration error, try again */
> >> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> >> -               return -EAGAIN;
> >> -
> >>         return 0;
> >>  }
> >>
> >> @@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >>                         id->bus_hold_flag = 0;
> >>
> >>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> >> -               if (ret)
> >> +               if (!ret)
> >>                         goto out;
> >>
> >In case  the Arbitration error happend  the cdns_i2c_process_msg would return 0
> >and we will miss the check  below.
> >
> >Am I missing something ?
> >
> >>                 /* Report the other error interrupts to application */
> >>                 if (id->err_status) {
> >>                         cdns_i2c_master_reset(adap);
> >>
> >> +                       /* If it is bus arbitration error, try again */
> >> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> >> +                               ret = -EAGAIN;
> >> +                               goto out;
> >> +                       }
> >> +
> >>                         if (id->err_status & CDNS_I2C_IXR_NACK) {
> >>                                 ret = -ENXIO;
> >>                                 goto out;
> >> --
> >> 2.19.2
> >>
> >>
>
> In cdns_i2c_process_msg process, when detect arbitration lost error return -EAGAIN to  cdns_i2c_master_xfer,  not return 0
> that mean cdns_i2c_process_msg  just go out ignore error check and  problem occur, So we should do something when arbitration error detect.

Arbitration lost is fine how about other errors like NACK.
