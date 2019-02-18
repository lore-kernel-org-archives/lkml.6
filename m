Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3039218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWBZCA5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfBRH71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:59:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46785 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfBRH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:59:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so8957860wrs.13;
        Sun, 17 Feb 2019 23:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFe9jHX1HoWKU6FMk5WMii4IqtK2zof/9fuLaWJERV4=;
        b=HWBZCA5pfGGENevoLmdMKxYCCXasF0r78JIHjqLOuLTtdQdw/g6i5Pg8FV0MSjfFnU
         SCUuacO6uSw1lzOqn4P+LQYDgf5ppcFBYO0ZACKVSI5PIsnVFVniQlWKhGTavSbbNmqn
         02ag7wchNxBw7bxIhetlvvb1Em5PW55J0/v2obfTi/+Y6qozA9VIm9ktvPiLUcve7Ai+
         438saAYNPgr1ocPhyLhs5R6RpiwxTv5vUmvGOeWPi1E8S5psHCsf+JQbQ7bc17+8R02Q
         1CfUgzXcsR2VGsIsqfdccUis9xU7PZc3g9V1HCTOc5p27JUva1f/85vUmBRExQ8apvS0
         xsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFe9jHX1HoWKU6FMk5WMii4IqtK2zof/9fuLaWJERV4=;
        b=cdi/F8Ov9n0CPRRUeqknP7MtKFGDUo+fy1P6JsfKbTaX5kTkIMoSAYWjKeNFve8hd5
         YczYcpd3krcSaT7IqiOfp4C3P9vDr3+6aPsJiGNweSlI5rZANLOtVheQ50CCy1tMA5Lx
         f9OCfCqJ8MCGMpO8BGQXrdy13/M8I65H4vzSqk9mSjhL+/cIy5eciD3FnllZAqGPu/F8
         brJf/jJCsjVbjDItXm7ZoCtTE8WmIBP/KuI7UTTdlSQEVZFTDjkSE7B7EqXDz4H0Zog/
         RP7F2zxzjTqXNC9J2saysGLsVDSRJ/rxS5BOmDJhlDcvqBAgr8BgJriiKeh6+8NUfOrj
         Z2MQ==
X-Gm-Message-State: AHQUAuYOzsnJ1CB3wd3K3l19U44HpHtUs/LDEh+huWDEwonE2wYovfh4
        PLr5wrdOnIEjRu4pgHUoSI8zH+9XfsJD1s5Or19uqg==
X-Google-Smtp-Source: AHgI3IZgCo+GoduJYr+RXl7qY26d13sbMdRcyVlbVNRfmJd5jyZrmSXQV5by647b8pIYR6W0F5ShsSqc0d65HOcfk4w=
X-Received: by 2002:a5d:4147:: with SMTP id c7mr16597764wrq.235.1550476761629;
 Sun, 17 Feb 2019 23:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20190129195214.30272-1-sxauwsk@163.com> <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
 <2019021615501780626817@163.com> <CAKfKVtGu3dzSR71-Rsp8SR8nq8-XhY5FrgDvxv9iu_L-TyL5+Q@mail.gmail.com>
 <2019021815163582329937@163.com>
In-Reply-To: <2019021815163582329937@163.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Mon, 18 Feb 2019 13:29:10 +0530
Message-ID: <CAKfKVtH7Sui0RWTk_unh3vfbtC7b_CnqAjmMF5s3fPHccRnYsw@mail.gmail.com>
Subject: Re: Re: [PATCH] i2c: cadence: try reset when master receive error interrupts
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

On Mon, Feb 18, 2019 at 12:48 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
>
> Hi , Shubhrajyoti
>
> >Hi ,
> >On Sat, Feb 16, 2019 at 1:21 PM sxauwsk@163.com <sxauwsk@163.com> wrote:
> >>
> >> >Hi Sxauwsk,
> >> >
> >> >On Wed, Jan 30, 2019 at 3:13 PM sxauwsk <sxauwsk@163.com> wrote:
> >> >>
> >> >> When the adapter receive error interrupts, such as NACK, arbitration lost,
> >> >> cdns_i2c_master_xfer return to the caller directly instead of resuming
> >> >> the adapter which resulted in the adapter being out of control.
> >> >>
> >> >> So when driver detect err_status then try to repair and fix it.
> >> >>
> >> >> Signed-off-by: sxauwsk <sxauwsk@163.com>
> >> >> ---
> >> >>  drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
> >> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> >> >> index b13605718291..e10048d7524a 100644
> >> >> --- a/drivers/i2c/busses/i2c-cadence.c
> >> >> +++ b/drivers/i2c/busses/i2c-cadence.c
> >> >> @@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
> >> >>         cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
> >> >>                           CDNS_I2C_IDR_OFFSET);
> >> >>
> >> >> -       /* If it is bus arbitration error, try again */
> >> >> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> >> >> -               return -EAGAIN;
> >> >> -
> >> >>         return 0;
> >> >>  }
> >> >>
> >> >> @@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> >> >>                         id->bus_hold_flag = 0;
> >> >>
> >> >>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> >> >> -               if (ret)
> >> >> +               if (!ret)
> >> >>                         goto out;
> >> >>
> >> >In case  the Arbitration error happend  the cdns_i2c_process_msg would return 0
> >> >and we will miss the check  below.
> >> >
> >> >Am I missing something ?
> >> >
> >> >>                 /* Report the other error interrupts to application */
> >> >>                 if (id->err_status) {
> >> >>                         cdns_i2c_master_reset(adap);
> >> >>
> >> >> +                       /* If it is bus arbitration error, try again */
> >> >> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> >> >> +                               ret = -EAGAIN;
> >> >> +                               goto out;
> >> >> +                       }
> >> >> +
> >> >>                         if (id->err_status & CDNS_I2C_IXR_NACK) {
> >> >>                                 ret = -ENXIO;
> >> >>                                 goto out;
> >> >> --
> >> >> 2.19.2
> >> >>
> >> >>
> >>
> >> In cdns_i2c_process_msg process, when detect arbitration lost error return -EAGAIN to  cdns_i2c_master_xfer,  not return 0
> >> that mean cdns_i2c_process_msg  just go out ignore error check and  problem occur, So we should do something when arbitration error detect.
> >
> >Arbitration lost is fine how about other errors like NACK.
>
> >> >>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> >> >> -               if (ret)
> >> >> +               if (!ret)
> >> >>                         goto out;
>
> Yes, you're right,  This place I should't make any change,  perfect solution!
>
> >> >>
> >> >> -       /* If it is bus arbitration error, try again */
> >> >> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> >> >> -               return -EAGAIN;
> >> >> -
> >> >>         return 0;
> >> >>  }
>
>
> >> >>                 /* Report the other error interrupts to application */
> >> >>                 if (id->err_status) {
> >> >>                         cdns_i2c_master_reset(adap);
> >> >>
> >> >> +                       /* If it is bus arbitration error, try again */
> >> >> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> >> >> +                               ret = -EAGAIN;
> >> >> +                               goto out;
> >> >> +                       }
> >> >> +
>
> Maybe Just remove Arbitration lost Detect part from  cdns_i2c_process_msg function,  then add to cdns_i2c_master_xfer,  Do you think?

I agree.
>
>
>
>
