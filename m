Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB01C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64A020892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544267848;
	bh=Ye96Xmhtk8Yuga9ks/JGcX/UBHFfWA8u7V66vGiV91U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JLSsc0rG3olbxgjH/oCoBn+Ur1nzhbVOU2tFOxw75nLR4M+YSpIInABDzQB7NeEvv
	 q0gp92ly4fnWboP7Xb4Y6rD9EOL+EbQwvzCpZSceK6EcuEeuaKlMvykHNn8n0dxae4
	 5l7BiUIE13nts6c12FYaAdZ3zS9WlYJm2x3/vGNQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64A020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLHLR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHLR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:17:26 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6644E20661;
        Sat,  8 Dec 2018 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544267845;
        bh=Ye96Xmhtk8Yuga9ks/JGcX/UBHFfWA8u7V66vGiV91U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=js14xh+mjo9TdrKVc+4gK2+6SEEUApp7k4JObpr1sHE+aziu7g7KHLzwRLMGaeS9g
         Pu8cwDiV21M7Z0xZBGn1XjZs8WF2xU9CcUfW/eVsKJzfLnPd1T+ksZRCBjDZ0OyS29
         iK4Q618yKxMpdsgeM96dV0KKtXaxiPaPlJI9uXR8=
Date:   Sat, 8 Dec 2018 11:17:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeremy Fertic <jeremyfertic@gmail.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH] Revert "Staging: iio: adt7316: Add an extra check for
 'ret' equals to 0"
Message-ID: <20181208111720.068822f9@archlinux>
In-Reply-To: <90e3066edb0616cd20ee019e3f2a392fd3a3f285.camel@gmail.com>
References: <20181205014900.4827-1-jeremyfertic@gmail.com>
        <fccdb26936a9cfcd5134c760cd918929ad3dfa19.camel@gmail.com>
        <20181205215953.GA2365@r2700x.localdomain>
        <20181206124047.GH3095@unbuntlaptop>
        <90e3066edb0616cd20ee019e3f2a392fd3a3f285.camel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2018 00:07:21 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Thu, 2018-12-06 at 15:40 +0300, Dan Carpenter wrote:
> > On Wed, Dec 05, 2018 at 02:59:53PM -0700, Jeremy Fertic wrote:  
> > > On Thu, Dec 06, 2018 at 01:25:55AM +0530, Shreeya Patel wrote:  
> > > > On Tue, 2018-12-04 at 18:49 -0700, Jeremy Fertic wrote:  
> > > > > This reverts commit 00426e99789357dbff7e719a092ce36a3ce49d94.
> > > > > 
> > > > > i2c_smbus_read_byte() returns 0 when a byte with the value 0 is
> > > > > read
> > > > > from
> > > > > the device. This is a valid read so revert the check for 0.
> > > > > 
> > > > > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> > > > > ---  
> > > > 
> > > > Hi Jeremy,
> > > > 
> > > > As per my understanding, 0 value indicates no error but no data
> > > > read.
> > > > Then how can this be a valid case?
> > > > 
> > > > Can you please make me understand that how can we consider this
> > > > as a
> > > > valid case even when no data has been read?  
> > 
> > It's not reading no data.  It's reading one byte of data and
> > returning
> > it.
> >   
> > > > 
> > > > 
> > > > Thanks  
> > > 
> > > I'm not sure I understand why the value 0 would indicate no data
> > > read.
> > > Doesn't that just mean a byte was read with the value 0.  
> > 
> > Yes.  It does mean that.  Please don't ask rhetorical
> > questions...  :(
> > This list is full of people who can't resist answering every
> > question.
> >   
> > > For instance, if the input to the adc is 0V. Can you point me to
> > > where
> > > you're seeing that this would indicate no data read?  
> > 
> > drivers/i2c/i2c-core-smbus.c
> >     88  /**
> >     89   * i2c_smbus_read_byte - SMBus "receive byte" protocol
> >     90   * @client: Handle to slave device
> >     91   *
> >     92   * This executes the SMBus "receive byte" protocol, returning
> > negative errno
> >     93   * else the byte received from the device.
> >     94   */
> >     95  s32 i2c_smbus_read_byte(const struct i2c_client *client)
> >     96  {
> >     97          union i2c_smbus_data data;
> >     98          int status;
> >     99  
> >    100          status = i2c_smbus_xfer(client->adapter, client-  
> > >addr, client->flags,  
> >    101                                  I2C_SMBUS_READ, 0,
> >    102                                  I2C_SMBUS_BYTE, &data);
> >    103          return (status < 0) ? status : data.byte;
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >    104  }
> >    105  EXPORT_SYMBOL(i2c_smbus_read_byte);  
> 
> Even I had sent the same code to Jonathan and we had a discussion on
> this. 
> I asked him that this code clearly shows that there is an error
> condition only when status < 0 then why do we need a check for status =
> 0.
> 
> Then he explained me that 0 isn't an error. The issue is the silliness
> of the i2c interface.
> 
> Pretty much every other bus returns an error (negative) if less data is
> received than expected.  Most i2c
> bus master's do as well but in theory it can return 0 to indicate no
> error but no data read (which doesn't make any sense)
> 
> 0 doesn't ever happen in reality but it should be handled for
> correctness though.
> 
> So we should wait for what Jonathan has to say on this :)

Yup, I was being an idiot.  Sorry about that!  For some reason I'd
gotten it into my head that the particular function we were talking
about was i2c_master_send which does indeed do as discussed above.

Apologies for misleading you on this. Definitely a proper idiot
moment of me not reading what the code actually was properly, even
when you questioned what I was going on about.

Thanks to Jeremy for catching this one.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Jonathan

> 
> Thanks
> 
> > You are right.  Commit 00426e997893 ("Staging: iio: adt7316: Add an
> > extra check for 'ret' equals to 0") needs to be reverted...
> > 
> > regards,
> > dan carpenter
> > 
> >   

