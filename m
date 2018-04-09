Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeDIS3W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:29:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45280 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeDIS3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:29:20 -0400
X-Google-Smtp-Source: AIpwx4+bGpTmj1l0l/CM8/CqMmHVvMJI3tVbx1HY3FkPMJiJwjInz5xMl/RR2HmxBJ8CrVWgLzWg3g==
Date: Mon, 9 Apr 2018 11:29:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
Message-ID: <20180409182917.GA20731@roeck-us.net>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <20180408073435.i5nq2ngx2fslaz6a@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408073435.i5nq2ngx2fslaz6a@katana>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 09:34:36AM +0200, Wolfram Sang wrote:
> Hi,
> 
> On Mon, Mar 19, 2018 at 09:10:58AM -0700, Guenter Roeck wrote:
> > Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
> > I2C device id") added a function to return the standard I2C device ID.
> > Use that function to verify the device ID of a given device.
> 
> I am very open to these patches, just...
> 
> > 
> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > RFC:
> > - Compile tested only
> 
> ... I would really like to have them tested. After that happened, Peter
> and I can figure out who should apply them for seamless upstreaming.
> 

Patch 2/2 was for real HW. I don't have access to such HW right now.
Guess we'll have to wait until someone does, unless Adrian is willing
to test it.

> > - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
> >   against all parts from a given manufacturer ?
> 
> Can't we just add it when we need it?
> 
Perfectly fine with me.

> > +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
> > +			real_id.manufacturer_id, real_id.part_id,
> > +			real_id.die_revision);
> > +		return -ENODEV;
> 
> I wonder about the ERR loglevel. ENODEV is not an error, I'd think?
> 
2d74187d5b4e, where this is derived from, uses dev_warn() instead,
so that may be a better choice.

Thanks,
Guenter

> Regards,
> 
>    Wolfram
> 
