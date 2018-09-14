Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A014C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD2220853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6QzEXE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD2220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeINHAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:00:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39903 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeINHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:00:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so3413228plp.6;
        Thu, 13 Sep 2018 18:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NVEVZoCzZdFFLU05M6zis4bp+Mod459xea44PwH48sA=;
        b=C6QzEXE/NGDCLT8ieUnknOD4tT0a2rM8fZFIDdkK5N5yQnVADS9TQGcnO+rHC2ulcO
         C83C54VA+kGd+IrD0riQp68cy094Fzh2ZSHSNzvZETMCKteO3yhQUC2eO9N2VBIufZtE
         iQApKffZr4kW9tq4hKd22/n1abezpk85/Po1634pOERF/p4BGjQj4OQyM6LvEid4uF9p
         uvrqNst1doGj2Yle4ysiq2vJGWMOTg18U2Bx2n75hl/RUPL5+yUmuPT5kJjToF93qves
         EtKp3ARLzso9WF1RYuqGuS+XSqK3TUGPIslVrznm/50on9wMVkV/J9fdhVAz9TXAOQpk
         q5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NVEVZoCzZdFFLU05M6zis4bp+Mod459xea44PwH48sA=;
        b=KKXx19aFhlB1pAtl3KhZntc3PIhXkJd8zjz33SghKUD3Ejo3wzLhUGadniafbaGmCw
         glwuTCX0xkkZqnzw/qCZiJT/DcrHGYP+au5p4imlFCBqE8XhRJWVFEe/kbX+tyNGGcga
         nxPEF54YIf38DP05/9fpSzWdQPk+m2gWRU/05jrY/yg27vE2g7xRNM+FZs8/t/gzZRkO
         NA6jTtR0lN3Pr+5D3sm4UKKDYLP3PYd76jJiEjvXH0Q3kJz2MA9F6uzPk+95x0A9l18f
         9jcqNKy3zY9XeLmPGi6dfCH0soUGmxFwx7FCB+IxKQL1rumzrhmckkQgp0Wp5Jr72meK
         r/Kg==
X-Gm-Message-State: APzg51Bt+xO3wXdKTb+LqnpWKI2w03qCx2/Taqj3VueV9xMDWuqxaz4i
        Elhpx0Ofq8kpsK37APbsXLI=
X-Google-Smtp-Source: ANB0VdadsACDSgytLHa3iytkVQeTxrrbhjB/kiui/yaF5YohbcjkbvvjHOzi7kF3UWugT2ZjKruMlg==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37-v6mr9646765plb.290.1536889693375;
        Thu, 13 Sep 2018 18:48:13 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id q80-v6sm7336889pfd.15.2018.09.13.18.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 18:48:12 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
Date:   Fri, 14 Sep 2018 09:48:06 +0800
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: lidar-v2: replace i2c block access
 method with the one already implemented.
Message-ID: <20180914014806.GA25667@Eros>
References: <20180913035145.28056-1-songqiang.1304521@gmail.com>
 <CAJCx=gk3Md910hfD2ZiTRNj6mv1nf+r6p_0tYMu7uKiEp4ZvOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCx=gk3Md910hfD2ZiTRNj6mv1nf+r6p_0tYMu7uKiEp4ZvOw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 02:43:35PM -0700, Matt Ranostay wrote:
> On Wed, Sep 12, 2018 at 8:51 PM Song Qiang <songqiang1304521@gmail.com> wrote:
> >
> > This driver tries to access a block of data on a i2c bus and it tries
> > to manually make a device command frame and a consecutively read frame,
> > then uses i2c_transfer() to read data. But this has already been
> > implemented in i2c_smbus_read_i2c_block_data().
> > Sorry for not having this device by my hand, which is a little expansive
> > for me, but I have another i2c device and tested with both i2c_transfer()
> > and i2c_smbus_read_i2c_block_data() and they all ends the same.
> > I'm not familiar with the SMBus, don't know if the lidar_smbus_xfer()
> > function is the same as i2c_smbus_read_block_data()? The original code
> > is commented with something I'm not sure, but I think if it's a standard
> > SMBus, it should be able to use in here.
> > Hoping for someone to explain.
> >
> 
> Yes actually there is a reason for this insanity!
> 
> It isn't actually SMBUS (note the lidar_smbus_xfer function below it)
> and has a odd way to read registers via I2C.
> Basically the I2C_M_STOP flags is the reason you can use the standard
> i2c_smbus_read_i2c_block_data().
> 
> Page 6 in this datasheet
> * http://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf
> 
> > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> > ---
> >  .../iio/proximity/pulsedlight-lidar-lite-v2.c  | 18 +-----------------
> >  1 file changed, 1 insertion(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > index 47af54f14756..ca880ba8e820 100644
> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > @@ -63,23 +63,7 @@ static const struct iio_chan_spec lidar_channels[] = {
> >
> >  static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
> >  {
> > -       struct i2c_client *client = data->client;
> > -       struct i2c_msg msg[2];
> > -       int ret;
> > -
> > -       msg[0].addr = client->addr;
> > -       msg[0].flags = client->flags | I2C_M_STOP;
> > -       msg[0].len = 1;
> > -       msg[0].buf  = (char *) &reg;
> > -
> > -       msg[1].addr = client->addr;
> > -       msg[1].flags = client->flags | I2C_M_RD;
> > -       msg[1].len = len;
> > -       msg[1].buf = (char *) val;
> > -
> > -       ret = i2c_transfer(client->adapter, msg, 2);
> > -
> > -       return (ret == 2) ? 0 : -EIO;
> > +       return i2c_smbus_read_i2c_block_data(data->client, reg, len, val);
> >  }
> >
> >  static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
> > --
> > 2.17.1
> >

Hi Matt,

Thanks for the explanition, now I understand why we have to use
lidar_smbus_xfer() here.
So we can use the standard i2c_smbus_read_i2c_block_data() here?
I'm thinking since you are the author it seems like you have the
hardware, would you mind to test if it's working? I'd appriciate
that.

yours,
Song Qiang
