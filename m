Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCABC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075D520700
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2j4FrA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075D520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLHPdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:33:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33714 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLHPdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:33:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so3346473pfb.0;
        Sat, 08 Dec 2018 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tt8+KB3NW2GbzNWfjDFSSXwO839XfkXfkEX/jHuieY4=;
        b=S2j4FrA81UBY6pa7mX3UNEVBzO+p0Tc9o0/Jhd5ujNjrevCxG1rpAIQx6k9GUBKNbb
         Vvd1Jiqhsj7xFvKV1JwC2gtCQAZ5JPPj8biwJ74PGJr8jgz6QQ6Yqp4rMYwTy0A8TJya
         gSM32UnJsPy5R9/nc4K0shp/kCSqV0vWQ4IwT3nNvqvDg+YMTOR9eE/TBX8Ka5Yj08pN
         afrpf4GdHfzFGv60iP0sEtU3Gcx/73FcGje5E3WlqasD7ikL7JW9WS2IfJlSGJ67MWBi
         6apGXn41UVxV6X/8oat8zbziv9TOdzzd868hLQdBcEbTBTF74vm19thNtzqWYxqMSwpF
         T8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tt8+KB3NW2GbzNWfjDFSSXwO839XfkXfkEX/jHuieY4=;
        b=Yg17+ssVpofKkk6haUfvED4OD1MrEmQE/KC2/iYegVcWo5E4yqMcicbbQBNvXO2zzc
         OEE50rY0zdaMXbfd/jcpVwZCa23vLXvdD0YCyucdvwBxuDWkmK3cEgL5dcHq1WVdgrcn
         YMXgm8bYh+aDgXkY8+6mrTMEq08VMH363x44rPxFfppWyGyoFQloz5G/2d/JBUL90lQw
         7Ito/OgRPh+kRBvGHAz9YcempIk9UFw56sGu9rPKd+hQaOP6SI+bjK+epZ6DF9W5GhzC
         RrdRSb07PDF5RDU8V64Wgnr3AwgcyBNIo2hKgE2uDRztdu/3nScuMwQqeqd+b/jHB17c
         i/cw==
X-Gm-Message-State: AA+aEWaryv9/RY/U1Mc1dLRNcr3GWn2JBDeX2H/akyzwzdcEbiKUf6uh
        jGWcdUW9BQZ4RK3mvuw5MtxyzkrE
X-Google-Smtp-Source: AFSGD/VA2s2s0gNj514jh/6nC2eQAjW7LQupDLOW1lSRJIWhSlpsn9IctUuH5U04422HAkwUC9Axcw==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr5422921pgt.260.1544283231886;
        Sat, 08 Dec 2018 07:33:51 -0800 (PST)
Received: from Shreeya-Patel ([103.212.140.153])
        by smtp.googlemail.com with ESMTPSA id s37sm7401173pgm.19.2018.12.08.07.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 07:33:51 -0800 (PST)
Message-ID: <4a96719b2b779db0990a370e6fa05c83a089ae1a.camel@gmail.com>
Subject: Re: [PATCH] Revert "Staging: iio: adt7316: Add an extra check for
 'ret' equals to 0"
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeremy Fertic <jeremyfertic@gmail.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Date:   Sat, 08 Dec 2018 21:03:46 +0530
In-Reply-To: <20181208111720.068822f9@archlinux>
References: <20181205014900.4827-1-jeremyfertic@gmail.com>
         <fccdb26936a9cfcd5134c760cd918929ad3dfa19.camel@gmail.com>
         <20181205215953.GA2365@r2700x.localdomain>
         <20181206124047.GH3095@unbuntlaptop>
         <90e3066edb0616cd20ee019e3f2a392fd3a3f285.camel@gmail.com>
         <20181208111720.068822f9@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-08 at 11:17 +0000, Jonathan Cameron wrote:
> On Sat, 08 Dec 2018 00:07:21 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > On Thu, 2018-12-06 at 15:40 +0300, Dan Carpenter wrote:
> > > On Wed, Dec 05, 2018 at 02:59:53PM -0700, Jeremy Fertic wrote:  
> > > > On Thu, Dec 06, 2018 at 01:25:55AM +0530, Shreeya Patel
> > > > wrote:  
> > > > > On Tue, 2018-12-04 at 18:49 -0700, Jeremy Fertic wrote:  
> > > > > > This reverts commit
> > > > > > 00426e99789357dbff7e719a092ce36a3ce49d94.
> > > > > > 
> > > > > > i2c_smbus_read_byte() returns 0 when a byte with the value
> > > > > > 0 is
> > > > > > read
> > > > > > from
> > > > > > the device. This is a valid read so revert the check for 0.
> > > > > > 
> > > > > > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> > > > > > ---  
> > > > > 
> > > > > Hi Jeremy,
> > > > > 
> > > > > As per my understanding, 0 value indicates no error but no
> > > > > data
> > > > > read.
> > > > > Then how can this be a valid case?
> > > > > 
> > > > > Can you please make me understand that how can we consider
> > > > > this
> > > > > as a
> > > > > valid case even when no data has been read?  
> > > 
> > > It's not reading no data.  It's reading one byte of data and
> > > returning
> > > it.
> > >   
> > > > > 
> > > > > 
> > > > > Thanks  
> > > > 
> > > > I'm not sure I understand why the value 0 would indicate no
> > > > data
> > > > read.
> > > > Doesn't that just mean a byte was read with the value 0.  
> > > 
> > > Yes.  It does mean that.  Please don't ask rhetorical
> > > questions...  :(
> > > This list is full of people who can't resist answering every
> > > question.
> > >   
> > > > For instance, if the input to the adc is 0V. Can you point me
> > > > to
> > > > where
> > > > you're seeing that this would indicate no data read?  
> > > 
> > > drivers/i2c/i2c-core-smbus.c
> > >     88  /**
> > >     89   * i2c_smbus_read_byte - SMBus "receive byte" protocol
> > >     90   * @client: Handle to slave device
> > >     91   *
> > >     92   * This executes the SMBus "receive byte" protocol,
> > > returning
> > > negative errno
> > >     93   * else the byte received from the device.
> > >     94   */
> > >     95  s32 i2c_smbus_read_byte(const struct i2c_client *client)
> > >     96  {
> > >     97          union i2c_smbus_data data;
> > >     98          int status;
> > >     99  
> > >    100          status = i2c_smbus_xfer(client->adapter,
> > > client-  
> > > > addr, client->flags,  
> > > 
> > >    101                                  I2C_SMBUS_READ, 0,
> > >    102                                  I2C_SMBUS_BYTE, &data);
> > >    103          return (status < 0) ? status : data.byte;
> > >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >    104  }
> > >    105  EXPORT_SYMBOL(i2c_smbus_read_byte);  
> > 
> > Even I had sent the same code to Jonathan and we had a discussion
> > on
> > this. 
> > I asked him that this code clearly shows that there is an error
> > condition only when status < 0 then why do we need a check for
> > status =
> > 0.
> > 
> > Then he explained me that 0 isn't an error. The issue is the
> > silliness
> > of the i2c interface.
> > 
> > Pretty much every other bus returns an error (negative) if less
> > data is
> > received than expected.  Most i2c
> > bus master's do as well but in theory it can return 0 to indicate
> > no
> > error but no data read (which doesn't make any sense)
> > 
> > 0 doesn't ever happen in reality but it should be handled for
> > correctness though.
> > 
> > So we should wait for what Jonathan has to say on this :)
> 
> Yup, I was being an idiot.  Sorry about that!  For some reason I'd
> gotten it into my head that the particular function we were talking
> about was i2c_master_send which does indeed do as discussed above.
> 
> Apologies for misleading you on this. Definitely a proper idiot
> moment of me not reading what the code actually was properly, even
> when you questioned what I was going on about.

It was not your mistake!
There was a confusion because of delay in replying to you from my side.
So it was just the case of human error :)

> 
> Thanks to Jeremy for catching this one.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 
> Jonathan
> 
> > 
> > Thanks
> > 
> > > You are right.  Commit 00426e997893 ("Staging: iio: adt7316: Add
> > > an
> > > extra check for 'ret' equals to 0") needs to be reverted...
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > >   
> 
> 
