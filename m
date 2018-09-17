Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90B0ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73182214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzJmfrbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73182214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeIQNEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:04:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43000 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIQNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:04:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so6994680plq.9;
        Mon, 17 Sep 2018 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aZgRiGQjRBQVs6cGrzCer3nNIY55Cpl4xvLWUjPexJI=;
        b=tzJmfrbLPW0CpHvcpJbq43738kO7NpctMUHtpPufFePztkE0zl/mEsz7khXuzZNfcM
         p2hBE5chl/KQlHjN/ThU9DExEZ9V+yXFw30VS7WFqplBFyXetCnly0tmbSxXq74grXsZ
         k2Avkejgviu1C6z2lPJWf+lkng7BSUIu0W/VP1HUJsGsOIjjxNl3coLjky9ONT0FY/Kg
         K/UKya2TfJslImoc/4ECt2L+2WvbkJ1rZZbV1hRrroPSx1SNGWmvKVydHhmhfEy391Vq
         8gMSd/E33Wg6Ga4h+UUDUzCTwfJbzwW+6xV0kR3VaXJl08vCiAuEqi0n1kpbhcmNXM1M
         nTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aZgRiGQjRBQVs6cGrzCer3nNIY55Cpl4xvLWUjPexJI=;
        b=GjJ9s8J1xa3+RhEj94E2yIPQpFHlIPsEfBWW3Cl6oiMVhH+FtFgU965Jof38Ms25Vr
         chKczaTdCHqsRNn8a7eyJ0VyFiBzI0V7N9MdQ2WWYbfqY66S5YOEpqdj2kJK00AUQFIL
         T51n6BjgJ15qrd32ukwQ4UUmA6fqgGGQiLnaenAuTv4n/5DK69Cx3PFxwKEobaxAYake
         HknMpnigjAc/OcDIsJVMiGnpaZy4X81xiDpmXLd1AwecHbARkug6FPXQh2ByIFglhXMC
         cAaV8gOmYNQkywN76SlNITUbD7ZH30pCbh64ld98DwzztDqwAHmyz1ZkB5dBFURtJZOq
         2YSA==
X-Gm-Message-State: APzg51CUB6R06mXoSnWrncdECEPPAweBkxVTtFeMgKVCsLHvN68LZpvY
        07+6FfY5INCoONgJ0A9iuMfkxD+NqbQ=
X-Google-Smtp-Source: ANB0Vdb0KCCT8+sWdxwd1rkMxzBejSTgWRlcbCdzT77+RBhT8ZbeUQaXAYI1MTnia7I4isokjRigNQ==
X-Received: by 2002:a17:902:bb85:: with SMTP id m5-v6mr23466255pls.46.1537169918808;
        Mon, 17 Sep 2018 00:38:38 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id g21-v6sm26093186pfe.41.2018.09.17.00.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 00:38:38 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:38:29 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        himanshujha199640@gmail.com
Subject: Re: [PATCH v5] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180917073829.GA25896@Eros>
References: <20180915095752.8116-1-songqiang.1304521@gmail.com>
 <20180917061933.GA15262@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917061933.GA15262@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:19:33AM -0400, Rob Herring wrote:
> On Sat, Sep 15, 2018 at 05:57:52PM +0800, Song Qiang wrote:
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into an iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > This version of driver supports only one-shot mode, and it can be
> > tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > 
> > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> 
> checkpatch.pl complains that the author and signoff emails don't match. 
> I think gmail ignores '.' in email names, but better to be consistent 
> IMO.
> 

Hi Rob,

This isn't the first time I've seen this '.' issue, but in most case it
was fine. 
The thing interesting is after I saw your email, I tried to access my
account with songqiang1304521@gmail.com(just without '.'), and it
succeeded! So maybe google just removed the '.' in my account everytime
I logged in. I think I'll send next version of my patch with my email
account without '.'.

yours,
Song Qiang

> > ---
> > Changes in v5:
> > 	- Correct some spell problems.
> > 	- Change tries-- to --tries to fix the count error.
> > 	- Add MODULE_DEVICE_TABLE().
> > 	- Add some comments.
> > 
> > Changes in v4:
> > 	- Add datasheet link, default i2c address and TODO list.
> > 	- Make capitalization of defines consistent.
> > 	- Replace i2c_transfer() with i2c_smbus_read_i2c_block_data().
> > 	- Remove IIO_CHAN_SOFT_TIMESTAMP() since no buffer/trigger
> > 	  support.
> > 	- Add information to MAINTAINERS.
> > 
> > Changes in v3:
> > 	- Recover ST's copyright.
> > 	- Clean up indio_dev member in vl53l0x_data struct since it's
> > 	  useless now.
> > 	- Replace __le16_to_cpu() with le16_to_cpu().
> > 	- Remove the iio_device_{claim|release}_direct_mode() since it's
> > 	  only needed when we use buffered mode.
> > 	- Clean up some coding style problems.
> > 
> > Changes in v2:
> > 	- Clean up the register table.
> > 	- Sort header files declarations.
> > 	- Replace some bit definations with GENMASK() and BIT().
> > 	- Clean up some code and comments that's useless for now.
> > 	- Change the order of some the definations of some variables to reversed
> > 	  xmas tree order.
> > 	- Using do...while() rather while and check.
> > 	- Replace pr_err() with dev_err().
> > 	- Remove device id declaration since we recommend to use DT.
> > 	- Remove .owner = THIS_MODULE.
> > 	- Replace probe() with probe_new() hook.
> > 	- Remove IIO_BUFFER and IIO_TRIGGERED_BUFFER dependences.
> > 	- Change the driver module name to vl53l0x-i2c.
> > 	- Align all the parameters if they are in the same function with open
> > 	  parentheses.
> > 	- Replace iio_device_register() with devm_iio_device_register
> > 	  for better resource management.
> > 	- Remove the vl53l0x_remove() since it's not needed.
> > 	- Remove dev_set_drvdata() since it's already setted above.
> > 
> >  .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
> >  MAINTAINERS                                   |   7 +
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> >  drivers/iio/proximity/Kconfig                 |  11 ++
> >  drivers/iio/proximity/Makefile                |   2 +
> >  drivers/iio/proximity/vl53l0x-i2c.c           | 180 ++++++++++++++++++
> >  5 files changed, 212 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> >  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
